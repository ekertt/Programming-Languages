
"""
This is a sudoku solver which solves the boards from the folder sudoku_boards.
These sudokus can be multiple sized, for example:  (4x4, 9x9, 16x16, etc.).
"""

__author__ = """Tim van Ekert, 13635565"""
__study__ = "Pre master SE, HvA Doorstroomminor"
__copyright__ = "None"
__license__ = "GPL"
__version__ = "1"
__email__ = "tim.van.ekert@student.uva.nl"
__status__ = "Done"

import math
import argparse
import copy
import sys

ZERO = 0


def print_sudoku(sudoku):
    # This function is responsible for printing the unsolved sudoku
    # as well as the solved sudokus.
    for i in sudoku:
        print(*i)


def generate_sudoku(filename):
    # This function retrieves the file path and name, and parses
    # the data in it to a sudoku array which the function returns.
    sudoku = []

    try:
        with open(filename) as f:
            [sudoku.append([int(x) for x in row.split()]) for row in f]
    except ValueError:
        exit(" The given sudoku file is not correct")

    # Check if sudoku is empty
    if not sudoku:
        exit(" Empty files aren't a sudoku")

    sudoku_width = len(sudoku[0])
    sudoku_height = len([row[0] for row in sudoku])

    # Check if width and height are equally sized
    if (sudoku_width != sudoku_height):
        exit(
            "Sudoku width and height are not equal so the sudoku is not valid")

    # Check if sudoku has too high numbers
    for rows in sudoku:
        for values in rows:
            if (values > len(rows)):
                exit("Sudoku has too high numbers to be a sudoku")

    return sudoku


def duplicateCheck(array):
    # Duplicate numbers check for rows columns and grids, without
    # the number zero since this one has to be filled in and is often double
    array = [i for i in array if i != 0]
    if(len(array) == len(set(array))):
        return False
    return True


def free_at_positions(numbers):
    # For every position
    # check the range of numbers ([1..9][1..16] etc)
    # get the values of each position
    # get the free numbers and return them in a list
    range_numbers = range(1, len(numbers) + 1)
    values = [values for values in range_numbers]
    free_numbers = set(values) - set(numbers)
    return list(free_numbers)


def free_for_all_constraints(sudoku, row, col):
    # return the set of (returning set of possible numbers: {1,2,3}):
    # free numbers in a row
    # free numbers in a column
    # free numbers in a subgrid
    return set(free_at_positions(sudoku[row])) & set(free_at_positions(
        [row[col] for row in sudoku])) & set(free_in_grid(sudoku, row, col))


def free_in_grid(sudoku, row, col):
    # for every grid
    # check the open positions by the rows and columns
    # retrieve the whole grid
    # return the possible values such as something like this: [1,2,3,4]
    row_of_grid = []
    col_of_grid = []

    length_subgrid = math.sqrt(len(sudoku))
    length = list(range(0, len(sudoku)))
    blocks = [length[i:i + int(length_subgrid)]
              for i in range(0, len(length), int(length_subgrid))]

    for rows in blocks:
        for i in rows:
            if row in rows:
                row_of_grid.append(i)

    for cols in blocks:
        for i in cols:
            if col in cols:
                col_of_grid.append(i)

    grid = [sudoku[row][col] for row in row_of_grid for col in col_of_grid]

    if(duplicateCheck(grid)):
        exit(" Sudoku consists of duplicate values in a grid")

    return free_at_positions(grid)


def open_positions(sudoku):
    # Function that checks the open positions for every row and column.
    # It returns the open positions in an array
    # such as: [(row, column), (15, 2)]
    sudoku_size = range(len(sudoku))
    return [(row, col) for row in sudoku_size for col in
            sudoku_size if sudoku[row][col] == ZERO]


def row_valid(sudoku, row):
    # This function checks if the row is valid by returning a boolean.
    # Exits the program if there is a duplicate value within a row.
    row = sudoku[row]
    if(duplicateCheck(row)):
        exit(" Sudoku consists of duplicate values in a row")

    return not free_at_positions(row)


def col_valid(sudoku, col):
    # This function checks if the col is valid by returning a boolean.
    # Exits the program if there is a duplicate value within a column
    column = [row[col] for row in sudoku]

    if(duplicateCheck(column)):
        exit(" Sudoku consists of duplicate values in a column")

    return not free_at_positions(column)


def grid_valid(sudoku, row, col):
    # This function checks if the grid is valid by returning a boolean.
    return not free_in_grid(sudoku, row, col)


def row_column_consistent(sudoku):
    # Consistent che k by checking the validity of the rows and columns
    # It returns the boolean value if there is one.
    boolean_value = [False for row_column in range(0, len(sudoku)) if (
        not row_valid(sudoku, row_column) or
        not col_valid(sudoku, row_column))]
    if boolean_value:
        return boolean_value[0]


def grid_consistent(sudoku):
    # Check if the grids are consistent within the rows and columns.
    # It returns the boolean value if there is one.
    boolean_value = [False for row_counter, columns in enumerate(
        sudoku) for col_counter in
        columns if (not grid_valid(sudoku, row_counter, col_counter))]
    if boolean_value:
        return boolean_value[0]


def consistent(sudoku):
    # Checks the consistency of the sudoku within row, column and grid.
    # It returns True or False.
    if(row_column_consistent(sudoku) is False or
            grid_consistent(sudoku) is False):
        return False
    return True


def constraints(sudoku):
    # Building up an array of the constraints.
    # This array returns a sorted array with tuples which store:
    # (row, column, [possible values])
    constraint_values = []
    for position in open_positions(sudoku):
        constraint_values.append(
            (position[0], position[1], free_for_all_constraints(
                sudoku, position[0], position[1])))

    return sort_constraints(constraint_values)


def sort_constraints(constraints):
    # Sort the constraints based on the length of the third value of the tuple:
    # [(row, column, [value]),(row, column, [value, value, value])]
    return(sorted(constraints, key=lambda x: len(x[2])))


def solve_sudoku(sudoku):
    # This function solves and returns the sudoku.
    # If the sudoku is unsolvable it returns the original sudoku.
    stack_sudoku = []
    stack_sudoku.append(sudoku)
    sudokus = []

    while stack_sudoku:
        sudoku_current = stack_sudoku.pop()

        if consistent(sudoku_current):
            if(len(sys.argv) == 3):
                sudokus.append(sudoku_current)
                if (len(sudokus) == int(sys.argv[2])):
                    return sudokus
            else:
                return print_sudoku(sudoku_current)

        constraints_list = constraints(sudoku_current)

        if constraints_list:
            constraint = constraints_list[0]
            values = constraint[2]

            for possible_values in values:
                sud = copy.deepcopy(sudoku_current)

                sud[constraint[0]][constraint[1]] = possible_values

                stack_sudoku.append(sud)

    return "stack error"


def main():
    # Main function to call the correct sudoku and print it
    parser = argparse.ArgumentParser()
    parser.add_argument('sudoku_string')
    parser.add_argument('number', nargs='?')
    args = parser.parse_args()

    sudoku = generate_sudoku(args.sudoku_string)

    sudoku = solve_sudoku(sudoku)

    if(sudoku):
        for i in sudoku:
            print_sudoku(i)
            print("\n")


main()
