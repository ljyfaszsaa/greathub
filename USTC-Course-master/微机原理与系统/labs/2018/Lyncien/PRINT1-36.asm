.MODEL SMALL 

.DATA
    D136 DB 36 DUP (0)   
    
.CODE   

PROC PRINT_N ;��ӡ���з� 
    PUSH AX  
    PUSH DX  
    MOV AH,2
    MOV DL,0Dh
    INT 21h  
    MOV DL,0Ah
    INT 21h   
    POP DX 
    POP AX      
    RET
ENDP
PROC PRINTC ;��ӡDL���ַ�
    PUSH AX 
    MOV AH,2
    INT 21h
    POP AX     
    RET
ENDP

.STARTUP  
;��ʼ������
    MOV CX,36
    MOV BX,36
INIT_LOOP:
    DEC BX
    MOV D136[BX],CL
    LOOP INIT_LOOP
    
    MOV CX,0 
MAIN:
    MOV AL,6 ;AL=6
    MUL CH   ;AL=6*CH
    ADD AL,CL;AL=AL+CL ALΪҪ��ӡ�������±�
    MOV BX,AX
    MOV AL,D136[BX] ;ALΪҪ��ӡ���� 
    MOV DL,10
    DIV DL ;AL/10,����AL,������AH
    MOV DL,AL ;ʮλ
    ADD DL,30H ;תΪ�ַ�
    CALL PRINTC
    MOV DL,AH ;��λ
    ADD DL,30H ;תΪ�ַ�
    CALL PRINTC    
    CMP CH,CL
    JZ NEXTLINE ;�н����������ж�
    MOV DL,32 ;�����ӡ�ո�
    CALL PRINTC
    INC CL
    JMP MAIN
    
NEXTLINE:
    CALL PRINT_N
    MOV CL,0 ;��=0
    INC CH   ;��++
    CMP CH,6 ;CH<6�������һ�� 
    JNZ MAIN

.EXIT 

END


