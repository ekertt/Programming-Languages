/*
* @author Tim van Ekert (13635565)
* @study Software Engineering HvA, Pre master SE UvA
* @version 1
* @description Represents a maze solver showing paths in some test mazes
 */

package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sync"
)

const southWall byte = (1 << 0) // The first flag
const eastWall byte = (1 << 1)  // The second flag

type Maze [][]byte

type Position struct {
	Row, Col int
}

// Returns the printed maze.
// If the cell isn't 0..3 then there is an error and the system will quite
func readMaze(f *os.File) (maze Maze) {
	s := bufio.NewScanner(f)
	for s.Scan() {
		maze = append(maze, []byte(s.Text()))
	}

	for i, row := range maze {
		for cell := range row {
			mazeWall := maze[i][cell]
			if mazeWall < 48 || mazeWall > 51 {
				log.Fatal("Invalid character within file.")
			}
		}
	}
	return
}

// Returns the route by showing this in the built up maze
// This is done by following the steps commented by the UvA
func solve(maze Maze) (route []Position) {
	//some helper variables
	numberOfRows := len(maze)
	numberOfCols := len(maze[0])
	countGoRoutines := 0
	route = append(route, Position{Row: 0, Col: 0})

	// Init channels for communication with the routines
	var routes chan []Position = make(chan []Position)
	var done chan []Position = make(chan []Position)
	var goRoutines chan int = make(chan int)

	// Closure function to explore the route
	// Explore function explaind by Robin in the "het vragenuurtje" lesson
	explore := func(path []Position) {
		var prevPosition Position

		if len(path) != 1 {
			prevPosition = path[len(path)-2]
		}

		var freePos []Position = freeAtPosition(path[len(path)-1], prevPosition, maze)

		for i := 0; i < len(freePos); i++ {
			if freePos[i].Row >= numberOfRows || freePos[i].Col >= numberOfCols {
				done <- path
				goRoutines <- 1
				return
			}
		}

		switch len(freePos) {
		case 1:
			routes <- append(path, freePos[0])
		case 2:
			routes <- append(path, freePos[0])
			routes <- append(path, freePos[1])
		case 3:
			routes <- append(path, freePos[0])
			routes <- append(path, freePos[1])
			routes <- append(path, freePos[2])
		}
		goRoutines <- 1

		return
	}

	// Init onceMaze to make each cell only visited once
	var onceMaze [][]sync.Once = make([][]sync.Once, numberOfRows)

	for i := 0; i < numberOfRows; i++ {
		onceMaze[i] = make([]sync.Once, numberOfCols)
	}

	onceMaze[0][0].Do(func() {
		countGoRoutines++
		go explore(route)
	})

	// Receiving messsages from the routines
	var foundSolution bool = false

	for countGoRoutines > 0 {
		select {
		case x := <-routes:
			var currentRoute = make([]Position, len(x))
			copy(currentRoute, x)

			//onceMaze on row and column value
			onceMaze[x[len(x)-1].Row][x[len(x)-1].Col].Do(func() {
				countGoRoutines++
				go explore(currentRoute)
			})
		case <-goRoutines:
			countGoRoutines--

		case doneRoute := <-done:
			route = doneRoute
			foundSolution = true
		}
	}

	close(routes)
	close(goRoutines)
	close(done)

	// if no solution found, return the empty maze
	if foundSolution == false {
		route = nil
	}

	return route
}

// Returns the free positions around the current positions.
// The previous position doesn't count because you cant go there anymore
func freeAtPosition(pos Position, prevPos Position, maze Maze) (freePos []Position) {
	northPos := Position{Row: pos.Row - 1, Col: pos.Col}
	southPos := Position{Row: pos.Row + 1, Col: pos.Col}
	westPos := Position{Row: pos.Row, Col: pos.Col - 1}
	eastPos := Position{Row: pos.Row, Col: pos.Col + 1}

	if northPos.Row >= 0 && northPos != prevPos {
		if maze[pos.Row-1][pos.Col]&southWall == 0 {
			freePos = append(freePos, northPos)
		}
	}

	if southPos != prevPos {
		if maze[pos.Row][pos.Col]&southWall == 0 {
			freePos = append(freePos, southPos)
		}
	}

	if westPos.Col >= 0 && westPos != prevPos {
		if maze[pos.Row][pos.Col-1]&eastWall == 0 {
			freePos = append(freePos, westPos)
		}
	}

	if eastPos != prevPos {
		if maze[pos.Row][pos.Col]&eastWall == 0 {
			freePos = append(freePos, eastPos)
		}
	}

	return freePos
}

func main() {
	if len(os.Args) < 2 {
		log.Fatal("Too few arguments.")
	}
	if len(os.Args) > 2 {
		log.Fatal("Too many arguments.")
	}

	f, err := os.Open(os.Args[1])

	if err != nil {
		log.Fatal("Error opening the file.", err)
	}
	maze := readMaze(f)
	for _, pos := range solve(maze) {
		maze[pos.Row][pos.Col] |= (1 << 2) // The third flag
	}
	for _, line := range maze {
		if len(line) <= 0 {
			log.Println("Printing an empty line.")
		}
		fmt.Println(string(line))
	}
}
