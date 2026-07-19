import difflib


def generate_diff(old_definition, new_definition):
    return "\n".join(
        difflib.unified_diff(
            old_definition.splitlines(),
            new_definition.splitlines(),
            fromfile="previous",
            tofile="current",
            lineterm="",
        )
    )


def compare_objects(changed_objects, historical_index):
    comparisons = []

    for new_obj in changed_objects:
        old_obj = historical_index.get(new_obj.name.lower())

        diff = None

        if old_obj:
            diff = generate_diff(
                old_obj.definition,
                new_obj.definition,
            )

        comparisons.append(
            {
                "name": new_obj.name,
                "old": old_obj,
                "new": new_obj,
                "diff": diff,
            }
        )

    return comparisons
