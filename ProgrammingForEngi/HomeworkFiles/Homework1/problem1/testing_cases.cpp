//Assignment 1, problem 1 Reading in standard input and echoing that input back to the consol
//
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

//Initilize the counter for how many cases we have gone through so far
std::int64_t caseCounter = 0;
//Initilize the string that will carry the input
std::string givenInput;
//Initilize the carrier for the first line max cases
std::int64_t maxCases;

//main function body
int main() {


	//Grab the first input which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter+1) {
		if(!(std::cin >> givenInput))//Get the next input. If there is no next input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " cases expected, but only " << caseCounter << " cases given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got an input continue on
			std::cout << "Case " << caseCounter << ":\n";//Print the case
			std::cout << "Echo: " << givenInput;//Echo the input
			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}