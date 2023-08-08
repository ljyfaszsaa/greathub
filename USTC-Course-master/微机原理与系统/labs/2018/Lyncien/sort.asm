.MODEL SMALL,STDCALL

.DATA
	N DW 0
	TMP DW 1 DUP (0)
    NUMS DW 1024 DUP (0)   
    MSG_ERR DB 0dh,0ah,'THERE ARE SOME ERRORS IN OPERATING THE FILE!','$'  
    MSG_SUCCESS db 0dh,0ah,'SORT RESULT:','$'
    FILEHANDLE DW 0
    FILENAME DB "test2.txt"
    TMPC DB 1 DUP (0)
.CODE   

PRINTC MACRO CHAR;��ӡ�ַ�
    PUSH AX
    PUSH DX 
    MOV AH,2
    MOV DL,CHAR
    INT 21H
    POP DX
    POP AX     
ENDM 

PRINTS MACRO PSTRING ;��ӡ�ַ���
    PUSH AX
    PUSH DX
    MOV AH,9H
    LEA DX,PSTRING
    INT 21H
    POP DX
    POP AX
ENDM

PRINTN PROC    ;��ӡһ��16λ����,AX
    ;PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    ;----------------
    MOV BX,10
    MOV CX,0
DPUSH:
    MOV DX,0
    DIV BX   ;DX:AX/10,��AX/10 ����AX��������DX
    PUSH DX ;���������λ��ѹջ
    INC CX  ;ͳ��λ��  
    CMP AX,0
    JZ DPOP  ;��Ϊ0���Ѿ������λ����ʼ��ջ   
    JMP DPUSH    
DPOP:
    POP DX
    ADD DL,30H
    MOV AH,2H            
    INT 21H  ;��ӡջ����λ        
    LOOP DPOP
    ;----------------
    POP DX
    POP CX
    POP BX
    ;POP AX
    RET
PRINTN ENDP

FGETN PROC ;���ļ���ȡһ��16λ����,�����AX  
    PUSH BX
    PUSH CX
    PUSH DX    
  
    MOV CX,5 ;�����ı����ȣ��5λ
    MOV AX,0 ;�˷��õ�AX,��ʼ��
LOOP1:
	;-------------------READCHAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    MOV AH,3FH
    MOV BX,FILEHANDLE
    MOV CX,1  ;��ȡ����
    LEA DX,TMPC;�����ݴ��ȡ�Ĵ�
    INT 21H   ;��ȡ��AX���ʵ�ʶ�ȡ�����ַ���
    JC R_ERR ;CF=1 ����
    CMP AX,0
    JZ R_QUIT ;AX=0, EOF
	CMP TMPC[0],20H
	JZ R_QUIT ;�ո�
    POP DX
    POP CX
    POP BX
    POP AX
    ;-------------------
    MOV DX,10 ;DX=10
    MUL DX    ;DX:AX=AX*10 ���ڶ�ȡ����16λ�޷������������ֻ����AX��,DXһֱ��10 
    SUB TMPC[0],30H ;
    ADD AX,WORD PTR TMPC[0] 
    LOOP LOOP1 
R_QUIT:
    POP DX
    POP CX
    POP BX
    POP AX    
    ;��ʱAXΪ��ȡ����
    JMP R_END
    
R_ERR:
    POP DX
    POP CX
    POP BX
    POP AX
R_END:
    POP DX
    POP CX
    POP BX
	RET
FGETN ENDP

SORT PROC ;ð������
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX    
    
	MOV CX,N 
	DEC CX	;��ѭ������ΪN-1
	SLOOP1:
	PUSH CX  ;����ѭ��������������
	;-------------------
		MOV BX,0
		SLOOP2: ;��ѭ��������Ҳ����ѭ������
		MOV AX,NUMS[BX]
		INC BX
		INC BX
		MOV DX,NUMS[BX]
		CMP AX,DX
		JZ NOEXCHANGE  ;AX=DX 
		JC NOEXCHANGE  ;AX<DX
		EXCHANGE:      ;AX>DX
			MOV NUMS[BX],AX
			DEC BX
			DEC BX
			MOV NUMS[BX],DX
			INC BX
			INC BX
		NOEXCHANGE:
		LOOP SLOOP2
	;-------------------
	POP CX  ;ȡ����ѭ��������
	LOOP SLOOP1
	
    POP DX
    POP CX
    POP BX
    POP AX
	RET
SORT ENDP

.STARTUP
    ;���ļ�
    LEA DX,FILENAME ;MOV DX,OFFSET _FILENAME
    MOV AH,3DH 
    MOV AL,2    
    INT 21H
    JC ERROR ;����
    ;---------
    MOV FILEHANDLE,AX   ;������
    CALL FGETN ;��ȡ��һ��������ʾ�������м�������
    MOV N,AX
    CALL PRINTN
	PRINTC 0DH
	PRINTC 0AH
    MOV BX,0
    MOV CX,N
FREAD:
    CALL FGETN
    MOV NUMS[BX],AX
    CALL PRINTN
    PRINTC 20H
    INC BX
    INC BX ;�������ֽڣ��±�ÿ��Ҫ��2
 	LOOP FREAD
 	
 	;---------
    CALL SORT
    ;---------
    
	PRINTS MSG_SUCCESS  
    PRINTC 0DH
    PRINTC 0AH
    
    MOV CX,N
    MOV BX,0
PRINTRESULT:
    MOV AX,NUMS[BX]
	CALL PRINTN
	PRINTC 20H
	INC BX
	INC BX
	
	LOOP PRINTRESULT

    JMP TOEND
    ;---------
ERROR:
    PRINTS MSG_ERR
    CALL PRINTN; ��ӡAX�洢�Ĵ�����
TOEND:
    MOV	AH, 4CH ;����������� 
	INT	21H

.EXIT 

END


