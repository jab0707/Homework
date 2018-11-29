def checkGrid(row,col,newNum,grid):
    """
    Checks the new input on the sudoku grid and returns true
    if this is a valid input, returns false and prints errors
    if this is not a valid input on the grid.
    """
    currRow = grid[row]
    currCol = [r[col] for r in grid]
    subGridR = row//3
    subGridC = col//3
    currSubGrid = [g[subGridC*3:subGridC*3+3] for g in grid[subGridR*3:subGridR*3+3]]
    subGridList = [num for subList in currSubGrid for num in subList]
    validNum = True

    if newNum in currRow:
        validNum = False
        print('Number {} twice in rwo'.format(newNum))
    if newNum in currCol:
        validNum = False
        print('Number {} twice in column'.format(newNum))

    if newNum in subGridList:
        validNum = False
        print('Number {} twice in subgrid'.format(newNum))

    return validNum



#Prompt for file
path = input("Enter input filepath: ")
file = open(path,'r')
inputStr = file.read()
#Read the file, replace out newline and tabs, split by space and make into an int list
inputNumbers = list(map(int,inputStr.replace('\n',' ').replace('\t',' ').split(' ')))
grid = [[],[],[],[],[],[],[],[],[]]#Initilize empty grid list
for row in range(0,9):#Fill in the grid
    grid[row] = inputNumbers[row*9:row*9 + 9]

for ind in range(0,9):#Print it
    printStr = str(grid[ind]).replace(',','').replace('[','').replace(']','')
    print(printStr)

row = int(input('Enter row: '))#Get new input
col = int(input('Enter column: '))
num = int(input('Enter number: '))

validNum = checkGrid(row,col,num,grid)

if validNum:
    grid[row][col] = num#Modify

#Print new grid
for ind in range(0,9):
    printStr = str(grid[ind]).replace(',','').replace('[','').replace(']','')
    print(printStr)







