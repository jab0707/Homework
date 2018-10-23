//Assignment 4, problem 1 Cipher
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

//Initilize globals

//Initilize functions
void encrypt(std::string &phrase);


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

		std::string currentInput;

		if (!(std::cin>>currentInput))//If there is no next valid input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " valid cases expected, but only " << caseCounter << " valid cases given!\n";
			std::cout << "No phrase given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got a valid input continue on
			std::cout << "Case " << caseCounter << ":\n";//Print the case
			encrypt(currentInput);
			std::cout << currentInput;
			

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}



void encrypt(std::string &phrase) {

	for (int idx = 0; idx < phrase.length();idx = idx + 1) {
		phrase[idx] = (char)((int)phrase[idx] + 13);

	}
	
}