DATA SEGMENT
    str1 DB 20 DUP(?)
    str2 DB 20 DUP(?)
    n DB ?
    M1 DB 10, 13, 'ENTER THE STRING: $'
    M2 DB 10, 13, 'STRING IS PALINDROME $'
    M3 DB 10, 13, 'STRING IS NOT PALINDROME$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:
    MOV AX, DATA
    MOV DS, AX
    LEA DX, M1
    MOV AH, 09H
    INT 21H
    LEA SI, str1
    CALL READSTRING
    MOV n, CL
    DEC SI
    LEA DI, str2
    MOV CL, 00H

UP1:
    CMP CL, n
    JZ CHECK
    MOV AL, [SI]
    MOV [DI], AL
    DEC SI
    INC CL
    INC DI
    JMP UP1

CHECK:
    LEA SI, str1
    LEA DI, str2
    MOV CL, 00H

UP2:
    CMP CL, n
    JZ PAL
    MOV AL, [SI]
    CMP AL, [DI]
    JNZ NOTPAL
    INC SI
    INC DI
    INC CL
    JMP UP2

NOTPAL:
    LEA DX, M3
    MOV AH, 09H
    INT 21H
    JMP EXIT

PAL:
    LEA DX, M2
    MOV AH, 09H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

READSTRING PROC NEAR
    MOV CL, 00H
    LEA SI, str1

UP:
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JZ L1
    MOV [SI], AL
    INC SI
    INC CL
    JMP UP

L1:
    RET
READSTRING ENDP
CODE ENDS
END START
