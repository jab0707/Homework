import copy


def is_number_in_row(board, row, number):
    for j in range(9):
        if board[row][j] == number:
            return True
    return False


def is_number_in_column(board, column, number):
    for i in range(9):
        if board[i][column] == number:
            return True
    return False


def is_number_in_subgrid(board, subgrid_i, subgrid_j, number):
    for i in range(3):
        for j in range(3):
            if board[3*subgrid_i + i][3*subgrid_j + j] == number:
                return True
    return False


def solve_sudoku(input_board):
    def solve(board):
        for i in range(9):
            for j in range(9):
                # the cell was already solved
                if board[i][j] != 0:
                    continue

                for number in range(1, 10):
                    if not is_number_in_row(board, i, number) and not is_number_in_column(board, j, number) and not is_number_in_subgrid(board, i//3, j//3, number):
                        board[i][j] = number
                        solution = solve(board)
                        if solution != None:
                            return solution
                        board[i][j] = 0

                # backtrack
                return None

        # TODO: check if the input grid is valid
        return board

    # use deepcopy so the solver does not modify the input board
    return solve(copy.deepcopy(input_board))
