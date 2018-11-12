#Python HW 1, problem 3, flip flop



numInputs = int(input())

for inputInd in range(numInputs):
    currInput = input()
    currInput = currInput.split(" ")
    start = int(currInput[0])
    time = int(currInput[1])
    a = int(currInput[2])
    b = int(currInput[3])
    print('Case {}:'.format(inputInd))
    for i in range(start,start+time,1):
        pStr = ''
        if (i%a == 0):
            pStr = pStr + 'flip'
        if (i%b == 0):
            pStr = pStr + 'flop'
        if (len(pStr) == 0):
            pStr = str(i)
        print(pStr)
