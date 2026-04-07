# Personal AI System — Architecture Options Breakdown

This document breaks down every component of your planned system into individual decisions. Each layer is independent — you can mix and match across layers.

---

## Layer 1: Tracking Data Storage

*Where does your state live? (reading progress, training logs, goals, check-offs)*

### Option 1A: Claude Artifact Persistent Storage (`window.storage`)

- **What it is:** Key-value store built into Claude artifacts. Your current Whoop tracker already uses this.
- **Setup effort:** Zero — already working.
- **Cost:** Free (included with Claude).
- **What it enables:** React artifacts can read/write state that persists across sessions. Works on phone via Claude app. Good for dashboards, checklists, journals.
- **What it can't do:** Nothing outside Claude can access this data. Your Mac mini can't read it. Apple Shortcuts can't read it. No API. No export without manually building an export button into the artifact. Data is tied to your Claude account.
- **Best for:** Self-contained dashboards where everything happens inside Claude.

### Option 1B: Supabase (cloud PostgreSQL + REST API)

- **What it is:** Free hosted database with automatic REST API. You create tables (e.g., `readings`, `workouts`, `goals`), and anything can read/write via HTTP.
- **Setup effort:** Medium. Create account, define tables, get API key. ~30 min to set up, then you need to learn the API patterns.
- **Cost:** Free tier = 500MB storage, 50k monthly requests. More than enough.
- **What it enables:** Claude artifacts, Mac mini scripts, Apple Shortcuts, and any future tool can all read/write to the same data. Real SQL queries. Row-level security if you want it.
- **What it can't do:** Doesn't store files (PDFs, slides) — only structured data. Requires internet. Your data lives on Supabase's servers (US/EU, you choose region).
- **Best for:** The "single source of truth" approach where multiple interfaces need access to the same state.

### Option 1C: SQLite on Mac mini

- **What it is:** A local database file on your Mac mini. Lightweight, no server needed — just a file that scripts read/write.
- **Setup effort:** Low. Create the database with a Python script. ~15 min.
- **Cost:** Free.
- **What it enables:** Fast, private, full SQL support. Mac mini scripts can read/write directly. If you run a small API server (FastAPI), other devices can access it too.
- **What it can't do:** Not accessible from outside your network unless you add Tailscale or similar. Claude artifacts can't reach it without an API layer. If Mac mini is off, data is unreachable.
- **Best for:** Privacy-first approach where you also run an API server on the Mac mini.

### Option 1D: iCloud (JSON files via CloudKit or just iCloud Drive)

- **What it is:** Store your tracking state as JSON files in iCloud Drive. They sync automatically to all Apple devices.
- **Setup effort:** Very low. Just read/write JSON files to `~/Library/Mobile Documents/`.
- **Cost:** Free (within your existing iCloud plan).
- **What it enables:** Apple Shortcuts can read/write these files natively. Mac mini scripts can read/write them. Automatic sync to phone/laptop.
- **What it can't do:** Not a database — no queries, no indexing. Concurrent writes from multiple sources can conflict (last write wins). Claude artifacts cannot access iCloud files. No API.
- **Best for:** Simple state tracking where Apple Shortcuts are the primary mobile interface and you don't need Claude artifacts to write data.

### Option 1E: Google Sheets as database

- **What it is:** A spreadsheet where each tab is a "table" (readings, workouts, etc.). Accessible via Google Sheets API.
- **Setup effort:** Low-medium. Create the sheet, set up API credentials.
- **Cost:** Free.
- **What it enables:** Human-readable — you can open the sheet and see/edit data manually. API access from scripts. Claude artifacts can fetch from Sheets API. Apple Shortcuts can access via HTTP.
- **What it can't do:** Slow for large datasets. Not designed for complex queries. 100 requests/100sec rate limit. Feels hacky at scale.
- **Best for:** If you want a visible, editable "database" you can also browse manually. Good for prototyping.

---

## Layer 2: File & Content Storage

*Where do your course materials live? (PDFs, slides, Obsidian notes, syllabi)*

### Option 2A: Mac mini local filesystem

- **What it is:** Your PDFs, .pptx files, and Obsidian vault live on the Mac mini's disk.
- **Setup effort:** Copy files to a structured folder. Zero if they're already there.
- **What it enables:** Fast access from Mac mini scripts. Can build a search index over them. Unlimited size. Full privacy.
- **What it can't do:** Not accessible from phone or Claude unless you expose an API or use Tailscale. Can't be directly consumed by Claude artifacts.
- **Best for:** The heavy knowledge base that agents search through on demand.

### Option 2B: iCloud Drive (synced folders)

- **What it is:** Course materials stored in iCloud Drive, synced across devices.
- **Setup effort:** Drag files into iCloud folders. Zero.
- **What it enables:** Available on all Apple devices. Mac mini can access them. Files app on iPhone can browse them.
- **What it can't do:** Claude can't access iCloud. No search API — you can only browse by filename. Large files (big PDFs) may take time to download on demand.
- **Best for:** Having your materials accessible everywhere for manual reference.

### Option 2C: Claude Projects (uploaded to project knowledge)

- **What it is:** Upload PDFs, slides, and notes directly into Claude Project knowledge bases.
- **Setup effort:** Low — drag and drop into each project. Reorganize as needed.
- **What it enables:** Claude has deep, full-text access to your materials in conversation. Can reference specific passages, compare across texts, answer detailed questions. The richest AI interaction with your materials.
- **What it can't do:** ~200k token context limit per project (roughly 400-500 pages). Can't be accessed by scripts, Shortcuts, or your Mac mini. Materials are siloed per project — the IR3 project can't see Econ materials. Manual uploads required.
- **Best for:** Deep study sessions where you want Claude to work through your actual readings.

### Option 2D: Obsidian vault (local + optional sync)

- **What it is:** Your existing Obsidian setup with notes, potentially synced via iCloud or Obsidian Sync.
- **Setup effort:** Already exists.
- **What it enables:** Rich linked notes with your own processing. Can be indexed by Mac mini scripts. Community plugins for various integrations.
- **What it can't do:** Claude can't directly access your vault (unless uploaded to a Project). Binary files (PDFs, slides) aren't native to Obsidian.
- **Best for:** Your own thinking and note-taking layer. The place where *your* knowledge lives, vs. raw course materials.

---

## Layer 3: Compute & AI Processing

*Where does the intelligence run?*

### Option 3A: Claude.ai conversations (manual)

- **What it is:** You open Claude, ask questions, get answers. What you do now.
- **Setup effort:** Zero.
- **What it enables:** Full Claude Opus/Sonnet capabilities. Upload files on the fly. Rich conversation.
- **What it can't do:** No automation. No scheduled tasks. You initiate everything. Each conversation starts fresh (unless using Projects or memory).
- **Best for:** Interactive deep work — exam prep, reading analysis, problem-solving.

### Option 3B: Claude Projects (persistent system prompts)

- **What it is:** Pre-configured Claude environments with custom system prompts and uploaded knowledge.
- **Setup effort:** Low-medium. Write system prompts, upload materials per project.
- **What it enables:** Each project is a specialist — the IR3 Expert, the Training Coach, the Econ Tutor. Uploaded materials persist across conversations. System prompt defines behavior, personality, and focus.
- **What it can't do:** Projects don't talk to each other. No automation — you still initiate. Can't call external APIs or read databases. Separate from your tracking data.
- **Best for:** Deep domain expertise. The "go here when I need to think hard about IR3" tool.

### Option 3C: Anthropic API calls from Mac mini scripts

- **What it is:** Python/Node scripts on your Mac mini that call Claude's API with carefully constructed prompts, injecting your data as context.
- **Setup effort:** Medium. Get API key, write scripts, design prompts. Need to manage token costs.
- **Cost:** Pay per token. Sonnet is ~$3/million input tokens, ~$15/million output. A daily briefing might cost $0.01-0.05/day. Very cheap.
- **What it enables:** Full automation. Scheduled briefings. Can inject any data — calendar, tracking state, file contents — into the prompt. Can chain multiple calls. Can route to different "agent" prompts based on context.
- **What it can't do:** No interactive conversation (one-shot). No artifact UI. Requires scripting.
- **Best for:** Automated briefings, progress reports, recommendations generated without your involvement.

### Option 3D: Anthropic API calls from Apple Shortcuts

- **What it is:** An Apple Shortcut on your phone that calls the Anthropic API directly via HTTP request.
- **Setup effort:** Medium. Build the Shortcut, handle API formatting.
- **Cost:** Same API pricing as 3C.
- **What it enables:** On-demand AI responses from your phone without opening Claude. Can include calendar data (Shortcuts has native calendar access), location, time of day. Tap a button → get a contextual briefing.
- **What it can't do:** Limited context — Shortcuts can't easily inject large files. No rich UI (just text output). Complex multi-step logic is painful in Shortcuts.
- **Best for:** Quick mobile triggers. "Brief me on today" while eating breakfast.

### Option 3E: Claude Code on Mac mini

- **What it is:** Claude Code (CLI tool) running on the Mac mini, potentially as a persistent agent.
- **Setup effort:** High. Install Claude Code, configure, design agent workflows.
- **Cost:** Requires Claude Max plan or API usage.
- **What it enables:** Full agentic capability — can read files, run scripts, access databases, make API calls, and chain complex workflows. Could theoretically monitor your state and proactively surface insights.
- **What it can't do:** Still requires triggering (no true "always watching" mode without custom setup). Heavy resource usage. Overkill for simple tasks.
- **Best for:** Complex agent tasks — "search all my IR3 slides for discussions of offensive realism and compile a study guide." Power user territory.

### Option 3F: Claude artifacts with embedded API calls

- **What it is:** React artifacts that call the Anthropic API internally (your existing training chat assistant does this).
- **Setup effort:** Medium. Build the artifact with API integration.
- **Cost:** API usage included when used within Claude.ai artifacts.
- **What it enables:** Interactive AI-powered dashboards. The artifact can show your data AND reason about it. "What should I train today?" answered by Claude within the dashboard, with full context from your logs.
- **What it can't do:** Only runs when you open the artifact. Can't push notifications. Limited to what's in persistent storage (no file system access).
- **Best for:** Smart dashboards — the main interface you interact with daily.

---

## Layer 4: Interface & Interaction

*How do you actually use the system?*

### Option 4A: Claude app (phone/desktop)

- **What it is:** Open Claude, interact with artifacts or conversations.
- **Setup effort:** Zero — already using this.
- **What it enables:** Rich UI via artifacts. Full conversation capability. Works on phone and desktop.
- **What it can't do:** Pull only — you must open it. No push notifications from Claude.
- **Best for:** Primary interactive interface for dashboards and deep work.

### Option 4B: Apple Shortcuts widget/button

- **What it is:** A home screen button or widget that triggers a Shortcut.
- **Setup effort:** Low-medium per Shortcut.
- **What it enables:** One-tap actions from your phone. "Morning briefing," "Log workout," "What's next?" Can show results in a notification or Shortcut output view.
- **What it can't do:** No rich UI. Text-only responses. Limited interactivity.
- **Best for:** Quick actions you want to do without opening an app.

### Option 4C: Local web dashboard on Mac mini

- **What it is:** A web app (React/Next.js) running on your Mac mini, accessible via browser on any device on your network (or via Tailscale from anywhere).
- **Setup effort:** High. Build the full web app.
- **Cost:** Free (self-hosted).
- **What it enables:** Full custom UI. Real-time data. Can integrate everything — calendar, tracking, course materials, AI responses. Accessible from any device with a browser.
- **What it can't do:** Requires the Mac mini to be on and reachable. No push notifications natively. Significant development effort.
- **Best for:** The "dream dashboard" — but high investment. Phase 3-4 territory.

### Option 4D: Apple Reminders / Notes integration

- **What it is:** Use Apple Reminders for reading checklists, Apple Notes for journal entries. Mac mini scripts read/write via AppleScript or Shortcuts.
- **Setup effort:** Low.
- **What it enables:** Native Apple apps you already use. Syncs everywhere. Siri integration. Widgets on home screen.
- **What it can't do:** No AI reasoning. No custom logic. No dashboards. Just data capture.
- **Best for:** Lightweight input layer — check off readings in Reminders, let a Mac mini script read the state and generate insights.

### Option 4E: iMessage bot (via Mac mini)

- **What it is:** A script on your Mac mini that monitors an iMessage conversation (via AppleScript) and responds.
- **Setup effort:** High and fragile. Apple doesn't officially support this. Breaks with macOS updates.
- **Cost:** Free but maintenance-heavy.
- **What it enables:** Chat with your "agent" via iMessage. Natural interface.
- **What it can't do:** Unreliable. No rich UI. Apple actively discourages this. Can break without warning.
- **Best for:** Cool demo, poor daily driver. I'd avoid this.

### Option 4F: Telegram bot (via Mac mini)

- **What it is:** A Telegram bot running on your Mac mini. You message it, it responds with AI-generated advice.
- **Setup effort:** Medium. Telegram bot API is well-documented and stable.
- **Cost:** Free.
- **What it enables:** Reliable messaging interface. Push notifications. Works everywhere. Can send rich formatting, buttons, inline keyboards. Stable API that doesn't break.
- **What it can't do:** Another app to install. No Apple ecosystem integration. No access to your calendar natively (but the Mac mini backend can fetch it).
- **Best for:** The mobile chat interface if you want something more reliable than iMessage hacking.

---

## Layer 5: Triggers & Scheduling

*What initiates actions?*

### Option 5A: Manual (you open the app/artifact)

- **What it is:** You decide when to interact.
- **Best for:** Deep work sessions, study prep, logging.

### Option 5B: Scheduled cron/launchd on Mac mini

- **What it is:** Scripts that run automatically at set times (e.g., 7:00 AM daily, Sunday evening for weekly review).
- **Setup effort:** Low. One `launchd` plist per task.
- **What it enables:** Automated briefings, progress reports, weekly summaries. "Every Sunday at 8 PM, generate a study progress report."
- **Best for:** Regular cadence reports and reminders.

### Option 5C: Calendar-triggered (event-based)

- **What it is:** A script that watches your calendar and triggers actions based on upcoming events. "IR3 lecture in 2 hours → check if readings are done → send reminder if not."
- **Setup effort:** Medium. Polling script + Google Calendar API.
- **What it enables:** Context-aware, event-driven nudges. Only alerts you when relevant.
- **Best for:** Smart reminders tied to your actual schedule.

### Option 5D: On-demand via Apple Shortcut

- **What it is:** You tap a button when you want something.
- **Setup effort:** Low per Shortcut.
- **What it enables:** "Brief me now" on your terms. No noise on quiet days.
- **Best for:** The breakfast briefing scenario. You decide when.

### Option 5E: Webhook/event-driven (e.g., when you check off a reading)

- **What it is:** An action in one system triggers processing in another. E.g., checking off a reading in the artifact calls the API to recalculate your study plan.
- **Setup effort:** High. Requires inter-system communication.
- **What it enables:** Real-time reactive system. State changes trigger fresh recommendations.
- **Best for:** Phase 3-4 ambition. Not where you start.

---

## Layer 6: Delivery & Output

*How does generated content reach you?*

### Option 6A: In-app (Claude artifact / web dashboard)

- **What it is:** You see it when you open the app.
- **Best for:** Dashboards, interactive tools, deep content.

### Option 6B: Apple push notification (via Shortcut)

- **What it is:** Mac mini script triggers a Shortcut on your phone via Pushover, ntfy, or HomeKit automation.
- **Setup effort:** Low-medium. Pushover app is $5 one-time, excellent API.
- **What it enables:** Glanceable alerts on your phone. "You have IR3 in 2 hours — Wendt Ch. 6 still unread."
- **Best for:** Time-sensitive nudges.

### Option 6C: Email digest

- **What it is:** Mac mini sends you an email with a daily/weekly summary.
- **Setup effort:** Low. Python `smtplib` or a service like Resend.
- **What it enables:** Longer-form briefings. Easy to archive. Works everywhere.
- **Best for:** Weekly reviews, study progress reports.

### Option 6D: Telegram message

- **What it is:** Bot sends you a message proactively.
- **Setup effort:** Low (if bot already exists from 4F).
- **What it enables:** Push messages with formatting. Can include buttons for quick actions ("Mark as read," "Snooze").
- **Best for:** Real-time alerts and quick interactive responses.

### Option 6E: Apple Reminders / Calendar entries

- **What it is:** Mac mini script creates Reminders or Calendar events programmatically.
- **Setup effort:** Low-medium via AppleScript or Shortcuts.
- **What it enables:** "Read Wendt Ch. 6" appears as a Reminder with a due date. Study blocks appear on your calendar.
- **Best for:** Integrating AI recommendations into your existing workflow tools.

---

## Recommended Combinations

### Minimal Viable System (start here)

| Layer | Choice | Why |
|-------|--------|-----|
| Tracking data | 1A: Artifact storage | Already works, zero setup |
| File storage | 2C: Claude Projects | Deep course knowledge per project |
| Compute | 3F: Artifact API calls + 3B: Projects | Smart dashboards + deep study |
| Interface | 4A: Claude app | Phone + desktop, already using it |
| Triggers | 5A: Manual | You open it when you need it |
| Delivery | 6A: In-app | See it in the artifact |

### Mid-Tier System (add Mac mini)

| Layer | Choice | Why |
|-------|--------|-----|
| Tracking data | 1B: Supabase | Everything reads/writes same source |
| File storage | 2A: Mac mini + 2C: Projects | Heavy files local, key materials in Projects |
| Compute | 3C: Mac mini API + 3F: Artifacts | Automated + interactive |
| Interface | 4A: Claude app + 4B: Shortcuts | Rich dashboards + quick mobile actions |
| Triggers | 5D: On-demand Shortcut + 5B: Weekly cron | Breakfast briefing + weekly review |
| Delivery | 6A: In-app + 6B: Push notifications | Daily use + smart nudges |

### Full System (the dream)

| Layer | Choice | Why |
|-------|--------|-----|
| Tracking data | 1B: Supabase | Universal access |
| File storage | 2A: Mac mini + 2C: Projects + 2D: Obsidian | Full ecosystem |
| Compute | 3C + 3D + 3E + 3F: All Mac mini + Shortcuts + Claude Code + Artifacts | Every use case covered |
| Interface | 4A + 4B + 4C: Claude + Shortcuts + Local dashboard | Multiple entry points |
| Triggers | 5B + 5C + 5D: Scheduled + Calendar + On-demand | Smart and flexible |
| Delivery | 6A + 6B + 6E: In-app + Push + Reminders integration | Reaches you everywhere |

---

## Decision Dependencies

Some choices constrain others:

- If you choose **1A (artifact storage)**, your Mac mini can't access tracking data → limits what automated briefings can include.
- If you choose **1C (SQLite on Mac mini)**, Claude artifacts can't access it unless you also build an API (adds effort).
- If you choose **1B (Supabase)**, everything can talk to everything → most flexible but requires Supabase setup.
- **2C (Claude Projects)** gives the deepest AI interaction with course materials but can't be automated.
- **3D (Shortcuts API calls)** needs an Anthropic API key with active billing — separate from your Claude.ai subscription.
- **4E (iMessage bot)** is fragile — if this is important to you, consider **4F (Telegram)** instead.
