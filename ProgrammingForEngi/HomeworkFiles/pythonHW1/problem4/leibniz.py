#Python HW 1, problem 1, echo input 



numInputs = int(input())

for inputInd in range(numInputs):
    iterations = int(input())
    piEst = 0
    for iter in range(iterations):
        piEst = piEst + (1/(1+(2*iter))*((-1)**iter))

    piEst = piEst * 4
    
    print('Case {}:'.format(inputInd))
    print('Pi estimated as: {:0.8f}'.format(piEst))
    
