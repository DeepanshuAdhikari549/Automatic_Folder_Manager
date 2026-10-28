import re
import shutil

from datetime import datetime, timedelta
from pathlib import Path

from config import (
    FOLDER_NAME_FORMAT,
    OUTPUT_DIR,
    RETENTION_DAYS,
)


# Accept only folder names matching YYYY-MM-DD-HH-mm-ss.
FOLDER_NAME_PATTERN = re.compile(
    r"^\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}$"
)


def ensure_output_directory() -> None:
    """
    Create the main output directory if it does not exist.
    """
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def create_daily_folder(
    folder_time: datetime | None = None,
) -> Path:
    """
    Create a timestamped folder inside the output directory.

    If folder_time is not supplied, use the current local time.
    Return the path of the created folder.
    """
    ensure_output_directory()

    if folder_time is None:
        folder_time = datetime.now().astimezone()

    folder_name = folder_time.strftime(FOLDER_NAME_FORMAT)
    folder_path = OUTPUT_DIR / folder_name

    # Do not silently reuse an existing folder.
    folder_path.mkdir(exist_ok=False)

    return folder_path


def get_folder_timestamp(folder_name: str) -> datetime | None:
    """
    Convert a correctly formatted folder name into a datetime.

    Return None if the name or date is invalid.
    """
    if not FOLDER_NAME_PATTERN.fullmatch(folder_name):
        return None

    try:
        return datetime.strptime(
            folder_name,
            FOLDER_NAME_FORMAT,
        )
    except ValueError:
        return None


def cleanup_old_folders(
    reference_time: datetime | None = None,
) -> list[Path]:
    """
    Delete timestamped folders older than the retention period.

    Folders with unrelated names are left untouched.
    Return the paths of successfully deleted folders.
    """
    ensure_output_directory()

    if reference_time is None:
        reference_time = datetime.now().astimezone()

    # Use the local wall-clock time represented by folder names.
    if reference_time.tzinfo is not None:
        reference_time = reference_time.replace(tzinfo=None)

    cutoff_time = reference_time - timedelta(
        days=RETENTION_DAYS
    )

    deleted_folders: list[Path] = []

    for folder_path in OUTPUT_DIR.iterdir():
        try:
            if not folder_path.is_dir():
                continue

            folder_time = get_folder_timestamp(
                folder_path.name
            )

            # Do not touch directories that do not match our naming scheme.
            if folder_time is None:
                continue

            if folder_time < cutoff_time:
                shutil.rmtree(folder_path)
                deleted_folders.append(folder_path)

        except OSError:
            # Let the caller log the failure and continue.
            raise

    return deleted_folders