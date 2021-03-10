import pytest
import os

# We run the commands in a tempdir, but this dir contains the sudoku files.
ROOT_DIR = os.getcwd()


@pytest.fixture()
def executable(pytestconfig):
    return pytestconfig.getoption("exe")


def build_sudoku_path(file):
    return ROOT_DIR + "/sudoku_boards/" + file


def test_master1(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("nrc_sudoku_1.txt"), "nrc")
    res.stdout.fnmatch_lines([
        "5 7 2 6 9 8 3 4 1",
        "8 1 6 7 3 4 2 9 5",
        "9 4 3 2 1 5 8 7 6",
        "4 8 5 9 2 6 1 3 7",
        "6 3 9 1 8 7 5 2 4",
        "7 2 1 5 4 3 9 6 8",
        "1 9 4 8 6 2 7 5 3",
        "2 6 7 3 5 1 4 8 9",
        "3 5 8 4 7 9 6 1 2"
    ], consecutive=True)
    assert res.ret == 0
