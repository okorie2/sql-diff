from git_utils import get_base_tip, get_changed_migrations, read_file_at_commit
from indexer import build_index
from sql_parser import extract_objects
from comparer import compare_objects
from html_reporter import generate_html_report
import argparse


def parse_args():
    parser = argparse.ArgumentParser(description="Generate SQL migration diff report")

    parser.add_argument(
        "--base-branch",
        default="origin/main",
        help="Base branch to compare against",
    )

    return parser.parse_args()


def main():

    args = parse_args()
    base_tip = get_base_tip(args.base_branch)

    print("Base tip:", base_tip)

    historical_index = build_index(base_tip, "migrations")

    changed_files = get_changed_migrations(base_tip)

    changed_objects = []

    for file in changed_files:
        sql = read_file_at_commit("pr-head", file)
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
