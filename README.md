# SQL Diff

A Git-aware SQL migration review tool.

SQL Diff improves the code review experience for database migrations by comparing changed SQL objects (stored procedures, functions, views, triggers, tables, and indexes) against their previous definitions rather than previous migration files.

Instead of asking reviewers to manually search through migration history, SQL Diff automatically finds the latest valid version of each SQL object from the target branch and generates an HTML report showing exactly what changed.

---

## Why?

Many teams follow a migration-based workflow:

```text
migrations/
├── 0001_CreateBook.sql
├── 0002_UpdateBook.sql
├── 0003_UpdateBook.sql
└── 0004_UpdateBook.sql
```

Every database change creates a new migration file.

When reviewing a pull request containing:

```text
0004_UpdateBook.sql
```

GitHub only shows the changes inside that migration file.

The reviewer cannot easily see:

- What the previous version of the SQL object looked like
- Which migration last modified it
- What actually changed in the database object

Reviewers often have to manually search through migration history before they can confidently review a change.

SQL Diff automates this process.

---

## How It Works

```text
          Get tip of base branch
                   │
                   ▼
    Read migration files from base branch
                   │
                   ▼
    Build latest SQL object index
                   │
                   ▼
   Parse changed migration files (PR)
                   │
                   ▼
    Match changed objects to index
                   │
                   ▼
        Generate SQL diff
                   │
                   ▼
         Generate HTML report
                   │
                   ▼
   Publish report to GitHub Pages
```

---

## Features

- Detects changed migration files using Git diff
- Compares against the latest version of the target branch
- Supports multiple SQL objects per migration file
- Builds an index of the latest object definitions
- Generates unified diffs using Python's `difflib`
- Supports SQL syntax highlighting
- Produces static HTML reports
- Publishes PR-specific reports through GitHub Pages
- Designed for CI/CD and pull request workflows

---

## Supported SQL Objects

Currently supports:

- Stored Procedures
- Functions
- Views
- Triggers
- Tables


---

## Project Structure

```text
scripts/sql-diff/
├── main.py
├── git_utils.py
├── sql_parser.py
├── indexer.py
├── comparer.py
├── html_reporter.py
└── models.py
```

---

## How It Works

### 1. Find the Tip of the Base Branch

SQL Diff compares against the latest version of the target branch.

Example:

```text
origin/main
```

The commit is resolved using:

```bash
git rev-parse origin/main
```

The base branch can also be configured:

```bash
python scripts/sql-diff/main.py \
    --base-branch origin/develop
```

### 2. Find Changed Migration Files

SQL Diff identifies new migration files introduced by the pull request.

```bash
git diff --name-only --diff-filter=A [base_branch] HEAD
```

Only SQL migration files are processed:

```text
migrations/*.sql
```

### 3. Parse SQL Objects

Migration files are scanned for supported SQL objects.

Example:

```sql
CREATE OR ALTER PROCEDURE dbo.usp_AddBook
AS
BEGIN
    ...
END
```

Multiple SQL objects within a single migration file are supported.

### 4. Build Object Index

SQL Diff reads migration files from the base branch and builds an index containing the latest definition of every SQL object.

Example:

```python
{
    "dbo.usp_addbook": SqlObject(...),
    "dbo.usp_updatebook": SqlObject(...)
}
```

This allows SQL Diff to quickly find the previous version of an object without manually searching migration history.

### 5. Compare Objects

Each SQL object changed in the pull request is matched against its previous definition.

Python's `difflib` generates a unified SQL diff showing:

- Added lines
- Removed lines
- Modified sections

### 6. Generate Report

An HTML report is produced containing:

- Summary of changed SQL objects
- Previous object location
- Current definition
- SQL syntax highlighting
- Unified SQL diff
- Collapsible sections for each object

---

## GitHub Pages Integration

SQL Diff publishes reports as static pages.

Each pull request gets its own URL:

```text
https://<owner>.github.io/<repo>/pr-<number>/
```

Example:

```text
https://example.github.io/sql-diff/pr-42/
```

Multiple pull requests can have reports available simultaneously:

```text
gh-pages/
├── pr-12/
│   └── index.html
│
├── pr-13/
│   └── index.html
│
└── pr-14/
    └── index.html
```

When a pull request is updated, only that PR's report is replaced.

---

## GitHub Pages Setup

Before using SQL Diff in CI:

1. Create a `gh-pages` branch.
2. Go to:

   **Repository Settings → Pages**

3. Configure:

   - **Source:** Deploy from a branch
   - **Branch:** `gh-pages`
   - **Folder:** `/`

SQL Diff will automatically publish reports into:

```text
/pr-{pull-request-number}/
```

---

## Cleanup Workflow

The repository also includes a GitHub Actions workflow:

```text
.github/workflows/cleanup-pr-report.yml
```

This workflow automatically removes SQL Diff reports from the `gh-pages` branch when a pull request is closed.

### What it does

When a pull request is closed, the workflow:

1. Checks out the `gh-pages` branch.
2. Removes the report directory for the closed pull request:

   ```text
   pr-{pull-request-number}/
   ```

3. Commits the deletion.
4. Pushes the updated `gh-pages` branch.

This ensures that reports for active pull requests remain available while reports for closed pull requests are automatically cleaned up, preventing the GitHub Pages branch from growing indefinitely.

---

## Running Locally

Run:

```bash
python scripts/sql-diff/main.py
```

With a custom base branch:

```bash
python scripts/sql-diff/main.py \
    --base-branch origin/main
```

The generated report will be written to:

```text
report/pr-{pr-number}/index.html
```

Open it in your browser:

```bash
open report/pr-{pr-number}/index.html
```

---

## Future Improvements

Planned enhancements include:

- Side-by-side diff view
- Search and filtering
- Better SQL parsing for complex scripts
- Database schema modelling
- Semantic SQL diffs
- Additional SQL dialect support
- Constraint-level change detection
- Object dependency tracking

---

## Motivation

Traditional Git diffs work well for application code but are less effective for migration-based database development.

SQL Diff aims to make reviewing SQL changes as straightforward as reviewing application code by reconstructing previous database object states automatically.

---

## License

MIT