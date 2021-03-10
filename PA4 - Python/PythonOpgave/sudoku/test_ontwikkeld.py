import pytest
import os

# We run the commands in a tempdir, but this dir contains the sudoku files.
ROOT_DIR = os.getcwd()


@pytest.fixture()
def executable(pytestconfig):
    return ("python3", ROOT_DIR + "/sudoku.py")


def build_sudoku_path(file):
    return ROOT_DIR + "/sudoku_boards/" + file


def test_complete(executable, testdir):
    res = testdir.run(*executable, build_sudoku_path("complete_sudoku.txt"))
    res.stdout.fnmatch_lines(
            ["3 9 6 8 5 1 7 4 2",
             "1 7 8 2 9 4 3 5 6",
             "5 2 4 6 7 3 8 9 1",
             "9 1 5 4 8 7 2 6 3",
             "4 8 3 9 2 6 5 1 7",
             "2 6 7 3 1 5 9 8 4",
             "6 5 2 1 3 8 4 7 9",
             "7 4 9 5 6 2 1 3 8",
             "8 3 1 7 4 9 6 2 5"],
            consecutive=True)
    assert res.ret == 0
