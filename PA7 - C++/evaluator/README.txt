# Evaluator
C++ assignment which evaluates expressions. To be extended with features:
 - converting infix to postfix expressions (individual.h)
 - reading files as matrices (Matrix.h, MatrixT.h)
 - write out the result as an algebraic expression (Str.h)
 - use C++ Algorithms to replace raw loops

## Compilation
Either compile using the Makefile with:

  make

or with either the 'g++' or 'clang++' compiler:

  g++ -std=c++17 -Wall -Wextra -pedantic -o evaluator evaluator.cpp
  g++ -std=c++17 -Wall -Wextra -pedantic -o individual individual.cpp
  g++ -std=c++17 -Wall -Wextra -pedantic -o MatrixT_operators_test MatrixT_operators_test.cpp
  g++ -std=c++17 -Wall -Wextra -pedantic -o Matrix_operators_test Matrix_operators_test.cpp
  
## Usage
Example usage:

  $ echo "./data/d1.txt ./data/d2.txt + ./data/d1.txt *" | ./evaluator
  13.75

This evaluates the given expression:
 - reads postfix expression from standard input
 - reads data from the given files and applies operators
 - stores intermediate results in files named 'intermediate_result_*.txt'
 - writes result to standard ouput
 
