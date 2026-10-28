import time
from datetime import datetime

from config import (
    CHECK_INTERVAL_SECONDS,
    OUTPUT_DIR,
    SCHEDULE_HOUR,
    SCHEDULE_MINUTE,
    STATE_FILE,
)
from folder_manager import (
    cleanup_old_folders,
    create_daily_folder,
    ensure_output_directory,
)
from logger_config import setup_logger


logger = setup_logger()


def read_last_run_date() -> str | None:
    """
    Read the date on which the folder was last created.

    Return None if the state file does not exist or is invalid.
    """
    try:
        value = STATE_FILE.read_text(
            encoding="utf-8"
        ).strip()

        # Validate the stored date.
        datetime.strptime(value, "%Y-%m-%d")

        return value

    except FileNotFoundError:
        return None

    except (ValueError, OSError) as error:
        logger.warning(
            "Could not read scheduling state: %s",
            error,
        )
        return None


def save_last_run_date(run_date: str) -> None:
    """
    Save the date of the last successfully created daily folder.
    """
    STATE_FILE.write_text(
        run_date,
        encoding="utf-8",
    )


def run_cleanup() -> None:
    """
    Delete expired folders and log the outcome.
    """
    try:
        deleted_folders = cleanup_old_folders()

        for folder_path in deleted_folders:
            logger.info(
                "Deleted expired folder: %s",
                folder_path,
            )

        logger.info(
            "Cleanup completed. Deleted %d folder(s).",
            len(deleted_folders),
        )

    except OSError:
        logger.exception(
            "Cleanup failed because of a filesystem error."
        )


def run_daily_task() -> None:
    """
    Create today's folder and then clean up expired folders.
    """
    now = datetime.now().astimezone()
    today = now.strftime("%Y-%m-%d")

    try:
        folder_path = create_daily_folder(now)

        # Save state after successful folder creation.
        save_last_run_date(today)

        logger.info(
            "Created daily folder: %s",
            folder_path,
        )

    except FileExistsError:
        # Avoid creating another folder with the same name.
        logger.warning(
            "Folder already exists. No duplicate created."
        )
        return

    except OSError:
        logger.exception(
            "Could not create or record today's folder."
        )
        return

    run_cleanup()


def run_scheduler() -> None:
    """
    Run continuously and execute the daily task at or after
    the configured local time.

    If the computer starts after 6 AM, catch up by creating
    today's folder when the scheduler starts.
    """
    ensure_output_directory()

    logger.info("Automatic Folder Manager started.")
    logger.info("Output directory: %s", OUTPUT_DIR)

    # Clean expired folders when the application starts.
    run_cleanup()

    while True:
        try:
            now = datetime.now().astimezone()
            today = now.strftime("%Y-%m-%d")

            scheduled_time = now.replace(
                hour=SCHEDULE_HOUR,
                minute=SCHEDULE_MINUTE,
                second=0,
                microsecond=0,
            )

            last_run_date = read_last_run_date()

            # Run once per calendar date, at or after 6 AM.
            if (
                now >= scheduled_time
                and last_run_date != today
            ):
                logger.info(
                    "Daily scheduled task is due."
                )
                run_daily_task()

            time.sleep(CHECK_INTERVAL_SECONDS)

        except KeyboardInterrupt:
            logger.info(
                "Scheduler stopped by keyboard interrupt."
            )
            break

        except Exception:
            logger.exception(
                "Unexpected scheduler error. Retrying."
            )
            time.sleep(CHECK_INTERVAL_SECONDS)