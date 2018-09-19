//Assignment 1, problem 2 Reading in standard input and converting it from celsius to fahrenheit
//Architecture from problem 1 used as a base for this problem
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>

//Initilize the counter for how many cases we have gone through so far
std::int64_t caseCounter = 0;
//Initilize the int that will carry the input
std::int64_t inFahr;
//Initilize the carrier for the first line max cases
std::int64_t maxCases;
//Initilize the int and float answers and conversion factors
std::int64_t intAns;

double floatAns;

double convertAsFloat(int fahrToCFloat);
int convertAsInt(int fahrToCInt);

//main function body
int main() {


	//Grab the first line which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter + 1) {
		if (!(std::cin >> inFahr))//Get the next input. If there is no next input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " cases expected, but only " << caseCounter << " cases given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got an input continue on
			//Convert to celsius as int and as float
			//To convert C = (F - 32)/1.8
			intAns = convertAsInt(inFahr);
			floatAns = convertAsFloat(inFahr);

			std::cout << "Case " << caseCounter << ":\n";//Print the case
			std::cout << inFahr << "F = " << intAns << "C\n";
			std::cout << inFahr << "F = " << floatAns << "C";
			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";
			}
		}
	}
	return 0; //Successful execution
}

double convertAsFloat(int fahrToCFloat) {
	//Converts the input Fahrenheit to Celsius using float math
	const double floatOffset = 32.0f;
	const double floatConvFactor = 1.8f;
	double outPut;
	outPut = (fahrToCFloat - floatOffset) / floatConvFactor;
	return outPut;
}

int convertAsInt(int fahrToCInt) {
	//Converts the input Fahrenheit to Celsius using int math
	//For the int scale we multiply by ten on top and bottom( by multiplying by 10 then dividing by 18 instead of 1.8
	const int intOffset = 32;
	const int intConvFactor = 18;
	int outPut;
	outPut = (((fahrToCInt - intOffset) * 10) / intConvFactor);
	return outPut;
}