# SQL Diff

A Git-aware SQL migration review tool.

SQL Diff improves the code review experience for database migrations by comparing changed SQL objects (stored procedures, functions, views and triggers) against their previous definitions, rather than against the previous migration file.

Instead of asking reviewers to manually search through historical migration files, SQL Diff automatically finds the latest version of each object before the current pull request and generates an HTML report showing exactly what changed.

---

## Why?

Many teams follow a migration-based workflow:

```
migrations/
    0001_CreateBook.sql
    0002_UpdateBook.sql
    0003_UpdateBook.sql
    0004_UpdateBook.sql
```

Every change to a stored procedure requires a new migration file.

When reviewing a pull request containing `0004_UpdateBook.sql`, GitHub only shows the changes inside that migration file.

The reviewer cannot easily see:

- What the previous version of the stored procedure looked like
- Which migration last modified it
- What actually changed in the SQL object

Reviewers often have to manually search through old migration files before they can review the change.

SQL Diff automates this process.

---

## How it works

```
        Get tip of base branch
                     │
                     ▼
      Read migration files at base tip
                     │
                     ▼
      Build index of latest SQL objects
                     │
                     ▼
     Parse changed migration files (HEAD)
                     │
                     ▼
      Match changed objects to index
                     │
                     ▼
          Generate unified SQL diff
                     │
                     ▼
             Produce HTML report
```

---

## Features

- Detects changed migration files using Git diff command
- Parses SQL objects from migration scripts
- Supports multiple SQL objects per migration file
- Builds an index of the latest object definitions
- Generates unified diffs using Python's `difflib`
- Produces a static HTML report suitable for GitHub Pages
- Designed for CI/CD and pull request workflows

---

## Supported SQL Objects

Currently supports:

- Stored Procedures


---

## Project Structure

```
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

### 1. Find the tip of the base branch


```
git rev-parse [base_branch]
```

---

### 2. Find changed migration files

```
git diff --name-only --diff-filter=A [base_branch] HEAD
```

Only migration files are processed.

---

### 3. Parse SQL objects

Migration files are scanned for SQL objects such as:

```sql
CREATE OR ALTER PROCEDURE dbo.usp_AddBook
```

Multiple objects within the same migration are supported.

---

### 4. Build historical index

The repository is inspected **at the merge base**, not the current working tree.

Every migration file is parsed and the latest definition of each SQL object is indexed.

Example:

```
{
    "dbo.usp_addbook": SqlObject(...),
    "dbo.usp_updatebook": SqlObject(...)
}
```

---

### 5. Compare objects

Each SQL object modified in the current pull request is matched against its previous definition.

Python's `difflib` generates a unified diff.

---

### 6. Generate report

An HTML report is produced containing:

- Summary of changed SQL objects
- Previous migration location
- Unified SQL diff
- Collapsible sections for each object

---

## Running Locally

```
python scripts/sql-diff/main.py
```

The generated report will be written to:

```
report/pr-{pr number}/index.html
```

Open it in your browser:

```
open report/pr-{pr number}/index.html
```

---

## Future Improvements

Planned enhancements include:

- SQL syntax highlighting
- Side-by-side diff view
- Support for additional SQL object types
- Better SQL parsing for complex scripts
- Search and filtering

---

## Motivation

SQL Diff aims to make reviewing SQL changes as straightforward as reviewing application code by reconstructing the previous state of database objects automatically.

---

## License

MIT