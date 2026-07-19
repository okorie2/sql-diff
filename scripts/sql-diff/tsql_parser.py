import re
from models import SqlObject

OBJECT_PATTERN = re.compile(
    r"(CREATE\s+OR\s+ALTER|ALTER)\s+"
    r"(PROCEDURE|FUNCTION|VIEW|TRIGGER)\s+"
    r"([^\s(]+)",
    re.IGNORECASE,
)


def extract_objects(sql, source_file=""):
    objects = []

    # Split SQL file into batches using GO separator
    batches = re.split(r"(?im)^\s*GO\s*$", sql)

    for batch in batches:
        match = OBJECT_PATTERN.search(batch)

        if match:
            objects.append(
                SqlObject(
                    object_type=match.group(2).upper(),
                    name=match.group(3),
                    definition=batch.strip(),
                    source_file=source_file,
                )
            )

    return objects
