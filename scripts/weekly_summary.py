"""Weekly data summary — queries Supabase for last 7 days."""

import sys
import logging
from datetime import date, timedelta
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from dotenv import load_dotenv
load_dotenv(Path(__file__).parent.parent / ".env")

from utils.supabase_client import get_client

logging.basicConfig(
    filename=Path(__file__).parent.parent / "logs" / "weekly_summary.log",
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)
log = logging.getLogger(__name__)


def fetch_last_7_days(client, table: str, date_col: str = "date") -> list:
    cutoff = (date.today() - timedelta(days=7)).isoformat()
    return (
        client.table(table)
        .select("*")
        .gte(date_col, cutoff)
        .order(date_col, desc=False)
        .execute()
        .data
    )


def build_summary() -> str:
    client = get_client(use_service_role=True)

    recovery_logs = fetch_last_7_days(client, "recovery_logs")
    training_logs = fetch_last_7_days(client, "training_logs")
    journal_entries = fetch_last_7_days(client, "journal_entries")

    lines = [f"# Ugentlig dataoversigt — {date.today().isoformat()}", ""]

    lines.append("## Recovery (sidste 7 dage)")
    if recovery_logs:
        hrv_vals = [r["hrv"] for r in recovery_logs if r.get("hrv")]
        rhr_vals = [r["rhr"] for r in recovery_logs if r.get("rhr")]
        sleep_vals = [r["sleep_hours"] for r in recovery_logs if r.get("sleep_hours")]

        def avg(lst): return round(sum(lst) / len(lst), 1) if lst else None

        green = sum(
            1 for r in recovery_logs
            if r.get("hrv", 0) >= 57 and r.get("rhr", 999) <= 62 and r.get("sleep_hours", 0) >= 8
        )
        yellow = sum(
            1 for r in recovery_logs
            if not (r.get("hrv", 0) >= 57 and r.get("rhr", 999) <= 62 and r.get("sleep_hours", 0) >= 8)
            and (r.get("hrv", 0) >= 50 or r.get("rhr", 999) <= 68)
        )
        red = len(recovery_logs) - green - yellow

        lines += [
            f"- Dage logget: {len(recovery_logs)}",
            f"- Gns. HRV: {avg(hrv_vals)} (tærskel: ≥57)",
            f"- Gns. RHR: {avg(rhr_vals)} (tærskel: ≤62)",
            f"- Gns. søvn: {avg(sleep_vals)} timer (tærskel: ≥8)",
            f"- Grønne dage: {green} | Gule: {yellow} | Røde: {red}",
        ]
        lines.append("")
        lines.append("### Daglig recovery")
        lines.append("| Dato | HRV | RHR | Søvn | Status |")
        lines.append("|------|-----|-----|------|--------|")
        for r in recovery_logs:
            hrv = r.get("hrv", "-")
            rhr = r.get("rhr", "-")
            sleep = r.get("sleep_hours", "-")
            status = r.get("status") or (
                "Grøn" if (r.get("hrv", 0) >= 57 and r.get("rhr", 999) <= 62 and r.get("sleep_hours", 0) >= 8)
                else "Rød" if (r.get("hrv", 0) < 50 or r.get("rhr", 999) > 68)
                else "Gul"
            )
            lines.append(f"| {r['date']} | {hrv} | {rhr} | {sleep} | {status} |")
    else:
        lines.append("_Ingen recovery-data for ugen._")
    lines.append("")

    lines.append("## Træning (sidste 7 dage)")
    strength_sessions = [t for t in training_logs if t.get("type") in ("strength", "push", "pull", "legs")]
    run_sessions = [t for t in training_logs if t.get("type") == "run"]
    other_sessions = [t for t in training_logs if t not in strength_sessions and t not in run_sessions]

    if training_logs:
        lines.append(f"- Total sessioner: {len(training_logs)}")
        lines.append(f"- Styrke: {len(strength_sessions)} sessioner")
        lines.append(f"- Løb: {len(run_sessions)} sessioner")
        if other_sessions:
            lines.append(f"- Andet (roning, cykling mv.): {len(other_sessions)}")
        lines.append("")

        if strength_sessions:
            lines.append("### Styrke-sessioner")
            lines.append("| Dato | Type | Øvelser/noter | RPE |")
            lines.append("|------|------|--------------|-----|")
            for t in strength_sessions:
                lines.append(
                    f"| {t.get('date','-')} | {t.get('type','-')} | {t.get('notes') or t.get('exercises') or '-'} | {t.get('rpe','-')} |"
                )
            lines.append("")

        if run_sessions:
            lines.append("### Løbe-sessioner")
            lines.append("| Dato | Distance (km) | Pace | Zone | Varighed |")
            lines.append("|------|--------------|------|------|----------|")
            total_dist = 0
            for t in run_sessions:
                dist = t.get("distance_km") or "-"
                if isinstance(dist, (int, float)):
                    total_dist += dist
                lines.append(
                    f"| {t.get('date','-')} | {dist} | {t.get('avg_pace') or '-'} | {t.get('zone') or '-'} | {t.get('duration_min') or '-'} min |"
                )
            lines.append(f"- Total løbedistance: {round(total_dist, 1)} km")
            lines.append("")
    else:
        lines.append("_Ingen træningsdata for ugen._")
        lines.append("")

    lines.append("## Journal (sidste 7 dage)")
    if journal_entries:
        moods = [j.get("mood") for j in journal_entries if j.get("mood")]
        energy = [j.get("energy") for j in journal_entries if j.get("energy")]

        def avg_str(lst): return round(sum(lst) / len(lst), 1) if lst else None

        if moods:
            lines.append(f"- Gns. humør: {avg_str(moods)}/10")
        if energy:
            lines.append(f"- Gns. energi: {avg_str(energy)}/10")
        lines.append("")
        lines.append("### Notable entries")
        for j in journal_entries:
            note = j.get("notes") or j.get("content") or ""
            if note:
                lines.append(f"- **{j.get('date','-')}**: {note[:200]}")
    else:
        lines.append("_Ingen journal-entries for ugen._")
    lines.append("")

    return "\n".join(lines)


if __name__ == "__main__":
    log.info("Building weekly summary")
    summary = build_summary()
    out_path = Path(__file__).parent.parent / "outputs" / f"weekly-summary-{date.today().isoformat()}.md"
    out_path.write_text(summary)
    print(summary)
    log.info(f"Summary written to {out_path}")
