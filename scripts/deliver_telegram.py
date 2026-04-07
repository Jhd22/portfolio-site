"""Telegram delivery — sends coach advice as Telegram messages."""

import os
import sys
import logging
import requests
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from dotenv import load_dotenv
load_dotenv(Path(__file__).parent.parent / ".env")

logging.basicConfig(
    filename=Path(__file__).parent.parent / "logs" / "telegram.log",
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)
log = logging.getLogger(__name__)

BOT_TOKEN = os.environ["TELEGRAM_BOT_TOKEN"]
CHAT_ID = os.environ["TELEGRAM_CHAT_ID"]
API_URL = f"https://api.telegram.org/bot{BOT_TOKEN}"

TELEGRAM_MAX_LENGTH = 4096


def send_message(text: str, parse_mode: str = "Markdown") -> None:
    chunks = [text[i:i + TELEGRAM_MAX_LENGTH] for i in range(0, len(text), TELEGRAM_MAX_LENGTH)]
    for chunk in chunks:
        resp = requests.post(
            f"{API_URL}/sendMessage",
            json={"chat_id": CHAT_ID, "text": chunk, "parse_mode": parse_mode},
            timeout=10,
        )
        resp.raise_for_status()
        log.info(f"Sent Telegram chunk ({len(chunk)} chars)")


def extract_key_recommendation(advice: str) -> str:
    lines = [l.strip() for l in advice.strip().splitlines() if l.strip()]
    for line in lines:
        if line.startswith(("#", "*", "-", "**", "1.", "2.")) or len(line) > 30:
            return line[:500]
    return lines[0][:500] if lines else advice[:500]


def deliver(label: str, advice: str) -> None:
    headline = extract_key_recommendation(advice)
    send_message(f"*{label}* — Vigtigste anbefaling:\n\n{headline}")
    send_message(f"*{label}* — Fuld plan:\n\n{advice}")
    log.info(f"Delivered {label} to Telegram")


if __name__ == "__main__":
    send_message("Coach pipeline test — bot er konfigureret korrekt.")
    print("Test message sent.")
