
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

grid[row][col] = num#Modify
#Print new grid
for ind in range(0,9):
    printStr = str(grid[ind]).replace(',','').replace('[','').replace(']','')
    print(printStr)