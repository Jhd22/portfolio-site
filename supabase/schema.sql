-- =============================================================================
-- Personal AI System — Supabase Schema
-- Created: 2026-03-28
-- Region: EU (Frankfurt)
-- =============================================================================

-- Enable UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================================================
-- READINGS — per-text tracking across all courses
-- =============================================================================
CREATE TABLE readings (
    id              INT PRIMARY KEY,
    course          TEXT NOT NULL CHECK (course IN ('IR2', 'Økonomi', 'Metode')),
    week            INT NOT NULL CHECK (week BETWEEN 6 AND 21),
    lecture         TEXT NOT NULL,
    title           TEXT NOT NULL,
    author          TEXT NOT NULL,
    pages           INT NOT NULL DEFAULT 0,
    status          TEXT NOT NULL DEFAULT 'ikke_startet'
                        CHECK (status IN ('ikke_startet', 'i_gang', 'læst')),
    priority        TEXT NOT NULL DEFAULT 'mellem'
                        CHECK (priority IN ('høj', 'mellem', 'lav')),
    type            TEXT NOT NULL DEFAULT 'pensum'
                        CHECK (type IN ('catch_up', 'pensum')),
    mode            TEXT NOT NULL DEFAULT 'fuld'
                        CHECK (mode IN ('fuld', 'noter', 'skim')),
    depth           TEXT NOT NULL DEFAULT 'unread'
                        CHECK (depth IN ('unread', 'read', 'noted', 'restructured', 'compared', 'tested')),
    notes           TEXT,
    started_at      TIMESTAMPTZ,
    completed_at    TIMESTAMPTZ,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER readings_updated_at
    BEFORE UPDATE ON readings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Indexes for common queries
CREATE INDEX idx_readings_course ON readings(course);
CREATE INDEX idx_readings_week ON readings(week);
CREATE INDEX idx_readings_status ON readings(status);
CREATE INDEX idx_readings_course_week ON readings(course, week);

-- =============================================================================
-- TRAINING_LOGS — daily workout entries
-- =============================================================================
CREATE TABLE training_logs (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    date            DATE NOT NULL,
    type            TEXT NOT NULL
                        CHECK (type IN ('strength_upper', 'strength_lower', 'run', 'cycling', 'mobility', 'rest', 'rowing')),
    duration_min    INT,
    exercises       JSONB,           -- array of {name, sets, reps, weight}
    distance_km     FLOAT,           -- for runs/cycling
    pace_min_km     FLOAT,
    zone            TEXT CHECK (zone IN ('zone2', 'tempo', 'intervals', 'mixed')),
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_training_logs_date ON training_logs(date);
CREATE INDEX idx_training_logs_type ON training_logs(type);

-- =============================================================================
-- RECOVERY_LOGS — morning biometric entries
-- =============================================================================
CREATE TABLE recovery_logs (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    date            DATE NOT NULL UNIQUE,
    hrv             FLOAT NOT NULL,
    rhr             FLOAT NOT NULL,
    sleep_hours     FLOAT NOT NULL,
    sleep_quality   TEXT CHECK (sleep_quality IN ('good', 'fair', 'poor')),
    recovery_score  FLOAT NOT NULL CHECK (recovery_score BETWEEN 0 AND 100),
    recovery_zone   TEXT NOT NULL CHECK (recovery_zone IN ('green', 'yellow', 'red')),
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_recovery_logs_date ON recovery_logs(date);
CREATE INDEX idx_recovery_logs_zone ON recovery_logs(recovery_zone);

-- =============================================================================
-- TRAINING_PLANS — structured programming from coaches
-- =============================================================================
CREATE TABLE training_plans (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    coach           TEXT NOT NULL CHECK (coach IN ('running', 'strength')),
    week_number     INT NOT NULL,
    day_of_week     INT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
    session_type    TEXT NOT NULL,    -- e.g. 'zone2_easy', '4x4_intervals', 'upper_hypertrophy'
    prescription    JSONB NOT NULL,   -- structured session detail
    notes           TEXT,             -- coaching rationale
    completed       BOOLEAN NOT NULL DEFAULT FALSE,
    actual_log_id   UUID REFERENCES training_logs(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_training_plans_coach ON training_plans(coach);
CREATE INDEX idx_training_plans_week ON training_plans(week_number);

-- =============================================================================
-- JOURNAL_ENTRIES — daily free-text journal
-- =============================================================================
CREATE TABLE journal_entries (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    date            DATE NOT NULL,
    content         TEXT NOT NULL,
    tags            TEXT[],           -- e.g. {'energy', 'stress', 'soreness'}
    mood            INT CHECK (mood BETWEEN 1 AND 5),
    energy          INT CHECK (energy BETWEEN 1 AND 5),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_journal_entries_date ON journal_entries(date);

-- =============================================================================
-- GOALS — targets and deadlines
-- =============================================================================
CREATE TABLE goals (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    domain          TEXT NOT NULL CHECK (domain IN ('school', 'training', 'general')),
    course          TEXT,             -- for school goals
    title           TEXT NOT NULL,
    target_date     DATE,
    status          TEXT NOT NULL DEFAULT 'active'
                        CHECK (status IN ('active', 'completed', 'paused')),
    notes           TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER goals_updated_at
    BEFORE UPDATE ON goals
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE INDEX idx_goals_domain ON goals(domain);
CREATE INDEX idx_goals_status ON goals(status);

-- =============================================================================
-- EVENTS — deadlines and key dates
-- =============================================================================
CREATE TABLE events (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    week            INT NOT NULL,
    date            DATE,
    label           TEXT NOT NULL,
    type            TEXT NOT NULL CHECK (type IN ('deadline', 'exam', 'holiday', 'info')),
    course          TEXT
);

CREATE INDEX idx_events_week ON events(week);
CREATE INDEX idx_events_type ON events(type);

-- =============================================================================
-- LEARNING_PROFILES — per-course learning pattern tracking
-- =============================================================================
CREATE TABLE learning_profiles (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    course          TEXT NOT NULL,
    observation     TEXT NOT NULL,
    evidence        TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_learning_profiles_course ON learning_profiles(course);

-- =============================================================================
-- KU_SCHEDULE — weekly class timetable
-- =============================================================================
CREATE TABLE ku_schedule (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    week            INT,             -- NULL = default schedule
    day_of_week     TEXT NOT NULL,    -- 'Mandag', 'Tirsdag', etc.
    time_slot       TEXT NOT NULL,    -- e.g. '08-10'
    course          TEXT NOT NULL,
    session_type    TEXT NOT NULL,    -- 'Forelæsning', 'Hold', 'Fagcafé', etc.
    room            TEXT
);

CREATE INDEX idx_ku_schedule_week ON ku_schedule(week);

-- =============================================================================
-- ROW LEVEL SECURITY
-- =============================================================================
-- Enable RLS on all tables (single-user, but good practice)
ALTER TABLE readings ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE recovery_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE training_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE journal_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE learning_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE ku_schedule ENABLE ROW LEVEL SECURITY;

-- Allow full access via service role (Mac mini scripts)
-- and authenticated/anon key (React artifacts, Shortcuts)
CREATE POLICY "Allow all for service role" ON readings FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON training_logs FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON recovery_logs FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON training_plans FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON journal_entries FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON goals FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON events FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON learning_profiles FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all for service role" ON ku_schedule FOR ALL USING (true) WITH CHECK (true);

-- =============================================================================
-- VIEWS — convenience queries
-- =============================================================================

-- Reading progress summary per course
CREATE OR REPLACE VIEW reading_progress AS
SELECT
    course,
    COUNT(*) AS total_texts,
    COUNT(*) FILTER (WHERE status = 'læst') AS completed,
    COUNT(*) FILTER (WHERE status = 'i_gang') AS in_progress,
    COUNT(*) FILTER (WHERE status = 'ikke_startet') AS not_started,
    ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'læst') / COUNT(*), 1) AS completion_pct,
    SUM(pages) AS total_pages,
    SUM(pages) FILTER (WHERE status = 'læst') AS pages_completed
FROM readings
GROUP BY course;

-- Readings due by week (unread texts up to a given week)
CREATE OR REPLACE VIEW readings_backlog AS
SELECT
    course,
    week,
    lecture,
    title,
    author,
    pages,
    status,
    priority,
    depth
FROM readings
WHERE status != 'læst'
ORDER BY
    CASE priority WHEN 'høj' THEN 1 WHEN 'mellem' THEN 2 WHEN 'lav' THEN 3 END,
    week,
    course;

-- Recent training activity (last 14 days)
CREATE OR REPLACE VIEW recent_training AS
SELECT
    tl.date,
    tl.type,
    tl.duration_min,
    tl.distance_km,
    tl.zone,
    rl.recovery_score,
    rl.recovery_zone,
    rl.hrv,
    rl.rhr,
    rl.sleep_hours
FROM training_logs tl
LEFT JOIN recovery_logs rl ON tl.date = rl.date
WHERE tl.date >= CURRENT_DATE - INTERVAL '14 days'
ORDER BY tl.date DESC;
