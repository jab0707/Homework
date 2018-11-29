

import sys
import PyQt5.QtWidgets as qw
class Sudoku(qw.QWidget):

    def __init__(self):
        super().__init__()
        self.title = 'Sudoku'
        self.row = 9;
        self.col = 9;
        self.subGridR = 3;
        self.subGridC = 3;
        self.theBoard =[];
        self.guiBoard = [];
        

        self.initilize();
        self.drawBoard();

    def initilize(self):
        #Prompt for file
        path = input("Enter input filepath: ")
        file = open(path,'r')
        inputStr = file.read()
        #Read the file, replace out newline and tabs, split by space and make into an int list
        inputNumbers = list(map(int,inputStr.replace('\n',' ').replace('\t',' ').split(' ')))
        grid = [[],[],[],[],[],[],[],[],[]]#Initilize empty grid list
        for row in range(0,9):#Fill in the grid
            grid[row] = inputNumbers[row*9:row*9 + 9]
        self.theBoard = grid

    def drawBoard(self):

        layout = qw.QGridLayout();
        for r in range(self.row):
            gui_boxes = []
            for c in range(self.col):
                gui_boxes.append(self.getBox(self.theBoard[r][c]))
            self.guiBoard.append(gui_boxes)

        for r in range(self.subGridR):
            for c in range(self.subGridC):
                subgrid = self.getSubGrid(r,c)
                layout.addWidget(subgrid,r,c)
        self.setLayout(layout)
        self.show()

    def getBox(self,initialVal):
        box = qw.QComboBox();
        choices = [' ','1','2','3','4','5','6','7','8','9']
        for choice in choices:
            box.addItem(choice)
        box.setCurrentIndex(initialVal)
        return box

    def getSubGrid(self,r,c):
        holdWidget = qw.QWidget();
        subGrid = qw.QGridLayout();
        for rId in range(self.subGridR):
            for cId in range(self.subGridC):
                subGrid.addWidget(self.guiBoard[r*self.subGridR + rId][c*self.subGridC + cId],rId,cId)
        holdWidget.setLayout(subGrid)
        return holdWidget



app = qw.QApplication(sys.argv)
sudoku = Sudoku()
sys.exit(app.exec_())

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



dialog = qw.QDialog()
dialog.setLayout(gridLayout)
dialog.setWindowTitle('Sudoku')
dialog.show()
sys.exit(app.exec_())

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








