%%%================================================================================================
% @author Tim van Ekert (13635565)
% @study Software Engineering HvA, Pre master SE UvA
% @version 1
% @description Represents the game server of the game.
% @end
%%%================================================================================================

-module(game_server).

-behaviour(gen_server).

-export([handle_call/3,
         handle_cast/2,
         handle_continue/2,
         points/2,
         start_link/1]).

-export([init/1, move/2]).

start_link({W, H, Players}) ->
    gen_server:start_link(game_server, {W, H, Players}, []).

% Abstraction to make a move.
move(Pid, Wall) -> gen_server:call(Pid, {move, Wall}).

init({Width, Height, Players}) ->
    Grid = grid:new(Width, Height),
    State = {Grid, Players},
    {ok, State, {continue, move}}.

% Given points per cell
points(Cell, Grid) ->
    {_, _, Walls} = Grid,
    {X, Y} = Cell,
    CellWalls = grid:get_cell_walls(X, Y),
    case CellWalls -- Walls == [] of
        true -> 1;
        false -> 0
    end.

handle_continue(move, State) ->
    {Grid, Players} = State,
    case grid:get_open_spots(Grid) == [] of
        true ->
            [H | T] = Players,
            H ! finished,
            {stop, normal, State};
        false ->
            hd(Players) ! {move, self(), Grid},
            {noreply, State}
    end.

% Move call is handled
% Adds a new wall to the state and giving the next player the turn.
% Calculates the score of a move
handle_call({move, Wall}, _From, {Grid, Players}) ->
    GridNew = grid:add_wall(Wall, Grid),
    StateNew = {GridNew, lists:reverse(Players)},

    {FirstCell, SecondCell} = Wall,
    Score = points(FirstCell, GridNew) +
                points(SecondCell, GridNew),
    {reply, {ok, Score}, StateNew, {continue, move}};
% Used for testing.
handle_call(state, _From, State) ->
    {reply, {ok, State}, State};
handle_call({setWalls, Walls}, _From,
            {{W, H, _}, Players}) ->
    {reply, ok, {{W, H, Walls}, Players}}.

% Required for gen_server behaviour.
% Normally you would implement this too,
% but not required for this assignment.
handle_cast(_, State) ->
    {reply, not_implemented, State}.
