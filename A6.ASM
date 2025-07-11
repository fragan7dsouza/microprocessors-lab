DATA SEGMENT
    f1 DB 00H
    f2 DB 01H
    f3 DB ?
    N DB 08
    msg DB 'THE FIBONACCI SERIES IS:',10,13,'$'
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    LEA DX, msg
    MOV AH, 09H
    INT 21H
    MOV BL, f1
    CALL DISPHEXA
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV BL, f2
    CALL DISPHEXA
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV CL, 00
    SUB N, 02H
UP:
    CMP CL, N
    JZ EXIT
    MOV AL, f1
    ADD AL, f2
    MOV f3, AL
    MOV BL, f3
    CALL DISPHEXA
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    MOV AL, f2
    MOV f1, AL
    MOV AL, f3
    MOV f2, AL
    INC CL
    JMP UP
EXIT:
    MOV AH, 4CH
    INT 21H
DISPHEXA PROC
    PUSH CX
    MOV DL, BL
    MOV CL, 04
    SHR DL, CL
    CMP DL, 09H
    JBE L1
    ADD DL, 07H
L1:
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    MOV DL, BL
    AND DL, 0FH
    CMP DL, 09H
    JBE L2
    ADD DL, 07H
L2:
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    POP CX
    RET
DISPHEXA ENDP
CODE ENDS
END START
