//Assignment 2, problem 3 Pi estimation Calculator
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <iomanip>
#include <numeric>

//Initilize globals
struct inputInfo {
	bool validInput;
	std::int64_t numTerms;
	std::string errorMsg;
};

//Initilize functions
inputInfo checkInput();
double leibnizCalc(std::int64_t termsToUse);

//main function body
int main() {
	//Initilize the counter for how many cases we have gone through so far
	std::int64_t caseCounter = 0;
	//Initilize the carrier for the first line max cases and other variables
	std::int64_t maxCases = 0;

	//Grab the first input which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter + 1) {

		inputInfo currentInput = checkInput();

		if (currentInput.validInput == false)//If there is no next valid input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " valid cases expected, but only " << caseCounter << " valid cases given!\n";
			std::cout << currentInput.errorMsg << "\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got a valid input continue on
			std::cout << "Case " << caseCounter << ":\n";//Print the case
			
			double piEst = leibnizCalc(currentInput.numTerms);
			std::cout << "Pi estimated as: " << std::fixed << std::setprecision(8) << piEst;

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

double leibnizCalc(std::int64_t termsToUse) {
	//Calculate the leibniz estimation of Pi using termsToUse number of terms
	double piEst = 0.00000000f;
	for (std::int64_t termId = 1; termId <= termsToUse;termId = termId + 1){
		double currentTerm = 1/((1 + (double(termId - 1)) * 2));
		if (termId % 2 == 0) {
			currentTerm = -currentTerm;
		}
		piEst = piEst + currentTerm;
	}
	

	piEst = piEst * 4;
	return piEst;

}

inputInfo checkInput() {
	//Checks the number of rings input to validate that it is between the limits 1 and 30000000
	//and it is an unsigned int
	//Retiurns if the input is valid, if so what it was, and any error message if it was not valid
	std::string inputStr;

	if (!(std::cin >> inputStr)) {//If there is no input
		return { false,0,"No input given!" };

	}
	else {
		size_t test = inputStr.find_first_not_of("0123456789");//This will return npos if it finds nothing not in the given items
		if (!(test == std::string::npos)) {//If the input contains anything other than numbers we don't want that
			return { false,0,"Improper input! Please input an unsigned Integer number of terms to use." };
		}
		//Otherwise we seem to have a valid input of a positive integer
		//Now we need to make sure it is in our limit
		std::int64_t termNum = std::stoi(inputStr);
		std::int64_t termMax = 10000000;
		if (termNum > termMax) {//If we exceed the maximum then return an error
			return { false, 0 , "Input exceeds maximum input! Maximum input is 10000000." };
		}

		return { true, termNum, "" };//Return true for valid input, the number of rings, and an empty error message

	}
}
