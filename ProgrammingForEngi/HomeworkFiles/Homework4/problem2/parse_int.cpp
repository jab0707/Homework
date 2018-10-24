//Assignment 4, problem 2 int parser
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

//Initilize globals

//Initilize functions
bool parse_int(const std::string &str, int &val);


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
		int val = +0;//initilize as positive 0 to prevent spurious errors
		bool successfulParse = false;

		if (!(std::cin >> currentInput))//If there is no next valid input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " valid cases expected, but only " << caseCounter << " valid cases given!\n";
			std::cout << "No phrase given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got a valid input continue on
			std::cout << "Case " << caseCounter << ":\n";//Print the case

			successfulParse = parse_int(currentInput,val);
			if (successfulParse) {
				std::cout << val;
			}
			else {
				std::cout << "Parsing failed";
			}


			if (caseCounter + 1 < maxCases) {
				std::cout << "\n";//For printing the newline we only want to do so for all but the last time
				//This way we do not end up with an extra space at the end
			}
		}
	}
	return 0; //Successful execution
}



bool parse_int(const std::string &str, int &val) {
	int asciiVal;
	int tensPlace = -1;
	const int maxTens = 9;
	const int maxVal = std::numeric_limits<int>::max();
	const int minVal = -maxVal - 1;
	bool negative = false;
	for (int idx = 0; idx < str.length();idx = idx + 1) {//for each character
		asciiVal = (int(str[idx]));//Grab the ascii value to check to see what it is
		if (asciiVal!=43 && asciiVal!=45 && (asciiVal < 48 || asciiVal >57)) {//if the character is not a digit, and not + and not -
			return false;
		}
		else {//else go forward
			if (asciiVal == 43 || asciiVal == 45) {
				//If this is not the first character and it is a + or - we have failed
				if (idx > 0) {
					return false;
				}
				else {
					if (asciiVal == 45) {
						negative = true;
					}
				}

			}
			else {//If it is a digit we need to add it to our value but prevent overflow
				tensPlace = tensPlace + 1;//up the tens place counter for the next digit we add
				if (tensPlace > maxTens) {//If our tens digits exceed the limit
					return false;
				}
				else if (tensPlace == maxTens) {//If our tens digit meet the limit we need to check closely for overflow
					if (negative) {//Check the negatlve separatly becase the limit is different
						if (val > (maxVal / 10)) {//If moving the tens place will exceed limit we can stop here
							return false;
						}
						else if (val == (maxVal / 10)) {//If moving the tens place reaches the limit for those digits check the digit we would add
							if ((asciiVal - 48) > 8) {//If that next digit exceeds its limit (8 for the ones place of the negative limit)
								return false;
							}
							else {//if it does not exceed the ones place limt we are good to add it
								val = (val * 10) + (asciiVal - 48);
							}
						}
						else {//If moving the tens place does not bring us to the limit for those digits, adding the next one will be fine
							val = (val * 10) + (asciiVal - 48);
						}

					} else {//Pretty much the same for positive, the difference is that the ones place limit is 7 for the maximum, not 8
						if (val > (maxVal / 10)) {
							return false;
						}
						else if (val == (maxVal / 10)) {
							if ((asciiVal - 48) > 7) {
								return false;
							}
							else {
								val = (val * 10) + (asciiVal - 48);
							}
						} else {
							val = (val * 10) + (asciiVal - 48);
						}

					}


				}
				else {//If the tens place is not above or at the limit, no need to check for overflow
					val = (val * 10) + (asciiVal - 48);
				}

			}

		}
		

	}
	if (negative) {//If it is negative, make it so
		val = -val;
	}
	return true;

}