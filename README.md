LC-3 Score Calculator - CIS-11

Hello!
This is a program that features a score calculator.
It is a console-based program coded in Assembly LC-3.
The program takes 5 user inputs which are test scores and would then calculate
and output the letter grades of each of the scores and display the minimum, maximum, and average of the scores

________________________________________________________________________________________________________________________________________________________________________________


How it runs:
Scores are calculated in this set:
90-99: A

80-89: B

70-79: C

60-69: D

0-59: F

Minimum/Maximum Calculation: Iterates through the stored scores to find the minimum and maximum values.

Average Calculation: Computes the integer average of the five scores.

________________________________________________________________________________________________________________________________________________________________________________

How to Assemble and Run:

To run this program, you will need an LC-3 Editor and Simulator (such as LC3Tools or PennSim).

Load the Code: Open your LC-3 Editor and load the .asm file.

Assemble: Use the simulator's "Assemble" command to convert the assembly code into machine code. This will generate a .asm file.

Run: Execute the program through using the simulator and loading the .obj file created by the editor. The simulator's console will display the prompt: Please enter 5 scores (each between 0 and 99):.

Enter Scores: Type a two-digit score (e.g., 87) and press Enter. The program will echo the score and display its letter grade. Repeat this for all five scores.

View Results: After the fifth score is entered, the program will display the calculated minimum, maximum, and average scores before halting.
