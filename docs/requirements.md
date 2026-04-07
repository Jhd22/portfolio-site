# Personal AI System — Requirements & Goals

---

## Vision

A unified personal AI system that tracks academic progress, training, and daily priorities — giving contextual, personalised advice across domains. The system should feel like a knowledgeable assistant that remembers what you've done, knows what's coming, and recommends what to do next.

---

## Hardware Inventory

| Device | Role | Always On | Key Capability |
|--------|------|-----------|----------------|
| MacBook Pro | Primary work device | No | Claude app, Obsidian, course work |
| Mac mini | Automation server | Yes | Cron jobs, API calls, file serving |
| iMac | Dev workstation + file host | Yes | Obsidian vault, course files, development |
| iPhone | Mobile access | — | Shortcuts, Claude app, notifications |
| Boox Note Air 3 | Study tablet | — | Reading, note-taking, future launcher |

---

## System Goals

### G1: Academic Command Center

Know where I am across all courses. Surface what I need to do next based on schedule, deadlines, and what I've already covered.

**Requirements:**
- Per-course reading checklists (check off texts as completed)
- Calendar-aware: knows when lectures are and what readings are assigned
- Tracks depth of engagement, not just binary read/unread (read → restructured → compared → tested)
- Recommends what to prioritise based on exam proximity, unread backlog, and dependencies between texts
- Works on phone (Claude app) and Boox (browser)

### G2: Per-Course Expert Agents

Each course gets a specialised agent with deep knowledge of the curriculum, texts, and exam format.

**Requirements:**
- IR3 Agent: full syllabus, theoretical frameworks, reading list, exam format. Knows how theories connect across weeks.
- Macro Econ Agent: curriculum, problem sets, models, key graphs. Tracks conceptual understanding.
- Qual Methods Agent: methods readings, MSSD/MDSD, research design frameworks, application practice.
- Each agent has access to uploaded slides (PowerPoints) and readings (PDFs).
- Each agent adapts to how I learn in *that specific course* (not a universal learning model).

### G3: Learning Pattern Monitor (per-course)

Track *how* I learn in each course and optimise study approach accordingly.

**Requirements:**
- Detects which study methods produce retention (restructuring? flashcards? oral practice? problem sets?)
- Per-course profiles, not universal — IR learning patterns ≠ Econ patterns
- Flags when a method isn't working (e.g., "you've re-read this chapter 3 times but can't explain the core argument — try a different approach")
- Informs the Progress Tracker

### G4: Progress Tracker (cross-course)

Am I on track across all courses? Am I allocating time well?

**Requirements:**
- Aggregates per-course progress into a single view
- Compares actual pace vs. required pace (given exam dates and remaining material)
- Flags risk areas: "You're 3 readings behind in IR3 and the exam is in 2 weeks"
- Weekly summary: what was accomplished, what's slipping
- Integrates with calendar to understand time available

### G5: Training Coach & Journal

Whoop-style daily tracker with intelligent coaching based on recent activity and recovery.

**Requirements:**
- Daily logging: recovery metrics (HRV, RHR, sleep), workout details, subjective notes
- Knows my training plan (upper/lower split, zone 2 running, VO2max work)
- Recommends today's session based on: recent volume, rest days, recovery score, time available
- Adapts recommendations when I say "I only have 30 minutes"
- Tracks protein intake against 150g daily target
- Journal functionality: free-text notes on how I feel, energy, soreness
- Persistent across sessions (builds history over time)
- Evolves from existing React artifacts (Whoop tracker + training chat assistant)

### G5b: Running Coach (VO2max focus, Runna-style)

Evidence-based running coach focused on increasing VO2max from ~43-45 to 48+, while preserving muscle mass.

**Requirements:**
- Programs in training blocks (base → build → peak), not static weekly plans
- Polarized model: 80% easy (zone 2), 20% hard (intervals, tempo)
- Adapts to recovery score: adjusts intensity and volume based on HRV/RHR/sleep
- Knows my running data: cadence 150 (target 170), GCT 262ms, only 3/58 runs were zone 2
- Respects the muscle mass constraint: caps running volume at ~6 runs/month based on my data showing LBM loss above that threshold
- Includes Concept 2 rower as VO2max stimulus alternative
- Every recommendation cites evidence tier (meta-analysis > RCT > observational > consensus)
- Key references: Seiler (polarized training), Helgerud (Norwegian 4×4), Billat (vVO2max), Daniels (training zones)

### G5c: Strength Coach (hypertrophy focus)

Evidence-based strength coaching for hypertrophy, autoregulated to recovery state and integrated with running load.

**Requirements:**
- Knows current lifts: bench e1RM 72kg, squat 85kg, RDL 117kg, pull-ups BW×10
- Addresses volume compliance problem (~50%) and muscle group imbalances (back 40%, legs 31% of target)
- Programs with RPE-based autoregulation — adjusts load to daily readiness
- Manages interference effect: sequences strength and cardio optimally within the week
- Tracks progressive overload across mesocycles, not just session to session
- Flags when volume drops below minimum effective dose for a muscle group
- Every recommendation cites evidence tier
- Key references: Schoenfeld (volume dose-response), Helms (RPE autoregulation), Wilson (concurrent training), Krieger (set volume meta-analysis)

### G5d: Scientific Advisor (evidence layer)

Not a separate agent — a quality standard baked into both coaches' system prompts.

**Requirements:**
- All training recommendations must be tagged with evidence tier:
  - Tier 1: systematic reviews / meta-analyses
  - Tier 2: multiple RCTs with consistent findings
  - Tier 3: single RCTs or strong mechanistic evidence
  - Tier 4: observational / expert consensus
- When personal data contradicts population-level evidence, flag it explicitly
- No bro-science: if evidence is weak or mixed, say so
- Cite specific studies when making key programming decisions
- Distinguish between well-established principles and emerging/contested findings

### G6: Morning Briefing (on-demand)

Contextual daily summary triggered when I want it — not pushed automatically.

**Requirements:**
- Triggered by Apple Shortcut tap or opening a dashboard
- Pulls today's calendar (lectures, deadlines, appointments)
- Checks reading progress: what's due for today's lectures that I haven't read
- Checks training plan: what's scheduled, what recovery looks like
- Generates a 2-3 paragraph briefing: "You have IR3 at 10. Read Wendt Ch. 6 before then. Training: rest day per plan, recovery is green."
- Optional breakfast reading mode: "give me a 3-minute summary of the key arguments in today's assigned reading"

### G7: Boox Launcher (future)

Custom home screen for the Boox Note Air 3 that surfaces study-relevant information.

**Requirements (Phase 4):**
- Shows today's readings and completion status
- Quick access to relevant PDFs/notes for current study session
- E-ink optimised: high contrast, no animations, minimal refresh
- Could be a simple web app displayed in Boox's browser
- Pulls data from Supabase (reading checklists, schedule)

---

## Data Architecture

### Tracking State (structured data)

| Data Type | Examples | Update Frequency |
|-----------|----------|-----------------|
| Reading progress | Which texts read, when, depth level | Daily |
| Training logs | Workouts, recovery metrics, meals | Daily |
| Learning patterns | Per-course study method effectiveness | Weekly (derived) |
| Goals & deadlines | Exam dates, assignment due dates, targets | As changed |
| Calendar events | Lectures, study blocks, training sessions | Synced from Apple Calendar |

**Decision needed:** Where does this live? (Supabase recommended for universal access)

### Course Materials (files)

| Content Type | Volume | Storage |
|-------------|--------|---------|
| Lecture slides (PowerPoints) | ~10-30 per course | Mac mini / iMac local |
| Reading PDFs | ~20-50 per course | Mac mini / iMac local |
| Obsidian notes | Growing vault | iMac (Obsidian vault) |
| Syllabi & reading lists | 1 per course | Embedded in Skills + Projects |

### Persistent Artifact State

| Data | Storage Key | Used By |
|------|------------|---------|
| Training journal | `whoop-j`, `whoop-days` | Training dashboard |
| Training chat logs | `training-logs` | Training assistant |
| Reading checklists | TBD | Academic dashboard |
| Course progress | TBD | Progress tracker |

---

## Agent Design

### Per-Course Agent Structure

Each course agent consists of:

```
┌─────────────────────────────────────┐
│           Course Agent              │
├─────────────────────────────────────┤
│ Claude Project (deep knowledge)     │
│  ├── Uploaded: slides, key PDFs     │
│  ├── System prompt: expert role     │
│  └── Accumulated conversation       │
│       context about my learning     │
├─────────────────────────────────────┤
│ Claude Skill (scaffolding)          │
│  ├── Syllabus structure (weeks)     │
│  ├── Reading list with dependencies │
│  ├── Exam format & strategy         │
│  └── Key frameworks & theorists     │
├─────────────────────────────────────┤
│ Learning Profile (per-course)       │
│  ├── Preferred study methods        │
│  ├── Known strengths / gaps         │
│  ├── Processing depth per text      │
│  └── What worked / what didn't      │
├─────────────────────────────────────┤
│ Reading Checklist                   │
│  ├── Per-week required readings     │
│  ├── Completion status + date       │
│  ├── Depth level (read/structured/  │
│  │    compared/tested)              │
│  └── Priority score (based on       │
│       schedule + exam proximity)    │
└─────────────────────────────────────┘
```

### Command Center Agent

Sits above all course agents and the training silo:

```
┌─────────────────────────────────────┐
│         Command Center              │
├─────────────────────────────────────┤
│ Reads from:                         │
│  ├── All course reading checklists  │
│  ├── Training logs & recovery       │
│  ├── Calendar (Apple Calendar)      │
│  └── Learning profiles (all courses)│
├─────────────────────────────────────┤
│ Produces:                           │
│  ├── Morning briefing               │
│  ├── Weekly progress report         │
│  ├── Priority recommendations       │
│  └── Risk alerts ("falling behind") │
├─────────────────────────────────────┤
│ Available via:                      │
│  ├── React dashboard artifact       │
│  ├── Apple Shortcut trigger         │
│  └── Boox browser (future)          │
└─────────────────────────────────────┘
```

---

## Implementation Phases

### Phase 1 — Foundation (now, no infrastructure)
- Build course Skills with syllabus scaffolding for IR3, Macro Econ, Qual Methods
- Create reading checklist React artifact with persistent storage
- Evolve training dashboard with journal + recommendations
- Extract learning profiles from existing Claude conversations
- Set up Claude Projects per course with uploaded materials

### Phase 2 — Infrastructure (add data layer + automation)
- Set up Supabase for shared tracking state
- Set up GitHub repo for system code + prompt templates
- Connect React artifacts to Supabase (replacing artifact-only storage)
- Build Apple Shortcut for on-demand briefing (calls Anthropic API)
- Set up Tailscale on Mac mini + iMac for secure remote access

### Phase 3 — Intelligence (add automation + monitoring)
- Build Mac mini scheduled scripts (Apple Calendar sync, progress monitoring)
- Implement per-course learning pattern tracking
- Build cross-course progress tracker with risk alerts
- GitHub Actions for scheduled tasks (backup to Mac mini)
- Connect calendar events to reading recommendations

### Phase 4 — Full System (polish + extend)
- Boox Note Air 3 custom launcher
- Advanced learning monitor with study method recommendations
- Full command center dashboard (web app on Mac mini)
- Proactive notifications via Pushover/Telegram
- Data export and review tools

---

## Design Principles

1. **Start simple, add complexity only when needed.** Phase 1 uses only Claude's existing features.
2. **Per-course, not universal.** Every learning model, every checklist, every agent adapts to the specific course.
3. **Pull over push.** You decide when to check in. No notification spam.
4. **Raw sources first.** The system helps you structure and process — it doesn't summarise prematurely.
5. **Mobile-friendly.** Everything must work on iPhone via Claude app or Shortcuts. Boox compatibility is a bonus.
6. **E-ink aware.** Design for high contrast, no animations, minimal refresh from the start.
7. **Data portability.** If Supabase dies or Claude changes, your data should be exportable.
8. **Honest about gaps.** The system should say "I don't have enough data to advise" rather than guess.
