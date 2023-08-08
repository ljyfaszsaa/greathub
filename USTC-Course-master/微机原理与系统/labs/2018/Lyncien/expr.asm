;˼·
;(1)��һ��ȡ�����ַ�(����CHARS����)
;(2)����'('������λ�ã�����POS_LPAREN�����У�ͬʱ��������NUM_LPAREN���������ַ�
;(3)����'='��������,ת(5)
;(4)��������Ƿ��ַ��������˳�
;(5)��ʼһ�ּ��㣬�����ҵ������ſ�ʼ����
;(6)GET_NUM1
;(7)GET_OP,����')'��'='��ɱ��ּ��㣬��������CHARS���飬ת(5)
;(8)GET_NUM2
;(9)NUM1 = NUM1 OP NUM2,ת(7) 
;���������������Ĳ�����'$'��䣬�Ժ��ȡ��ֱ������
.MODEL SMALL
    .STACK 100H
    .DATA       
    CHARS DB 1024 DUP(0)   ;���봮
    POS_LPAREN DB  512 DUP(0) ;������λ������
    NUM_LPAREN DB 0            ;����������
    NUM_LPAREN_UNMATCH DB 0            ;δ��Ե�����������
    LENGTH DW 0   ;���봮�ܳ���
    OP DB 0
    CHAR DB 0
    TEMP1 DW 0
    TEMP2 DW 0
    ADDR DW 0    ;��¼ÿ����������������CHARS��λ�ã����ڴ洢
    ERRMSG1 DB 0DH,0AH,"ILLEGAL CHAR!!!",'$'
    ERRMSG2 DB 0DH,0AH,"UNMATCHED BRACKET!!!",'$'    
    ERRMSG3 DB 0DH,0AH,"OPERATOR ERROR!!!",'$'
    INPUTFLAG DB 0 ;��¼��һ�������ַ������ͣ�1Ϊ���֣�2Ϊ+��-
.CODE
.STARTUP  

;=====================================================================
GETCHAR MACRO  ;��ȡ��ǰ�����ַ�������AL
	MOV	AH, 1
	INT	21H
ENDM

PRINTS MACRO _PSTRING ;��ӡ�ַ���
    PUSH AX
    PUSH DX
    MOV AH,9H
    LEA DX,_PSTRING
    INT 21H
    POP DX
    POP AX
ENDM

PRINTCHAR MACRO CHAR ;��ӡһ���ַ�
	PUSH AX
	PUSH DX
	MOV	AH, 2
	MOV DL,CHAR
	INT	21H
	POP DX
	POP AX
ENDM

PRINTNUM MACRO NUM	;��ӡһ��16λ����,AX
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	;----------------  
	MOV AX,NUM
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
	POP AX
PRINTN ENDM

;=====================================================================



    LEA BX,CHARS 
    MOV CX,0 
    LEA DI,POS_LPAREN 
    INC DI    ;POS_LPAREN[0]���洢����POS_LPAREN[1]��ʼ
GETC:
    GETCHAR
    MOV [BX],AL         ;��ǰ�ַ����CHARS����
    INC BX
     
    CMP AL,3DH
    JE  GETC_END        ;��'=',

    CMP AL,'('
    JNE GETC1           ;����'(',�����ж�
    ;----------
    MOV [DI],CL         ;��'(' ���µ�ǰ'('��λ��
    INC DI 
    INC NUM_LPAREN      ;'('����++
    INC NUM_LPAREN_UNMATCH
    MOV INPUTFLAG,0 
    JMP GETC_CONTINUE
    ;---------- 
GETC1:  
    CMP AL,')'
    JNE GETC2           ;����')',�����ж�
    ;----------
    DEC NUM_LPAREN_UNMATCH ;��')',����δ��Ե�'('��
    MOV INPUTFLAG,0
    JMP GETC_CONTINUE
    ;---------- 
GETC2:
    CMP AL,'+'
    JZ GETC_OP_CHECK
    ;---------------    
    CMP AL,'-'
    JZ GETC_OP_CHECK
    ;---------------
    CMP AL,'0'
    JL ERROR1  ;�Ƿ��ַ�
    CMP AL,'9'
    JG ERROR1  ;�Ƿ��ַ�
    MOV INPUTFLAG,1 ;��¼��ǰ�����ַ�������
    JMP GETC_CONTINUE
GETC_OP_CHECK:
    CMP INPUTFLAG,2 
    JZ ERROR3  ;��һ�������ַ���+��-,����
    MOV INPUTFLAG,2 ;��¼��ǰ�����ַ���+��-     
GETC_CONTINUE:  
    INC CX
    JMP GETC  
GETC_END: 
    INC CX
    MOV LENGTH,CX
    CMP NUM_LPAREN_UNMATCH,0
    JNZ ERROR2
    JMP CAL_PAREN
;----------------------------------------------------------
CAL_PAREN:  ;�ӵ�ǰ���ҵ�'('��ʼ����
    LEA DI,POS_LPAREN 
    MOV BL,NUM_LPAREN  
    MOV BH,0
    ADD DI,BX     
    MOV AL,[DI]    ;����ARRAY[num] ;AL=���ҵļ���NUM_LPAREN��'('��λ��
    MOV AH,0
    LEA DI,CHARS
    ADD DI,AX      ;DI����ƫ�Ƶ�ַ���õ�������λ�ã������ֿ�ʼ��ȡ��λ�� 
    MOV ADDR,DI    ;���¸�λ�ã����ֽ�������⿪ʼ����
    ;-----------
    MOV DH,[DI]
    CMP DH,28H 
    JNE START_CAL  
    MOV DH,24H
    MOV [DI],DH
    INC DI
    JMP START_CAL

;-----------------------------------------------------------    
START_CAL:   
    
    PUSH AX 
    PUSH CX
    PUSH DX 
    MOV AX,0
    MOV CX,0
    MOV DX,0
    
GET_NUM1:
    MOV DH,[DI]    
    CMP DH,24H      ;����$������ 
    JE L3
    CMP DH,3DH      ;����=���
    MOV TEMP1,AX
    JE PRINTRESULT 
    CMP DH,24H
    JNE L2
L3:
    INC DI
    MOV DH,[DI]
    CMP DH,3DH  ;����=��� 
    JE PRINTRESULT 
    CMP DH,28H  ;���������ٶ�һλ
    JE L3
    CMP DH,24H   ;����$�ٶ�һλ
    JE L3  
    JNE L2

L2: 
    MOV [DI],24H  ; ��$���� 
    INC DI  
    CMP DH,2DH     
    MOV CHAR,DH    ;ÿ���ַ�����CHAR����Ϊ�����������OP
    JLE RETU1     ;С��'-'�����������֣�����������ɶ�ȡ
    ;���������Ķ�ȡ           
    SUB DH,30H       ;�����һ������TEMP1����ÿ��һ���ַ���ASCII)����ȥ30H ������һ���ַ��������֣��ͽ�������ֳ�10�ټ�����һ���ַ������ν��� 
    MOV DL,DH
    MOV DH,0 
    PUSH DX
    MOV CX,10
    MUL CX 
    POP DX
    ADD AX,DX 
    JMP GET_NUM1   
    
RETU1:
    MOV TEMP1,AX    ;����TEMP1 
    JMP GET_OP 
;-----------------------------------        
GET_OP: 
    MOV DH,CHAR      
    CMP DH,3DH       ;��Ϊ=�������
    JE PRINTRESULT 
    CMP DH,29H        ;��Ϊ������ɱ��ּ��� 
    JE  FINISH_CAL
    MOV OP,DH   
    MOV AX,0
    JMP GET_NUM2
;-----------------------------------  
JUDGE_OP:         ;����&���ٶ�һ���ַ���һ��Ϊ- 
    INC DI
    MOV DH,[DI]
    INC DI
    CMP DH,OP       ;���ȡNUM2ǰ��OP���бȽϣ�+-Ϊ����--Ϊ��
    JNE L14 
    MOV DH,28H        ;OP����Ϊ+ 
    MOV OP,DH
    JMP GET_NUM2      
L14:
    MOV OP,DH        ;OP����Ϊ- 
    JMP GET_NUM2
;-----------------------------------      
GET_NUM2: ;����GET_NUM1��һ����GET_NUM1�󣬲���GET_OP GET_NUM2
    MOV DH,[DI] 
    MOV CHAR,DH
    CMP DH,3DH   ;'=' 
    JE RETU2
    CMP DH,26H   ;'&'
    JE JUDGE_OP
    CMP DH,24H   ;'$'
    JNE L4
L5:
    INC DI
    MOV DH,[DI] 
    CMP DH,3DH   ;'='
    JE RETU2  
    CMP DH,28H   ;'('
    JE L5
    CMP DH,24H   ;'$'
    JNE L4
    JE L5
L4:
    MOV [DI],24H ; ��$����
    INC DI
    CMP DH,2DH   ;'-'
    MOV CHAR,DH 
    JLE RETU2    ;С��'-'�����������֣�����������ɶ�ȡ
    ;�����������Ķ�ȡ��-30H��AX*10�ټӸ�λ 
    SUB DH,30H
    MOV DL,DH
    MOV DH,0
    MOV CX,10 
    PUSH DX
    MUL CX  
    POP DX
    ADD AX,DX 
    JMP GET_NUM2   
    
RETU2:
    MOV TEMP2,AX
    JMP CAL1
;----------------------------------------------------------    
CAL1:
    CMP OP,2DH ;'-' 
    MOV AX,0
    JE TOSUB
    JNE TOADD      
TOSUB:
    MOV DX,TEMP2
    SUB TEMP1,DX 
    MOV TEMP2,0
    JMP GET_OP  
TOADD:
    MOV DX,TEMP2
    ADD TEMP1,DX
    MOV TEMP2,0 
    JMP GET_OP
;--------------------------------------------------------- 

FINISH_CAL: 
    MOV AX,TEMP1  
    MOV DI,ADDR ;���ֿ�ʼ��ȡ��λ�ã����⿪ʼ���� 
    CMP AX,0
    JGE SAVETEMP1   ;TEMP1����0,ֱ�Ӵ� 
    ;��TEMP1С��0�����ȴ���&���ٴ���- 
    MOV [DI],26H
    INC DI
    MOV [DI],2DH
    INC DI
    ;--------ȡ��TEMP1����0-TEMP1ʹ�����
    MOV CX,0 
    SUB CX,AX
    MOV AX,CX

SAVETEMP1:;����ȡ����ģ�TEMP1���ַ������CHARS���飬
	PUSH BX
	PUSH CX
	PUSH DX
	;----------------  
	MOV BX,10
	MOV CX,0
DPUSH1:
	MOV DX,0
	DIV BX   ;DX:AX/10,��AX/10 ����AX��������DX
	PUSH DX ;���������λ��ѹջ
	INC CX  ;ͳ��λ��  
	CMP AX,0
	JZ DPOP1  ;��Ϊ0���Ѿ������λ����ʼ��ջ   
	JMP DPUSH1	
DPOP1:
	POP DX
	ADD DL,30H
    MOV [DI],DL
    INC DI	
	LOOP DPOP1
	;----------------
	POP DX
	POP CX
	POP BX
    ;---------------- 
       
    DEC NUM_LPAREN  
    POP DX
    POP CX
    POP AX
   
 
  
;-----------------------------------------------------------     
ENDJUDGE:
    CMP NUM_LPAREN,0
    JGE CAL_PAREN ;'('����>0����ʼ�µ�һ�ּ���
    JMP PRINTRESULT ;��������ӡ

;--------------------------------�����ǽ����� 
    
PRINTRESULT:
	MOV AX,TEMP1	
	CMP AX,0 
	JGE POSTIVE  ;���ڵ���0��ֱ�ӿ�ʼ��ӡ
	MOV CX,0 
	SUB CX,AX    
	MOV AX,CX	;С��0��ȡ������
	PRINTCHAR 2DH ;��ӡ��-��
POSTIVE:
	PRINTNUM AX

    JMP CEND


ERROR1:
    PRINTS ERRMSG1
    JMP CEND
ERROR2:
    PRINTS ERRMSG2
    JMP CEND   
ERROR3:
    PRINTS ERRMSG3
    JMP CEND 
CEND:

.EXIT
END









