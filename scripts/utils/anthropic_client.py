"""
Anthropic API client utility.
Used for automated briefings and AI-powered scripts on Mac mini.
"""

import os
from anthropic import Anthropic
from dotenv import load_dotenv

load_dotenv()


def get_client() -> Anthropic:
    """Returns an Anthropic API client."""
    return Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])


def generate_response(
    prompt: str,
    system: str = "",
    model: str = "claude-sonnet-4-20250514",
    max_tokens: int = 2000,
) -> str:
    """
    Generate a one-shot response from Claude.
    
    Args:
        prompt: The user message content.
        system: Optional system prompt.
        model: Model to use (Sonnet for automated tasks — cheap and fast).
        max_tokens: Maximum response length.
    
    Returns:
        The assistant's text response.
    """
    client = get_client()
    
    kwargs = {
        "model": model,
        "max_tokens": max_tokens,
        "messages": [{"role": "user", "content": prompt}],
    }
    if system:
        kwargs["system"] = system
    
    response = client.messages.create(**kwargs)
    
    # Extract text from response content blocks
    return "".join(
        block.text for block in response.content if block.type == "text"
    )
