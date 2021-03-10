import pytest
import os

# We run the commands in a tempdir, but this dir contains the sudoku files.
ROOT_DIR = os.getcwd()


@pytest.fixture()
def executable(pytestconfig):
    return pytestconfig.getoption("exe")


def build_sudoku_path(file):
    return ROOT_DIR + "/sudoku_boards/" + file


def test_expert1(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("hard_sudoku_1.txt"))
    res.stdout.fnmatch_lines([
        "8 1 2 7 5 3 6 4 9",
        "9 4 3 6 8 2 1 7 5",
        "6 7 5 4 9 1 2 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 2 1 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"
    ], consecutive=True)
    assert res.ret == 0


def test_expert2(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("hard_sudoku_2.txt"))
    res.stdout.fnmatch_lines([
        "1 7 2 5 4 9 6 8 3",
        "6 4 5 8 7 3 2 1 9",
        "3 8 9 2 6 1 7 4 5",
        "4 9 6 3 2 7 8 5 1",
        "8 1 3 4 5 6 9 7 2",
        "2 5 7 1 9 8 4 3 6",
        "9 6 4 7 1 5 3 2 8",
        "7 3 1 6 8 2 5 9 4",
        "5 2 8 9 3 4 1 6 7"
    ], consecutive=True)
    assert res.ret == 0
