#pragma once


struct sudoku_board {
        int grid[9][9]; // 0 value indicates an empty cell
};




static bool is_number_in_row(sudoku_board board, int row, int number)
{
        for (int j = 0; j < 9; j = j + 1) {
                if (board.grid[row][j] == number) {
                        return true;
                }
        }
        return false;
}


static bool is_number_in_column(sudoku_board board, int column, int number)
{
        for (int i = 0; i < 9; i = i + 1) {
                if (board.grid[i][column] == number) {
                        return true;
                }
        }
        return false;
}


static bool is_number_in_subgrid(sudoku_board board, int subgrid_i, int subgrid_j, int number)
{
        for (int i = 0; i < 3; i = i + 1) {
                for (int j = 0; j < 3; j = j + 1) {
                        if (board.grid[3*subgrid_i + i][3*subgrid_j + j] == number) {
                                return true;
                        }
                }
        }
        return false;
}


static bool solve_sudoku(sudoku_board board, sudoku_board *solution)
{
        for (int i = 0; i < 9; i = i + 1) {
                for (int j = 0; j < 9; j = j + 1) {
                        // the cell was already solved
                        if (board.grid[i][j] != 0) {
                                continue;
                        }

                        for (int number = 1; number <= 9; number = number + 1) {
                                if (!is_number_in_row(board, i, number) &&
                                    !is_number_in_column(board, j, number) &&
                                    !is_number_in_subgrid(board, i/3, j/3, number)) {

                                        board.grid[i][j] = number;
                                        if (solve_sudoku(board, solution)) {
                                                return true;
                                        }
                                        board.grid[i][j] = 0;
                                }
                        }

                        // backtrack
                        return false;
                }
        }

        // TODO: check if the input grid is valid
        *solution = board;
        return true;
}