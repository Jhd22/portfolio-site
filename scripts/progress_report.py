"""
Weekly Progress Report
Runs on Mac mini (Sunday evening via launchd).
Summarises the week's accomplishments and flags risk areas.
"""

import json
from datetime import date, timedelta

from utils.supabase_client import get_client, get_readings, get_training_logs, get_events
from utils.anthropic_client import generate_response


def build_weekly_context() -> dict:
    client = get_client(use_service_role=True)
    week = date.today().isocalendar()[1]
    all_readings = get_readings(client)
    
    # Progress per course
    progress = {}
    for course in ["IR2", "Økonomi", "Metode"]:
        texts = [r for r in all_readings if r["course"] == course]
        completed = [r for r in texts if r["status"] == "læst"]
        progress[course] = {
            "total": len(texts),
            "completed": len(completed),
            "pct": round(100 * len(completed) / len(texts), 1) if texts else 0,
            "remaining_high_priority": sum(
                1 for r in texts
                if r["status"] != "læst" and r["priority"] == "høj"
            ),
        }
    
    # Training this week
    training = get_training_logs(client, days=7)
    
    # Upcoming deadlines (next 3 weeks)
    upcoming = []
    for w in range(week, week + 4):
        upcoming.extend(get_events(client, week=w))
    
    return {
        "week": week,
        "progress": progress,
        "training_sessions": len(training),
        "training_types": [t["type"] for t in training],
        "upcoming_deadlines": [
            e for e in upcoming if e["type"] in ("deadline", "exam")
        ],
    }


def generate_report(context: dict) -> str:
    prompt = f"""Generate a weekly progress report for week {context['week']}.

**Reading Progress**:
{json.dumps(context['progress'], indent=2, ensure_ascii=False)}

**Training This Week**: {context['training_sessions']} sessions
Types: {', '.join(context['training_types']) or 'None logged'}

**Upcoming Deadlines**:
{json.dumps(context['upcoming_deadlines'], indent=2, ensure_ascii=False)}

Format: 
1. What went well this week
2. What's at risk / falling behind
3. Top 3 priorities for next week

Be direct. Flag concrete problems, not vague concerns."""

    return generate_response(prompt)


def main():
    context = build_weekly_context()
    report = generate_report(context)
    
    print(f"\n{'='*60}")
    print(f"WEEKLY PROGRESS — Week {context['week']}")
    print(f"{'='*60}")
    print(report)
    print(f"{'='*60}")
    
    return report


if __name__ == "__main__":
    main()
