from git_utils import get_merge_base, get_changed_migrations
from indexer import build_index
from tsql_parser import extract_objects
from comparer import compare_objects
from html_reporter import generate_html_report


def main():

    merge_base = get_merge_base()

    print("Merge base:", merge_base)

    historical_index = build_index(merge_base, "migrations")

    changed_files = get_changed_migrations(merge_base)

    changed_objects = []

    for file in changed_files:
        with open(file, "r", encoding="utf-8") as f:
            sql = f.read()

        changed_objects.extend(extract_objects(sql, source_file=file))

    comparisons = compare_objects(changed_objects, historical_index)

    for comparison in comparisons:
        print("\nObject:", comparison["name"])

        if comparison["diff"]:
            print(comparison["diff"])
        else:
            print("New object")

    report = generate_html_report(comparisons)

    print(f"\nHTML report written to: {report}")


if __name__ == "__main__":
    main()
