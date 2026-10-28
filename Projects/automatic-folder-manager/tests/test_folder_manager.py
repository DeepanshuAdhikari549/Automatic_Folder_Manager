import tempfile
import unittest

from datetime import datetime, timedelta
from pathlib import Path
from unittest.mock import patch

import folder_manager


class TestFolderManager(unittest.TestCase):

    def setUp(self):
        """
        Create a temporary directory for each test.

        These tests will not modify your real Output files folder.
        """
        self.temp_directory = tempfile.TemporaryDirectory()
        self.output_path = Path(self.temp_directory.name)

        self.output_patch = patch.object(
            folder_manager,
            "OUTPUT_DIR",
            self.output_path,
        )
        self.output_patch.start()

    def tearDown(self):
        """
        Restore the original configuration and remove test files.
        """
        self.output_patch.stop()
        self.temp_directory.cleanup()

    def test_create_daily_folder(self):
        """
        Verify that a folder is created with the correct name.
        """
        test_time = datetime(2026, 10, 26, 6, 0, 0)

        folder_path = folder_manager.create_daily_folder(
            test_time
        )

        self.assertTrue(folder_path.is_dir())

        self.assertEqual(
            folder_path.name,
            "2026-10-26-06-00-00",
        )

    def test_cleanup_removes_expired_folder(self):
        """
        Verify that a folder older than five days is deleted.
        """
        old_time = datetime(2026, 10, 20, 6, 0, 0)

        old_folder = self.output_path / (
            old_time.strftime(
                folder_manager.FOLDER_NAME_FORMAT
            )
        )

        old_folder.mkdir()

        reference_time = datetime(2026, 10, 26, 6, 0, 0)

        deleted = folder_manager.cleanup_old_folders(
            reference_time
        )

        self.assertIn(old_folder, deleted)
        self.assertFalse(old_folder.exists())

    def test_cleanup_keeps_recent_folder(self):
        """
        Verify that a recent folder is not deleted.
        """
        recent_time = datetime(2026, 10, 25, 6, 0, 0)

        recent_folder = self.output_path / (
            recent_time.strftime(
                folder_manager.FOLDER_NAME_FORMAT
            )
        )

        recent_folder.mkdir()

        reference_time = datetime(2026, 10, 26, 6, 0, 0)

        deleted = folder_manager.cleanup_old_folders(
            reference_time
        )

        self.assertNotIn(recent_folder, deleted)
        self.assertTrue(recent_folder.exists())

    def test_cleanup_keeps_unrelated_directories(self):
        """
        Verify that directories with unrelated names are untouched.
        """
        unrelated_folder = self.output_path / "important_backup"
        unrelated_folder.mkdir()

        folder_manager.cleanup_old_folders(
            datetime(2026, 10, 26, 6, 0, 0)
        )

        self.assertTrue(unrelated_folder.exists())

    def test_invalid_timestamp_is_rejected(self):
        """
        Verify that invalid folder names are not accepted.
        """
        self.assertIsNone(
            folder_manager.get_folder_timestamp(
                "2026-99-99-99-99-99"
            )
        )

    def test_existing_folder_is_not_recreated(self):
        """
        Verify that duplicate folder creation raises an error.
        """
        test_time = datetime(2026, 10, 26, 6, 0, 0)

        folder_manager.create_daily_folder(test_time)

        with self.assertRaises(FileExistsError):
            folder_manager.create_daily_folder(test_time)


if __name__ == "__main__":
    unittest.main()