//Assignment 5, problem 2 
//
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>


class Rational{
private:
	int num;
	int denom;
public:
	Rational() {
		num = 0;
		denom = 1;
	}
	Rational(int n, int d) {
		num = n;
		denom = d;
		normalize();
	}
	Rational(int n) {
		num = n;
		denom = 1;
	}
	int get_numerator() const {
		return this->num;
	}
	int get_denominator() const {
		return this->denom;
	}
	void normalize() {
		
		if (this->denom == 0) {
			throw("Denominator cannot be 0!");
		}

		int divis = 1;
		divis = gcd(this->num, this->denom);
		this->num = this->num / divis;
		this->denom = this->denom / divis;
		if (this->denom < 0) {
			this->denom = this->denom *-1;
			this->num = this->num * -1;
		}

	}

	int gcd(int num1, int num2) {
		if (num2 == 0) { 
			return std::abs(num1);
		}
		if (std::abs(num2) > std::abs(num1)) {
			return gcd(num2, num1);
		}
		return gcd(num2, num1 % num2);
	}

	double toDecimal() const {
		return (double)this->num / (double)this->denom;

	}

	Rational operator+(Rational rhs) {//Defining within class because the access the private members of the class
		int newDenom = (rhs.denom * this->denom);
		int newNum = (rhs.num * this->denom) + (rhs.denom * this->num);
		Rational ans(newNum, newDenom);
		return ans;
	}
	Rational operator-(Rational rhs) {
		int newDenom = (rhs.denom * this->denom);
		int newNum = (rhs.denom * this->num)-(rhs.num * this->denom);
		Rational ans(newNum, newDenom);
		return ans;
	}
	Rational operator*(Rational rhs) {
		int newDenom = (rhs.denom * this->denom);
		int newNum = rhs.num * this->num;
		Rational ans(newNum, newDenom);
		return ans;
	}
	Rational operator/(Rational rhs) {
		int newDenom = (rhs.num * this->denom);
		int newNum = rhs.denom * this->num;
		Rational ans(newNum, newDenom);
		return ans;
	}
	bool operator==(Rational rhs) {
		if (rhs.denom == this->denom && rhs.num == this->num) {
			return true;
		}
		else {
			return false;
		}
	}
	bool operator<(Rational rhs) {
		if (this->toDecimal() < rhs.toDecimal()) {
			return true;
		}
		else {
			return false;
		}
	}
	friend std::ostream& operator<<(std::ostream& output, Rational a) {
		output << a.num << "/" << a.denom;
		return output;
	}

	
};


//main function body
int main() {
	std::uint64_t maxCases = 0;

	//Grab the first line which should be a number that tells us max cases
	std::cin >> maxCases;
	//For each case
	for (std::uint64_t caseCounter = 0;caseCounter < maxCases; caseCounter = caseCounter + 1) {
		
		std::cout << "Case " << caseCounter << ":\n";//Print the case
		int n1, d1, n2, d2;
		std::cin >> n1;
		std::cin >> d1;
		std::cin >> n2;
		std::cin >> d2;
		Rational r1(n1, d1);
		Rational r2(n2, d2);
		std::string lessThan = "false";
		if (r1 < r2) {
			lessThan = "true";
		}
		std::cout << r1 + r2 << " " << r1 - r2 << " " << r1 * r2 << " " << r1 / r2<<" " << lessThan << "\n" << r1.toDecimal() << " " << r2.toDecimal();


		if (caseCounter + 1 < maxCases) {
			std::cout << "\n";//For printing the newline we only want to do so for all but the last time
			//This way we do not end up with an extra space at the end
		}

	}
	return 0; //Successful execution
}