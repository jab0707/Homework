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
		delete &c;
		delete &r;
	}
	Matrix operator=(const Matrix &assignX) {
		c = assignX.c;
		r = assignX.r;
		x = new double[c*r];
		for (int ind = 0;ind < r*c;ind = ind + 1) {
			x[ind] = assignX.x[ind];
		}
	}
	Matrix operator*(Matrix m2) {
		Matrix ans(this->r,m2.c);
		double multAns = 0;
		int ansIdx = 0;
		for (int rIdx = 0;rIdx < this->r;rIdx = rIdx + 1) {
			for (int m2Col = 0;m2Col < m2.c;m2Col = m2Col + 1) {
				multAns = 0;
				for (int cIdx = 0;cIdx < this->c;cIdx = cIdx + 1) {
					multAns = multAns + (this->x[rIdx*this->c + cIdx] * m2.x[cIdx*m2.c + m2Col]);
				}
				ans.x[ansIdx] = multAns;
				ansIdx = ansIdx + 1;
			}
		}
		return ans;
	}

	Matrix operator+(Matrix m2) {
		Matrix ans(this->r, this->c);
		for (int ansIdx = 0;ansIdx < this->r *this->c;ansIdx = ansIdx + 1) {
			ans.x[ansIdx] = this->x[ansIdx] + m2.x[ansIdx];

		}
		return ans;
	}

	double operator[](int idx) {
		return this->x[idx];
	}
	double operator()(int rIdx, int cIdx) {
		return this->x[(rIdx*this->r) + cIdx];
	}
	friend std::ostream& operator<<(std::ostream& os, const Matrix& m){
		for (int rIdx = 0;rIdx < m.r;rIdx = rIdx + 1) {
			for (int cIdx = 0;cIdx < m.c;cIdx = cIdx + 1) {
				os << m.x[(rIdx*m.c) + cIdx];
				if (cIdx + 1 < m.c) {
					os << " "
				}
			}
			if (rIdx + 1 > m.r) {
				os << "\n";
			}
		}
		return os;
	}
	friend std::istream& operator>> (std::istream& is, Matrix& m) {
		for (xInd = 0;xInd < m.r*m.c;xInd = xInd + 1) {
			is >> m.x[xInd];
		}
		return is; 
	}
};


//main function body
int main() {
	std::uint64_t maxCases = 0;

	//Grab the first line which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (std::uint64_t caseCounter = 0;caseCounter < maxCases; caseCounter = caseCounter+1) {
		
		std::cout << "Case " << caseCounter << ":\n";//Print the case
		
		if (caseCounter + 1 < maxCases) {
			std::cout << "\n";//For printing the newline we only want to do so for all but the last time
			//This way we do not end up with an extra space at the end
		}
	}
	return 0; //Successful execution
}