//Assignment 3, problem 1 Min and max calculator
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
	std::uint64_t numOfNums;
	std::int64_t numbers[256];
	std::string errorMsg;
};
struct calcResults {
	std::int64_t min=0;
	std::int64_t max=0;
};


//Initilize functions
inputInfo checkInput();
calcResults calcMinMax(std::int64_t numOfNums, std::int64_t nums[256]);


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
			calcResults results = calcMinMax(currentInput.numOfNums, currentInput.numbers);
			std::cout << "Min: " << results.min << "\n";
			std::cout << "Max: " << results.max;

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}

calcResults calcMinMax(std::int64_t numOfNums, std::int64_t nums[256]) {
	//

	std::int64_t min = nums[0];
	std::int64_t max = nums[0];

	for (std::int64_t currNum = 0;currNum < numOfNums;currNum = currNum + 1) {
		if (min > nums[currNum]) {
			min = nums[currNum];
		}
		if (max < nums[currNum]) {
			max = nums[currNum];
		}
	}
	return { min,max };
}

inputInfo checkInput() {
	//
	std::string currentInput;
	inputInfo returnInfo = { true, 0,{0},"" };
	if (!(std::cin >> currentInput)) {
		return { false,0,{0},"Number of numbers not given." };
	}
	size_t test = currentInput.find_first_not_of("0123456789");//This will return npos if it finds nothing not in the given items
	if (!(test == std::string::npos)) {//If the input contains anything other than numbers we don't want that
		return { false,0,{0},"Improper input! Please input an unsigned Integer for number of numbers." };
	}
	std::int64_t numOfNums = stoi(currentInput);
	if (numOfNums == 0) {
		return { false,0,{0},"Cannot take min or max of 0 inputs." };
	}


	for (std::int64_t currNum = 0;currNum < numOfNums; currNum = currNum + 1) {
		if (!(std::cin >> currentInput)) {
			return { false,0,{0},"Number of numbers not given." };
		}
		size_t test2 = currentInput.find_first_not_of("-0123456789");//This will return npos if it finds nothing not in the given items
		if (!(test2 == std::string::npos)) {//If the input contains anything other than numbers we don't want that
			return { false,0,{0},"Improper input! Please input an Integer for each number." };
		}

		returnInfo.numbers[currNum] = stoi(currentInput);

	}
	
	returnInfo.numOfNums = numOfNums;
	return returnInfo;
}
