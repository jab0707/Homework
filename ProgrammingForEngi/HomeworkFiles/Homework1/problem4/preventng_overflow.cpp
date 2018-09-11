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
//Initilize the double that will carry the input
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
		
		std::cout << "Case " << caseCounter << ":\n";//Print the case

		std::cin >> givenInput;//Get the next input
		overFlow = testIfOverFlow(givenInput);

		
		if (!overFlow) {
			outFloat = (float) givenInput;
			std::cout << outFloat;
		}



		if (caseCounter + 1 < maxCases) {
			std::cout << "\n";//For printing the newline we only want to do so for all but the last time
			//This way we do not end up with an extra space at the end
		}
	}
	return 0; //Successful execution
}

bool testIfOverFlow(double doub) {
	//Tests to see if the given input will safely case into a float or if it will
	//Overflow. If it overflows then will return false. If it can safely fit
	//in a float single precision it will return true
	float floatMax = std::numeric_limits<float>::max();
	float floatMin = -floatMax;
	if (doub>= floatMin && doub <= floatMax) {
		std::cout << doub << " won't overflow a float, float = ";
		return false;
	}
	else {
		std::cout << doub << " will overflow a float";
		return true;
	}

}