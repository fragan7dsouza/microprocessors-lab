DATA SEGMENT
    arr     DB 12H, 15H, 63H, 78H, 86H, 99H
    len     DB $-ARR
    mid     DB ?
    key     DB 99H
    msg1    DB 10, 13, 'KEY NOT FOUND', 10, 13, '$'
    msg2    DB 10, 13, 'KEY FOUND AT POSITION $'
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    DEC len
    MOV DL, 00H
    MOV DH, len
    MOV CH, key
UP:
    CMP DL, DH
    JA NOTFOUND
    MOV AL, DL
    ADD AL, DH
    SHR AL, 1
    MOV mid, AL
    MOV BX, 00
    MOV BL, mid
    CMP CH, arr[BX]
    JZ FOUND
    JB FIRSTHALF
    INC mid
    MOV DL, mid
    JMP UP
FIRSTHALF:
    DEC mid
    MOV DH, mid
    JMP UP
NOTFOUND:
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    JMP EXIT
FOUND:
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    INC mid
    MOV BL, mid
    CALL DISPHEXA
EXIT:
    MOV AH, 4CH
    INT 21H
DISPHEXA PROC
    MOV DL, BL
    MOV CL, 04H
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
    RET
DISPHEXA ENDP
CODE ENDS
END START
