from dataclasses import dataclass


@dataclass
class SqlObject:
    object_type: str
    name: str
    definition: str
    source_file: str
