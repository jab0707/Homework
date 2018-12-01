


import sys
import PyQt5.QtWidgets as qw
class Sudoku(qw.QWidget):

    def __init__(self):

        super().__init__()#Initilize base class
        #Initilize globals
        self.title = 'Sudoku'
        self.row = 9;
        self.col = 9;
        self.subGridR = 3;
        self.subGridC = 3;
        self.theBoard =[];
        self.theStrBoard = [];
        self.guiBoard = [];
        
        #Run sudoku initilizer and draw the board
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
        strGrid = [[],[],[],[],[],[],[],[],[]]
        for row in range(0,9):#Fill in the grid
            grid[row] = inputNumbers[row*9:row*9 + 9]
            strGrid[row] = list(map(str,grid[row]))
            strGrid[row] = [' ' if x == '0' else x for x in strGrid[row]]
        self.theBoard = grid
        self.theStrBoard = strGrid

    def drawBoard(self):
        #Draw the board gui
        layout = qw.QGridLayout();
        for r in range(self.row):#Make comboboxes for each grid location
            gui_boxes = []
            for c in range(self.col):
                gui_boxes.append(self.getBox(self.theBoard[r][c],r,c))
            self.guiBoard.append(gui_boxes)
        #Arrange the boxes into subgrids in the main grid
        for r in range(self.subGridR):
            for c in range(self.subGridC):
                subgrid = self.getSubGrid(r,c)
                layout.addWidget(subgrid,r,c)
        self.setLayout(layout)
        self.show()

    def updateGrid(self,change):
        rIdx = 0
        for boxRow in self.guiBoard:
            cIdx = 0
            for box in boxRow:
                #if (box.currentText()) == self.theStrBoard[rIdx][cIdx]:
                if change:
                    if box.currentText == ' ':
                        self.theBoard[rIdx][cIdx] = 0
                        self.theStrBoard[rIdx][cIdx] = ' '
                    else:
                        self.theStrBoard[rIdx][cIdx] = box.currentText()
                        if box.currentText() == ' ':
                            self.theBoard[rIdx][cIdx] = 0
                        else:
                            self.theBoard[rIdx][cIdx] = int(box.currentText())
                else:
                    box.setCurrentIndex(box.findText((self.theStrBoard[rIdx][cIdx])))
                cIdx = cIdx + 1
            rIdx = rIdx + 1

    def checkComplete(self):
        complete = True
        for row in self.theBoard:
            for c in row:
                if c == 0:
                    complete = False

        if complete:
            print("Congradulations! Sudoku Complete!")

    

    def checkChoices(self,row,col):
        grid = self.theBoard
        currRow = grid[row]
        currCol = [r[col] for r in grid]
        subGridR = row//3
        subGridC = col//3
        currSubGrid = [g[subGridC*3:subGridC*3+3] for g in grid[subGridR*3:subGridR*3+3]]
        subGridList = [num for subList in currSubGrid for num in subList]
        choices = [1,2,3,4,5,6,7,8]

        choices = sorted(list(set(choices)-set(currRow)-set(currCol) - set(subGridList)))
        choiceStr = [' ']
        if self.theBoard[row][col] != 0:
            choiceStr.append(self.theStrBoard[row][col])
        else:
            for chInt in choices:
                choiceStr.append(str(chInt))
        return choiceStr


    def getBox(self,initialVal,r,c):
        #Create a box at the specified location
        box = qw.QComboBox();
        choices = self.checkChoices(r,c)
        
        for choice in choices:
            box.addItem(choice)
        if self.theBoard[r][c] == 0:
            box.setCurrentIndex(0)
        else:
            box.setCurrentIndex(1)
        box.rc = [r,c];
        box.currentTextChanged.connect(self.changedCheck)
        return box

    def changedCheck(self):
        goodToChange = self.checkGrid()
        self.updateGrid(goodToChange)
        self.checkComplete()

    def getSubGrid(self,r,c):
        #Create a subgrid at the specified location
        holdWidget = qw.QWidget();
        subGrid = qw.QGridLayout();
        for rId in range(self.subGridR):
            for cId in range(self.subGridC):
                subGrid.addWidget(self.guiBoard[r*self.subGridR + rId][c*self.subGridC + cId],rId,cId)
        holdWidget.setLayout(subGrid)
        return holdWidget

    def checkGrid(self):
        """
        Checks the new input on the sudoku grid and returns true
        if this is a valid input, returns false and prints errors
        if this is not a valid input on the grid.
        """
        grid = self.theBoard
        
        rIdx = 0
        for row in self.guiBoard:
            cIdx = 0
            for box in row:
                if box.currentText() == ' ':
                    grid[rIdx][cIdx] = 0
                else:
                    grid[rIdx][cIdx] = int(box.currentText())
                cIdx = cIdx + 1
            rIdx = rIdx + 1


        err1 = 0
        err2 = 0
        err3 = 0
        
        validNum = True
        for row in range(len(self.theBoard)):
            for col in range(len(self.theBoard[1])):
                currRow = grid[row]
                currRow = list(filter((0).__ne__,currRow))
                currCol = [r[col] for r in grid]
                currCol = list(filter((0).__ne__,currCol))
                subGridR = row//3
                subGridC = col//3
                currSubGrid = [g[subGridC*3:subGridC*3+3] for g in grid[subGridR*3:subGridR*3+3]]
                subGridList = [num for subList in currSubGrid for num in subList]
                subGridList = list(filter((0).__ne__,subGridList))
                
        

                if len(currRow) != len(set(currRow)):#If duplicates, set will remove and change the length
                    for each in set(currRow):
                        numCount = currRow.count(each)
                        if numCount > 1:
                            if err1 == 0:
                                err1 = 1
                                print('Number {} twice in row'.format(int(each)))
                    validNum = False
                    
                if len(currCol) != len(set(currCol)):
                    for each in set(currCol):
                        numCount = currCol.count(each)
                        if numCount > 1:
                            if err2 == 0:
                                err2 = 1
                                print('Number {} twice in col'.format(int(each)))
                    validNum = False

                if len(subGridList) != len(set(subGridList)):
                    for each in set(subGridList):
                        numCount = subGridList.count(each)
                        if numCount > 1:
                            if err3 ==0:
                                err3 = 1
                                print('Number {} twice in subgrid'.format(int(each)))
                    validNum = False

        return validNum


if __name__ == '__main__':#Execute as the main
    app = qw.QApplication(sys.argv)#Make a new app
    sudoku = Sudoku()#Make it sudoku
    sys.exit(app.exec_())#Run it













