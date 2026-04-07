"""Strength coach — loads system prompt, calls Claude, saves output."""

import sys
import logging
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from dotenv import load_dotenv
load_dotenv(Path(__file__).parent.parent / ".env")

from utils.anthropic_client import generate_response

logging.basicConfig(
    filename=Path(__file__).parent.parent / "logs" / "strength_coach.log",
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)
log = logging.getLogger(__name__)

PROMPTS_DIR = Path(__file__).parent.parent / "prompts"
OUTPUTS_DIR = Path(__file__).parent.parent / "outputs"


def run(weekly_summary: str) -> str:
    system_prompt = (PROMPTS_DIR / "strength-coach-system-prompt.md").read_text()

    user_message = f"""{weekly_summary}

---

Her er min uge. Giv mig næste uges styrketræningsjusteringer og programmeringsbeslutninger."""

    log.info("Calling strength coach")
    response = generate_response(
        prompt=user_message,
        system=system_prompt,
        max_tokens=2000,
    )

    out_path = OUTPUTS_DIR / f"strength-advice-{date.today().isoformat()}.md"
    out_path.write_text(response)
    log.info(f"Strength advice saved to {out_path}")
    return response


if __name__ == "__main__":
    from weekly_summary import build_summary
    summary = build_summary()
    advice = run(summary)
    print(advice)
