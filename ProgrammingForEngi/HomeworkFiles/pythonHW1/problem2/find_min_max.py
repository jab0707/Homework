#Python HW 1, problem 2, min max calc



numInputs = int(input())

for inputInd in range(numInputs):
    currentInput = (input())#read input line
    currentInput = currentInput.split(' ')#split to a list by the spaces
    currentNumbers = [int(i) for i in currentInput]#covert strings to ints
    currMax = currentNumbers[0]
    currMin = currentNumbers[0]
    for num in currentNumbers:
        if (num > currMax ):
            currMax = num
        if (num<currMin):
            currMin = num

    print('Case {}:'.format(inputInd))
    print('Min: {}\nMax: {}'.format(currMin,currMax))
    
