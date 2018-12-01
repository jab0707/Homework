
path = input("Enter input filepath: ")
file = open(path,'r')
inputStr = file.read()

inputNumbers = list(map(int,inputStr.replace('\n',' ').split(' ')))

for ind in range(0,81,9):
    printStr = str(inputNumbers[ind:ind+9]).replace(',','').replace('[','').replace(']','')
    print(printStr)
