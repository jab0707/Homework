//Assignment 2, problem 1 Flip Flop Simulator
//Architecture built off of HW1 P1
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <vector>

//Initilize globals
struct inputInfo {
	bool validInput;
	std::vector<std::string> allInputs;
};

//Initilize functions
inputInfo checkInput(std::int64_t inNum);
void simulateFish(int startT, int simT, int divA, int divB);

//main function body
int main() {
	//Initilize the counter for how many cases we have gone through so far
	std::int64_t caseCounter = 0;
	//Initilize the carrier for the first line max cases and other variables
	std::int64_t maxCases;
	inputInfo currentInput;

	//Grab the first input which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter + 1) {
		currentInput = checkInput(4); 

		if (currentInput.validInput == false)//If there is no next valid input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " valid cases expected, but only " << caseCounter << " valid cases given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got a valid input continue on
			std::cout << "Case " << caseCounter << ":\n";//Print the case

			simulateFish(stoi(currentInput.allInputs[0]), stoi(currentInput.allInputs[1]), stoi(currentInput.allInputs[2]), stoi(currentInput.allInputs[3]));

			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}


inputInfo checkInput(std::int64_t inNum) {
	//Checks the inputs to see if they are valid. If they are vaid, captures them in a string vector and returns them in the input
	//info structure. Will look for inNum number of inputs.
	
	//Initilize things
	std::vector<std::string> allInputs;
	std::string currentInput;
	bool validInputs;

	for (int counter = 0;counter < inNum;counter = counter + 1) {
		if (!(std::cin>>currentInput )) {//If there is no input where expected, this is invalid. Return an invalid input
			validInputs = false;
			return {validInputs,allInputs};
		}
		else {//Otherwise we have a valid input to record
			allInputs.push_back(currentInput);
		}
	}
	//If we have made it here we have recorded all the expected inputs and they were valid
	validInputs = true;
	return { validInputs,allInputs };

}

void simulateFish(int startT, int simT, int divA, int divB) {
	//Simulates the fish flip flop based on the start time (startT), the total time (simT) and the A and B factors
	//On time % a = 0 it flips, on time % b = 0 it flops
	bool flip;
	bool flop;

	for (int time = startT; time < startT + simT; time = time + 1) {
		flip = false;
		flop = false;
		if (time % divA == 0) {
			flip = true;
		}
		if (time % divB == 0) {
			flop = true;
		}
		if (flip) {
			std::cout << "flip";
		}
		if (flop) {
			std::cout << "flop";
		}
		if (!flip && !flop) {
			std::cout << time;
		}
		if (time + 1 < startT + simT) {
			std::cout << "\n";
		}
	}

}