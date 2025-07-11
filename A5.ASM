DATA SEGMENT
    n DB 06H
    fact DW ?
    msg DB 'FACTORIAL(6)=$'
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    MOV AX, 1
    MOV BL, n
    MOV BH, 00
    CALL FACTORIAL
    MOV fact, AX
    MOV BL, AH
    LEA DX, msg
    MOV AH, 09H
    INT 21H
    CALL DISPHEXA
    MOV BX, fact
    CALL DISPHEXA
    MOV AH, 4CH
    INT 21H
FACTORIAL PROC
    CMP BX, 1
    JE L1
    PUSH BX
    DEC BX
    CALL FACTORIAL
    POP BX
    MUL BX
L1:
    RET
FACTORIAL ENDP
DISPHEXA PROC
    MOV DL, BL
    MOV CL, 04
    SHR DL, CL
    CMP DL, 09H
    JBE L2
    ADD DL, 07H
L2:
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 09H
    JBE L3
    ADD DL, 07H
L3:
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    RET
DISPHEXA ENDP
CODE ENDS
END START
