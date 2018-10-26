//Assignment 4, problem 1 Cipher
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>
#include <math.h>

//Initilize things
struct Vec3 {
	double x;
	double y;
	double z;
	double v[3] = { x,y,z };
};
struct Mat3 {
	double m [9];
};

//Functions
Vec3 read_vec();
Mat3 read_mat();
void print(Vec3 v);
void print(Mat3 m);
Vec3 add(Vec3 u, Vec3 v);
double dot(Vec3 u, Vec3 v);
double length(Vec3 u);
Mat3 transpose(Mat3 m);
Vec3 row(Mat3 m, int i);
Vec3 col(Mat3 m, int i);
Vec3 multiply(Mat3 m, Vec3 u);
Mat3 multiply(Mat3 m1, Mat3 m2);
//These functions are called to handle getting proper input, performing the operation, and handling the output
void handleAdd();
void handleDot();
void handleMultiply();
void handleLength();
void handleTrans();
void handleRow();
void handleCol();



//main function body
int main() {
	std::int64_t maxCases = 0;
	std::cin >> maxCases;
	std::string command;
	std::string key;
	const std::string keys[7] = { "add","dot","length","multiply","transpose","row","col" };
	for (std::int64_t caseCounter = 0;caseCounter < maxCases; caseCounter = caseCounter + 1) {
		
		std::cout << "Case " << caseCounter << ":\n";//Print the case

		std::cin >> command;

		if (command.compare(keys[0])==0) {
			handleAdd();
		}
		else if (command.compare(keys[1])==0) {
			handleDot();
		}
		else if (command.compare(keys[2])==0) {
			handleLength();
		}
		else if (command.compare(keys[3])==0) {
			handleMultiply();
		}
		else if (command.compare(keys[4])==0) {
			handleTrans();
		}
		else if (command.compare(keys[5])==0) {
			handleRow();
		}
		else if (command.compare(keys[6])==0) {
			handleCol();
		}
		else {
			std::cout << "Error: Improper operation type: " << command << "\nExiting!\n";
			return 1;
		}




		if (caseCounter + 1 < maxCases) {
			std::cout << "\n";//For printing the newline we only want to do so for all but the last time
			//This way we do not end up with an extra space at the end
		}
	}
	return 0; //Successful execution
}


Vec3 read_vec() {
	//reads three inputs and assigns them to the values in vect
	Vec3 v;
	std::cin >> v.x;
	std::cin >> v.y;
	std::cin >> v.z;

	return v;

}

Mat3 read_mat() {
	//reads nine inputs and puts them into the Mat3

	Mat3 m;
	for (int idx = 0;idx < 9;idx = idx + 1) {
		std::cin >> m.m[idx];
	}

	return m;
}

void print(Vec3 v) {
	//Prints the vecor
	std::cout << "( " << v.x << ", " << v.y << ", " << v.z << " )";

}
void print(Mat3 m) {
	//prints the matrix
	std::cout << "[ ";
	for (std::uint8_t idx = 0;idx <= 7;idx = idx + 1) {
		std::cout << m.m[idx] << ", ";

	}
	std::cout << m.m[8] << " ]";
}
Vec3 add(Vec3 u, Vec3 v) {
	//Compute vector addition
	Vec3 result;
	result.x = u.x + v.x;
	result.y = u.y + v.y;
	result.z = u.z + v.z;
	return result;
}
double dot(Vec3 u, Vec3 v) {
	//Compute dot product
	return (u.x*v.x) + (u.y*v.y) + (u.z*v.z);

}
double length(Vec3 u) {

	return std::sqrt(pow(u.x,2)+pow(u.y,2)+pow(u.z,2));
}
Mat3 transpose(Mat3 m) {
	Mat3 mT;
	mT.m[0] = m.m[0];
	mT.m[1] = m.m[3];
	mT.m[2] = m.m[6];
	mT.m[3] = m.m[1];
	mT.m[4] = m.m[4];
	mT.m[5] = m.m[7];
	mT.m[6] = m.m[2];
	mT.m[7] = m.m[5];
	mT.m[8] = m.m[8];
	return mT;
}
Vec3 row(Mat3 m, int i) {
	Vec3 r = { m.m[(i * 3)],m.m[(i * 3) + 1],m.m[(i * 3) + 2] };
	return r;
}
Vec3 col(Mat3 m, int i) {
	Vec3 c = { m.m[i],m.m[i + 3],m.m[i + 6] };
	return c;
}
Vec3 multiply(Mat3 m, Vec3 u) {
	Vec3 result;
	result.x = (m.m[0] * u.x) + (m.m[1] * u.y) + (m.m[2] * u.z);
	result.y = (m.m[3] * u.x) + (m.m[4] * u.y) + (m.m[5] * u.z);
	result.z = (m.m[6] * u.x) + (m.m[7] * u.y) + (m.m[8] * u.z);
	return result;
}
Mat3 multiply(Mat3 m1, Mat3 m2) {
	Mat3 result;
	result.m[0] = (m1.m[0] * m2.m[0]) + (m1.m[1] * m2.m[3]) + (m1.m[2] * m2.m[6]);
	result.m[1] = (m1.m[0] * m2.m[1]) + (m1.m[1] * m2.m[4]) + (m1.m[2] * m2.m[7]);
	result.m[2] = (m1.m[0] * m2.m[2]) + (m1.m[1] * m2.m[5]) + (m1.m[2] * m2.m[8]);

	result.m[3] = (m1.m[3] * m2.m[0]) + (m1.m[4] * m2.m[3]) + (m1.m[5] * m2.m[6]);
	result.m[4] = (m1.m[3] * m2.m[1]) + (m1.m[4] * m2.m[4]) + (m1.m[5] * m2.m[7]);
	result.m[5] = (m1.m[3] * m2.m[2]) + (m1.m[4] * m2.m[5]) + (m1.m[5] * m2.m[8]);

	result.m[6] = (m1.m[6] * m2.m[0]) + (m1.m[7] * m2.m[3]) + (m1.m[8] * m2.m[6]);
	result.m[7] = (m1.m[6] * m2.m[1]) + (m1.m[7] * m2.m[4]) + (m1.m[8] * m2.m[7]);
	result.m[8] = (m1.m[6] * m2.m[2]) + (m1.m[7] * m2.m[5]) + (m1.m[8] * m2.m[8]);

	return result;
}


void handleAdd() {
	//
	std::string key;
	Vec3 v1;
	Vec3 v2;
	Vec3 sum;
	std::cin >> key;
	if ((key.compare("V")!=0)) {
		throw("Vector not given when vector was expected!\n");
	}
	v1 = read_vec();
	std::cin >> key;
	if ((key.compare("V")!=0)) {
		throw("Vector not given when vector was expected!\n");
	}
	v2 = read_vec();

	sum = add(v1, v2);
	print(sum);

}
void handleDot() {
	std::string key;
	Vec3 v1;
	Vec3 v2;
	double dVec;
	std::cin >> key;
	if ((key.compare("V")!=0)) {
		throw("Vector not given when vector was expected!\n");
	}
	v1 = read_vec();
	std::cin >> key;
	if ((key.compare("V")!=0)) {
		throw("Vector not given when vector was expected!\n");
	}
	v2 = read_vec();

	dVec = dot(v1, v2);
	std::cout << dVec;
}
void handleMultiply() {
	std::string key;
	Mat3 m1 = { 0,0,0,0,0,0,0,0,0 };
	Mat3 m2 = { 0,0,0,0,0,0,0,0,0 };
	Vec3 v1;
	Vec3 v2;
	bool matFor1 = false;
	bool matFor2 = false;
	std::cin >> key;
	if (key.compare("V")==0) {
		v1 = read_vec();
		
	}
	else if (key.compare("M")==0) {
		m1 = read_mat();
		matFor1 = true;
	}
	else {
		throw("Vector or Matrix not given when expected!\n");
	}

	std::cin >> key;
	if (key.compare("V")==0) {
		v2 = read_vec();
	}
	else if (key.compare("M")==0) {
		m2 = read_mat();
		matFor2 = true;
	}
	else {
		throw("Vector or Matrix not given when expected!\n");
	}

	if (matFor1 && matFor2) {
		//If matrix x matrix
		Mat3 mResult = multiply(m1, m2);
		print(mResult);

	}
	else if (matFor1 && !matFor2) {
		//if matrix x vector
		Vec3 vResult = multiply(m1, v2);
		print(vResult);
	}
	else {
		throw("Must either give M x M, or M x V");
	}

}
void handleLength() {
	std::string key;
	std::cin >> key;
	if (key.compare("V")!=0) {
		throw("Vector not given when vector was expected!\n");
	}
	Vec3 v = read_vec();
	std::cout << length(v);

}
void handleTrans() {
	std::string key;
	std::cin >> key;
	if (key.compare("M")!=0) {
		throw("Matrix not given when matrix was expected!\n");
	}
	Mat3 Matrix = read_mat();
	Mat3 tMatrix = transpose(Matrix);
	print(tMatrix);

}
void handleRow() {
	std::string key;
	std::cin >> key;
	if (key.compare("M")!=0) {
		throw("Matrix not given when matrix was expected!\n");
	}
	Mat3 Matrix = read_mat();
	int rowIdx;
	std::cin >> rowIdx;
	Vec3 r = row(Matrix, rowIdx);
	print(r);


}
void handleCol() {
	std::string key;
	std::cin >> key;
	if (key.compare("M")!=0) {
		throw("Matrix not given when matrix was expected!\n");
	}
	Mat3 Matrix = read_mat();
	int colIdx;
	std::cin >> colIdx;
	Vec3 c = col(Matrix, colIdx);
	print(c);
}
