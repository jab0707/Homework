//Assignment 2, problem 2 Profit Calculator and comparison
//Architecture built off of HW1 P1
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <iomanip>

//Initilize globals
struct inputInfo {
	bool validInput;
	std::int64_t ringsSold;
	std::string errorMsg;
};

//Initilize functions
inputInfo checkInput();
double billsCalculation(std::int64_t rings);
double exactProfit(std::int64_t rings);

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
			std::cout << currentInput.ringsSold << " rings were sold\n";
			//Initilize the needed variables
			double billProfit = 0;
			double exProfit = 0;
			//Calculate via bill and our methods
			//std::int64_t ringSold = currentInput.ringsSold;
			billProfit = billsCalculation(currentInput.ringsSold);
			exProfit = exactProfit(currentInput.ringsSold);
			std::cout << "Bill's program outputs " << std::fixed << std::setprecision(2) << billProfit << "\n";
			std::cout << "The exact profit is    " << std::fixed << std::setprecision(2) << exProfit;

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

double billsCalculation(std::int64_t rings) {
	//Caclulates profit using double math to get Bill's output

	if (rings > 0) {//If we sold more than zero rings
		double totalProfit = 0.25f;
		//For ever ring sold add 10*rings sold + .25 to the profit
		for (std::int64_t ringCount = 1; ringCount < rings; ringCount = ringCount + 1) {
			totalProfit = totalProfit + 10 * ringCount + 0.25f;
		}
		return totalProfit;
	}
	else {//if we sold 0 rings, then the profit is 0
		return 0.00f;
	}
}

double exactProfit(std::int64_t rings) {
	//Caclulates using a more robust method that is not as subseptable to floating point error
	if (rings > 0) {//If we have at least one ring sold
		double totalProfit = 0.00f;
		//Store the cent amount and dollar amount separatly as precise ints and combine later
		std::int64_t centAmount = 25;
		std::int64_t dollarAmount = 0;
		for (std::int64_t ringCount = 1; ringCount < rings; ringCount = ringCount + 1) {
			centAmount = centAmount + 25;
			dollarAmount = dollarAmount + 10 * ringCount;
		}
		//Now combine into a double
		totalProfit = dollarAmount + (double(centAmount) / 100);
		return totalProfit;

	}
	else {//If no rings sold, return 0 for earnings
		return 0.00f;
	}
}

inputInfo checkInput() {
	//Checks the number of rings input to validate that it is between the limits 1 and 30000000
	//and it is an unsigned int
	//Retiurns if the input is valid, if so what it was, and any error message if it was not valid
	std::string inputStr;

	if (!(std::cin >> inputStr)) {//If there is no input
		return { false,0,"No input given!" };

	}else {
		size_t test = inputStr.find_first_not_of("0123456789");//This will return npos if it finds nothing not in the given items
		if (!(test == std::string::npos)) {//If the input contains anything other than numbers we don't want that
			return { false,0,"Improper input. Please input an unsigned Integer for rings sold." };
		}
		//Otherwise we seem to have a valid input of a positive integer
		//Now we need to make sure it is in our limit
		std::int64_t ringNum = std::stoi(inputStr);
		std::int64_t ringMax = 30000000;
		if (ringNum > ringMax) {//If we exceed the maximum then return an error
			return { false, 0 , "Input exceeds maximum input! Maximum input is 30000000." };
		}

		return { true, ringNum, "" };//Return true for valid input, the number of rings, and an empty error message

	}
}
