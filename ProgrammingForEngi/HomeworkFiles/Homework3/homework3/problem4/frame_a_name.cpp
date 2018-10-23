//Assignment 3, problem 4 Name Framer
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
void frame_name(std::string name);


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
			frame_name(currentInput.input);//Frame the name

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

void frame_name(std::string name) {
	//Prints the properly spaced and sized frame

	const std::uint8_t minSize = 25;//The size of the welcome to my program line
	const std::uint8_t sizeToAdd = 11;//The size of the name line without a name
	std::uint64_t szDiffName = 0;//Difference between name size and the total size
	std::uint64_t szDiffMsg = 0;//diff between message size and total size
	std::uint64_t windowSize;//The window size
	if (name.length() + sizeToAdd > minSize) {//Determine the window size
		windowSize = name.length() + sizeToAdd;
		szDiffMsg = (sizeToAdd + name.length()) - minSize;
	}
	else {
		windowSize = minSize;
		szDiffName = minSize - (sizeToAdd + name.length());
	}
	//Print according to the window size
	for (std::uint64_t count = 1; count <= windowSize; count = count + 1) {
		std::cout << '*';
	}
	std::cout << "\n*";
	for (std::uint64_t count = 1; count <= windowSize -2; count = count + 1) {
		std::cout << ' ';
	}
	std::cout << "*\n* Hello, " << name;

	for (std::uint64_t count = 1; count <= szDiffName; count = count + 1) {
		std::cout << ' ';
	}
	std::cout << " *\n* Welcome to my program";
	for (std::uint64_t count = 1; count <= szDiffMsg ; count = count + 1) {
		std::cout << ' ';
	}
	std::cout << " *\n*";
	for (std::uint64_t count = 1; count <= windowSize - 2; count = count + 1) {
		std::cout << ' ';
	}
	std::cout << "*\n";
	for (std::uint64_t count = 1; count <= windowSize; count = count + 1) {
		std::cout << '*';
	}

}

inputInfo checkInput() {
	//Properly get the input, clearing the newline character if need be
	std::string currentInput;
	inputInfo returnInfo = { true,"","" };

	if (std::cin.peek() == 10) {
		std::cin.clear();
		std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
	}
	
	std::getline(std::cin, currentInput);
	return { true,currentInput,"" };

}
