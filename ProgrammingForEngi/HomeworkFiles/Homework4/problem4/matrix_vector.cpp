//Assignment 4, problem 1 Cipher
//Architecture built off of HW1 P1 and other probelms
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>
#include <string>

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


//main function body
int main() {
	std::int64_t maxCases = 0;
	std::cin >> maxCases;


	for (std::int64_t caseCounter = 0;caseCounter < maxCases; caseCounter = caseCounter + 1) {




		std::cout << "Case " << caseCounter << ":\n";//Print the case

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

