; ============================================================================
; Program: Celsius to Fahrenheit Converter (Final Project Submission)
; Author: Will Hall
; Course: CS155 — Computer Organization and Assembly Language
; Description:
;   This program reads a two-digit Celsius temperature input from the user,
;   converts the value to Fahrenheit using fixed-point integer arithmetic,
;   and prints the Fahrenheit temperature in a clean, three-digit format.
;
;   The program uses core LC-3 instructions, subroutines for modularity, and
;   manual math operations to simulate floating point logic using integer logic.
;   Input is taken as two ASCII characters, converted to integer, calculated
;   using (C * 9 / 5) + 32, then output as ASCII digits.
;   Written and debugged by hand according to the textbook and simulator constraints.
; ============================================================================

; ============================================================================
; Description:
;   - Reads two-digit Celsius input (00–99)
;   - Converts to Fahrenheit using integer math
;   - Preserves R0 during newline, outputs clean result
; ============================================================================

        .ORIG x3000

; ========== MAIN ==========
START
        LD R6, STACK_PTR      ; Safe stack
        LEA R0, PROMPT
        PUTS

        JSR READ2DIGIT        ; R0 = Celsius

        ; Multiply R0 by 9 → R2
        ADD R1, R0, #0        ; Copy to R1
        AND R2, R2, #0
        ADD R2, R1, R1        ; 2C
        ADD R2, R2, R1        ; 3C
        ADD R2, R2, R2        ; 6C
        ADD R2, R2, R1        ; 7C
        ADD R2, R2, R1        ; 8C
        ADD R2, R2, R1        ; 9C

        ; Divide by 5 → R3
        AND R3, R3, #0
        LD R4, NEG5
DIV_LOOP
        ADD R2, R2, R4
        BRn DIV_DONE
        ADD R3, R3, #1
        BRnzp DIV_LOOP
DIV_DONE
        LD R4, POS5
        ADD R2, R2, R4
        ADD R0, R3, #0        ; R0 = quotient

        ; Add 32
        LD R5, CONST32
        ADD R0, R0, R5        ; R0 = Fahrenheit

        ; Preserve Fahrenheit in R7
        ADD R7, R0, #0

        ; Print newline
        LD R0, NEWLINE
        TRAP x21

        ; Restore R0 and print result
        ADD R0, R7, #0
        JSR PRINT_NUM

        HALT

; ----------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Description:
;   Converts the integer in R0 (range 0–255) to its decimal representation and
;   outputs the digits to the console using TRAP x21. No leading zeros are removed.
;   Uses register R7 as a copy of input, and R1–R5 for digit math and ASCII conversion.
; ----------------------------------------------------------------------------
; ========== PRINT_NUM ==========
PRINT_NUM
        ADD R7, R0, #0
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0
        LD R4, ASCII_ZERO

        ; Divide by 100
        LD R5, NEG100
DIV100
        ADD R7, R7, R5
        BRn DONE100
        ADD R1, R1, #1
        BRnzp DIV100
DONE100
        LD R5, POS100
        ADD R7, R7, R5

        ; Print hundreds
        ADD R0, R1, R4
        TRAP x21

        ; Divide by 10
        LD R5, NEG10
DIV10
        ADD R7, R7, R5
        BRn DONE10
        ADD R2, R2, #1
        BRnzp DIV10
DONE10
        LD R5, POS10
        ADD R7, R7, R5

        ; Print tens
        ADD R0, R2, R4
        TRAP x21

        ; Print ones
        ADD R0, R7, R4
        TRAP x21
        RET

; ----------------------------------------------------------------------------
; Subroutine: READ2DIGIT
; Description:
;   Reads two ASCII characters from the user (via TRAP x23), converts them into
;   an integer value representing a Celsius temperature (00–99), and stores the
;   result in R0. Uses registers R1, R2, and R6 for conversion and math.
; ----------------------------------------------------------------------------
; ========== READ2DIGIT ==========
READ2DIGIT
        TRAP x23
        LD R2, ASCII_ZERO
        NOT R2, R2
        ADD R2, R2, #1
        ADD R1, R0, R2

        ; Multiply digit1 * 10
        AND R2, R2, #0
        ADD R2, R1, R1
        ADD R2, R2, R2
        ADD R2, R2, R2
        ADD R2, R2, R1
        ADD R2, R2, R1

        TRAP x23
        LD R6, ASCII_ZERO
        NOT R6, R6
        ADD R6, R6, #1
        ADD R1, R0, R6

        ADD R0, R2, R1
        RET

; ========== CONSTANTS ==========
PROMPT       .STRINGZ "Enter Celsius (00–99): "
NEWLINE      .FILL x0A
ASCII_ZERO   .FILL x30
NEG5         .FILL #-5
POS5         .FILL #5
CONST32      .FILL #32
STACK_PTR    .FILL xFE00
NEG100       .FILL #-100
POS100       .FILL #100
NEG10        .FILL #-10
POS10        .FILL #10

        .END
