#Python HW 1, problem 1, echo input 



numInputs = int(input())

for inputInd in range(numInputs):
    currInput = input()
    print('Case {}:'.format(inputInd))
    print('Echo: {}'.format(currInput))
    