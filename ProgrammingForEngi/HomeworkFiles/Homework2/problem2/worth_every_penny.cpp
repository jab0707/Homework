//Assignment 2, problem 2 Profit Calculator and comparison
//Architecture built off of HW1 P1
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <vector>

//Initilize globals
struct inputInfo {
	bool validInput;
	std::int64_t ringsSold;
	std::string errorMsg;
};

//Initilize functions
inputInfo checkInput();
double billsCalculation(std::uint16_t rings);
double exactProfit(std::uint16_t rings);

//main function body
int main() {
	//Initilize the counter for how many cases we have gone through so far
	std::int64_t caseCounter = 0;
	//Initilize the carrier for the first line max cases and other variables
	std::int64_t maxCases;

	//Grab the first input which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter + 1) {
		double billProfit;
		double exProfit;
		inputInfo currentInput = checkInput();

		if (currentInput.validInput == false)//If there is no next valid input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " valid cases expected, but only " << caseCounter << " valid cases given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got a valid input continue on
			std::cout << "Case " << caseCounter << ":\n";//Print the case

			billProfit = billsCalculation(currentInput.ringsSold);
			exProfit = exactProfit(currentInput.ringsSold);

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

double billsCalculation(std::uint16_t rings) {

}

double exactProfit(std::uint16_t rings) {

}

inputInfo checkInput() {
	//Checks the number of rings input to validate that it is between the limits 1 and 30000000
	//Retiurns if the input is valid, if so what it was, and any error message if it was not valid
	std::string inputStr;

	if (!(std::cin >> inputStr)) {//If there is no input
		return { false,0,"No input given!" };

	}else {
		int test = inputStr.find_first_not_of("0123456789");
		if () {

		}

	}
}
