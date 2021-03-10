#!/usr/bin/env python3

import pytest
import os

# We run the commands in a tempdir, but this dir contains the sudoku files.
ROOT_DIR = os.getcwd()


@pytest.fixture()
def executable(pytestconfig):
    return ("python3", ROOT_DIR + "/sudoku.py")


def build_sudoku_path(file):
    return ROOT_DIR + "/sudoku_boards/" + file


# These error messages are rather unclear, since you can solve them
# in any order. It just checks if all the possible solutions are in
# your output.
def test_2_solutions(executable, testdir):
    res = testdir.run(*executable, build_sudoku_path("2_sol_9_grid.txt"), "2")
    output = res.stdout.str()

    assert "\n".join([
        "8 1 2 7 5 3 6 4 9",
        "9 4 3 6 8 2 1 7 5",
        "6 7 5 4 9 1 2 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 2 1 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"
    ]) in output

    assert "\n".join([
        "8 2 1 7 5 3 6 4 9",
        "9 4 3 6 8 2 1 7 5",
        "6 7 5 4 9 1 2 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 1 2 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"
    ]) in output

    assert res.ret == 0


# Same as above.
def test_4_solutions(executable, testdir):
    res = testdir.run(*executable, build_sudoku_path("4_sol_9_grid.txt"), "4")
    output = res.stdout.str()
    assert "\n".join([
        "8 1 2 7 5 3 6 4 9",
        "9 4 3 6 8 2 1 7 5",
        "6 7 5 4 9 1 2 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 2 1 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"]) in output

    assert "\n".join([
        "8 2 1 7 5 3 6 4 9",
        "9 4 3 6 8 2 1 7 5",
        "6 7 5 4 9 1 2 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 1 2 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"
    ]) in output

    assert "\n".join([
        "8 2 1 7 5 3 6 4 9",
        "9 4 3 6 8 1 2 7 5",
        "6 7 5 4 9 2 1 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 1 2 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"
    ]) in output

    assert "\n".join([
        "8 1 2 7 5 3 6 4 9",
        "9 4 3 6 8 1 2 7 5",
        "6 7 5 4 9 2 1 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 2 1 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"
    ]) in output
    assert res.ret == 0
