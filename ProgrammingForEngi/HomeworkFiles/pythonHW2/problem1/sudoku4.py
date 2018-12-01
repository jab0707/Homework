

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
        for row in range(0,9):#Fill in the grid
            grid[row] = inputNumbers[row*9:row*9 + 9]
        self.theBoard = grid

    def drawBoard(self):
        #Draw the board gui
        layout = qw.QGridLayout();
        for r in range(self.row):#Make comboboxes for each grid location
            gui_boxes = []
            for c in range(self.col):
                gui_boxes.append(self.getBox(self.theBoard[r][c]))
            self.guiBoard.append(gui_boxes)
        #Arrange the boxes into subgrids in the main grid
        for r in range(self.subGridR):
            for c in range(self.subGridC):
                subgrid = self.getSubGrid(r,c)
                layout.addWidget(subgrid,r,c)
        self.setLayout(layout)
        self.show()

    def getBox(self,initialVal):
        #Create a box at the specified location
        box = qw.QComboBox();
        choices = [' ','1','2','3','4','5','6','7','8','9']
        for choice in choices:
            box.addItem(choice)
        box.setCurrentIndex(initialVal)
        return box

    def getSubGrid(self,r,c):
        #Create a subgrid at the specified location
        holdWidget = qw.QWidget();
        subGrid = qw.QGridLayout();
        for rId in range(self.subGridR):
            for cId in range(self.subGridC):
                subGrid.addWidget(self.guiBoard[r*self.subGridR + rId][c*self.subGridC + cId],rId,cId)
        holdWidget.setLayout(subGrid)
        return holdWidget


if __name__ == '__main__':#Execute as the main
    app = qw.QApplication(sys.argv)#Make a new app
    sudoku = Sudoku()#Make it sudoku
    sys.exit(app.exec_())#Run it











