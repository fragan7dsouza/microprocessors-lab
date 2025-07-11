INCLUDE F1.MAC
INCLUDE F2.MAC
DATA SEGMENT
    str db 50 DUP(?)
    n db ?
    msg1 db 10, 13, 'ENTER STRING : $'
    msg2 db 10, 13, 'ENTERED STRING IS : $'
DATA ENDS
CODE SEGMENT
    ASSUME CS: CODE, DS: DATA
START:
    MOV AX, DATA
    MOV DS, AX
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    LEA SI, str
    CALL READSTRING
    MOV n, CL
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    LEA SI, str
    MOV CL, n
    CALL DISPSTRING
    MOV AH, 4CH
    INT 21H
READSTRING PROC NEAR
    MOV CL, 00H
UP:
    CMP CL, 50
    JZ L1
    READCHAR
    CMP AL, 0DH
    JZ L1
    MOV [SI], AL
    INC SI
    INC CL
    JMP UP
L1:
    RET
READSTRING ENDP
DISPSTRING PROC NEAR
UP2:
L2:
    CMP CL, 00
    JZ L2
    MOV DL, [SI]
    DISPCHAR
    INC SI
    DEC CL
    JMP UP2
    RET
DISPSTRING ENDP
CODE ENDS
END START
