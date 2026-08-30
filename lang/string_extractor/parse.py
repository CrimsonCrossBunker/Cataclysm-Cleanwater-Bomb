import json
from pathlib import Path

from .parser import parsers


NON_GAME_DATA_SUFFIXES = (".schema.json",)
NON_GAME_DATA_DIRECTORIES = (
    Path(__file__).resolve().parents[2] / "data" / "lua" / "reference",
)


def _is_under_directory(path, directory):
    try:
        path.relative_to(directory)
    except ValueError:
        return False
    return True


def is_non_game_data_json(file_path):
    """Return whether *file_path* is not a translatable game-data JSON file.

    JSON Schema documents and the generated Platform reference snapshots are
    repository metadata, not game data.  They are classified here before JSON
    type dispatch so that an unknown JSON Schema ``type`` cannot be mistaken
    for a missing game-data parser.  Keep this classification explicit instead
    of catching unknown-type errors: ordinary game JSON must still fail closed
    when its type is not registered in ``parsers``.
    """
    path = Path(file_path).resolve()
    return path.name.endswith(NON_GAME_DATA_SUFFIXES) or any(
        _is_under_directory(path, directory)
        for directory in NON_GAME_DATA_DIRECTORIES
    )


def parse_json_object(json, origin):
    """
    Extract strings from the JSON object.
    Silently ignores JSON objects without "type" key.
    Raises exception if the JSON object contains unrecognized "type".
    """
    if "type" in json and type(json["type"]) is str:
        json_type = json["type"].lower()
        if json_type in parsers:
            try:
                if json.get("//I18N", True):
                    parsers[json_type](json, origin)
            except Exception as E:
                print(f"Exception when parsing JSON data type '{json_type}'")
                raise E
        else:
            raise Exception(f"Unrecognized JSON data type '{json_type}'")


def parse_json_file(file_path):
    """Extract strings from the specified JSON file."""
    if is_non_game_data_json(file_path):
        return

    with open(file_path, encoding="utf-8") as fp:
        json_data = json.load(fp)

    try:
        json_objects = json_data if type(json_data) is list else [json_data]
        for json_object in json_objects:
            parse_json_object(json_object, file_path)
    except Exception:
        print("Error in JSON object\n'{0}'\nfrom file: '{1}'".format(
            json.dumps(json_object, indent=2), file_path))
        raise
