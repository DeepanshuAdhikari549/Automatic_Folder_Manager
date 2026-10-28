from pathlib import Path

# Main output folder
OUTPUT_DIR = Path.home() / "Output files"

SCHEDULE_HOUR = 6
SCHEDULE_MINUTE = 0

RETENTION_DAYS = 5

CHECK_INTERVAL_SECONDS = 30

PROJECT_DIR = Path(__file__).resolve().parent

# Logging configuration
LOG_DIR = PROJECT_DIR / "logs"
LOG_FILE = LOG_DIR / "folder_manager.log"

STATE_FILE = PROJECT_DIR / "last_run_date.txt"

FOLDER_NAME_FORMAT = "%Y-%m-%d-%H-%M-%S"