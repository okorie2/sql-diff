from git_utils import list_files_at_commit, read_file_at_commit
from tsql_parser import extract_objects


def build_index(commit, migration_directory="migrations"):
    """
    Builds an index of the latest SQL object definitions
    at a specific git commit.

    Returns:
    {
        "dbo.ap_WorkOrder_Get": SqlObject(...),
        "dbo.ap_Invoice_Get": SqlObject(...)
    }
    """

    index = {}

    migration_files = list_files_at_commit(commit, migration_directory)

    for file in migration_files:
        sql = read_file_at_commit(commit, file)

        objects = extract_objects(sql, source_file=file)

        for obj in objects:
            # Latest occurrence wins
            index[obj.name.lower()] = obj

    return index
