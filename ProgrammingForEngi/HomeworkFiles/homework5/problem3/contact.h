#pragma once
#include <string>

class Contact {
	std::string first, last, phone, mail;
public:
	Contact();
	Contact(std::string fName, std::string lName, std::string pNum, std::string email);
	std::string getFName();
	std::string getLName();
	std::string getPhone();
	std::string getEmail();
};