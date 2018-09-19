//Assignment 1, problem 3 dealing with boss health overflow
//Arhiteture from problem 1 used as a base for this problem
//Author: Jake Bergquist


//Included needed libraries
#include <iostream>


//Initilize the counter for how many cases we have gone through so far
short caseCounter = 0;
//Initilize the string that will carry the input
short inDamage;
//Initilize the carrier for the first line max cases
short maxCases;
//Initilize other vairables
struct bossInfo {
	bool overHeal;
	bool dead;
	short NUMBER;
};
bossInfo handleBossDamage(short damage);

//main function body
int main() {


	//Grab the first line which should be a number that tells us max cases
	std::cin >> maxCases;

	//For each case
	for (;caseCounter < maxCases; caseCounter = caseCounter + 1) {
		
		if(!(std::cin >> inDamage))//Get the next input. If there is no next input send an error message and return 1
		{
			std::cout << "Error: " << maxCases << " cases expected, but only " << caseCounter << " cases given!\nStopping execution.";
			return 1;//Unsucessful execution
		}
		else {//If we got an input continue on

			bossInfo damageDone = handleBossDamage(inDamage);//Handle the boss damage

			std::cout << "Case " << caseCounter << ":\n";//Print the case
			if (damageDone.overHeal) {//If we tried to overflow the heal notiofy the user
				std::cout << "no healing the boss to kill it!\n";
			}
			std::cout << "boss health is " << damageDone.NUMBER;//Then give the health prinout
			if (damageDone.dead) {//If we actually killed the boss then get onto a new line and say so
				std::cout << "\nthe boss is dead!";
			}

			if (caseCounter + 1 < maxCases) {//Handle the end of the cases newline such that the last case does not have an excess new line
				std::cout << "\n";
			}
		}
	}
	return 0; //Successful execution
}

bossInfo handleBossDamage(short damage) {
	//Handles the damage done to the boss to prevent overflow and prevent health from going negative
	//Returns a struct containing booleans for overHeal, dead, and NUMBER (which is the
	bool overHeal = false;//Start by resetting these for each case
	bool bossDead = false;
	short NUMBER; //cuurrent boss health.
	const short bossStartingH = 32000;
	const short maxBossH = 32767;//Maximum short value
	const short minBossH = 0;
	const short overHealThresh = 767;//Any more healing that this would be an overflow
	if (inDamage > overHealThresh) {//If it is over the overhealing threshold then we set health to max to avoid overflow
		overHeal = true;//Ans notify that there has been an overheal attempt
		NUMBER = maxBossH;
	}
	else if (-inDamage >= bossStartingH) {//If the damage is enough to KO the boss
		bossDead = true;//Mark the boss death
		NUMBER = minBossH;//Set the boss health to min
	}
	else {//Otherwise the damage is within the region where we need to calculate it
		NUMBER = bossStartingH + inDamage;
	}
	return {overHeal,bossDead,NUMBER};
}