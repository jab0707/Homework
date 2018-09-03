#include <iostream>

int main() {
	// We can make a simple guessing game, where the user can try to guess
	// some number we have in our program.
	int the_number = 15;
	int guess = 0;


	
	
	
	
	
	
	
	
	
	// QUESTION: What if we wanted to have the user re-try until they get it right?
    //while (guess != the_number) {
	for (int i = 0; i < 10 && guess != the_number; i = i +1)
	{
        std::cout << "Guess a number: ";
        std::cin >> guess;
		std::cin.clear();
		std::cin.ignore(1024, '\n');
		

        // An if/else statement is a way to execute code conditionally based on
        // the result of some test. In this case we can print whether or not the
        // user guessed the number.
        // QUESTION: Is this a correct solution?
        if (guess == the_number) {
            std::cout << "You guessed it!\nYou still had "<<9-i<<" guesses left\n";
        }
        else {
            std::cout << "That's not it\n";
			std::cout << "You have " << 9 - i << " guesses left.\n";
        
            // QUESTION: What if we wanted to tell the user if they were too high/low?
            if (guess > the_number) {
                std::cout << "your guess is too high \n";
            }

            else{
                std::cout << "your guess is too low \n";
            }
        }

    }
	
	
	
	
	
	
	
	
	
	// QUESTION: What if we wanted to re-try for a fixed number of times?
	
	
	
	
	
	
	
	
	return 0;
}

