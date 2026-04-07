# Apple Shortcuts Setup

## Overview
Apple Shortcuts on iPhone can call the Anthropic API directly via HTTP request, enabling on-demand briefings without opening Claude.

## Prerequisites
- Anthropic API key with active billing (separate from Claude.ai subscription)
- API key stored in a Shortcut variable (never hardcoded in shared shortcuts)

## Shortcut 1: Morning Briefing

### Flow
1. Tap shortcut (or trigger via automation)
2. Shortcut calls Mac mini briefing endpoint (via Tailscale IP), OR
3. Shortcut calls Anthropic API directly with calendar context

### Option A: Via Mac mini (recommended)
```
1. Get URL: http://[tailscale-ip]:8080/briefing
2. Get Contents of URL (GET request)
3. Show Result
```
Requires a small FastAPI server on Mac mini exposing the briefing script.

### Option B: Direct API call
```
1. Get Calendar Events (today)
2. Set Variable: calendar_context = [formatted events]
3. URL: https://api.anthropic.com/v1/messages
4. Method: POST
5. Headers:
   - Content-Type: application/json
   - x-api-key: [your key]
   - anthropic-version: 2023-06-01
6. Body (JSON):
   {
     "model": "claude-sonnet-4-20250514",
     "max_tokens": 1000,
     "messages": [{
       "role": "user",
       "content": "Generate a morning briefing. Today's schedule: [calendar_context]. Keep it to 2 paragraphs."
     }]
   }
7. Get Dictionary Value: content → 0 → text
8. Show Result
```

## Shortcut 2: Log Recovery (future)
Quick-entry for morning HRV, RHR, sleep hours → POST to Supabase.

## Shortcut 3: Mark Reading Complete (future)
Select a reading from a list → PATCH to Supabase.

## Notes
- Shortcuts has native Apple Calendar access (no API needed)
- Supabase REST API works directly from Shortcuts via HTTP
- Use Tailscale to reach Mac mini from anywhere
- API costs: ~$0.01–0.05 per briefing call (Sonnet)
