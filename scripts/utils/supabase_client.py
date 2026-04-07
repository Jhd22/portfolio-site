"""
Supabase client utility.
Shared across all scripts that need database access.
"""

import os
from supabase import create_client, Client
from dotenv import load_dotenv

load_dotenv()


def get_client(use_service_role: bool = False) -> Client:
    """
    Returns a Supabase client.
    
    Args:
        use_service_role: If True, uses the service role key (full access).
                         If False, uses the anon key (RLS-restricted).
    """
    url = os.environ["SUPABASE_URL"]
    key = os.environ["SUPABASE_SERVICE_KEY" if use_service_role else "SUPABASE_ANON_KEY"]
    return create_client(url, key)


def get_readings(client: Client, course: str = None, status: str = None, week: int = None):
    """Fetch readings with optional filters."""
    query = client.table("readings").select("*")
    if course:
        query = query.eq("course", course)
    if status:
        query = query.eq("status", status)
    if week:
        query = query.eq("week", week)
    return query.order("week").order("id").execute().data


def get_recovery(client: Client, date: str = None):
    """Fetch recovery log for a specific date or most recent."""
    query = client.table("recovery_logs").select("*")
    if date:
        query = query.eq("date", date)
    else:
        query = query.order("date", desc=True).limit(1)
    return query.execute().data


def get_training_logs(client: Client, days: int = 14):
    """Fetch recent training logs."""
    from datetime import date, timedelta
    cutoff = (date.today() - timedelta(days=days)).isoformat()
    return (
        client.table("training_logs")
        .select("*")
        .gte("date", cutoff)
        .order("date", desc=True)
        .execute()
        .data
    )


def get_events(client: Client, week: int = None):
    """Fetch events/deadlines, optionally filtered by week."""
    query = client.table("events").select("*")
    if week:
        query = query.eq("week", week)
    return query.order("week").execute().data


def get_schedule(client: Client, week: int):
    """
    Get KU schedule for a given week.
    Returns override schedule if one exists, otherwise the default (week=NULL).
    """
    # Check for week-specific override
    override = (
        client.table("ku_schedule")
        .select("*")
        .eq("week", week)
        .execute()
        .data
    )
    if override:
        return override
    
    # Fall back to default schedule
    return (
        client.table("ku_schedule")
        .select("*")
        .is_("week", "null")
        .execute()
        .data
    )
