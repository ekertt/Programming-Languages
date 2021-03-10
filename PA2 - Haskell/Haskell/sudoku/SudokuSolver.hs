{-|
Module      : SudokuSolver
Description : This is a Haskell program which solves easy sudokus

Author      : Tim van Ekert
Student no  : 13635565

This is a piece of code which solves sudokus using Haskell.
This is done by checking every constraint of a Sudoku and applying the found fields within the correct positions.
-}

import Data.List
import System.Environment

type Row = Int

type Column = Int

type Value = Int

type Grid = [[Value]]

type Sudoku = (Row, Column) -> Value

type Constraint = (Row, Column, [Value])

type Node = (Sudoku, [Constraint])

positions :: [Int]
positions = [1 .. 9]

values :: [Value]
values = [1 .. 9]

blocks :: [[Int]]
blocks = [[1 .. 3], [4 .. 6], [7 .. 9]]

centerOfBlocks :: [Int]
centerOfBlocks = [1, 4, 7]

-- Converts a sudoku into a grid.
sud2grid :: Sudoku -> Grid
sud2grid s = [[s (r, c) | c <- positions] | r <- positions]

-- Converts a grid into a sudoku.
grid2sud :: Grid -> Sudoku
grid2sud gr = \(r, c) -> pos gr (r, c)
  where
    pos :: [[a]] -> (Row, Column) -> a
    pos gr (r, c) = (gr !! (r - 1)) !! (c - 1)

-- Function to extend a sudoku with a value at (row, column).
extend :: Sudoku -> (Row, Column, Value) -> Sudoku
extend sud (r, c, v) (i, j) =
  if r == i && c == j
    then v
    else sud (i, j)

-- Read a file-sudoku into a Sudoku
readSudoku :: String -> IO Sudoku
readSudoku filename = do
  stringGrid <- readFile filename
  return $ (grid2sud . splitStringIntoGrid) stringGrid
  where
    splitStringIntoGrid = map (map readint . words) . lines
    readint x = read x :: Int

-- Prints a Sudoku to the terminal by transforming it to a grid first.
printSudoku :: Sudoku -> IO ()
printSudoku = putStr . unlines . map (unwords . map show) . sud2grid

-- Helper to parse command-line arguments.
getSudokuName :: [String] -> String
getSudokuName [] = error "Filename of sudoku as first argument."
getSudokuName (x:_) = x

-- Check free positions in row
freeInRow :: Sudoku -> Row -> [Value]
freeInRow sudoku row = values \\ (!!) (sud2grid sudoku) (row - 1)

-- Check free positions in column
freeInColumn :: Sudoku -> Column -> [Value]
freeInColumn sudoku column =
  values \\ map (\a -> (!!) a (column - 1)) (sud2grid sudoku)

-- Check free positions in subgrid
freeInSubgrid :: Sudoku -> (Row, Column) -> [Value]
freeInSubgrid sudoku (row, column) =
  values \\ subColumnsGrid sudoku (row, column)

-- Check free at positions
freeAtPos :: Sudoku -> (Row, Column) -> [Value]
freeAtPos sudoku (row, column) =
  (concat
     [ freeInRow sudoku row
     , freeInColumn sudoku column
     , freeInSubgrid sudoku (row, column)
     ] \\
   values) \\
  values

-- Check open position numbers
openPositions :: Sudoku -> [(Row, Column)]
openPositions sudoku =
  [ (row, column)
  | row <- positions
  , column <- positions
  , sudoku (row, column) == 0
  ]

-- Check if row is valid by checking if its empty or not
rowValid :: Sudoku -> Row -> Bool
rowValid sudoku row = null (freeInRow sudoku row)

-- Check if col is valid
colValid :: Sudoku -> Column -> Bool
colValid sudoku column = null (freeInColumn sudoku column)

-- Check if subgrid is valid
subgridValid :: Sudoku -> (Row, Column) -> Bool
subgridValid sudoku (row, column) = null (freeInSubgrid sudoku (row, column))

-- Check if sudoku is consistent
consistent :: Sudoku -> Bool
consistent sudoku =
  and $
  concat
    [ [rowValid sudoku row | row <- positions]
    , [colValid sudoku column | column <- positions]
    , [ subgridValid sudoku (row, column)
      | row <- positions
      , column <- positions
      ]
    ]

-- Print node function for debugging
printNode :: Node -> IO ()
printNode = printSudoku . fst

-- List of all possible constraints
constraints :: Sudoku -> [Constraint]
constraints sudoku =
  sortBy
    sbLength
    (map (\a -> (fst a, snd a, freeAtPos sudoku a)) (openPositions sudoku))

-- Compare lengths of tuples
sbLength :: (Row, Column, [Value]) -> (Row, Column, [Value]) -> Ordering
sbLength (_, _, a) (_, _, b) = compare (getLengthA a) (getLengthB b)

-- Get length of arrays from tuples
getLengthA = length

getLengthB = length

-- Sudoku solver
solveSudoku :: Sudoku -> Sudoku
solveSudoku sudoku = solve (sudoku, constraints sudoku)

-- Solve sudoku and check on constraints
solve :: Node -> Sudoku
solve (sudoku, []) = sudoku
solve (sudoku, cs)
  | length (openPositions sudoku) == 81 = error "empty sudoku"
                  --  | (consistent sudoku == False && ((length (openPositions sudoku)) /= 0)) =  error "Filename of sudoku as first argument."
  | otherwise = solve (extendNode (sudoku, tail cs) (row, column, head value))
  where
    (row, column, value) = head cs

-- Extend the node
extendNode :: Node -> (Row, Column, Value) -> Node
extendNode (sudoku, cs) (row, column, value) =
  (extend sudoku (row, column, value), cs)

-- Do not modify the way your sudoku is printed!
main = do
  args <- getArgs
  sud <- (readSudoku . getSudokuName) args
       -- TODO: Call your solver.
      --  printSudoku sud
      --  print $ freeInRow sud 9
      --  print $ freeInColumn sud 8
      --  print $ freeInSubgrid sud (9,9)
      --  print $ freeAtPos sud (8,8)
      -- --  print $ openPositions sud
      --  print $ rowValid sud 3
      --  print $ colValid sud 3
      --  print $ subgridValid sud (9,9)
      --  print $ consistent sud
      --  print $ constraints sud
  printSudoku (solveSudoku sud)

-- some additional functions
subColumnsGrid :: Sudoku -> (Row, Column) -> [Value]
subColumnsGrid sudoku (row, column) =
  [ sudoku (row', column')
  | row' <- (\x -> concat $ filter (elem x) blocks) row
  , column' <- (\x -> concat $ filter (elem x) blocks) column
  ]