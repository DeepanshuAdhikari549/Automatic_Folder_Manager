# Automatic Folder Manager

A simple Python automation project that creates folders at a scheduled time and automatically removes folders older than 5 days.

## Features

- Automatically creates a new folder every day at 6:00 AM (configurable).
- Uses timestamps to name folders.
- Deletes folders older than 5 days.
- Runs in the background using systemd.
- Maintains logs for monitoring and troubleshooting.
- Rotates log files to control their size.

## Tech Stack

- Python
- Linux
- systemd
- Logging

## Project Structure

```text
automatic-folder-manager/
├── config.py
├── main.py
├── folder_manager.py
├── scheduler.py
├── logger_config.py
├── tests/
├── logs/
├── requirements.txt
└── README.md
