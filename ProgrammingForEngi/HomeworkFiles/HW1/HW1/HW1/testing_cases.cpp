//Assignment 1, problem 1 Reading in standard input and echoing that input back to the consol
//
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>;
#include <string>;

std::int64_t caseCounter = 0;

//main function body
int main() {
	//Initilize the string that will carry the input
	std::string givenInput;
	

	std::cin >> givenInput;
	std::cout << "Case " << caseCounter << ":\n";
	std::cout << "Echo: " << givenInput<<"\n";

	return 0; //Successful execution
}