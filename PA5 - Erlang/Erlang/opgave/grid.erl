%%%================================================================================================
% @author Tim van Ekert (13635565)
% @study Software Engineering HvA, Pre master SE UvA
% @version 1
% @description This is a file which represents a game called "kamertje verhuur". The game consists
% of only a grid. The purpose is to place walls within those grids, which can be achieved running
% this code.
% @end
%%%================================================================================================

-module(grid).

-export([add_wall/2,
         choose_random_wall/1,
         get_all_walls/2,
         get_cell_walls/2,
         get_open_spots/1,
         get_wall/3,
         has_wall/2,
         new/2,
         print/1,
         show_hlines/2,
         show_vlines/2]).

% Shows the horizontal lines within the given grid
show_hlines(Row, Grid) ->
    {X, Y, WallList} = Grid,
    Range = lists:seq(0, X - 1),
    StringRow = "+" ++
                    lists:flatten([print_hline({{X, Row - 1}, {X, Row}},
                                               Grid)
                                       ++ "+"
                                   || X <- Range])
                        ++ "~n",
    StringRow.

% Shows the vertical lines within the given grid.
show_vlines(Row, Grid) ->
    {X, Y, WallList} = Grid,
    Range = lists:seq(0, X),
    StringRow = lists:flatten([print_vline({{X - 1, Row},
                                            {X, Row}},
                                           Grid)
                               || X <- Range]),
    {L, _} = lists:split(length(StringRow) - 2, StringRow),
    L ++ "~n".

% Prints the horizontal line if on the correct spot: "--".
print_hline(Wall, Grid) ->
    case has_wall(Wall, Grid) of
        true -> "--";
        false -> "  "
    end.

% Prints the vertical line if on the correct spot: "|".
print_vline(Wall, Grid) ->
    case has_wall(Wall, Grid) of
        true -> "|  ";
        false -> "   "
    end.

% Initializes the new grid.
new(Width, Height) -> {Width, Height, []}.

% Gets the wall of a cell, the northern, western, eastern or southern side.
get_wall(X, Y, Dir) ->
    case Dir of
        north -> {{X, Y - 1}, {X, Y}};
        east -> {{X, Y}, {X + 1, Y}};
        south -> {{X, Y}, {X, Y + 1}};
        west -> {{X - 1, Y}, {X, Y}};
        _ -> error_directory
    end.

% Checks if a called wall exists. returning a boolean.
has_wall(Wall, Grid) ->
    {_, _, WallList} = Grid,
    lists:member(Wall, WallList).

% Adds a wall to the grid
add_wall(Wall, Grid) ->
    {Width, Height, WallList} = Grid,
    case has_wall(Wall, Grid) of
        false -> {Width, Height, [Wall | WallList]};
        true -> Grid
    end.

% Get all walls for the given X and Y cell.
get_cell_walls(X, Y) ->
    [get_wall(X, Y, Directions)
     || Directions <- [north, east, south, west]].

% Get all walls possible walls within a grid using the width and height.
get_all_walls(Width, Height) ->
    AllWallsList = lists:merge([get_cell_walls(X, Y)
                                || X <- lists:seq(0, Width - 1),
                                   Y <- lists:seq(0, Height - 1)]),
    WallsList = lists:usort(AllWallsList),
    WallsList.

% Gets the open spots in the grid, return these in a list.
get_open_spots(Grid) ->
    {X, Y, WallList} = Grid,
    OpenSpots = get_all_walls(X, Y) -- WallList,
    OpenSpots.

% Gets a random open wall from the grid.
choose_random_wall(Grid) ->
    case get_open_spots(Grid) of
        [] -> [];
        _ ->
            OpenSpots = get_open_spots(Grid),
            RandomNumber = rand:uniform(length(OpenSpots)),
            lists:nth(RandomNumber, OpenSpots)
    end.

% Prints this grid in a structured format
% using the show_Xlines functions.
print(Grid) ->
    {_, H, _} = Grid,
    lists:map(fun (Row) ->
                      io:fwrite(show_hlines(Row, Grid)),
                      case Row < H of
                          true -> io:fwrite(show_vlines(Row, Grid));
                          false -> ok
                      end
              end,
              lists:seq(0, H)),
    io:fwrite("~n"),
    ok.
