import subprocess
import re

OBJECT_PATTERN = re.compile(
    r"(CREATE\s+OR\s+ALTER|ALTER)\s+"
    r"(PROCEDURE|FUNCTION|VIEW|TRIGGER)\s+"
    r"([^\s(]+)",
    re.IGNORECASE,
)

merge_base = subprocess.check_output(
    ["git", "merge-base", "HEAD", "origin/main"], text=True
).strip()

changed_files = subprocess.check_output(
    ["git", "diff", "--name-only", merge_base, "HEAD"],
    text=True,
).splitlines()

migration_files = [
    f for f in changed_files if f.startswith("migrations/") and f.endswith(".sql")
]

print("Changed migrations:")
for f in migration_files:
    print(f)


def extract_objects(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    objects = []

    for match in OBJECT_PATTERN.finditer(content):
        objects.append(
            {
                "type": match.group(2).upper(),
                "name": match.group(3),
            }
        )

    return objects


for file in migration_files:
    print(file)
    print(extract_objects(file))
