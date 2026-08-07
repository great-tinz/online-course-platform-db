# Online Course Platform Database — Progress Log

> This file is the **single source of truth** for this whole learning journey. It is kept updated after every session. If anything ever happens to this PC (C drive dies, opencode reinstalled, etc.), paste THIS FILE into a fresh opencode session and it will know exactly what I'm doing and where to continue.

## 🚨 HOW TO RESUME (read this if you're starting fresh)

If you are reading this after a break, a reinstall, or a new machine:

1. Paste this whole file (or tell the AI "read PROGRESS.md") as your first message.
2. It knows: the project, the database, every SQL level, every lesson learned, current status, known to-dos, and future plans.
3. Then simply say **"continue where we left off"** — the AI should pick up at the current status line below.

## Project status: IN PROGRESS — SQL training (Levels 1–5)

---

## 🎯 My goals (written as SMART goals)

**Big-picture dream:** Become a Data Analyst. Learn SQL + Python (pandas) so deeply that I can take a real job or build a portfolio that proves it.

1. **SQL mastery — by Sept 2026 (before internship deadline):**
   - Specific: finish all SQL levels (1–5), the consolidation sprint, push to GitHub, do Scenario 4, and the Aiven DBA phase.
   - Measurable: a GitHub repo with schema + queries + screenshots; every level's questions answered correctly; my own "why" notes written for every mistake.
   - Achievable: one level per session, incremental.
   - Relevant: SQL is the #1 skill every data analyst must know.
   - Time-bound: finish the SQL curriculum before the Oasis internship deadline (Sept 15, 2026).

2. **Python + pandas (for Oasis Infobyte internship tasks) — by Sept 15, 2026:**
   - Specific: complete the 3 internship tasks (EDA Retail Sales, Cleaning Data, House Prices regression) using Python/pandas, and keep the code in a GitHub repo.
   - Measurable: 3 finished, working task files + README each.
   - Achievable: learned in parallel with SQL (complementary, not harmful multitasking).
   - Relevant: this is real, unpaid, resume-worthy work.
   - Time-bound: deadline Sept 15, 2026.

3. **A lifelong habit — every session:**
   - Write every query by hand (no AI-generated SQL).
   - Predict the result row count BEFORE running (non-negotiable teaching rule).
   - Update PROGRESS.md at the end of every session.

---

## What this project is

A complete database build for an **Online Course Platform**, done from scratch:

- **Scenario: 1** — Online Course Platform (6 tables)
- The full workflow: ER diagram → schema → data → queries → screenshots
- Learning goal: master SQL by **understanding**, writing every query by hand (no AI-generated SQL), and learning from errors with "why" explanations

---

## Roadmap (where we are)

| Step | Status |
|---|---|
| Scenario 1: ER diagram | ✅ Done |
| Schema (create_tables.sql) | ✅ Done |
| Data (insertdata.sql) | ✅ Done (one known mismatch — see below) |
| **Level 1** — See & filter (SELECT, WHERE, LIKE, BETWEEN, IN, IS NULL) | ✅ Done |
| **Level 2** — Sort & Limit (ORDER BY, LIMIT) | ✅ Done |
| **Level 3** — Summarize (GROUP BY, COUNT, AVG, SUM, MIN, MAX, HAVING, DISTINCT, ROUND, YEAR) | ✅ Done |
| **Level 4** — JOINs (INNER, LEFT, aliases, COUNT(DISTINCT), multiplication trap) | ✅ Done |
| **Level 5** — Subqueries (IN / NOT IN, scalar, EXISTS, nested) | 🔄 IN PROGRESS |
| Consolidation sprint (fix files, README, final screenshots) | ⏳ Not started |
| Push to GitHub | ⏳ Not started (user decides when) |
| Scenario 4 — harder DB design from scratch | ⏳ Not started |

---

## Database overview

**Live MySQL version used:** 9.7.0 (docs reference: MySQL 8.4 Manual)

| Table | Row count | Primary key | Notes |
|---|---|---|---|
| student | 603 | student_id (AUTO, 1000+) | Names repeat on purpose (data realism) |
| instructor | 17 | instructor_id (AUTO, 5000+) | All use gmail |
| course | 31 | **course_code** | PK is the code, not an id |
| enrollment | 603 | enrollment_id (AUTO, 100000+) | Unique (student_id, course_code) |
| review | 100 | review_id (AUTO, 500000+) | Rating 1–5, unique (student_id, course_code) |
| lesson | 93 | lesson_id (AUTO) | Each course has 3 lessons (sequence 1,2,3) |

### The 6 FK connections (ER diagram = JOIN recipe)

1. `course.instructor_id` → `instructor.instructor_id`
2. `enrollment.student_id` → `student.student_id`
3. `enrollment.course_code` → `course.course_code`
4. `review.student_id` → `student.student_id`
5. `review.course_code` → `course.course_code`
6. `lesson.course_code` → `course.course_code`

---

## Project files

```
online_course_platform_db/
├── ER-Diagram-Online-Course-Platform.png
├── PROGRESS.md                  ← this file (kept updated)
├── schema/
│   └── create_tables.sql        ← 6 CREATE TABLE statements (source of truth)
├── data/
│   └── insertdata.sql           ← all INSERTs, FK-safe order (1,462 lines)
├── queries/
│   └── retrieval/
│       ├── select_all_queries.sql       ← DESC ×6 + SELECT * ×6
│       ├── basic_filters.sql            ← Level 1 (14 queries)
│       ├── sorting_limit.sql            ← Level 2
│       ├── summarize_aggregates.sql     ← Level 3
│       ├── joins.sql                    ← Level 4
│       └── subqueries.sql               ← Level 5 (in progress)
└── screenshot/
    ├── data-retrieval/          ← query result screenshots
    └── schema desc img/         ← DESC screenshots (6)
```

---

## SQL levels — key lessons learned (my own "why" notes)

### Level 1 — Filtering
- `IS` is only used with NULL. Comparison operators (`=`, `>`, `<`) stand alone.
- `%` wildcard works only with `LIKE`, not `<>` (that compares exact text).
- `'%gmail'` = ends with "gmail"; `'%gmail.com'` = ends with gmail.com. Literal letters must appear exactly where placed.
- There are NO yahoo instructors — all 17 are gmail. (Never assume data matches reality — query it.)

### Level 2 — Sort & Limit
- `ORDER BY` = three mandatory pieces: `ORDER BY <column> <ASC|DESC>`.
- `LIMIT` without `ORDER BY` = random grab, not "first N".
- All three parts are mandatory: `ORDER price DESC` (missing BY) and `ORDER BY ASC` (missing column) are both errors.

### Level 3 — Summarize (GROUP BY)
- Processing order: `FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT`.
- WHERE filters raw rows **before** piles; HAVING filters piles **after** (uses `COUNT(*)`, never bare `COUNT`).
- GROUP BY is only useful when the grouped column **repeats** (course_code = 31 piles from 301 rows ✅; student_id = 603 piles of 1 ❌).
- After GROUP BY, every SELECT column is a pile name **or** an aggregate (ERROR 1055 / only_full_group_by).
- GROUP BY takes column names, never aggregates (`GROUP BY COUNT(*)` invalid).
- `SUM(*)` invalid — SUM needs a numeric column.
- Alias with a space breaks (`AS total _enrollments` → ERROR 1064).
- Aggregate in WHERE → ERROR 1111. Use HAVING.
- `ROUND(AVG(price),2)` not `AVG((price),2)`.
- Column is `completion_status`, NOT `enrollment_status` (ERROR 1054).
- `YEAR()` works for grouping dates.
- Single totals need **no GROUP BY** (e.g. COUNT(DISTINCT course_code) + COUNT(*) over whole lesson table).

### Level 4 — JOINs
- `JOIN` == `INNER JOIN` (MySQL default).
- `ON` connects **foreign key → primary key** — the FK lines in the ER diagram ARE the legal joins.
- MySQL won't error on wrong ON columns — it just returns garbage/empty set. Always check the schema first.
- Driving table: the "many" side. In INNER JOIN, table order doesn't change the result.
- **LEFT JOIN** = all rows from the LEFT table survive; unmatched get NULL on the right.
- "Find the empties" pattern: `FROM keep_all X LEFT JOIN maybe_some Y ... WHERE Y.key IS NULL`.
- `COUNT(Y.key)` gives 0 for empties; `COUNT(*)` would wrongly give 1.
- **Two-child-table trap:** joining a table to TWO child tables multiplies rows (DS101: 24 enrollments × 5 reviews = 120). Fix: `COUNT(DISTINCT ...)`.
- Functional dependency: `GROUP BY course_code` lets you select `title` (PK determines it); `GROUP BY difficulty_level` does NOT let you select `course_code`.

### Level 5 — Subqueries (in progress)
- Subquery = a query feeding another query. Inner runs **first**.
- Shapes: **IN** (returns a list, used with `WHERE x IN (...)`), **scalar** (one value, used with `WHERE x > (...)`), **EXISTS** (yes/no check).
- You can always run the inner query alone to debug.
- `NOT IN` is dangerous with NULLs; `NOT EXISTS` is safer (to use going forward).

### The 3-step decision flow (for any SQL question)
1. **Columns from more than one table?** → JOIN
2. **Filtering against a computed number/list (average, max, id list)?** → subquery
3. **Number per group, unique list, or filtered rows?** → GROUP BY / DISTINCT / WHERE

### The analyst translation table (business → tool)
| Business sentence | Hidden tool |
|---|---|
| "...with... / ...together..." | JOIN |
| "...above average / than the max / the most..." | subquery |
| "...never / no / without / who haven't..." | LEFT JOIN + IS NULL or NOT EXISTS |
| "...each / per / by..." | GROUP BY |
| "...just list / unique..." | DISTINCT |
| "...the average (one number)..." | aggregate, no GROUP BY |

---

## 📖 Full journey so far (session history)

- **Session 1–2:** Picked Scenario 1 (Online Course Platform, 6 tables). Decided NOT to use AI for SQL learning. Built the ER diagram by hand in the terminal, then wrote `schema/create_tables.sql` (6 CREATE TABLE statements, FKs included, course PK = course_code).
- **Session 3:** Wrote `data/insertdata.sql` (1,462 lines, FK-safe insert order: student → instructor → course → enrollment → review → lesson). Verified counts. **Important:** added 2 extra lessons manually in MySQL ("Introduction to Data Collection" CS105 and "Why Python Matters" PY101) that are NOT yet in the file (see Known issues).
- **Session 4 (Level 1):** SELECT + WHERE with `=`, `>`, `<`, LIKE with `%`, BETWEEN, IN, IS NULL. Wrote `queries/retrieval/basic_filters.sql` (14 queries).
- **Session 5 (Level 2):** ORDER BY (ASC/DESC), LIMIT. Wrote `sorting_limit.sql`. Learned the "three mandatory pieces" rule.
- **Session 6 (Level 3):** GROUP BY + COUNT/AVG/SUM/MIN/MAX, HAVING, DISTINCT, ROUND, YEAR. Wrote `summarize_aggregates.sql`. Learned the FROM→WHERE→GROUP BY→HAVING→ORDER BY→LIMIT processing order the hard way (ERROR 1055, 1111, 1064, 1054).
- **Session 7 (Level 4):** INNER JOIN + LEFT JOIN + aliases. Wrote `joins.sql`. Learned the FK map, the two-child-table multiplication trap, and COUNT(DISTINCT) fix.
- **Session 8 (Level 5, current):** Subqueries (IN, NOT IN, scalar, EXISTS). Wrote `subqueries.sql`. Currently mid-practice.
- **Internship decision (parallel):** Chose Oasis Infobyte **Data Analytics** track (not Data Science). Decided NOT to post on LinkedIn → no certificate, but GitHub + CV line still count.

---

## 🗺️ Future plans (in exact order)

1. **Finish Level 5** — subquery practice questions (Q1–Q9 in subqueries.sql): Tier 1 (WITH reviews ~100 / WITHOUT ~503 / courses with reviews ~29 / below-average price ~16), Tier 2 (nested), Tier 3 (SELECT-list subqueries as the clean Q9 fix, 31 rows).
2. **Close Level 4 gaps** — Q8 (students with no reviews ~503), Q10 (Completed-enrollment counts, 31 rows).
3. **Consolidation sprint** — fix known issues (below), final screenshots, write README.md.
4. **Push to GitHub** — only when I say so. After this, the repo (AND this progress file) are backed up forever in the cloud.
5. **Scenario 4** — a harder DB design from scratch (7+ tables, recursive relationship, subtyping, optional 1:1).
6. **DBA phase** — deploy to Aiven free MySQL (1GB), migrate via mysqldump, work on a remote DB.
7. **Python/pandas phase (parallel)** — Oasis Infobyte internship tasks, learned via a separate tutoring chat.
8. **Future database work** — deeper DBA skills, more scenarios, building a real portfolio.

---

## Known issues / to-dos (consolidation sprint)

1. **Lesson count mismatch:** the live DB has 93 lessons, but `insertdata.sql` only has 91. The 2 manual lessons added directly to MySQL are missing from the file:
   - "Introduction to Data Collection" (CS105, seq 1)
   - "Why Python Matters" (PY101, seq 1)
   → Must add these 2 rows to the lesson INSERT so the file matches the DB. Otherwise re-running the file loses them.
2. **basic_filters.sql** — lines 6, 11, 12 still show old (pre-fix) query versions. Update to the corrected ones that were verified in the terminal.
3. **sorting_limit.sql** — stray letter "i" on line 1. Remove it.
4. **summarize_aggregates.sql, joins.sql, subqueries.sql** — created by the user in terminal; verify contents/screenshots are saved.
5. **README.md** — not yet created. Add a project README before pushing to GitHub.
6. Screenshots — take final ones as each level is completed.

---

## 🔒 Backup strategy (WHERE this file lives & how to never lose it)

**Current location:** `C:\Users\ahiat\Desktop\MASTER FOLDER\DATA SCIENCE\online_course_platform_db\PROGRESS.md` — inside the project repo folder.

**Is this safe? YES — this is the right place, here's why:**

- It lives **inside the repo folder**, so when we push to GitHub, this file gets pushed too. GitHub is a free cloud backup that survives ANY PC death.
- A file in the "Data Science" folder (outside the repo) would NOT get pushed — that's the tradeoff you were worried about. So the repo location is actually better: **you get the folder AND the backup.**

**The 3-layer safety plan (so you're never scared again):**

1. **GitHub (the ultimate backup):** once pushed, the file exists forever online. This is THE fix for your fear — after push, even a dead C drive can't lose this history. Just clone the repo on a new machine.
2. **This file stays updated** every session, so the version on disk is always current for the next push.
3. **If you're extra paranoid (or before first push):** copy PROGRESS.md to wherever you already back up your other files (USB stick / external drive / cloud folder). It's a single .md file — 1 second to copy, do it any time.

**Before GitHub push exists:** the only copy is on this C drive. So if the PC dies BEFORE the first push, we lose everything. **That's the single biggest reason to push to GitHub early.** If you want, we can push a first version now (just the progress file + current files) so it's never at risk again, then keep pushing updates.

---

## Side projects / context (not part of this repo)

- **Oasis Infobyte virtual internship** — accepted for the Data Science track, but planning to complete the **Data Analytics** track instead (3 tasks: EDA Retail Sales, Cleaning Data, House Prices regression). Deadline: September 15. Will NOT post on LinkedIn (means no certificate, but GitHub portfolio + CV line still count). Runs in the Python/pandas phase, in parallel with continued SQL practice. Not started yet.
- **Next scenario:** Scenario 4 — harder design (7+ tables, recursive relationship, subtyping, optional 1:1).
- **Deployment later (DBA phase):** Aiven free MySQL (1GB), migrate via mysqldump, work remotely.
