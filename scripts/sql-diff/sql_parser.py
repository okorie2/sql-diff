import re
from models import SqlObject

OBJECT_PATTERNS = [
    (
        "PROCEDURE",
        re.compile(
            r"(CREATE(?:\s+OR\s+ALTER)?|ALTER)\s+PROCEDURE\s+(?P<name>[\[\]\w.]+)",
            re.IGNORECASE,
        ),
    ),
    (
        "FUNCTION",
        re.compile(
            r"(CREATE(?:\s+OR\s+ALTER)?|ALTER)\s+FUNCTION\s+(?P<name>[\[\]\w.]+)",
            re.IGNORECASE,
        ),
    ),
    (
        "VIEW",
        re.compile(
            r"(CREATE(?:\s+OR\s+ALTER)?|ALTER)\s+VIEW\s+(?P<name>[\[\]\w.]+)",
            re.IGNORECASE,
        ),
    ),
    (
        "TRIGGER",
        re.compile(
            r"(CREATE(?:\s+OR\s+ALTER)?|ALTER)\s+TRIGGER\s+(?P<name>[\[\]\w.]+)",
            re.IGNORECASE,
        ),
    ),
    (
        "TABLE",
        re.compile(
            r"CREATE\s+TABLE\s+(?P<name>[\[\]\w.]+)",
            re.IGNORECASE,
        ),
    ),
]


def extract_objects(sql, source_file=""):
    objects = []

    batches = re.split(r"(?im)^\s*GO\s*$", sql)

    for batch in batches:
        batch = batch.strip()

        if not batch:
            continue

        for object_type, pattern in OBJECT_PATTERNS:
            match = pattern.search(batch)

            if not match:
                continue

            objects.append(
                SqlObject(
                    object_type=object_type,
                    name=match.group("name"),
                    definition=batch,
                    source_file=source_file,
                )
            )

            break

    return objects
