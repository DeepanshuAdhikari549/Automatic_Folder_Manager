from folder_manager import ensure_output_directory
from logger_config import setup_logger
from scheduler import run_scheduler


def main() -> None:
    """
    Start the Automatic Folder Manager application.
    """
    logger = setup_logger()

    try:
        ensure_output_directory()

        logger.info(
            "Main output directory is ready."
        )

        run_scheduler()

    except KeyboardInterrupt:
        logger.info(
            "Application stopped by the user."
        )

    except Exception:
        logger.exception(
            "Application encountered a fatal error."
        )
        raise

    finally:
        logger.info(
            "Automatic Folder Manager has stopped."
        )


if __name__ == "__main__":
    main()