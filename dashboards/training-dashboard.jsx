// Training Dashboard — React Artifact
//
// Evolves from existing Whoop-style tracker + training chat assistant.
// Will connect to Supabase for persistent state instead of artifact storage.
//
// Features:
// 1. Daily recovery input (HRV, RHR, sleep) → recovery_logs table
// 2. Workout logging → training_logs table
// 3. Recovery score calculation and zone display
// 4. Training plan view (today's prescription from training_plans)
// 5. 14-day training history chart
// 6. Journal entry (free text + mood/energy) → journal_entries table
//
// Migration from artifact storage:
//   Old keys: 'whoop-j', 'whoop-days', 'training-logs'
//   New: all state in Supabase tables
//
// Supabase patterns same as study-dashboard.jsx
