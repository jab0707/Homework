// A comment, such as this one, begins with //. Everything that comes after //
// on the same line will be treated as a comment.

/* This is also a comment, but
it can be on multiple lines. */

// Comments will be ignored by the compiler.

#include <iostream> /* We will be reading from the keyboard and writing to the
screen, which requires using input/output facilities provided by the
language. The I/O facilities we need for this program are found in the
"iostream" file. The #include directive copies the contents of that file
and pastes it here so that we can use whatever facilities provided by the
file. <iostream> is not part of the core language but belongs to
the Standard Template Library (STL). */
#include <string> /* The "string" file, also included in STL, provides
definitions for the "std::string" data type, which we need in order to work
with things that are represented as sequences of characters such as names. */

int main() /* Every C++ program defines a function named "main" which returns
		   an integer. */
{
	int class_code_cs; /* This is a declaration statement. It defines the name
					   class_code_cs, which is a variable of type int (integer). */
	class_code_cs = 6962; /* This is an assignment statement. We assign the
						  value 6962 to the variable class_code_cs. */

	int class_code_me = 6250; /* We can combine a definition and an assignment
							  into one statement. */

	int class_code_bioen = 6900;

	std::cout << "Please enter your name: "; /* print "Please enter your name: "
											 to the screen. */

	std::string my_name;
	float section;

	std::cin >> my_name; /* wait for the user to enter his name from the
						 keyboard, then assign it to the variable "my_name". */
	std::cout << "what section are you in? ";
	std::cin >> section;

	std::cout << "Hello, " << my_name << "\n"; /* we can print multiple things
											   by concatenating them with <<. The "\n" signifies a new line. */
	std::cout << "My section is " << section << "\n";

	std::cout << "Welcome to CS" << class_code_cs << "\n";
	std::cout << "Welcome to ME" << class_code_me << "\n";
	std::cout << "Welcome to BIOEN" << class_code_bioen << "\n";
	return 0; /* we return the number 0 to the code that calls this function
			  (main), to signify successful execution of "main".
			  Can be omitted and 0 will be returned by default. */
}
