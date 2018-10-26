//Assignment 4, problem 1 Cipher
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

//Initilize things
class LabelGenerator {
private:
	const std::string l_prefix;
	int start_l;
	int current_l;
public:
	//Constructor
	LabelGenerator(const std::string &prefix, int start) :
		start_l(start),
		current_l(start),
		l_prefix(prefix)
	{
	}
	//default constructor default label L starting at 0.
	LabelGenerator() :
		l_prefix("L"),
		start_l(0),
		current_l(0)
	{
	}


	std::string next_label() {
		std::string fullLabel = l_prefix + std::to_string(current_l);
		current_l = current_l + 1;
		return fullLabel;

	}

};



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

		std::string currentLabel;
		int startNum;
		int endNum;
		std::cin >> currentLabel;
		
		std::size_t spacePos = currentLabel.find("**_**");
		while (spacePos != std::string::npos) {
			currentLabel.replace(spacePos, 5, " ");
			spacePos = currentLabel.find("**_**");
		}
		std::cin >> startNum;
		std::cin >> endNum;

		LabelGenerator lGen(currentLabel, startNum);

		int labels = endNum - startNum;
		std::cout << "Case " << caseCounter << ":\n";//Print the case
		for (int lab = 0; lab <= labels; lab = lab + 1) {
			std::cout << lGen.next_label();
			if (lab + 1 <= labels) {
				std::cout << " ";
			}
		}
		if (caseCounter + 1 < maxCases) {
			std::cout << "\n";//For printing the newline we only want to do so for all but the last time
			//This way we do not end up with an extra space at the end
		}
	}
	return 0; //Successful execution
}



