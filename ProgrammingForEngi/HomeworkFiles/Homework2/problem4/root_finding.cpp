//Assignment 2, problem 3 Pi estimation Calculator
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <iomanip>
#include <vector>
#include <numeric>
#include <cmath>

//Initilize globals
struct inputInfo {
	bool validInput;
	double startingGuess;
	std::int64_t iterations;
	double errorThresh;
	std::string errorMsg;
};
struct newtonOutput {
	double root;
	std::uint64_t finalIter;
	double finalError;
};

//Initilize functions
double fofx(double x);
double fprimeofx(double x);
double calcErr(double xOld, double xNew);
inputInfo checkInput();
newtonOutput newtonMethod(double startGuess,std::int64_t iterations, double errorThrehold);

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

			newtonOutput currentOutput = newtonMethod(currentInput.startingGuess,currentInput.iterations,currentInput.errorThresh);
			std::cout << "root at x = " << std::fixed << std::setprecision(5) << currentOutput.root;
			//Switch back to scientific notation for the error
			std::cout << " with error " << std::scientific<< currentOutput.finalError << " after " << currentOutput.finalIter << " iterations";

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

newtonOutput newtonMethod(double startGuess, std::int64_t iterations, double errorThrehold) {
	//
	//
	//f(x) = x^5 + 6x^4 + 3x^3 - x - 50
	//f'(x) = 5x^4 + 24x^3 + 9x^2 - 1

	//This counts as the first iteraction
	double oldGuess = startGuess;
	double newGuess = oldGuess - (fofx(oldGuess) / fprimeofx(oldGuess));
	double err = calcErr(oldGuess, newGuess);
	std::uint64_t currentIter = 1;

	while (err > errorThrehold && currentIter < iterations) {
		oldGuess = newGuess;
		newGuess = oldGuess - (fofx(oldGuess) / fprimeofx(oldGuess));
		err = calcErr(oldGuess, newGuess);
		currentIter = currentIter +1;
	}
	return { newGuess,currentIter,err };
}

double fofx(double x) {
	//computes f(x) =  x^5 + 6x^4 + 3x^3 - x - 50
	return pow(x, 5) + (6 * pow(x, 4)) + (3 * pow(x, 3)) - x - 50;
}
double fprimeofx(double x) {
	//computes f'(x) = 5x^4 + 24x^3 + 9x^2 - 1
	return (5*pow(x, 4)) + (24 * pow(x, 3)) + (9 * pow(x, 2)) - 1;
}
double calcErr(double xOld, double xNew) {
	//Computes the error of the new guess
	return abs((xNew - xOld) / xNew);
}

inputInfo checkInput() {
	//Checks the number of rings input to validate that it is between the limits 1 and 30000000
	//and it is an unsigned int
	//Retiurns if the input is valid, if so what it was, and any error message if it was not valid
	std::string startGuessString;
	std::string iterationsString;
	std::string errorString;

	if (!(std::cin >> startGuessString)|| !(std::cin >> iterationsString)|| !(std::cin >> errorString)) {//If there is no input for any of the three inputs
		return { false,0,0,0,"No or incomplete input given!\nProvide starting guess, iterations, and error threshold." };

	}
	else {
		size_t test = iterationsString.find_first_not_of("0123456789");//This will return npos if it finds nothing not in the given items
		if (!(test == std::string::npos)) {//If the input contains anything other than numbers we don't want that
			return { false,0,0,0,"Improper input! Please input an unsigned Integer for iterations." };
		}
		test = startGuessString.find_first_not_of("0123456789-e.");//This will return npos if it finds nothing not in the given items
		if (!(test == std::string::npos)) {//If the input contains anything other than numbers we don't want that
			return { false,0,0,0,"Improper input! Please input a valid float for first guess." };
		}
		test = errorString.find_first_not_of("0123456789-e.");//This will return npos if it finds nothing not in the given items
		if (!(test == std::string::npos)) {//If the input contains anything other than numbers we don't want that
			return { false,0,0,0,"Improper input! Please input a valid float for error threshold." };
		}
		//Otherwise we seem to have a valid input of a positive integer
		//Now we need to make sure it is in our limit
		double startGuess = std::stod(startGuessString);
		std::int64_t iters = std::stoi(iterationsString);
		double errorThresh = std::stod(errorString);

		return { true, startGuess,iters,errorThresh, "" };//Return true for valid input, the inputs, and an empty error message

	}
}
