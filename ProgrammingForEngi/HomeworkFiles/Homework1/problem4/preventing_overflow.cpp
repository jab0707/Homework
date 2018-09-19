//Assignment 4, preventing float overflow
//Built from problem 1 structure
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

//Initilize the counter for how many cases we have gone through so far
std::int64_t caseCounter = 0;
//Initilize the carrier for the first line max cases
std::int64_t maxCases;
//Initilize the other variables and functions
double givenInput;
bool overFlow;
bool testIfOverFlow(double doub);
float outFloat;



//main function body
int main() {
	//Grab the first line which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter + 1) {

		if (!(std::cin >> givenInput))//Get the next input. If there is no next input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " cases expected, but only " << caseCounter << " cases given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we sucessfully got the next line then continue on

			std::cout << "Case " << caseCounter << ":\n";//Print the case
			overFlow = testIfOverFlow(givenInput);//Check for overflow

			if (!overFlow) {//If we are not overflowing then we can do the conversion.
				outFloat = (float)givenInput;
				std::cout << outFloat;
			}

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

bool testIfOverFlow(double doub) {
	//Tests to see if the given input will safely case into a float or if it will
	//Overflow. If it overflows then will return true. If it can safely fit
	//in a float single precision it will return false
	float floatMax = std::numeric_limits<float>::max();
	float floatMin = -floatMax;//Using numeric_limits min will result in the finest precision, not the greates negative magnitude
	if (doub>= floatMin && doub <= floatMax) {
		std::cout << doub << " won't overflow a float, float = ";
		return false;
	}
	else {
		std::cout << doub << " will overflow a float";
		return true;
	}

}