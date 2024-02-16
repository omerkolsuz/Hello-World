;==============================================================================
; Definitions of registers, etc. ("constants")
;==============================================================================
.EQU RESET      = 0x0000
.EQU PM_START   = 0x0056

.DEF TEMP       = R16

;==============================================================================
; Start of program
;==============================================================================
.CSEG   ; Start of the code segment
.ORG RESET ; Initialize program counter at reset
RJMP init ; Jump to initialization routine

.ORG PM_START  // Program memory start for included files
.INCLUDE "delay.inc" // Include delay definitions
.INCLUDE "lcd.inc"   // Include LCD control definitions

;==============================================================================
; Basic initializations of stack pointer, I/O pins, etc.
;==============================================================================
init:
    ; Set stack pointer to point at the end of RAM.
    LDI TEMP, LOW(RAMEND)
    OUT SPL, TEMP
    LDI TEMP, HIGH(RAMEND)
    OUT SPH, TEMP
    
    ; Initialize I/O pins and LCD
    CALL init_pins
    CALL lcd_init   ; Initialize LCD
    RJMP main       ; Jump to the main program

;==============================================================================
; Initialize I/O pins
;==============================================================================
init_pins:
    ; Initialization of I/O pins goes here
    ; This part remains unchanged from your original code.
    RET

;==============================================================================
; Main part of program
;==============================================================================
main:
    ; Write "Hello World" to the LCD
    LCD_INSTRUCTION 0x01 ; Clear LCD display
    LCD_WRITE_CHAR 'H'
    LCD_WRITE_CHAR 'e'
    LCD_WRITE_CHAR 'l'
    LCD_WRITE_CHAR 'l'
    LCD_WRITE_CHAR 'o'
    LCD_WRITE_CHAR ','
    LCD_WRITE_CHAR ' '
    LCD_WRITE_CHAR 'W'
    LCD_WRITE_CHAR 'o'
    LCD_WRITE_CHAR 'r'
    LCD_WRITE_CHAR 'l'
    LCD_WRITE_CHAR 'd'
    LCD_INSTRUCTION 0xC0 ; Move cursor to the second line if needed

    ; Loop indefinitely
    RJMP main
