LC-3 Score Calculator - CIS-11
1. Project Description
This is an LC-3 assembly language program designed to perform statistical analysis on a set of five student scores. The program prompts the user to enter five two-digit scores (ranging from 00 to 99). For each score entered, it immediately calculates and displays the corresponding letter grade.

After all five scores are collected, the program calculates and displays the minimum, maximum, and average values of the set.

2. Features
User Input: Accepts five two-digit numeric scores from the console.

Input Validation: Checks that all characters entered are numeric digits ('0'-'9').

Letter Grade Calculation: Instantly determines and displays the letter grade for each score:

90-99: A

80-89: B

70-79: C

60-69: D

0-59: F

Minimum/Maximum Calculation: Iterates through the stored scores to find the minimum and maximum values.

Average Calculation: Computes the integer average of the five scores.

Modular Design: Uses multiple subroutines for tasks like getting input, displaying numbers, and stack operations.

Stack Management: Utilizes the stack to pass the calculated letter grade from the grading subroutine to a printing routine.

Pointer-Based Array Access: Uses a base register as a pointer to access and store scores in an array.

3. How to Assemble and Run
To run this program, you will need an LC-3 simulator (such as LC3Tools or PennSim).

Load the Code: Open your LC-3 simulator and load the .asm file.

Assemble: Use the simulator's "Assemble" command to convert the assembly code into machine code. This will generate a .obj file.

Run: Execute the program from the starting address (x3000). The simulator's console will display the prompt: Please enter 5 scores (each between 0 and 99):.

Enter Scores: Type a two-digit score (e.g., 87) and press Enter. The program will echo the score and display its letter grade. Repeat this for all five scores.

View Results: After the fifth score is entered, the program will display the calculated minimum, maximum, and average scores before halting.

4. Program Structure and Subroutines
The program is divided into a main execution block and several key subroutines:

START_MAIN: The main logic block. It calls subroutines to get the five scores and then executes the code to find and display the min, max, and average.

GET_NUMERIC_INPUT_RTN: Handles reading a two-digit number from the user, validating it, and converting it from ASCII characters to a single binary value.

DETERMINE_LETTER_GRADE_RTN: Takes a score in R3 and determines the corresponding letter grade. It then pushes the ASCII value of the letter onto the stack.

DISPLAY_NUMBER_RTN: Converts a two-digit binary number into two separate ASCII characters and prints them to the console.

STACK_PUSH_OP_RTN / STACK_POP_OP_RTN: Standard subroutines to push a value onto the stack and pop a value off the stack.

VALIDATE_CHAR_INPUT_RTN: A helper routine that checks if a character input is a valid digit between '0' and '9'. If not, it displays an error and restarts the program.

WIPE_GP_REGISTERS_RTN: A utility subroutine to clear general-purpose registers, ensuring a clean state for other subroutines.
