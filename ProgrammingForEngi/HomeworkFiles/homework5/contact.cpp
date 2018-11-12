#include <string>
#include "contact.h"

Contact::Contact() {
	first = "";
	last = "";
	phone = "";
	mail = "";
}

Contact::Contact(std::string fName, std::string lName, std::string pNum, std::string email)
	:first(fName), last(lName), phone(pNum), mail(email)
{

}

std::string Contact::getFName() {
	return first;
}
std::string Contact::getLName() {
	return last;
}
std::string Contact::getPhone() {
	return phone;
}
std::string Contact::getEmail() {
	return mail;
}