//Assignment 1, problem 2 Reading in standard input and converting it from celsius to fahrenheit
//Arhiteture from problem 1 used as a base for this problem
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

//Initilize the counter for how many cases we have gone through so far
std::int64_t caseCounter = 0;
//Initilize the string that will carry the input
std::int64_t inFahr;
//Initilize the carrier for the first line max cases
std::int64_t maxCases;
//Initilize the int and float answers
std::int64_t intAns;
const int intOffset = 32;
const int intConvFactor = 18;
double floatAns;
const double floatOffset = 32.0f;
const double floatConvFactor = 1.8f;

//main function body
int main() {


	//Grab the first line which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter+1) {
		std::cin >> inFahr;//Get the next input
		//Convert to celsius as int and as float
		//To convert C = (F - 32)/1.8
		intAns = (((inFahr - intOffset) * 10) / intConvFactor);
		floatAns = (inFahr - floatOffset) / floatConvFactor; 

		std::cout << "Case " << caseCounter << ":\n";//Print the case
		std::cout << inFahr << "F = "<< intAns<< "C\n";//
		std::cout << inFahr << "F = " << floatAns << "C";
		if (caseCounter + 1 < maxCases) {
			std::cout << "\n";
		}
	}
	return 0; //Successful execution
}