# Personal AI System

A unified personal AI system tracking academic progress, training, and daily priorities — with contextual, personalised advice across domains.

## Architecture

```
┌──────────────────────────────────────────────────────┐
│                   Command Center                      │
│         (cross-domain dashboard + briefings)          │
├────────────────────┬─────────────────────────────────┤
│   School Silo      │        Training Silo            │
│  ┌──────────────┐  │  ┌─────────────────────────┐    │
│  │ IR3 Agent    │  │  │ Training Coach           │    │
│  │ Econ Agent   │  │  │ Running Coach (VO2max)   │    │
│  │ Methods Agent│  │  │ Strength Coach (hypert.) │    │
│  └──────────────┘  │  └─────────────────────────┘    │
├────────────────────┴─────────────────────────────────┤
│              Supabase (shared data layer)             │
│  readings · training_logs · recovery_logs · goals    │
│  events · journal · learning_profiles · ku_schedule  │
├──────────────────────────────────────────────────────┤
│              Hardware / Access Layer                   │
│  MacBook Pro · Mac mini · iMac · iPhone · Boox       │
│              (connected via Tailscale)                │
└──────────────────────────────────────────────────────┘
```

## Quick Start

1. **Clone** this repo
2. **Copy** `.env.example` → `.env` and fill in your keys
3. **Run** `supabase/schema.sql` in your Supabase SQL Editor
4. **Run** `supabase/seed.sql` to populate initial data
5. **Install** Tailscale on Mac mini + iMac
6. **Set up** Claude Projects per course with uploaded materials

## Data Layer

- **Supabase** (EU region): Shared PostgreSQL database accessible from Claude artifacts, Mac mini scripts, Apple Shortcuts, and future Boox launcher
- **119 readings** across IR2, Økonomi, and Metode (weeks 6–21, Spring 2026)
- **Training logs** with Whoop-style recovery scoring (HRV baseline ~50.8ms, RHR ~64.8)

## Repo Structure

```
supabase/          Schema + seed data
agents/            System prompts and profiles per agent
scripts/           Mac mini automation (Python)
shortcuts/         Apple Shortcuts documentation
dashboards/        React artifact source files
docs/              Architecture and requirements docs
```

## Design Principles

1. Start simple, add complexity only when needed
2. Per-course, not universal (every model adapts to the specific course)
3. Pull over push (you decide when to check in)
4. Raw sources first (the system helps structure, not summarise)
5. Mobile-friendly (iPhone via Claude app or Shortcuts)
6. Data portability (exportable if anything breaks)

## Implementation Phases

- **Phase 1** — Foundation: Skills, Projects, artifact storage ✓
- **Phase 2** — Infrastructure: Supabase + GitHub + Tailscale ← *current*
- **Phase 3** — Intelligence: Automation + monitoring
- **Phase 4** — Full System: Boox launcher, proactive notifications
