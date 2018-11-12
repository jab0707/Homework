//HW5, problem 3 contacts manager main
#include <string>
#include <iostream>
#include "contact.h"
#include <map>

void handleAdd(std::map <std::string, Contact> &cMap);
void handleRemove(std::map <std::string, Contact> &cMap);
void handleList(std::map <std::string, Contact> &cMap);
void handleFind(std::map <std::string, Contact> &cMap);

int main() {
	std::string cmd;
	std::map <std::string,Contact> contactList;//map with string keys to Contact conetents
	do {
		if (cmd == "exit") { 
			break; 
		}else if (cmd == "list") {
			// List contacts in the manager
			handleList(contactList);
		}else if(cmd == "add"){
			// Add a contact to the manager
			handleAdd(contactList);
		}
		else if (cmd == "remove") {
			// Remove a contact from the manager
			handleRemove(contactList);
		}else if (cmd == "find") {
			// Find a contact in the manager]
			handleFind(contactList);
		}
		// Print a terminal prompt so the user knows
		 // we're waiting for their input
		std::cout << "> ";
		}
	while(std::cin >> cmd);
		return 0;
	}


void handleAdd(std::map <std::string, Contact> &cMap) {
	//Adds a contact to the map
	std::string fName, lName, pNum, email, fullName;
	std::cout << "first name: ";
	std::cin >> fName;
	std::cout << "last name: ";
	std::cin >> lName;
	std::cout << "phone number: ";
	std::cin >> pNum;
	std::cout << "e-mail: ";
	std::cin >> email;
	fullName = fName + " " + lName;
	Contact newC(fName,lName,pNum,email);
	cMap[fullName] = newC;

}

void handleRemove(std::map <std::string, Contact> &cMap) {
	std::string fName, lName, fullName;
	std::cout << "first name: ";
	std::cin >> fName;
	std::cout << "last name: ";
	std::cin >> lName;
	fullName = fName + " " + lName;
	std::map <std::string, Contact>::iterator idx;
	idx = cMap.find(fullName);
	if (idx == cMap.end()) {
		std::cout << "contact not found\n";
	}
	else {
		cMap.erase(idx);
		std::cout << "removed " << fullName << "\n";
	}

}
void handleList(std::map <std::string, Contact> &cMap) {
	Contact currentC;
	int counter = 0;
	if (cMap.size() == 0) {
		std::cout << "no contacts\n";
	}
	else {
		for (std::map <std::string, Contact>::iterator idx = cMap.begin(); idx != cMap.end();++idx, counter = counter + 1) {
			currentC = idx->second;
			std::cout << currentC.getFName() << ", " << currentC.getLName();
			if (counter < cMap.size()) {
				std::cout << "\n";
			}
		}

	}

}
void handleFind(std::map <std::string, Contact> &cMap) {
	//

	std::string searchKey,fName,lName;
	std::cout << "first name: ";
	std::cin >> fName;
	std::cout << "last name: ";
	std::cin >> lName;
	searchKey = fName + " " + lName;
	
	std::map <std::string, Contact>::iterator idx = cMap.find(searchKey);
	if (idx == cMap.end()) {
		std::cout << "contact not found\n";
	}
	else {
		Contact currentC = idx->second;
		std::cout << "Name: " << currentC.getFName() << " " << currentC.getLName() << "\n" << "Phone Number: " << currentC.getPhone() << "\n" << "E-mail: " << currentC.getEmail() << "\n";
	}


}
