; CIS11 - 23651
; Hugo Ngo and Sadia Plimley
; Final Project - Test Score Calculator
; Description:
;  LC-3 Program that takes user input which are their test scores as numbers
;  Then outputs the letter grades that corresponds their scores
;  And outputs the maximum, minimum, and average of those scores
; Inputs: 5 Test Scores from the user
; Outputs: Letter Grades that represent the test scores
;          Maximum, minimum, and average of those scores
; Side Effects: None
; Run:  Assemble the program
;	Open the Simullate Software
;	Load the Assembled program(.obj file)
;	Run the code and see the output on the console

.ORIG x3000                     ; Set program starting address to x3000

START_MAIN

    LEA R0, INPUT_PROMPT_MSG    ; Load address of input prompt message into R0
    PUTS                        ; Print the input prompt message
    INPUT_PROMPT_MSG .STRINGZ "Please enter 5 scores (each between 0 and 99):"

    LD R0, NEWLINE_CONST_VAL    ; Load newline character into R0
    OUT                         ; Output newline

    JSR GET_NUMERIC_INPUT_RTN   ; Call subroutine to get first numeric input from user
    LEA R6, SCORE_DATA_ARRAY    ; Load address of score array into R6
    STR R3, R6, #0              ; Store input score in first array slot
    JSR DETERMINE_LETTER_GRADE_RTN ; Call subroutine to determine letter grade for score
    JSR STACK_POP_OP_RTN        ; Pop and display letter grade from stack

    LD R0, NEWLINE_CONST_VAL    ; Load newline character
    OUT                         ; Output newline

    JSR GET_NUMERIC_INPUT_RTN   ; Get second numeric input
    LEA R6, SCORE_DATA_ARRAY    ; Load address of score array
    STR R3, R6, #1              ; Store in second slot
    JSR DETERMINE_LETTER_GRADE_RTN ; Determine letter grade
    JSR STACK_POP_OP_RTN        ; Pop and display letter grade

    LD R0, NEWLINE_CONST_VAL    ; Output newline
    OUT

    JSR GET_NUMERIC_INPUT_RTN   ; Get third numeric input
    LEA R6, SCORE_DATA_ARRAY    ; Load address of score array
    STR R3, R6, #2              ; Store in third slot
    JSR DETERMINE_LETTER_GRADE_RTN ; Determine letter grade
    JSR STACK_POP_OP_RTN        ; Pop and display letter grade

    LD R0, NEWLINE_CONST_VAL    ; Output newline
    OUT

    JSR GET_NUMERIC_INPUT_RTN   ; Get fourth numeric input
    LEA R6, SCORE_DATA_ARRAY    ; Load address of score array
    STR R3, R6, #3              ; Store in fourth slot
    JSR DETERMINE_LETTER_GRADE_RTN ; Determine letter grade
    JSR STACK_POP_OP_RTN        ; Pop and display letter grade

    LD R0, NEWLINE_CONST_VAL    ; Output newline
    OUT

    JSR GET_NUMERIC_INPUT_RTN   ; Get fifth numeric input
    LEA R6, SCORE_DATA_ARRAY    ; Load address of score array
    STR R3, R6, #4              ; Store in fifth slot
    JSR DETERMINE_LETTER_GRADE_RTN ; Determine letter grade
    JSR STACK_POP_OP_RTN        ; Pop and display letter grade

    LD R0, NEWLINE_CONST_VAL    ; Output newline
    OUT

;--- CALCULATE AND DISPLAY MINIMUM SCORE ---;
FIND_MINIMUM_SCORE
    LD R1, TOTAL_SCORES_VAL     ; Load total number of scores (5)
    LEA R2, SCORE_DATA_ARRAY    ; Load address of score array
    LD R4, SCORE_DATA_ARRAY     ; Load first score as initial min
    ST R4, MIN_SCORE_RESULT     ; Store as initial min
    ADD R2, R2, #1              ; Move to next score
    ADD R1, R1, #-1             ; Decrement score count

MIN_CHECK_LOOP
    LDR R5, R2, #0              ; Load next score
    NOT R4, R4                  ; Bitwise NOT of R4
    ADD R4, R4, #1              ; Two's complement: R4 = -R4
    ADD R5, R5, R4              ; R5 = R5 - R4
    BRn UPDATE_MIN_AND_CONTINUE ; If R5 < R4, update min

    ADD R2, R2, #1              ; Move to next score
    LD R4, SCORE_DATA_ARRAY     ; Reload first score (reset min)
    AND R5, R5, #0              ; Clear R5
    ADD R1, R1, #-1             ; Decrement score count
    BRp MIN_CHECK_LOOP          ; Loop if more scores

    LEA R0, MIN_OUTPUT_LABEL    ; Load min label
    PUTS                        ; Print min label
    LD R3, MIN_SCORE_RESULT     ; Load min score
    AND R1, R1, #0              ; Clear R1
    JSR DISPLAY_NUMBER_RTN      ; Display min score
    LD R0, SPACE_CONST_VAL      ; Load space character
    OUT                         ; Output space

    JSR WIPE_GP_REGISTERS_RTN   ; Clear registers
    LD R0, NEWLINE_CONST_VAL    ; Load newline character
    OUT                         ; Output newline

;--- CALCULATE AND DISPLAY MAXIMUM SCORE ---;
FIND_MAXIMUM_SCORE
    LD R1, TOTAL_SCORES_VAL     ; Load total number of scores (5) into R1
    LEA R2, SCORE_DATA_ARRAY    ; Load address of score array into R2
    LD R4, SCORE_DATA_ARRAY     ; Load first score into R4
    ST R4, MAX_SCORE_RESULT     ; Store as initial max
    ADD R2, R2, #1              ; Move to next score

MAX_CHECK_LOOP
    LDR R5, R2, #0              ; Load next score into R5
    NOT R4, R4                  ; Take bitwise NOT of R4 (for subtraction)
    ADD R4, R4, #1              ; Two's complement: R4 = -R4
    ADD R5, R5, R4              ; R5 = R5 - R4 (compare current score to max)
    BRp UPDATE_MAX_AND_CONTINUE ; If R5 > R4, update max
    LEA R0, MAX_OUTPUT_LABEL    ; Load max label
    PUTS                        ; Print max label
    LD R3, MAX_SCORE_RESULT     ; Load max score
    AND R1, R1, #0              ; Clear R1
    JSR DISPLAY_NUMBER_RTN      ; Display max score
    LD R0, SPACE_CONST_VAL      ; Load space character
    OUT                         ; Output space

    LD R0, NEWLINE_CONST_VAL    ; Load newline character
    OUT                         ; Output newline
    JSR WIPE_GP_REGISTERS_RTN   ; Clear registers

;--- CALCULATE AND DISPLAY AVERAGE SCORE ---;
CALCULATE_AVERAGE_SCORE
    LD R1, TOTAL_SCORES_VAL     ; Load total number of scores (5)
    LEA R2, SCORE_DATA_ARRAY    ; Load address of score array
    AND R3, R3, #0              ; Clear sum register

SUM_ALL_SCORES_LOOP
    LDR R4, R2, #0              ; Load score
    ADD R3, R3, R4              ; Add to sum
    ADD R2, R2, #1              ; Next score
    ADD R1, R1, #-1             ; Decrement counter
    BRp SUM_ALL_SCORES_LOOP     ; Loop if more scores

    LD R1, TOTAL_SCORES_VAL     ; Reload total number of scores
    NOT R1, R1                  ; Bitwise NOT for division
    ADD R1, R1, #1              ; R1 = -TOTAL_SCORES_VAL
    ADD R4, R3, #0              ; Copy sum to R4
    AND R6, R6, #0              ; Clear quotient

AVERAGE_DIVISION_LOOP
    ADD R4, R4, #0              ; Check if sum is zero or negative
    BRnz AVERAGE_CALCULATION_ENDED ; If R4 <= 0, done dividing
    ADD R6, R6, #1              ; Increment quotient
    ADD R4, R4, R1              ; Subtract total scores from sum
    BRp AVERAGE_DIVISION_LOOP   ; Loop if sum still positive

AVERAGE_CALCULATION_ENDED
    ST R6, FINAL_AVERAGE_SCORE  ; Store average
    LEA R0, AVG_OUTPUT_LABEL    ; Load average label
    PUTS                        ; Print average label
    AND R3, R3, #0              ; Clear R3
    AND R1, R1, #0              ; Clear R1
    AND R4, R4, #0              ; Clear R4
    ADD R3, R3, R6              ; Prepare average for display
    JSR DISPLAY_NUMBER_RTN      ; Display average
    HALT                        ; End program
    
;--- GET LETTER GRADE SUBROUTINE -;
DETERMINE_LETTER_GRADE_RTN
    AND R2, R2, #0                   ; Clear R2

CHECK_FOR_A
    LD R0, GRADE_A_MIN_NEG           ; Load minimum score for A (negative)
    LD R1, ASCII_CHAR_A              ; Load ASCII for 'A'
    ADD R2, R3, R0                   ; Compare score to A minimum
    BRzp STORE_LETTER_AND_PUSH_RTN   ; If score >= 90, assign 'A'

CHECK_FOR_B
    AND R2, R2, #0                   ; Clear R2
    LD R0, GRADE_B_MIN_NEG           ; Load minimum score for B (negative)
    LD R1, ASCII_CHAR_B              ; Load ASCII for 'B'
    ADD R2, R3, R0                   ; Compare score to B minimum
    BRzp STORE_LETTER_AND_PUSH_RTN   ; If score >= 80, assign 'B'

CHECK_FOR_C
    AND R2, R2, #0                   ; Clear R2
    LD R0, GRADE_C_MIN_NEG           ; Load minimum score for C (negative)
    LD R1, ASCII_CHAR_C              ; Load ASCII for 'C'
    ADD R2, R3, R0                   ; Compare score to C minimum
    BRzp STORE_LETTER_AND_PUSH_RTN   ; If score >= 70, assign 'C'

CHECK_FOR_D
    AND R2, R2, #0                   ; Clear R2
    LD R0, GRADE_D_MIN_NEG           ; Load minimum score for D (negative)
    LD R1, ASCII_CHAR_D              ; Load ASCII for 'D'
    ADD R2, R3, R0                   ; Compare score to D minimum
    BRzp STORE_LETTER_AND_PUSH_RTN   ; If score >= 60, assign 'D'

ASSIGN_F_GRADE_DEFAULT
    AND R2, R2, #0                   ; Clear R2
    LD R0, GRADE_F_MIN_NEG           ; Load minimum score for F (negative)
    LD R1, ASCII_CHAR_F              ; Load ASCII for 'F'
    ADD R2, R3, R0                   ; Compare score to F minimum
    BRnzp STORE_LETTER_AND_PUSH_RTN  ; Assign 'F' by default

    RET                              ; Return if no grade assigned

STORE_LETTER_AND_PUSH_RTN
    ST R7, GEN_SAVE_SLOT_1           ; Save return address
    AND R0, R0, #0                   ; Clear R0
    ADD R0, R1, #0                   ; Move letter grade to R0
    JSR STACK_PUSH_OP_RTN            ; Push letter grade onto stack
    LD R7, GEN_SAVE_SLOT_1           ; Restore return address
    RET                              ; Return

GRADE_A_MIN_NEG .FILL #-90           ; Minimum score for A (negative)
ASCII_CHAR_A .FILL X41               ; ASCII code for 'A'
GRADE_B_MIN_NEG .FILL #-80           ; Minimum score for B (negative)
ASCII_CHAR_B .FILL X42               ; ASCII code for 'B'
GRADE_C_MIN_NEG .FILL #-70           ; Minimum score for C (negative)
ASCII_CHAR_C .FILL X43               ; ASCII code for 'C'
GRADE_D_MIN_NEG .FILL #-60           ; Minimum score for D (negative)
ASCII_CHAR_D .FILL X44               ; ASCII code for 'D'
GRADE_F_MIN_NEG .FILL #-50           ; Minimum score for F (negative)
ASCII_CHAR_F .FILL X46               ; ASCII code for 'F'

;------- GLOBAL VARIABLES --------;

NEWLINE_CONST_VAL .FILL xA       ; Newline character
SPACE_CONST_VAL .FILL x20        ; Space character
ASCII_TO_NUM_CONV_OFFSET .FILL #-48 ; For ASCII to number conversion
NUM_TO_ASCII_CONV_OFFSET .FILL #48  ; For number to ASCII conversion
UNUSED_ASCII_NEG_30_CONST .FILL #-30
TOTAL_SCORES_VAL .FILL 5         ; Number of scores
MAX_SCORE_RESULT .BLKW 1         ; Storage for max score
MIN_SCORE_RESULT .BLKW 1         ; Storage for min score
UNUSED_AVG_LABEL_MEM .BLKW 1
FINAL_AVERAGE_SCORE .BLKW 1      ; Storage for average

UPDATE_MIN_AND_CONTINUE
    LDR R4, R2, #0               ; Load new min
    ST R4, MIN_SCORE_RESULT      ; Store as min
    ADD R2, R2, #1               ; Move to next score
    ADD R1, R1, #-1              ; Decrement counter
    BRnzp MIN_CHECK_LOOP         ; Continue loop

UPDATE_MAX_AND_CONTINUE
    LDR R4, R2, #0               ; Load new max
    ST R4, MAX_SCORE_RESULT      ; Store as max
    ADD R2, R2, #1               ; Move to next score
    ADD R1, R1, #-1              ; Decrement counter
    BRp MAX_CHECK_LOOP           ; Continue loop

SCORE_DATA_ARRAY .BLKW 5         ; Array to store 5 scores

MIN_OUTPUT_LABEL .STRINGZ "MINIMUM SCORE: "      ; Stores the string "MINIMUM SCORE: " in memory, null-terminated
MAX_OUTPUT_LABEL .STRINGZ "MAXIMUM SCORE: "      ; Stores the string "MAXIMUM SCORE: " in memory, null-terminated
AVG_OUTPUT_LABEL .STRINGZ "AVERAGE SCORE: "      ; Stores the string "AVERAGE SCORE: " in memory, null-terminated

ASCII_Y_LOWER_NEG_CONST .FILL xFF87              ; Stores the 2's complement (negative) value for lowercase 'y' (possibly for input validation)
ASCII_Y_UPPER_NEG_CONST .FILL xFFA7              ; Stores the 2's complement (negative) value for uppercase 'Y' (possibly for input validation)
PROGRAM_START_ADDR_CONST .FILL x3000             ; Stores the program's starting address (x3000)

GEN_SAVE_SLOT_1 .FILL X0                         ; General-purpose save slot initialized to 0
GEN_SAVE_SLOT_2 .FILL X0                         ; General-purpose save slot initialized to 0
GEN_SAVE_SLOT_3 .FILL X0                         ; General-purpose save slot initialized to 0
GEN_SAVE_SLOT_4 .FILL X0                         ; General-purpose save slot initialized to 0
GEN_SAVE_SLOT_5 .FILL X0                         ; General-purpose save slot initialized to 0

;--- GET NUMERIC SCORE SUBROUTINE --;
GET_NUMERIC_INPUT_RTN
    ST R7, GEN_SAVE_SLOT_1           ; Save return address
    JSR WIPE_GP_REGISTERS_RTN        ; Clear general-purpose registers
    LD R4, ASCII_TO_NUM_CONV_OFFSET  ; Load offset to convert ASCII to number

    GETC                             ; Get first character from keyboard
    JSR VALIDATE_CHAR_INPUT_RTN      ; Validate input is a digit
    OUT                              ; Echo character

    ADD R1, R0, #0                   ; Copy input character to R1
    ADD R1, R1, R4                   ; Convert ASCII to numeric value (tens digit)
    ADD R2, R2, #10                  ; Set R2 to 10 for multiplication

MULTIPLY_TENS_DIGIT_LOOP
    ADD R3, R3, R1                   ; Add tens digit value to R3 (accumulate)
    ADD R2, R2, #-1                  ; Decrement counter
    BRp MULTIPLY_TENS_DIGIT_LOOP     ; Loop until R2 is zero (multiply by 10)

    GETC                             ; Get second character from keyboard
    JSR VALIDATE_CHAR_INPUT_RTN      ; Validate input is a digit
    OUT                              ; Echo character

    ADD R0, R0, R4                   ; Convert ASCII to numeric value (ones digit)
    ADD R3, R3, R0                   ; Add ones digit to R3 (final score)

    LD R0, SPACE_CONST_VAL           ; Load space character
    OUT                              ; Output space

    LD R7, GEN_SAVE_SLOT_1           ; Restore return address
    RET                              ; Return from subroutine

;-- DISPLAY TWO-DIGIT SUBROUTINE -;
DISPLAY_NUMBER_RTN
    ST R7, GEN_SAVE_SLOT_1           ; Save return address
    LD R5, NUM_TO_ASCII_CONV_OFFSET  ; Load offset to convert number to ASCII
    ADD R4, R3, #0                   ; Copy number to R4
    AND R1, R1, #0                   ; Clear R1 (tens digit counter)

CALC_TENS_DIGIT_LOOP
    ADD R1, R1, #1                   ; Increment tens digit
    ADD R4, R4, #-10                 ; Subtract 10 from R4
    BRp CALC_TENS_DIGIT_LOOP         ; Loop if R4 still positive

    ADD R1, R1, #-1                  ; Adjust tens digit back
    ADD R4, R4, #10                  ; Adjust remainder back

    ADD R6, R4, #-10                 ; Check if remainder needs adjustment
    BRnp REMAINDER_ADJUSTED          ; If not positive, skip adjustment

REMAINDER_NEEDS_ADJUST
    ADD R1, R1, #1                   ; Increment tens digit
    ADD R4, R4, #-10                 ; Subtract 10 from remainder

REMAINDER_ADJUSTED
    ST R1, TEMP_QUOTIENT_MEM         ; Store tens digit
    ST R4, TEMP_REMAINDER_MEM        ; Store ones digit

    LD R0, TEMP_QUOTIENT_MEM         ; Load tens digit
    ADD R0, R0, R5                   ; Convert to ASCII
    OUT                              ; Output tens digit
    LD R0, TEMP_REMAINDER_MEM        ; Load ones digit
    ADD R0, R0, R5                   ; Convert to ASCII
    OUT                              ; Output ones digit

    LD R7, GEN_SAVE_SLOT_1           ; Restore return address
    RET                              ; Return from subroutine

TEMP_REMAINDER_MEM .FILL X0          ; Temporary storage for ones digit
TEMP_QUOTIENT_MEM .FILL X0           ; Temporary storage for tens digit

;------ STACK PUSH SUBROUTINE ----;
STACK_PUSH_OP_RTN
    ST R7, GEN_SAVE_SLOT_2           ; Save return address
    LD R6, STACK_POINTER_MEM_LOC     ; Load stack pointer
    ADD R6, R6, #0                   ; Check if stack pointer is valid
    BRnz STACK_OPERATION_ERROR       ; If not, error

    ADD R6, R6, #-1                  ; Decrement stack pointer
    STR R0, R6, #0                   ; Push R0 onto stack
    ST R6, STACK_POINTER_MEM_LOC     ; Update stack pointer
    LD R7, GEN_SAVE_SLOT_2           ; Restore return address
    RET                              ; Return

STACK_POINTER_MEM_LOC .FILL X4000    ; Stack pointer initial location

;------ STACK POP SUBROUTINE -----;
STACK_POP_OP_RTN
    LD R6, STACK_POINTER_MEM_LOC     ; Load stack pointer
    ST R1, GEN_SAVE_SLOT_5           ; Save R1
    LD R1, STACK_BOTTOM_LIMIT_NEG    ; Load stack bottom limit
    ADD R1, R1, R6                   ; Check for underflow
    BRzp STACK_OPERATION_ERROR       ; If underflow, error
    LD R1, GEN_SAVE_SLOT_5           ; Restore R1

    LDR R0, R6, #0                   ; Pop value from stack into R0
    ST R7, GEN_SAVE_SLOT_4           ; Save return address

    OUT                              ; Output popped value (letter grade)
    LD R0, SPACE_CONST_VAL           ; Load space character
    OUT                              ; Output space

    ADD R6, R6, #1                   ; Increment stack pointer
    ST R6, STACK_POINTER_MEM_LOC     ; Update stack pointer
    LD R7, GEN_SAVE_SLOT_4           ; Restore return address
    RET                              ; Return

STACK_OPERATION_ERROR
    LEA R0, STACK_FAILURE_MSG        ; Load error message
    PUTS                             ; Print error message
    HALT                             ; Halt program

STACK_BOTTOM_LIMIT_NEG .FILL xC000   ; Stack bottom limit (negative offset)
STACK_FAILURE_MSG .STRINGZ "CRITICAL STACK FAULT (Overflow/Underflow). Program terminated."

;--- CLEAR REGISTERS SUBROUTINE --;
WIPE_GP_REGISTERS_RTN
    AND R1, R1, #0                   ; Clear R1
    AND R2, R2, #0                   ; Clear R2
    AND R3, R3, #0                   ; Clear R3
    AND R4, R4, #0                   ; Clear R4
    AND R5, R5, #0                   ; Clear R5
    AND R6, R6, #0                   ; Clear R6
    RET                              ; Return

;--- VALIDATE INPUT SUBROUTINE ---;
VALIDATE_CHAR_INPUT_RTN
    ST R1, GEN_SAVE_SLOT_5           ; Save R1
    ST R2, GEN_SAVE_SLOT_4           ; Save R2
    ST R3, GEN_SAVE_SLOT_3           ; Save R3

    LD R1, MIN_VALID_DIGIT_NEG_ASCII ; Load minimum valid digit offset
    ADD R2, R0, R1                   ; Check if input >= '0'
    BRn INPUT_VALIDATION_FAILURE      ; If less, invalid

    LD R1, MAX_VALID_DIGIT_NEG_ASCII ; Load maximum valid digit offset
    ADD R3, R0, R1                   ; Check if input <= '9'
    BRp INPUT_VALIDATION_FAILURE      ; If more, invalid

    LD R1, GEN_SAVE_SLOT_5           ; Restore R1
    LD R2, GEN_SAVE_SLOT_4           ; Restore R2
    LD R3, GEN_SAVE_SLOT_3           ; Restore R3
    RET                              ; Return if valid

INPUT_VALIDATION_FAILURE
    LEA R0, INVALID_CHAR_ERROR_MSG   ; Load error message
    PUTS                             ; Print error message
    LD R0, NEWLINE_FOR_VALIDATION_ERR; Output newline
    OUT
    LD R7, MAIN_PROGRAM_START_ADDR   ; Load program start address
    JMP R7                           ; Restart program

INVALID_CHAR_ERROR_MSG .STRINGZ "ERROR: Invalid character entered. Restarting input process..."
MAIN_PROGRAM_START_ADDR .FILL X3000  ; Program start address
MIN_VALID_DIGIT_NEG_ASCII .FILL #-48 ; Offset for '0'
MAX_VALID_DIGIT_NEG_ASCII .FILL #-57 ; Offset for '9'
NEWLINE_FOR_VALIDATION_ERR .FILL XA  ; Newline character

.END                                 ; End of program
