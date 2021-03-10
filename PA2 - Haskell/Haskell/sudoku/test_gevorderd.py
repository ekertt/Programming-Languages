import pytest
import os

# We run the commands in a tempdir, but this dir contains the sudoku files.
ROOT_DIR = os.getcwd()


@pytest.fixture()
def executable(pytestconfig):
    return pytestconfig.getoption("exe")


def build_sudoku_path(file):
    return ROOT_DIR + "/sudoku_boards/" + file


def test_unsolvable_1(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("unsolvable_sudoku_1.txt"))
    assert res.ret != 0


def test_unsolvable_2(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("unsolvable_sudoku_2.txt"))
    assert res.ret != 0


def test_unsolvable_3(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("unsolvable_sudoku_3.txt"))
    assert res.ret != 0


def test_empty_grid(executable, testdir):
    sudoku = build_sudoku_path("empty_sudoku.txt")
    res = testdir.run(executable, sudoku)
    # Op codegrade wordt gekeken of je resultaat correct is.
    assert res.ret == 0
