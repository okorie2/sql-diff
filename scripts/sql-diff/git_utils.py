import subprocess


def get_base_tip(base_branch="origin/main"):
    return subprocess.check_output(
        ["git", "rev-parse", base_branch],
        text=True,
    ).strip()


def get_changed_migrations(merge_base, head="pr-head"):
    changed_files = subprocess.check_output(
        ["git", "diff", "--name-only", "--diff-filter=A", merge_base, head],
        text=True,
    ).splitlines()

    return [
        f for f in changed_files if f.startswith("migrations/") and f.endswith(".sql")
    ]


def list_files_at_commit(commit, directory):
    """
    Returns all files inside a directory at a specific commit.
    Example:
    list_files_at_commit("abc123", "migrations")
    """

    result = subprocess.check_output(
        [
            "git",
            "ls-tree",
            "-r",
            "--name-only",
            commit,
            directory,
        ],
        text=True,
    )

    return [file.strip() for file in result.splitlines() if file.endswith(".sql")]


def read_file_at_commit(commit, path):
    """
    Reads a file's contents from a specific git commit.
    Does not modify the working tree.
    """

    return subprocess.check_output(
        [
            "git",
            "show",
            f"{commit}:{path}",
        ],
        text=True,
    )
