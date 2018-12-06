import time

import module # imports the C++ extension
from sudoku import solve_sudoku

start_time = time.perf_counter()
# put here the function you want to time
result = module.example(10)
elapsed_time = time.perf_counter() - start_time
print(f'Result: {result}')
print(f'Execution time: {1000*elapsed_time:.4f} ms')