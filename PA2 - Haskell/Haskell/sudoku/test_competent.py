import pytest
import os

# We run the commands in a tempdir, but this dir contains the sudoku files.
ROOT_DIR = os.getcwd()


@pytest.fixture()
def executable(pytestconfig):
    return pytestconfig.getoption("exe")


def build_sudoku_path(file):
    return ROOT_DIR + "/sudoku_boards/" + file


def test_simple_1(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("simple_1_open_spot.txt"))
    # Dit kijkt of je output gelijk is aan de verwachte output.
    # Pas daarom de output van je solver niet aan!
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
    # Vereist dat je programma een exit code heeft van 0
    assert res.ret == 0


def test_simple_5(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("simple_5_open_spots.txt"))
    res.stdout.fnmatch_lines([
        "3 9 6 8 5 1 7 4 2",
        "1 7 8 2 9 4 3 5 6",
        "5 2 4 6 7 3 8 9 1",
        "9 1 5 4 8 7 2 6 3",
        "4 8 3 9 2 6 5 1 7",
        "2 6 7 3 1 5 9 8 4",
        "6 5 2 1 3 8 4 7 9",
        "7 4 9 5 6 2 1 3 8",
        "8 3 1 7 4 9 6 2 5"
    ], consecutive=True)
    assert res.ret == 0


def test_simple_10(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("simple_10_open_spots.txt"))
    res.stdout.fnmatch_lines([
        "3 9 6 8 5 1 7 4 2",
        "1 7 8 2 9 4 3 5 6",
        "5 2 4 6 7 3 8 9 1",
        "9 1 5 4 8 7 2 6 3",
        "4 8 3 9 2 6 5 1 7",
        "2 6 7 3 1 5 9 8 4",
        "6 5 2 1 3 8 4 7 9",
        "7 4 9 5 6 2 1 3 8",
        "8 3 1 7 4 9 6 2 5"
    ], consecutive=True)
    assert res.ret == 0


def test_complete(executable, testdir):
    res = testdir.run(executable, build_sudoku_path("complete_sudoku.txt"))
    res.stdout.fnmatch_lines([
        "3 9 6 8 5 1 7 4 2",
        "1 7 8 2 9 4 3 5 6",
        "5 2 4 6 7 3 8 9 1",
        "9 1 5 4 8 7 2 6 3",
        "4 8 3 9 2 6 5 1 7",
        "2 6 7 3 1 5 9 8 4",
        "6 5 2 1 3 8 4 7 9",
        "7 4 9 5 6 2 1 3 8",
        "8 3 1 7 4 9 6 2 5"
    ], consecutive=True)
    assert res.ret == 0
