"""Coach pipeline orchestrator — weekly summary → coaches → Telegram."""

import sys
import logging
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from dotenv import load_dotenv
load_dotenv(Path(__file__).parent.parent / ".env")

LOG_PATH = Path(__file__).parent.parent / "logs" / "coach_pipeline.log"
logging.basicConfig(
    filename=LOG_PATH,
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)
log = logging.getLogger(__name__)

OUTPUTS_DIR = Path(__file__).parent.parent / "outputs"


def already_ran_today() -> bool:
    today = date.today().isoformat()
    return (OUTPUTS_DIR / f"running-advice-{today}.md").exists() and \
           (OUTPUTS_DIR / f"strength-advice-{today}.md").exists()


def main():
    log.info("=== Coach pipeline starting ===")

    if already_ran_today():
        log.info("Already ran today — skipping (idempotent)")
        print("Already ran today. Delete today's output files to re-run.")
        return

    log.info("Step 1: Building weekly summary")
    from weekly_summary import build_summary
    summary = build_summary()
    log.info(f"Summary built ({len(summary)} chars)")

    log.info("Step 2: Running coach")
    from running_coach import run as run_running_coach
    running_advice = run_running_coach(summary)
    log.info("Running advice generated")

    log.info("Step 3: Strength coach")
    from strength_coach import run as run_strength_coach
    strength_advice = run_strength_coach(summary)
    log.info("Strength advice generated")

    log.info("Step 4: Delivering via Telegram")
    from deliver_telegram import deliver
    deliver("Løbecoach", running_advice)
    deliver("Styrkecoach", strength_advice)

    log.info("=== Coach pipeline complete ===")
    print("Pipeline complete.")


if __name__ == "__main__":
    main()
