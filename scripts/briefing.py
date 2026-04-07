"""
Morning Briefing Generator
Runs on Mac mini (scheduled via launchd or triggered by Apple Shortcut).
Generates a contextual daily briefing using Supabase data + Claude API.
"""

import json
from datetime import date, timedelta

from utils.supabase_client import (
    get_client,
    get_readings,
    get_recovery,
    get_training_logs,
    get_events,
    get_schedule,
)
from utils.anthropic_client import generate_response


# Load the command center system prompt
SYSTEM_PROMPT_PATH = "../agents/command-center/system-prompt.md"


def get_current_week() -> int:
    """
    Calculate the current ISO week number.
    KU semester uses weeks 6–21 (Spring 2026).
    """
    return date.today().isocalendar()[1]


def build_context() -> dict:
    """Gather all data needed for the briefing."""
    client = get_client(use_service_role=True)
    week = get_current_week()
    today = date.today()
    
    # Readings due this week (unread)
    week_readings = [
        r for r in get_readings(client, week=week)
        if r["status"] != "læst"
    ]
    
    # Total backlog (all unread up to this week)
    all_readings = get_readings(client)
    backlog = [
        r for r in all_readings
        if r["status"] != "læst" and r["week"] <= week
    ]
    
    # Reading progress summary
    progress = {}
    for course in ["IR2", "Økonomi", "Metode"]:
        course_texts = [r for r in all_readings if r["course"] == course]
        completed = sum(1 for r in course_texts if r["status"] == "læst")
        progress[course] = {
            "total": len(course_texts),
            "completed": completed,
            "pct": round(100 * completed / len(course_texts), 1) if course_texts else 0,
        }
    
    # Today's recovery
    recovery = get_recovery(client, date=today.isoformat())
    
    # Recent training (last 7 days)
    recent_training = get_training_logs(client, days=7)
    
    # Today's schedule
    schedule = get_schedule(client, week)
    today_name = ["Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag", "Søndag"][today.weekday()]
    today_schedule = [s for s in schedule if s["day_of_week"] == today_name]
    
    # Upcoming events/deadlines (this week + next)
    events_this_week = get_events(client, week=week)
    events_next_week = get_events(client, week=week + 1)
    
    return {
        "date": today.isoformat(),
        "day": today_name,
        "week": week,
        "today_schedule": today_schedule,
        "week_readings_unread": week_readings,
        "backlog_count": len(backlog),
        "backlog_high_priority": [r for r in backlog if r["priority"] == "høj"],
        "progress": progress,
        "recovery": recovery[0] if recovery else None,
        "recent_training": recent_training,
        "events": events_this_week + events_next_week,
    }


def generate_briefing(context: dict) -> str:
    """Generate the briefing using Claude API."""
    
    # Read system prompt
    try:
        with open(SYSTEM_PROMPT_PATH, "r") as f:
            system = f.read()
    except FileNotFoundError:
        system = "You are a personal assistant generating a morning briefing. Be direct and actionable."
    
    prompt = f"""Generate my morning briefing based on this data:

**Date**: {context['date']} ({context['day']}), Week {context['week']}

**Today's Schedule**:
{json.dumps(context['today_schedule'], indent=2, ensure_ascii=False)}

**This Week's Unread Readings** ({len(context['week_readings_unread'])} texts):
{json.dumps([{{'course': r['course'], 'title': r['title'], 'author': r['author'], 'priority': r['priority']}} for r in context['week_readings_unread']], indent=2, ensure_ascii=False)}

**Backlog**: {context['backlog_count']} unread texts due up to this week ({len(context['backlog_high_priority'])} high priority)

**Reading Progress**:
{json.dumps(context['progress'], indent=2, ensure_ascii=False)}

**Recovery**:
{json.dumps(context['recovery'], indent=2, ensure_ascii=False) if context['recovery'] else 'No recovery data logged today'}

**Recent Training (last 7 days)**:
{json.dumps([{{'date': t['date'], 'type': t['type'], 'duration': t.get('duration_min')}} for t in context['recent_training']], indent=2, ensure_ascii=False)}

**Upcoming Events/Deadlines**:
{json.dumps([{{'week': e['week'], 'date': e.get('date'), 'label': e['label'], 'type': e['type']}} for e in context['events']], indent=2, ensure_ascii=False)}

Keep it to 2–3 paragraphs. Lead with today's most actionable items."""

    return generate_response(prompt, system=system)


def main():
    print("Gathering data...")
    context = build_context()
    
    print("Generating briefing...")
    briefing = generate_briefing(context)
    
    print("\n" + "=" * 60)
    print(f"MORNING BRIEFING — {context['date']} ({context['day']})")
    print("=" * 60)
    print(briefing)
    print("=" * 60)
    
    return briefing


if __name__ == "__main__":
    main()
