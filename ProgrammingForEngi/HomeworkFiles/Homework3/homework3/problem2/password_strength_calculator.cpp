//Assignment 3, problem 2 Password Strength Calculator
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <cctype>

//Initilize globals
struct inputInfo {
	bool validInput;
	std::string input;
	std::string errorMsg;
};



//Initilize functions
inputInfo checkInput();
std::uint64_t calcPassStrength(std::string password);


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
			std::uint64_t strength = calcPassStrength(currentInput.input);
			std::cout << "Strength: " << strength;

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

std::uint64_t calcPassStrength(std::string password) {
	//Calculates password strength
	std::uint64_t passStr = password.length();//Base strength is the pass length
	std::uint8_t condsMet = 0;//Number of conditions met. Max = 4.
	bool hasPunct = false, hasNum = false, hasUpper = false, hasLower = false;
	char currentChar;

	//For the neght of the password check each condition and flag true when met
	for (std::uint64_t ind = 0; ind < password.length();ind = ind + 1) {
		currentChar = password[ind];
		if (std::ispunct(currentChar)) {
			hasPunct = true;
		}
		else if (std::isalpha(currentChar)) {
			if (std::islower(currentChar)) {
				hasLower = true;
			}
			if (std::isupper(currentChar)) {
				hasUpper = true;
			}
		}
		else if (std::isdigit(currentChar)) {
			hasNum = true;
		}

	}
	//For each condition add its value to the score and count how many conditions are met
	if (hasPunct) {
		passStr = passStr + 2;
		condsMet = condsMet + 1;
	}
	if (hasNum) {
		passStr = passStr + 1;
		condsMet = condsMet + 1;
	}
	if (hasUpper) {
		passStr = passStr + 1;
		condsMet = condsMet + 1;
	}
	if (hasLower) {
		passStr = passStr + 1;
		condsMet = condsMet + 1;
	}
	//For each condition met, adjust the score
	for (std::uint8_t iter = 1; iter < condsMet; iter = iter + 1) {
		passStr = passStr * 2;
	}

	return passStr;
}

inputInfo checkInput() {
	//Make sure we get an input
	std::string currentInput;
	inputInfo returnInfo = { true,"","" };
	if (!(std::cin >> currentInput)) {
		return { false,"","No Password given!" };
	}
	return { true,currentInput,"" };

}
