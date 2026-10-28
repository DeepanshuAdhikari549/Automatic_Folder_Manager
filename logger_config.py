import logging
from logging.handlers import RotatingFileHandler

from config import LOG_DIR, LOG_FILE


def setup_logger() -> logging.Logger:
    """
    Configure application logging.

    Logs are written to a file and displayed in the console.
    Old log files are rotated to prevent unlimited log growth.
    """
    LOG_DIR.mkdir(parents=True, exist_ok=True)

    logger = logging.getLogger("automatic_folder_manager")
    logger.setLevel(logging.INFO)

    # Avoid adding duplicate handlers if setup is called again.
    if logger.handlers:
        return logger

    formatter = logging.Formatter(
        fmt="%(asctime)s | %(levelname)s | %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    file_handler = RotatingFileHandler(
        LOG_FILE,
        maxBytes=2 * 1024 * 1024,
        backupCount=5,
        encoding="utf-8",
    )

    file_handler.setFormatter(formatter)

    console_handler = logging.StreamHandler()
    console_handler.setFormatter(formatter)

    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    return logger