"""
Calendar Sync: Apple Calendar → Supabase
Runs on Mac mini (requires macOS).
Uses icalBuddy CLI to read Apple Calendar events.

Prerequisites:
    brew install ical-buddy

Alternative: use EventKit via PyObjC for native access.
"""

import subprocess
import json
import re
from datetime import date, timedelta

from utils.supabase_client import get_client


def get_calendar_events(days_ahead: int = 7) -> list[dict]:
    """
    Fetch upcoming events from Apple Calendar using icalBuddy.
    
    Returns list of dicts with: title, date, start_time, end_time, calendar, location
    """
    try:
        result = subprocess.run(
            [
                "icalBuddy",
                "-f",
                "-nc",              # no calendar names in output
                "-nrd",             # no relative dates
                "-df", "%Y-%m-%d",  # date format
                "-tf", "%H:%M",    # time format
                "-b", "|||",       # bullet point separator
                f"eventsFrom:today to:+{days_ahead}d",
            ],
            capture_output=True,
            text=True,
            timeout=10,
        )
    except FileNotFoundError:
        print("Error: icalBuddy not installed. Run: brew install ical-buddy")
        return []
    
    if result.returncode != 0:
        print(f"icalBuddy error: {result.stderr}")
        return []
    
    # Parse icalBuddy output
    events = []
    for block in result.stdout.split("|||"):
        block = block.strip()
        if not block:
            continue
        
        lines = block.split("\n")
        title = lines[0].strip() if lines else ""
        
        # Extract date/time and location from remaining lines
        event = {"title": title, "raw": block}
        for line in lines[1:]:
            line = line.strip()
            if re.match(r"\d{4}-\d{2}-\d{2}", line):
                event["date"] = line[:10]
            if "location:" in line.lower():
                event["location"] = line.split(":", 1)[1].strip()
        
        if title:
            events.append(event)
    
    return events


def sync_to_supabase(events: list[dict]):
    """
    Sync calendar events to Supabase.
    For now, this is informational — the briefing script
    can read from Apple Calendar directly via icalBuddy.
    Future: store in a calendar_events table for richer queries.
    """
    # Placeholder for future implementation
    print(f"Found {len(events)} calendar events")
    for event in events:
        print(f"  - {event.get('date', '???')}: {event['title']}")


def main():
    print("Fetching Apple Calendar events...")
    events = get_calendar_events(days_ahead=7)
    sync_to_supabase(events)
    print("Done.")


if __name__ == "__main__":
    main()
