//Assignment 1, problem 1 Reading in standard input and echoing that input back to the consol
//
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

//Initilize stuff
class Matrix {
#include <iostream>
public:
	int c;//cols
	int r;//rows
	double *x;
	

	Matrix() {
		c = 0;
		r = 0;
		x = new double[0];
	}
	Matrix(int m, int n) {
		c = n;
		r = m;
		x = new double[c*r];
	}

	Matrix(const Matrix &assignX) {
		c = assignX.c;
		r = assignX.r;
		x = new double[c*r];
		for (int ind = 0;ind < r*c;ind = ind + 1) {
			x[ind] = assignX.x[ind];
		}
	}

	~Matrix() {
		delete[] x; 
	}
	Matrix operator=(const Matrix &assignX) {
		c = assignX.c;
		r = assignX.r;
		x = new double[c*r];
		for (int ind = 0;ind < r*c;ind = ind + 1) {
			x[ind] = assignX.x[ind];
		}
	}

	double operator[](int idx) {
		return this->x[idx];
	}
	double operator()(int rIdx, int cIdx) {
		return (*this)[(rIdx*this->r) + cIdx];
	}

};

Matrix operator+(Matrix m1, Matrix m2) {
	Matrix ans(m1.r, m1.c);
	for (int ansIdx = 0;ansIdx < m1.r *m1.c;ansIdx = ansIdx + 1) {
		ans.x[ansIdx] = m1[ansIdx] + m2[ansIdx];

	}
	return ans;
}

Matrix operator*(Matrix m1,Matrix m2) {
	Matrix ans(m1.r, m2.c);
	double multAns = 0;
	int ansIdx = 0;
	for (int rIdx = 0;rIdx < m1.r;rIdx = rIdx + 1) {
		for (int m2Col = 0;m2Col < m2.c;m2Col = m2Col + 1) {
			multAns = 0;
			for (int cIdx = 0;cIdx < m1.c;cIdx = cIdx + 1) {
				multAns = multAns + (m1.x[rIdx*m1.c + cIdx] * m2.x[cIdx*m2.c + m2Col]);
			}
			ans.x[ansIdx] = multAns;
			ansIdx = ansIdx + 1;
		}
	}
	return ans;
}

std::ostream& operator<<(std::ostream& os, const Matrix& m) {
	for (int rIdx = 0;rIdx < m.r;rIdx = rIdx + 1) {
		for (int cIdx = 0;cIdx < m.c;cIdx = cIdx + 1) {
			os << m.x[(rIdx*m.c) + cIdx];
			if (cIdx + 1 < m.c) {
				os << " ";
			}
		}
		if (rIdx + 1 < m.r) {
			os << "\n";
		}
	}
	return os;
}

std::istream& operator>> (std::istream& is, Matrix& m) {
	for (int xInd = 0;xInd < m.r*m.c;xInd = xInd + 1) {
		is >> m.x[xInd];
	}
	return is;
}

void handleAdd();
void handleMultiply();

//main function body
int main() {
	std::uint64_t maxCases = 0;

	//Grab the first line which should be a number that tells us max cases
	std::cin >> maxCases;
	std::string command;
	//For each case
	for (std::uint64_t caseCounter = 0;caseCounter < maxCases; caseCounter = caseCounter+1) {
		const std::string keys[2] = { "add","multiply"};
		std::cout << "Case " << caseCounter << ":\n";//Print the case
		std::cin >> command;
		if (command.compare(keys[0]) == 0) {
			handleAdd();
		}
		else if (command.compare(keys[1]) == 0) {
			handleMultiply();
		}

		if (caseCounter + 1 < maxCases) {
			std::cout << "\n";//For printing the newline we only want to do so for all but the last time
			//This way we do not end up with an extra space at the end
		}
		
	}
	return 0; //Successful execution
}


void handleAdd() {
	int m1;
	int n1;
	int m2;
	int n2;

	std::cin >> m1;
	std::cin >> n1;

	Matrix mat1(m1, n1);
	std::cin >> mat1;
	
	std::cin >> m2;
	std::cin >> n2;

	Matrix mat2(m2, n2);
	std::cin >> mat2;

	Matrix ans = (mat1 + mat2);


	std::cout << ans;
}

void handleMultiply() {
	int m1;
	int n1;
	int m2;
	int n2;

	std::cin >> m1;
	std::cin >> n1;

	Matrix mat1(m1, n1);
	std::cin >> mat1;

	std::cin >> m2;
	std::cin >> n2;

	Matrix mat2(m2, n2);
	std::cin >> mat2;

	Matrix ans = (mat1 * mat2);

	std::cout << ans;
}