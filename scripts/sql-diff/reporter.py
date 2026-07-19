def generate_markdown_report(comparisons):

    lines = []

    lines.append("# SQL Object Diff Report\n")

    changed_count = 0
    new_count = 0

    for item in comparisons:

        name = item["name"]

        lines.append(f"## {name}\n")

        if item["old"] is None:
            lines.append("🆕 New object\n")
            new_count += 1

        elif item["diff"]:

            changed_count += 1

            lines.append(f"Previous version: `{item['old'].source_file}`\n")

            lines.append("```diff")

            lines.append(item["diff"])

            lines.append("```\n")

        else:
            lines.append("No changes detected\n")

    lines.insert(1, f"Changed objects: {changed_count}, " f"New objects: {new_count}\n")

    return "\n".join(lines)
