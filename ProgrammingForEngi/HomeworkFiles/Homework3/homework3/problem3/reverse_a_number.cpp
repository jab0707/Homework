//Assignment 3, problem 2 In Inverter
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <cctype>

//Initilize globals
struct inputInfo {
	bool validInput;
	std::int64_t input;
	std::string errorMsg;
};



//Initilize functions
inputInfo checkInput();
std::int64_t reverse_number(std::int64_t number);


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
		std::cout << "Case " << caseCounter << ":\n";//Print the case
		if (currentInput.validInput == false)//If there is no next valid input send an error message and return 1
		{
			std::cout << currentInput.errorMsg;
			if (caseCounter + 1 < maxCases) {
				std::cout << '\n';
			}
		}
		else {//If we got a valid input continue on
			
			std::int64_t reversedNum = reverse_number(currentInput.input);
			std::cout << reversedNum;


			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

std::int64_t reverse_number(std::int64_t number) {
	//Reverse the integer
	
	std::uint16_t tensPower = 0;//if the number is 100, this is 2, if it is 1000, this is 3 etc
	std::uint64_t divCheck = number / 10;//Check when we have hit the first digit of the original
	std::int64_t placeHolderNum = 0;//Holds onto our old number so we can properly extract the new digit
	std::int64_t newDigit;
	while (divCheck != 0) {//Find out how long the input is
		divCheck = divCheck / 10;
		tensPower = tensPower + 1;
	}
	std::int64_t revNumber = 0;
	if (tensPower == 0) {//If there is only one digit, east to reverse
		revNumber = number;
	}
	else {//Otherwise for each tens place extract the digit and put it into the correct place in the rev number
		for (std::uint64_t counter = 0; counter <= tensPower; counter = counter + 1) {
			placeHolderNum = placeHolderNum * 10; 
			newDigit = (number / (std::int64_t)pow(10, (tensPower - counter)) - placeHolderNum);
			
			revNumber = revNumber + newDigit * (std::int64_t)pow(10, counter);

			placeHolderNum = placeHolderNum + newDigit;
		}
	}


	return revNumber;
}

inputInfo checkInput() {
	//Checks input to make sure it is a proper input
	std::int64_t currentInput;
	inputInfo returnInfo = { true,0,"" };
	
	if (!(std::cin >> currentInput)) {//If there is an input at all
		std::cin.clear();
		std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		return { false,0,"Invalid input" };
	}
	if (std::cin.peek() != 10) {//If the entire input was properly read
		std::cin.clear();
		std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		return { false,0,"Invalid input" };
	}

	//If allw e got in was an int then make sure it is good to go
	if (currentInput < 0) {
		std::cin.clear();
		std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		return { false, 0, "Invalid input" };
	}


	return { true,currentInput,"" };

}
