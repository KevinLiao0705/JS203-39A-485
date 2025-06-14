;******************************************************************************
;Copy From JS232_27C
;Establish Date 2012,7,2
;Purpose:Argentina Customer Use
;Change To Espanish Language 


	
 

        .equ __24ep64MC202, 1 ;
        .include "p24ep64MC202.inc"

;BY DEFINE=============================
	.EQU OLED_AMT_K		,92
	.EQU	SLAVE_DK	,1	
	.EQU	DATEST_DK	,1	
;	.EQU	U2TX_TEST_DK	,1	
;	.EQU 	IICM_DK		,1
;	.EQU 	IICS_DK		,1
;====================================
	.EQU	VER0_K		,'1'
	.EQU	VER1_K		,'0'
	.EQU 	DEVICE_ID_K		,0x2537
	.EQU 	SERIAL_ID_K		,0x0000
	.EQU 	OLED_MAIN_DEVICE_ID_K	,0x2306

	.EQU 	F24SET_FADR	,0xA000	;DONT USE THE LAST BLOCK OF FLASH(0x0A800)
	.EQU 	FRAM_SIZE_K	,16	
	.EQU 	RX485_SYNC_K	,0xAAC6
;;=====================================================



;====================================
	.include "pindef.s";
;====================================


;..............................................................................
;Global Declarations:
;..............................................................................
    	.global __reset          
    	.global __T1Interrupt    
  	.global __T4Interrupt    
  	.global __U1RXInterrupt    
  	.global __U1TXInterrupt  
  	.global __U2RXInterrupt    
  	.global __U2TXInterrupt  

.MACRO 	LDPTR XX
    	MOV #tbloffset(\XX),W1
.ENDM


.MACRO 	BSF XX
	BSET \XX,#&XX&_P
.ENDM
.MACRO 	BCF XX
	BCLR \XX,#&XX&_P
.ENDM
.MACRO 	TG XX
	BTG \XX,#&XX&_P
.ENDM
.MACRO 	BTFSS XX
	BTSS \XX,#&XX&_P
.ENDM
.MACRO 	BTFSC XX
	BTSC \XX,#&XX&_P
.ENDM


.MACRO 	SETIICT	XX
	MOV TMR3,W0
	MOV W0,IICTMRB		
	MOV #\XX,W0		
	MOV W0,IICTMRL		
.ENDM
	
.MACRO 	CHKIICT
	MOV IICTMRB,W0			;;
	SUB TMR3,WREG			;;
	SUBR IICTMRL,WREG		;;
.ENDM



.MACRO 	RETW XX
        RETLW #\XX,W0
.ENDM

.MACRO 	LOFFS0 XX
        MOV #tbloffset(\XX),W0
.ENDM
.MACRO 	LOFFS1 XX
        MOV #tbloffset(\XX),W1
.ENDM
.MACRO 	LOFFS2 XX
        MOV #tbloffset(\XX),W2
.ENDM
.MACRO 	LOFFS3 XX
        MOV #tbloffset(\XX),W3
.ENDM
.MACRO 	LOFFS4 XX
        MOV #tbloffset(\XX),W4
.ENDM
.MACRO 	LOFFS5 XX
        MOV #tbloffset(\XX),W5
.ENDM
.MACRO 	LOFFS6 XX
       	MOV #tbloffset(\XX),W6
.ENDM
.MACRO 	LOFFS7 XX
        MOV #tbloffset(\XX),W7
.ENDM

.MACRO 	MOVLF XX,YY
        MOV #\XX,W0
	MOV W0,\YY
.ENDM

.MACRO 	MOVFF XX,YY
	PUSH \XX
	POP \YY
.ENDM
	
.MACRO 	LXYB XX,YY,XD,YD
	MOV #\XX,W0
	MOV W0,LCDX
	MOV #\YY,W0
	MOV W0,LCDY
	MOV #\XD,W0
	MOV W0,LCDXE
	MOV #\YD,W0
	MOV W0,LCDYE
.ENDM


.MACRO 	W_TFTC XX
	MOV #\XX,W0
	CALL WTFTC
.ENDM

.MACRO 	W_TFTD XX
	MOV #\XX,W0
	CALL WTFTD
.ENDM

.MACRO 	W_TFTCD XX,YY
	MOV #\XX,W0
	CALL WTFTC
	MOV #\YY,W0
	CALL WTFTD
.ENDM

.MACRO 	W_TFTDD XX
	MOV #\XX,W0
	SWAP W0
	CALL WTFTD
	MOV #\XX,W0
	CALL WTFTD
.ENDM

.MACRO 	W_TFTDDW
	SWAP W0
	CALL WTFTD
	SWAP W0
	CALL WTFTD
.ENDM

;*************************
.MACRO 	LXY XX,YY
	MOV #\XX,W0
	MOV W0,LCDX
	MOV #\YY,W0
	MOV W0,LCDY
.ENDM
;-------------------------


;*************************
.MACRO 	LW10 XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
.ENDM
;-------------------------


;*************************
.MACRO 	WRFXS XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
	CALL WR_FXSREG		
 .ENDM
;-------------------------

;*************************
.MACRO 	RRFXS XX
	MOV #\XX,W1
	MOV #0x00,W0
	CALL RD_FXSREG		
 .ENDM
;-------------------------


;*************************
.MACRO 	WMFXS XX,YY,ZZ
	MOV #\XX,W1
	MOV #\YY,W0
	MOV W0,R1
	MOV #\ZZ,W0
	MOV W0,R0
	CALL WM_FXS		
 .ENDM

.MACRO 	RMFXS XX
	MOV #\XX,W1
	CALL RM_FXS		
 .ENDM



;*************************
.MACRO 	WAIC XX,YY
	MOV #\XX,W1
	MOV #\YY,W0
	CALL WSPI		
 .ENDM
;-------------------------

;*************************
.MACRO 	RAIC XX
	MOV #\XX,W1
	CALL RSPI		
 .ENDM
;-------------------------

;*************************
.MACRO 	WAICW XX
	MOV #\XX,W1
	CALL WSPI		
 .ENDM
;-------------------------


;************************                
.MACRO 	STWC XX
	BSF TFT_SCL_O
	BCF TFT_CS_O
	MOV #\XX,W0
	CALL STWCP
.ENDM
;-------------------------

;************************                
.MACRO 	STWEND
	BSF TFT_CS_O
.ENDM
;-------------------------

;************************                
.MACRO 	STWD XX
	MOV #\XX,W0
	CALL STWDP
.ENDM
;-------------------------


;-------------------------


;..............................................................................
;Constants stored in Program space
;..............................................................................

        .section .CONST, code
        .palign 2                ;Align next word stored in Program space to an
                                 ;address that is a multiple of 2

;..............................................................................
;Uninitialized variables in Near data memory (Lower 8Kb of RAM)
;..............................................................................

          .section .nbss, bss, near

ICD2_USE: 		.SPACE 128
START_REG:		.SPACE 0
R0:    			.SPACE 2		
R1:			.SPACE 2		
R2:			.SPACE 2		
R3:			.SPACE 2		
R4:			.SPACE 2		
R5:			.SPACE 2		
R6:			.SPACE 2		
R7:			.SPACE 2		
R8:			.SPACE 2		
R9:			.SPACE 2		
DEBUG_CNT:		.SPACE 2		

U1RXI_BUF:		.SPACE 2		

;;====================================
TMP0:			.SPACE 2				
TMP1:			.SPACE 2				
TMP2:			.SPACE 2				
TMP3:			.SPACE 2				
TMP4:			.SPACE 2				
TMP5:			.SPACE 2				
TMP6:			.SPACE 2				
TMP7:			.SPACE 2				
TMP8:			.SPACE 2				
TMP9:			.SPACE 2				
TMP10:			.SPACE 2				
TMP11:			.SPACE 2				
TMP12:			.SPACE 2				
TMP13:			.SPACE 2				
TMP14:			.SPACE 2				
TMP15:			.SPACE 2				



ADTEST:		.SPACE 2		


TMR2_BUF:		.SPACE 2		
TMR2_FLAG:		.SPACE 2		
TMR2_IORF:		.SPACE 2		

TMR3_BUF:		.SPACE 2		
TMR3_FLAG:		.SPACE 2		
TMR3_IORF:		.SPACE 2		
DELAY_CNT:		.SPACE 2		
DELAY_ACT:		.SPACE 2		
DELAY_BASE_TIM:		.SPACE 2		
DELAY_ACT_TIM:		.SPACE 2		

TX_DEVICE_ID:		.SPACE 2		
TX_SERIAL_ID:		.SPACE 2		
TX_GROUP_ID:		.SPACE 2		

RX_DEVICE_ID:		.SPACE 2		
RX_SERIAL_ID:		.SPACE 2		
RX_GROUP_ID:		.SPACE 2		


ADCH_CNT:		.SPACE 2		
ADBUF_CNT:		.SPACE 2		
ADBUF0:			.SPACE 2		
ADBUF1:			.SPACE 2		
ADBUF2:			.SPACE 2		
ADBUF3:			.SPACE 2		



I50VADI:		.SPACE 2		
T50VADI:		.SPACE 2		
V50VADI:		.SPACE 2		
T32VADI:		.SPACE 2		
I32VADI:		.SPACE 2		
V32VADI:		.SPACE 2		
PS_FLAG:		.SPACE 2




V50CMD:			.SPACE 2
V32ON_TIM:		.SPACE 2
V50OFF_TIM:		.SPACE 2


;;====================================
FLAGA:	        	.SPACE 2
FLAGB:	        	.SPACE 2
FLAGC:	        	.SPACE 2
FLAGD:	        	.SPACE 2
SPIBUF:			.SPACE 2		
SPIBUFA:		.SPACE 2		
SPIBUFB:		.SPACE 2		
;;====================================
SSPA_RFOP:		.SPACE 2		
SSPA_TEMP:		.SPACE 2		
SSPA_FLAG:		.SPACE 2		
ADSAMP_TIM:		.SPACE 2		



CMDINX:			.SPACE 2
CMDSTEP:		.SPACE 2
CMDTIME:		.SPACE 2
KBMODE_INX:		.SPACE 2
KBMODE_STEP:		.SPACE 2
KBMODE_TIM:		.SPACE 2
;;====================================
NOWKB_INX:		.SPACE 2
IMAGE_PAG:		.SPACE 2
SPEC_KEY_BUF:		.SPACE 32
SERIAL_ID:		.SPACE 2
;SWITCH_KB_FLAG1:	.SPACE 2

CONVAD_CNT:		.SPACE 2
VR1BUF:			.SPACE 2
VR1V:			.SPACE 2
LCDX:			.SPACE 2
LCDY:			.SPACE 2
LCDX_LIM0:		.SPACE 2
LCDX_LIM1:		.SPACE 2
LCDY_LIM0:		.SPACE 2
LCDY_LIM1:		.SPACE 2
BMPX:			.SPACE 2
BMPY:			.SPACE 2
LCDXE:			.SPACE 2
LCDYE:			.SPACE 2
COLOR_B:		.SPACE 2
RAMSTR_BUF_PTR:		.SPACE 2
FONT_X:			.SPACE 2
FONT_Y:			.SPACE 2
STR_LEN:		.SPACE 2
COLOR_F:		.SPACE 2
FONT_WB:		.SPACE 2
FLASH_CNT:		.SPACE 2
;;====================================
KEYSCAN_CNT:		.SPACE 2
KEYCODE:		.SPACE 2
KEYDATA0:		.SPACE 2
KEYDATA1:		.SPACE 2
KEYDATA2:		.SPACE 2
KEYDATA3:		.SPACE 2
KEYDATA4:		.SPACE 2
KEYDATA5:		.SPACE 2
KEYDATA6:		.SPACE 2
KEYDATA7:		.SPACE 2

KEY_BUF:		.SPACE 2
KEY_TMP:		.SPACE 2
YESKEY_CNT:		.SPACE 2
NOKEY_CNT:		.SPACE 2
CONKEY_CNT:		.SPACE 2
KEYDB_BUF:		.SPACE 2
KEYDB_CNT:		.SPACE 2
KEYDB_TIM:		.SPACE 2

EMUKR0:			.SPACE 2
EMUKR1:			.SPACE 2
EMUKR2:			.SPACE 2
EMUKR3:			.SPACE 2

;;====================================
SSPA_CONNECT_CNT:	.SPACE 2



KB_TYPE_CNT:		.SPACE 2
KB_PAGE_CNT:		.SPACE 2
KB_X256_CNT:		.SPACE 2
KB_X256_TH:		.SPACE 2
WPAGE_CNT:		.SPACE 2


FADR0:			.SPACE 2
FADR1:			.SPACE 2
DADR0:			.SPACE 2
DADR1:			.SPACE 2
CHKSUM:			.SPACE 2
TEMP_BUF0:		.SPACE 2
TEMP_BUF1:		.SPACE 2
TEMP_BUF2:		.SPACE 2
TEMP_BUF3:		.SPACE 2
TEMP_BUF4:		.SPACE 2
TEMP_BUF5:		.SPACE 2
TEMP_BUF6:		.SPACE 2
TEMP_BUF7:		.SPACE 2
TEMP_BUF8:		.SPACE 2
TEMP_BUF9:		.SPACE 2
TEMP_BUFA:		.SPACE 2
TEMP_BUFB:		.SPACE 2
TEMP_BUFC:		.SPACE 2
TEMP_BUFD:		.SPACE 2
TEMP_BUFE:		.SPACE 2
TEMP_BUFF:		.SPACE 2
TEST_SET0:		.SPACE 2
TEST_SET1:		.SPACE 2
TEST_SET2:		.SPACE 2
TEST_SET3:		.SPACE 2


;DUTX_LEN:		.SPACE 2
;WAIT_DUTX_TIM:		.SPACE 2
;F24SET_BUF:		.SPACE 64
;;====================================
EMU_UARTTX_TIM:		.SPACE 2
SHIFT_TIME:		.SPACE 2
;C1DO1:			.SPACE 2
;C1DI1:			.SPACE 2
;C1BCLK_CNT:		.SPACE 2
;ICIO_CNT:		.SPACE 2
;ICIO_CNTB:		.SPACE 2
;;====================================
;EDFLAG0:		.SPACE 2
;EDFLAG1:		.SPACE 2
;EDFLAG2:		.SPACE 2
;EDFLAG3:		.SPACE 2
;;====================================
;;====================================
;PP_GROUP:		.SPACE 2
;MID:			.SPACE 2
;SID:			.SPACE 2
;RX_GRP:		.SPACE 2
;RX_FMID:		.SPACE 2
;RX_FSID:		.SPACE 2
;RX_TMID:		.SPACE 2
;RX_TSID:		.SPACE 2
;RX_MCMD:		.SPACE 2
;RX_SCMD:		.SPACE 2
;RX_PARA0:		.SPACE 2
;RX_PARA1:		.SPACE 2
;RX_PARA2:		.SPACE 2
;RX_PARA3:		.SPACE 2
;RX_PARA4:		.SPACE 2
;RX_PARA5:		.SPACE 2
;RX_PARA6:		.SPACE 2
;RX_PARA7:		.SPACE 2
URX_BUF:		.SPACE 64 ;32 WORD
;;====================================
U1RX_BYTE_PTR:		.SPACE 2
U1RXA_LEN:		.SPACE 2
U1RXB_LEN:		.SPACE 2
U1RX_LEN:		.SPACE 2
U1TX_BCNT:		.SPACE 2
U1TX_BTX:		.SPACE 2
U1RX_XORSUM:		.SPACE 2
U1RX_ADDSUM:		.SPACE 2
U1RX_TMP0:		.SPACE 2
U1RX_TMP1:		.SPACE 2
U1RXT:			.SPACE 2
;;====================================
U2RX_BYTE_PTR:		.SPACE 2
U2RXA_LEN:		.SPACE 2
U2RXB_LEN:		.SPACE 2
U2RX_LEN:		.SPACE 2
U2TX_BCNT:		.SPACE 2
U2TX_BTX:		.SPACE 2
U2RX_XORSUM:		.SPACE 2
U2RX_ADDSUM:		.SPACE 2
U2RX_TMP0:		.SPACE 2
U2RX_TMP1:		.SPACE 2
U2RXT:			.SPACE 2
;;====================================
PRE_RX_CMD:		.SPACE 2
RX_ADDR:		.SPACE 2
RX_FLAGS:		.SPACE 2
RX_LEN:			.SPACE 2
RX_CMD:			.SPACE 2	
UTX_CMD:		.SPACE 2	
UTX_PARA0:		.SPACE 2	
UTX_PARA1:		.SPACE 2	
UTX_PARA2:		.SPACE 2	
UTX_PARA3:		.SPACE 2	
URX_PARA0:		.SPACE 2	
URX_PARA1:		.SPACE 2	
URX_PARA2:		.SPACE 2	
URX_PARA3:		.SPACE 2	
UTX_CHKSUM0:		.SPACE 2	
UTX_CHKSUM1:		.SPACE 2	
UTX_BTX:		.SPACE 2	
UTX_BUFFER_LEN:		.SPACE 2	
UTX_BUF:		.SPACE 64	



ADIN_BUF:		.SPACE 32	
ADIN_CNT:		.SPACE 2	
V34V_ADV:		.SPACE 2	
I34V_ADV:		.SPACE 2	
TEMP_ADV:		.SPACE 2	
FAULT_ADV:		.SPACE 2	


;;====================================
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;:			.SPACE 2
;;========================================


;######################################
PARASET_BUF:		.SPACE 0 ;256
PARA0_FSET:		.SPACE 2
PARA1_FSET:		.SPACE 2
PARA2_FSET:		.SPACE 2
PARA3_FSET:		.SPACE 2
PARA4_FSET:		.SPACE 2
PARA5_FSET:		.SPACE 2
PARA6_FSET:		.SPACE 2
PARA7_FSET:		.SPACE 2
PARA8_FSET:		.SPACE 2
PARA9_FSET:		.SPACE 2
PARAA_FSET:		.SPACE 2
PARAB_FSET:		.SPACE 2
PARAC_FSET:		.SPACE 2
PARAD_FSET:		.SPACE 2
PARAE_FSET:		.SPACE 2
PARAF_FSET:		.SPACE 2
;=====================================
SET_END:		.SPACE 0
SET_SPARE:		.SPACE (128+PARASET_BUF-SET_END)
;=================================
;KEYHEAD_TMP:		.SPACE 512
;BYTE0-BIT3~0 NOWPAGE
;BYTE0-BIT4~0 LOAD OK
;BYTE4 CHKSUM0
;BYTE5 CHKSUM1
;BYTE6 CHKSUM2
;BYTE7 CHKSUM3


END_REG:		.SPACE 2




.EQU STACK_BUF		,0x1F00	
.EQU U1RX_BUFSIZE	,256	;
.EQU U2RX_BUFSIZE	,256	;
.EQU U1RX_BUFA		,0x2000	;
.EQU U1RX_BUFB		,0x2100	;
.EQU U2RX_BUFA		,0x2200	;
.EQU U2RX_BUFB		,0x2300	;
.EQU U1TX_BUF		,0x2400	;
.EQU U2TX_BUF		,0x2500	;
.EQU FLASH_BUF		,0x2600 ; 

.EQU KB_HEAD_BUF	,0x2A00 ;512 

.EQU FLASH_TMP		,0x2C00	;512			
.EQU F24SET_BUF		,0x2C00	;512			

.EQU END_RAM		,0x2FFF		;512W

;END=4FFF

; 0=4S
; 1=8uS
; 2=16uS
; 3=31uS
; 4=62.5uS
; 5=125uS
; 6=250uS
; 7=500US
; 8=1MS
; 9=2 
;10=4
;11=8
;12=16
;13=32
;14=64
;15=128
 


;TMR2_FLAG
.EQU    T4U_F_P      	,0
.EQU    T8U_F_P      	,1
.EQU    T16U_F_P      	,2
.EQU	T32U_F_P	,3
.EQU	T64U_F_P	,4
.EQU	T128U_F_P	,5
.EQU	T256U_F_P	,6
.EQU	T512U_F_P	,7
.EQU	T1M_F_P		,8
.EQU	T2M_F_P		,9
.EQU	T4M_F_P 	,10
.EQU	T8M_F_P		,11
.EQU	T16M_F_P	,12
.EQU	T32M_F_P	,13
.EQU	T64M_F_P	,14
.EQU	T128M_F_P	,15
.EQU    T4U_F      	,TMR2_FLAG
.EQU    T8U_F      	,TMR2_FLAG
.EQU    T16U_F      	,TMR2_FLAG
.EQU	T32U_F		,TMR2_FLAG
.EQU	T64U_F		,TMR2_FLAG
.EQU	T128U_F		,TMR2_FLAG
.EQU	T256U_F		,TMR2_FLAG
.EQU	T512U_F		,TMR2_FLAG
.EQU	T1M_F		,TMR2_FLAG
.EQU	T2M_F		,TMR2_FLAG
.EQU	T4M_F 		,TMR2_FLAG
.EQU	T8M_F		,TMR2_FLAG
.EQU	T16M_F		,TMR2_FLAG
.EQU	T32M_F		,TMR2_FLAG
.EQU	T64M_F		,TMR2_FLAG
.EQU	T128M_F		,TMR2_FLAG









;FLAGA
.EQU U1U2_F		,FLAGA
.EQU U1U2_F_P		,0
.EQU U1RX_START_F	,FLAGA
.EQU U1RX_START_F_P	,1
.EQU P50VEN_F		,FLAGA
.EQU P50VEN_F_P		,2
.EQU P32VEN_F		,FLAGA
.EQU P32VEN_F_P		,3
.EQU U2TXON_F  	        ,FLAGA
.EQU U2TXON_F_P	        ,4
.EQU PS_ON_F      	,FLAGA	
.EQU PS_ON_F_P	        ,5
.EQU SSPA_ON_F      	,FLAGA	
.EQU SSPA_ON_F_P	,6
;EQU SLAVE_F		,FLAGA
;EQU SLAVE_F_P		,7
.EQU ERR_F		,FLAGA
.EQU ERR_F_P		,8
.EQU OK_F		,FLAGA
.EQU OK_F_P		,9
;.EQU ERR_F		,FLAGA
;.EQU ERR_F_P		,10
;.EQU OK_F		,FLAGA
;.EQU OK_F_P		,11
;EQU AICIO_AB_F		,FLAGA
;EQU AICIO_AB_F_P  	,12
;.EQU MASTER_U1RX_F	,FLAGA
;.EQU MASTER_U1RX_F_P 	,13
;.EQU MASTER_U2RX_F	,FLAGA
;.EQU MASTER_U2RX_F_P 	,14
;.EQU WAIT_DUTX_F	,FLAGA
;.EQU WAIT_DUTX_F_P  	,15




;FLAGB
;.EQU DISKP_F		,FLAGB
;.EQU DISKP_F_P		,0
;.EQU NOKEY_F		,FLAGB
;.EQU NOKEY_F_P		,1
;.EQU DISKR_F		,FLAGB
;.EQU DISKR_F_P		,2
;.EQU KEY_PUSH_F		,FLAGB
;.EQU KEY_PUSH_F_P	,3
;.EQU STRLEN_F		,FLAGB
;.EQU STRLEN_F_P		,4
;.EQU RAMSTR_F		,FLAGB
;.EQU RAMSTR_F_P		,5
;EQU CHK_SYNC_F		,FLAGB
;EQU CHK_SYNC_F_P	,6
;EQU SLAVE_U2RX_F	,FLAGB
;EQU SLAVE_U2RX_F_P	,7
;EQU SLAVE_U2TX_F	,FLAGB
;EQU SLAVE_U2TX_F_P	,8
;EQU TEST_F		,FLAGB
;EQU TEST_F_P		,9
;EQU LOAD_U1TXPARA_F	,FLAGB
;EQU LOAD_U1TXPARA_F_P	,10
;EQU LOAD_U2TXPARA_F	,FLAGB
;EQU LOAD_U2TXPARA_F_P	,11
;EQU AIC_BEEP_F		,FLAGB
;EQU AIC_BEEP_F_P	,12
;EQU RESTART_F		,FLAGB
;EQU RESTART_F_P	,13
;EQU VOLP_F		,FLAGB
;EQU VOLP_F_P		,14
;EQU HEAD_LINE_F	,FLAGB
;EQU HEAD_LINE_F_P	,15



;FLAGC
;EQU BEEPL_F		,FLAGC
;EQU BEEPL_F_P		,0
;EQU CODTXA_LDED_F	,FLAGC
;EQU CODTXA_LDED_F_P	,1
;EQU CODTXB_LDED_F	,FLAGC
;EQU CODTXB_LDED_F_P	,2
;EQU RXU1CMD_F		,FLAGC
;EQU RXU1CMD_F_P	,3
;EQU RXU2CMD_F		,FLAGC
;EQU RXU2CMD_F_P	,4
;EQU RXIICCMD_F		,FLAGC
;EQU RXIICCMD_F_P	,5
;EQU MYMID_F		,FLAGC
;EQU MYMID_F_P		,6
;.EQU SNDPACK_RXAB_F	,FLAGC
;.EQU SNDPACK_RXAB_F_P	,7
;EQU LDU1TX_U2RACRB_F	,FLAGC
;EQU LDU1TX_U2RACRB_F_P	,8
;EQU LDU2TX_U1RACRB_F	,FLAGC
;EQU LDU2TX_U1RACRB_F_P	,9
;EQU LDU1TX_U2RBCRA_F	,FLAGC
;EQU LDU1TX_U2RBCRA_F_P	,10
;EQU LDU2TX_U1RBCRA_F	,FLAGC
;EQU LDU2TX_U1RBCRA_F_P	,11
;EQU IICS_RXED_F	,FLAGC
;EQU IICS_RXED_F_P	,12
;EQU IICRX_ERR_F	,FLAGC
;EQU IICRX_ERR_F_P	,13
;EQU LD_CODTXA_F	,FLAGC
;EQU LD_CODTXA_F_P	,14
;EQU LD_CODTXB_F	,FLAGC
;EQU LD_CODTXB_F_P	,15


;FLAGD
.EQU U1TX_EN_F		,FLAGD
.EQU U1TX_EN_F_P	,0
.EQU U2TX_EN_F		,FLAGD
.EQU U2TX_EN_F_P	,1
.EQU U1RX_BUFAB_F	,FLAGD
.EQU U1RX_BUFAB_F_P	,2
.EQU U2RX_BUFAB_F	,FLAGD
.EQU U2RX_BUFAB_F_P	,3
.EQU U1RXT_F		,FLAGD
.EQU U1RXT_F_P		,4
.EQU U2RXT_F		,FLAGD
.EQU U2RXT_F_P		,5
.EQU U1TX_END_F		,FLAGD
.EQU U1TX_END_F_P	,6 
.EQU U2TX_END_F		,FLAGD
.EQU U2TX_END_F_P	,7 
.EQU U1RX_PACKA_F	,FLAGD
.EQU U1RX_PACKA_F_P	,8 
.EQU U2RX_PACKA_F	,FLAGD
.EQU U2RX_PACKA_F_P	,9 
.EQU U1RX_PACKB_F	,FLAGD
.EQU U1RX_PACKB_F_P	,10
.EQU U2RX_PACKB_F	,FLAGD
.EQU U2RX_PACKB_F_P	,11
.EQU U1RX_EN_F		,FLAGD
.EQU U1RX_EN_F_P	,12
.EQU U2RX_EN_F		,FLAGD
.EQU U2RX_EN_F_P	,13






.text                             ;Start of Code section
__reset:
 	GOTO POWER_ON



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_WREG:			;;
        CLR W0			;;
        MOV W0,W14		;;
        REPEAT #12		;;
        MOV W0,[++W14]		;;
        CLR W14			;;
        RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CLR_ALLREG:			;;
	MOV #START_REG,W1	;;
CLR_ALLREG_1:			;;
	CLR [W1++]		;;
	MOV #END_REG,W0		;;		
	CP W1,W0		;;
	BRA NZ,CLR_ALLREG_1	;;	
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		


	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
POWER_ON:			;;
        MOV #STACK_BUF,W15  	;;Initialize the Stack Pointer Limit Register
        MOV #STACK_BUF+254,W0  	;;Initialize the Stack Pointer Limit Register
        MOV W0,SPLIM		;;
        CALL CLR_WREG 		;;
	CALL CLR_ALLREG		;;
	CALL INIT_RAM		;;
	MOV #100,W0		;;
	CALL DLYX		;;
	CLR SERIAL_ID		;;
	CLR ANSELA		;;
	CLR ANSELB		;;
	CALL INIT_IO		;;

	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #20,W1		;;
WAIT_POWER:			;;
	MOV #500,W0		;;
	CALL DLYX		;;
	DEC W1,W1		;;
	BRA NZ,WAIT_POWER	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
        CALL CLR_WREG 		;;
	CALL INIT_IO		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;	
	CALL INIT_AD		;;
	CALL INIT_SIO		;;
	CALL INIT_OSC		;;

        ;;CALL TEST_OSC

	MOV #10000,W0		;;
	CALL DLYX		;;
        CALL GET_SERIAL_ID              
	;CALL TEST_OSC
	;MOV #PARA0_FSET,W2
	;CALL LF24_F24SET
	;NOP
	;NOP
	;INC PARA0_FSET
	;MOV #PARA0_FSET,W1
	;CALL SAVE_F24WORD
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	NOP
	NOP
	NOP
	CALL INIT_TIMER2	;;
	CALL INIT_TIMER3	;;
	;CALL TEST_TIMER	;;
	CALL INIT_UART1		;;
	CALL INIT_UART2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;


	;CALL TEST_UART		;;
	;CALL TEST_UART_I		;;
	;CALL TEST_FLASH_QPI	;;
	;CALL TEST_FLASH	;;
	;CALL TEST_FLASH_PGM	;;
	;CALL TEST_OLED_A	;;
	;CALL TEST_OLED_G	;;
	;CALL TEST_OLED_H	;;
	;CALL TEST_TFT
	;CALL TEST_IMAGE



	GOTO MAIN		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


GET_SERIAL_ID:
        CLR SERIAL_ID
        BTFSC ADDR_A0_I
        BSET SERIAL_ID,#0
        BTFSC ADDR_A1_I
        BSET SERIAL_ID,#1
        RETURN

	





;66MPS
TEST_OSC:
        BSF P50V_EN_O
        BSF P50V_EN_IO
        BSF P32V_EN_O
        BSF P32V_EN_IO
	MOV #10000,W0		;;
	CALL DLYX		;;
        BCF P50V_EN_O
        BCF P50V_EN_IO
        BCF P32V_EN_O
        BCF P32V_EN_IO
	MOV #10000,W0		;;
	CALL DLYX		;;
        BRA TEST_OSC


        





	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	TG LED_O
	CLRWDT
	BRA TEST_OSC	

;1MS
TEST_TIMER:
	CLRWDT
	BTSS TMR2,#8
	BCF LED_O
	BTSC TMR2,#8
	BSF LED_O
	BRA TEST_TIMER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART:				;;
	BCLR IFS0,#U1TXIF		;;
	BCLR IEC0,#U1TXIE		;;UTXINT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IFS0,#U1RXIF		;;
	BCLR IEC0,#U1RXIE		;;URXINT
	
	MOV #0xAB,W0			;;
	MOV W0,U2TXREG			;;
	;CALL U1TX_RSP			;;
	MOV #10,W0			;;	
	CALL DLYMX			;;
	BRA TEST_UART 			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1TX_END:				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_UART_I:				;;
	CLRWDT
	BRA TEST_UART_IX
			
TEST_UART_IX:
	MOV #0xFFFF,W0			;;	
	CALL DLYX			;;
	MOVLF #0x0123,UTX_CMD
	MOVLF #0x0224,UTX_PARA0
	MOVLF #0x0325,UTX_PARA1
	MOVLF #0x0426,UTX_PARA2
	MOVLF #0x0527,UTX_PARA3
	CALL UTX_STD
	BRA TEST_UART_I		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_AD:				;;
	CLR ANSELA			;;
	CLR ANSELB			;;
	BSET ANSELA,#0			;;
	BSET ANSELA,#1			;;
	BSET ANSELB,#0			;;
	BSET ANSELB,#1			;;
	BSET ANSELB,#2			;;
	BSET ANSELB,#3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x0004,W0			;;AUTO SAMPLE	
	;MOV #0x000C,W0			;;Enable simultaneous sampling and auto-sample
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON1			;;
	;MOV #0x0300,W0			;;4 CHANNEL	
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON2			;;
	MOV #0x800F,W0			;;	
	MOV W0,AD1CON3			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CON4			;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSH                  ;;
	MOV #0x0000,W0			;;	
	MOV W0,AD1CSSL                  ;;
	BSET AD1CON1,#ADON		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS_ONOFF_PRG:                           ;;
	BTFSS T4M_F			;;
        RETURN                          ;;
        BTFSS PS_ON_F                   ;;                
        BRA PS_OFF_PRG                  ;;
PS_ON_PRG:                              ;;
	BSF P50VEN_F                    ;;
        CP0 V32ON_TIM                   ;;
        BRA NZ,$+6                      ;;
        BSF P32VEN_F                    ;;
        RETURN                          ;;
        DEC V32ON_TIM                   ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PS_OFF_PRG:                             ;;
	BCF P32VEN_F                    ;;
        CP0 V50OFF_TIM                  ;;
        BRA NZ,$+6                      ;;
        BCF P50VEN_F                    ;;
        RETURN                          ;;
        DEC V50OFF_TIM                  ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	
TESTPRG:
	BTFSS P50VEN_F
	BRA TTYY
	BCF P50VEN_F
	BCF P32VEN_F
        RETURN
TTYY:
	BSF P50VEN_F
	BSF P32VEN_F
        RETURN

        	
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN:					;;
	BSF U1RX_EN_F			;;
	BSF U2RX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MAIN_LOOP:				;;
	CLRWDT				;;
	BTFSC T128M_F			;;
	TG LED_O

	CALL PS_ONOFF_PRG		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET PS_FLAG,#0 		;;
	BCLR PS_FLAG,#1			;;
	BTFSC PS_FAULT_I		;;
	BSET PS_FLAG,#1			;;
	BCLR PS_FLAG,#2			;;
	BTFSC P50VEN_F                  ;;
	BSET PS_FLAG,#2			;;
	BCLR PS_FLAG,#3			;;
	BTFSC P32VEN_F                  ;;
	BSET PS_FLAG,#3			;;
	BCLR PS_FLAG,#4			;;
	BTFSC PS_ON_F                   ;;
	BSET PS_FLAG,#4			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSC P50VEN_F                  ;;
	BSF P50V_EN_O                   ;;
	BTFSS P50VEN_F                  ;;
	BCF P50V_EN_O                   ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BTFSC P32VEN_F                  ;;
	BSF P32V_EN_O                   ;;
	BTFSS P32VEN_F                  ;;
	BCF P32V_EN_O                   ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BTFSS SSPA_ON_F                 ;;
        BCF SSPA_EN_O                   ;;
        BTFSC SSPA_ON_F                 ;;
        BSF SSPA_EN_O                   ;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CALL TMR2PRG			;;	
	CALL TMR3PRG			;;	
	CALL TIMEACT_PRG		;;
	CALL CHK_U1RX			;;
	CALL CHK_U2RX			;;
	CALL CONVERT_AD			;;
	CALL CHK_U2TX_END		;;        
	CALL DELAY_ACT_PRG              ;;
	BRA MAIN_LOOP			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	














CHK_LDU1TX:
	RETURN
CHK_LDU2TX:
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OTHPRG:					;;
	BTSC U2STA,#OERR		;;
	BCLR U2STA,#OERR		;;
	BTSC U1STA,#OERR		;;
	BCLR U1STA,#OERR		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;66MIPS
; 0=4uS
; 1=8uS
; 2=16uS
; 3=31uS
; 4=62.5uS
; 5=125uS
; 6=250uS
; 7=500US
; 8=1MS
; 9=2 
;10=4
;11=8
;12=16
;13=32
;14=64
;15=128


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR2PRG:				;;
	CLR TMR2_FLAG			;;	
	MOV TMR2,W0			;;
	XOR TMR2_BUF,WREG		;;	
	BTSC SR,#Z			;;
	RETURN				;;
	MOV W0,TMR2_FLAG		;;	
	IOR TMR2_IORF			;;
	XOR TMR2_BUF			;;
	CLRWDT				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TMR3PRG:				;;
	CLR TMR3_FLAG			;;	
	MOV TMR3,W0			;;
	XOR TMR3_BUF,WREG		;;	
	BTSC SR,#Z			;;
	RETURN				;;
	MOV W0,TMR3_FLAG		;;	
	IOR TMR3_IORF			;;
	XOR TMR3_BUF			;;
	CLRWDT				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TIMEACT_PRG:				;;
	BTFSS T4M_F			;;
	RETURN				;;
	INC SHIFT_TIME
	MOV #8,W0
	CP SHIFT_TIME
	BRA LTU,$+4
	CLR SHIFT_TIME
	MOV SHIFT_TIME,W0
	BRA W0
	BRA TIME_J0
	BRA TIME_J1
	BRA TIME_J2
	BRA TIME_J3
	BRA TIME_J4
	BRA TIME_J5
	BRA TIME_J6
	BRA TIME_J7
TIME_J0:
	INC EMU_UARTTX_TIM
	MOV #3,W0
	CP EMU_UARTTX_TIM
	BRA GEU,$+4
	RETURN 
	CLR EMU_UARTTX_TIM
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCF U1U2_F			;;
	CLR UTX_BTX			;;
	MOV #U1TX_BUF,W1		;;
	MOV #0xAA,W0			;;10
	CALL LOAD_UBYTE_A		;;
	MOV #0x55,W0			;;9
	CALL LOAD_UBYTE_A		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x01,W0			;;8
	CALL LOAD_UBYTE_A		;;
	MOV #0x03,W0			;;7
	CALL LOAD_UBYTE_A		;;
	MOV #0x92,W0			;;6
	CALL LOAD_UBYTE_A		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x02,W0			;;5
	CALL LOAD_UBYTE_A		;;
	MOV #0x25,W0			;;25 DU
	CALL LOAD_UBYTE_A		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x03,W0			;;3
	CALL LOAD_UBYTE_A		;;
	MOV #0x01,W0			;;2
	CALL LOAD_UBYTE_A		;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x55,W0			;;1
	CALL LOAD_UBYTE_A		;;
	MOV #0xAA,W0			;;0
	CALL LOAD_UBYTE_A		;;
	CALL U1TX_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN
TIME_J1:
        INC SSPA_CONNECT_CNT
        MOV #60,W0
        CP SSPA_CONNECT_CNT
        BRA LTU,$+4
 	BCLR SSPA_FLAG,#0		;;
        RETURN
TIME_J2:
	RETURN
TIME_J3:
	RETURN
TIME_J4:
	RETURN
TIME_J5:
	RETURN
TIME_J6:
	RETURN
TIME_J7:
	RETURN


CMD_NONE_PRG:
	RETURN




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER1:				;;
        CLR TMR1                        ;;
	MOV #0xA030,W0			;;0.13US
	MOV W0,T1CON			;;
        MOV #100,W0                    	;;
        MOV W0,PR1                      ;;
        BCLR IFS0,#3			;;
        BSET IEC0,#3                    ;;  	          
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER3:				;;
	MOV #0xA030,W0			;;0.13US
	MOV W0,T3CON			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_TIMER2:				;;
	MOV #0xA030,W0			;;/256
	MOV W0,T2CON			;;BASE TIME
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_SIO:			;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BCLR OSCCON,#6		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR18		;;
	MOV #36,W0		;;RP36 U1RX
	IOR RPINR18		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR0		;;
	MOV #0x0001,W0		;;RP20 U1TX
	IOR RPOR0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #42,W0		;;RP42 U2RX
	IOR RPINR19		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x00FF,W0		;;
	AND RPOR4		;;
	MOV #0x0300,W0		;;RP43 U2TX
	IOR RPOR4		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	/*
	MOV #0xFF00,W0		;;
	AND RPINR18		;;
	MOV #37,W0		;;RP40 U1RX
	IOR RPINR18		;;LSB:U1RX
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR2		;;
	MOV #0x0001,W0		;;RP39 U1TX
	IOR RPOR2		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPINR19		;;
	MOV #97,W0		;;RP119 U2RX PITX
	IOR RPINR19		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFF00,W0		;;
	AND RPOR4		;;
	MOV #0x0003,W0		;;RP39 U2TX
	IOR RPOR4		;;
	*/

	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xFF00,W0		;;
	;AND RPINR22		;;
	;MOV #47,W0		;;
	;IOR RPINR22		;;SPI2 DI 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0x00FF,W0		;;
	;AND RPOR8		;;
	;MOV #0x08,W0		;;
	;SWAP W0		;;
	;IOR RPOR8		;;SPI2 DO 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #0xFF00,W0		;;
	;AND RPOR9		;;
	;MOV #0x09,W0		;;
	;IOR RPOR9		;;SPI2 CLK 
	;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #58,W0		;;
;	SWAP W0			;;	
;	MOV W0,RPINR0		;;INT1
;	MOV #119,W0		;;
;	MOV.B WREG,RPINR1	;;INT2
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #0xFF00,W0		;;
;	AND RPOR5		;;
;	MOV #0x0031,W0		;;REFCLKO
;	IOR RPOR5		;;RP54
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #55,W0		;;IC1 RP97
;	MOV.B WREG,RPINR7	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV RPINR7,W0		;;IC2 RPI120 LCDRS0
;	AND #255,W0		;;
;	SWAP W0			;;
;	ADD #120,W0		;;
;	SWAP W0			;;
;	MOV W0,RPINR7		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
;	MOV #118,W0		;;IC3 118 LCDRS1
;	MOV.B WREG,RPINR8	;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1		;;
	MOV #0x46,W2		;;
	MOV #0x57,W3		;;
	MOV.B W2,[W1] 		;;
	MOV.B W3,[W1]		;;
	BSET OSCCON,#6		;;
	RETURN			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;FCY=50mHZ
;FCY=66mHZ
;UXBRG=FCY/(4*BOUDRATE) -1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART1:				;;
	MOV #1709,W0	;9600		;;66MHZ
	;MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	;MOV #35,W0	;460800		;;66MHZ
	MOV W0,U1BRG			;;
	;MOV #0x8008,W0			;;NONE PARITY
	MOV #0x800A,W0			;;EVEN PARITY
	;MOV #0x800C,W0			;;ODD PARITY
	MOV W0,U1MODE			;;
	MOV #0x0400,W0			;;
	MOV W0,U1STA 			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC3,#2 			;;
	BSET IPC3,#1 			;;
	BSET IPC3,#0 			;;
	BCLR IFS0,#U1TXIF		;;
	BSET IEC0,#U1TXIE		;;UTXINT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	MOV U1RXREG,W0			;;
	BCLR IFS0,#U1RXIF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC2,#14 			;;
	BSET IPC2,#13 			;;
	BSET IPC2,#12 			;;
	BCLR IFS0,#U1RXIF		;;
	BSET IEC0,#U1RXIE		;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_UART2:				;;
	;MOV #142,W0	;115200		;;66MHZ
	;MOV #65,W0	;256000		;;66MHZ
	;MOV #47,W0	;345600		;;66MHZ
	MOV #35,W0	;460800		;;66MHZ
	MOV W0,U2BRG			;;
	MOV #0x8008,W0			;;NONE PARITY
	;MOV #0x800A,W0			;;EVEN PARITY
	;MOV #0x800C,W0			;;ODD PARITY
	MOV W0,U2MODE			;;
	MOV #0x0400,W0			;;
	MOV W0,U2STA 			;;
	BSET CNPUB,#6
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC7,#14 			;;
	BSET IPC7,#13 			;;
	BSET IPC7,#12 			;;
	BCLR IFS1,#U2TXIF		;;
	BSET IEC1,#U2TXIE		;;UTXINT
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	MOV U2RXREG,W0			;;
	BCLR IFS1,#U2RXIF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BCLR IPC7,#10 			;;
	BSET IPC7,#9 			;;
	BSET IPC7,#8 			;;
	BCLR IFS1,#U2RXIF		;;
	BSET IEC1,#U2RXIE		;;URXINT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_H:					;;
OSC_FRCPLL:				;;
	MOV #1,W0			;;FRCPLL
	BRA OSC_PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
OSC_M:					;;
OSC_FRC:				;;
	MOV #7,W0			;;FRC
	BRA OSC_PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_L:					;;
	MOV #7,W0			;;FRC
	BRA OSC_PRG			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
OSC_PRG:				;;
	MOV #OSCCONH,W1			;;
	MOV #0x78,W2			;;
	MOV #0x9A,W3			;;
	DISI #3				;;
	MOV.B W2,[W1]			;;
	MOV.B W3,[W1]			;;	
	MOV.B WREG,OSCCONH		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #OSCCON,W1			;;
	MOV #0x46,W2			;;
	MOV #0x57,W3			;;
	DISI #3				;;
	MOV.B W2,[W1]			;;
	MOV.B W3,[W1]			;;
	BSET OSCCON,#0			;;
OSC_PRG_1:				;;
	CLRWDT				;;
	BTSC OSCCON,#0			;;
	BRA OSC_PRG_1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_OSC:				;;
	CLR CLKDIV			;;
	MOV #48,W0			;;X*(48+2)/4=50MIPS
;	MOV #64,W0			;;X*(64+2)/4=66MIPS
	MOV #69,W0			;;X*(69+2)/3.685=66MIPS
	MOV W0,PLLFBD			;;PLLDIV
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;BIT40:PLL PREDIV=X+2	MUST BE 1-8MHZ
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT76:PLL POSTDIV=00=2,01=4,10=NO USE 11=8
	IOR CLKDIV			;;
	MOV #0x0000,W0			;;BIT10-8=FRCDIV OSC=7.37MHZ
	IOR CLKDIV			;;
	NOP
	NOP
	NOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10000,W0			;;
	CALL DLYX			;;
	NOP
	NOP
	NOP
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOV #7,W0			;;7=Fast RC Oscillator (FRC) with Divide-by-n
	;MOV #6,W0			;;6=Fast RC Oscillator (FRC) with Divide-by-16
	;MOV #5,W0			;;5=Low-Power RC Oscillator (LPRC)
	;MOV #3,W0			;;3=XT,HS,EC WITH PLL
	;MOV #2,W0			;;2=XT,HS,EC
	MOV #1,W0			;;1=FRCPLL
	;MOV #0,W0			;;0=FRC
	CALL OSC_PRG			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0			;;MAX 31
	;NEG W0,W0
	MOV W0,OSCTUN 			;;
	;MOV #0x8800,W0			;;/256 512K REFCLKO
	;MOV #0x8600,W0			;;/64  2.048 REFCLKO
	;MOV W0,REFOCON 			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEST_U1TX:				;;
	CLRWDT				;;
	MOV #0xAB,W0			;;
	MOV W0,U1TXREG			;;
	MOV #10000,W0			;;
	CALL DLYX			;;
	BRA TEST_U1TX			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_RAM:				;;
	SETM CONVAD_CNT
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
INIT_IO:				;;
	;;PIN1 				;;
	BSF V50V_ADI_IO			;;
	;;PIN2 				;;
	BSF T32V_ADI_IO			;;
	;;PIN3 				;;
	BSF I32V_ADI_IO			;;
	;;PIN4 				;;
	BSF V32V_ADI_IO			;;
	;;PIN5 				;;
	;;PIN6 				;;
	BSF ADDR_A0_IO			;;
	;;PIN7 				;;
	BSF ADDR_A1_IO			;;
	;;PIN8	 			;;
	BSF RS422_RX_IO			;;
	;;PIN9	 			;;
	BCF RS422_TX_O			;;
	BSF RS422_TX_IO			;;
	;;PIN11	 			;;PGD
	;;PIN12	 			;;PGC
	;;PIN13	 			;;
	BCF P50V_EN_O	        	;;
	BCF P50V_EN_IO	        	;;
	;;PIN14 			;;
	BSF PS_FAULT_IO 		;;
	;;PIN15 			;;
	BCF RS485_DE_O			;;
	BCF RS485_DE_IO			;;
	;;PIN18 			;;
	BSF RS485_RO_IO			;;
	;;PIN19 			;;
	BSF RS485_DI_O			;;
	BCF RS485_DI_IO			;;
	;;PIN20 			;;
	BCF P32V_EN_O	        	;;
	BCF P32V_EN_IO	        	;;
	;;PIN21 			;;
	BCF SSPA_EN_O	        	;;
	BCF SSPA_EN_IO	        	;;
	;;PIN22 			;;
	BCF IOOUT_EN_O	        	;;
	BCF IOOUT_EN_IO	        	;;
	;;PIN23 			;;
	BCF LED_O			;;
	BCF LED_IO			;;
	;;PIN27 			;;
	BSF I50V_ADI_IO			;;
	;;PIN23 			;;
	BSF T50V_ADI_IO			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;























	











	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX:				;;
	BTFSC U1RX_PACKA_F		;;	
	BRA CHK_U1RX_A			;;
	BTFSC U1RX_PACKB_F		;;	
	BRA CHK_U1RX_B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX_A:				;;
	BCF U1RX_PACKA_F		;;
	MOV U1RXA_LEN,W0		;;
	MOV W0,U1RX_LEN			;;
	MOV #U1RX_BUFA,W1		;;
	BRA CHK_U1RX_1			;;
CHK_U1RX_B:				;;
	BCF U1RX_PACKB_F		;;			
	MOV U1RXB_LEN,W0		;;
	MOV W0,U1RX_LEN			;;
	MOV #U1RX_BUFB,W1		;;
	BRA CHK_U1RX_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U1RX_1:				;;
	MOV W1,RX_ADDR			;;
	MOV [W1++],W0			;;
	MOV W0,TMP0			;;
	MOV [W1++],W0			;;
	MOV W0,TMP1			;;
	MOV [W1++],W0			;;	
	MOV W0,TMP2			;;
	MOV [W1++],W0			;;
	MOV W0,TMP3			;;
	MOV [W1++],W0			;;
	MOV W0,TMP4			;;
	MOV [W1++],W0			;;
	MOV W0,TMP5			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TMP0,W0			;;
	AND #255,W0			;;
	CP W0,#0x01			;;
	BRA Z,$+4			;;
	RETURN	                        ;;
	MOV TMP1,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	CP W0,#0x02			;;
	BRA Z,$+4			;;
	RETURN				;;
	MOV TMP2,W0			;;
	SWAP W0				;;
	AND #255,W0			;;
	CP W0,#0x03			;;
	BRA Z,$+4			;;
	RETURN				;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        MOV TMP0,W0
        SWAP W0 			;;
        AND #255,W0
        MOV W0,R0                       ;;
        MOV #100,W0                     ;;
        MUL R0                          ;;
        MOV W2,SSPA_RFOP                ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TMP1,W0			;;
        SWAP.B W0                       ;;                
        AND #15,W0                      ;;
        MOV W0,R0                       ;;
        MOV #10,W0                      ;;
        MUL R0                          ;;
        MOV W2,W0                       ;;
        ADD SSPA_RFOP                   ;;
	MOV TMP1,W0			;;
        AND #15,W0                      ;;
        ADD SSPA_RFOP                   ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TMP2,W0			;;
        SWAP.B W0                       ;;                
        AND #15,W0                      ;;
        MOV W0,R0                       ;;
        MOV #10,W0                      ;;
        MUL R0                          ;;
        MOV W2,SSPA_TEMP                ;;
	MOV TMP2,W0			;;
        AND #15,W0                      ;;
        ADD SSPA_TEMP                   ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        BCLR SSPA_FLAG,#3		;;              
        BTSC TMP3,#0                    ;;OVER DUTY
        BSET SSPA_FLAG,#3		;;              
        BCLR SSPA_FLAG,#4		;;              
        BTSC TMP3,#1                    ;;OVER PULSE WIDTH
        BSET SSPA_FLAG,#4		;;              
        BCLR SSPA_FLAG,#5	        ;;              
        BTSC TMP3,#2                    ;;OVER TEMPERATURE
        BSET SSPA_FLAG,#5	        ;;              
        BCLR SSPA_FLAG,#6	        ;;              
        BTSC TMP3,#3                    ;;OVER REFLECT
        BSET SSPA_FLAG,#6	        ;;              
	BSET SSPA_FLAG,#0		;;
        CLR SSPA_CONNECT_CNT            ;;

	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX:				;;
	BTFSC U2RX_PACKA_F		;;	
	BRA CHK_U2RX_A			;;
	BTFSC U2RX_PACKB_F		;;	
	BRA CHK_U2RX_B			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX_A:				;;
	BCF U2RX_PACKA_F		;;
	MOV U2RXA_LEN,W0		;;
	MOV W0,U2RX_LEN			;;
	MOV #U2RX_BUFA,W1		;;
	BRA CHK_U2RX_1			;;
CHK_U2RX_B:				;;
	BCF U2RX_PACKB_F		;;			
	MOV U2RXB_LEN,W0		;;
	MOV W0,U2RX_LEN			;;
	MOV #U2RX_BUFB,W1		;;
	BRA CHK_U2RX_1			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2RX_1:				;;
	MOV W1,RX_ADDR			;;
	MOV [W1++],W0			;;
        MOV W0,RX_DEVICE_ID             ;;        
	MOV #DEVICE_ID_K,W2		;;
	CP W0,W2			;;
	BRA Z,CHK_U2RX_2		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U2RX_2		;;
	RETURN				;;
CHK_U2RX_2:				;;
	MOV [W1++],W0			;;
        MOV W0,RX_SERIAL_ID             ;;        
	MOV SERIAL_ID,W2		;;
	CP W0,W2			;;
	BRA Z,CHK_U2RX_3		;;
	MOV #0xFFFF,W2			;;
	CP W0,W2			;;
	BRA Z,CHK_U2RX_3		;;
	RETURN				;;
CHK_U2RX_3:				;;
	MOV [W1++],W0			;;
	MOV W0,RX_GROUP_ID		;;
        MOV #0XAB00,W0                  ;;
        CP RX_GROUP_ID                  ;;
        BRA Z,$+4                       ;;
        RETURN                          ;;        
	MOV [W1++],W0			;;
	MOV W0,RX_LEN			;;
	MOV [W1++],W0			;;
	MOV W0,RX_CMD			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA0		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA1		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA2		;;
	MOV [W1++],W0			;;
	MOV W0,URX_PARA3		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_CMD,W0			;;	
	SWAP W0				;;
	AND #255,W0			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CP W0,#0x00			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_SYSTEM_ACT		;;
	CP W0,#0x10			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_GETINF_ACT		;;
	CP W0,#0x20			;;
	BRA NZ,$+6			;;
	GOTO URXDEC_CMD_ACT		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DELAY_ACT_PRG:			;;
        MOV TMR2,W0                     ;;
        SUB DELAY_ACT_TIM,WREG         ;;
        BTSS W0,#15                     ;;
        RETURN                          ;;  
	MOV DELAY_ACT,W0		;;
        CLR DELAY_ACT                   ;;
	AND #3,W0			;;
	BRA W0				;;
	BRA DELAY_ACT_J0                ;;//RETURN SLOT INF	BRA DELAY_ACT_J1                ;;
	BRA DELAY_ACT_J1                ;;
	BRA DELAY_ACT_J2                ;;
DELAY_ACT_J0:
	RETURN
DELAY_ACT_J1:
        MOV #DEVICE_ID_K,W0             ;;
	MOV W0,TX_DEVICE_ID
        MOV SERIAL_ID,W0
	MOV W0,TX_SERIAL_ID
        MOV #0xAC00,W0
	MOV W0,TX_GROUP_ID
	MOV #0x1000,W0
	MOV W0,UTX_CMD
	MOV #0x0000,W0
	MOV W0,UTX_PARA0
	MOV #0x0000,W0
	MOV W0,UTX_PARA1
	MOV #0x0000,W0
	MOV W0,UTX_PARA2
	MOV #0x000A,W0
	MOV W0,UTX_PARA3
	;=================================<<DEBUG

        /*
	MOVLF #0x023F,SSPA_RFOP 
	MOVLF #0x0018,SSPA_TEMP
	MOVLF #0x800F,SSPA_FLAG
	MOVLF #0X0260,V50VADI
	MOVLF #0X0000,I50VADI
	MOVLF #0X0000,T50VADI
	MOVLF #0X0260,V32VADI
	MOVLF #0X0000,I32VADI
	MOVLF #0X0000,T32VADI
	MOVLF #0X8000,PS_FLAG
        */

	;=================================
	MOV #UTX_BUF,W3			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV PS_FLAG,W0			;;
	MOV W0,[W3++]			;;
	MOV V50VADI,W0			;;
	MOV W0,[W3++]			;;
	MOV I50VADI,W0			;;
	MOV W0,[W3++]			;;
	MOV T50VADI,W0			;;
	MOV W0,[W3++]			;;
	MOV V32VADI,W0			;;
	MOV W0,[W3++]			;;
	MOV I32VADI,W0			;;
	MOV W0,[W3++]			;;
	MOV T32VADI,W0			;;
	MOV W0,[W3++]			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV SSPA_FLAG,W0		;;
	MOV W0,[W3++]			;;
	MOV SSPA_RFOP,W0		;;
	MOV W0,[W3++]			;;
	MOV SSPA_TEMP,W0		;;
	MOV W0,[W3++]			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #UTX_BUF,W0			;;
	SUB W3,W0,W0			;;
	LSR W0,#1,W0			;;
	MOV W0,UTX_BUFFER_LEN		;;
	BSF U1U2_F			;;
	MOV #UTX_BUF,W3			;;
	CALL UTX_STD			;;        
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



DELAY_ACT_J2:
	RETURN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_GETINF_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #0XFF,W0			;;
        CP W0,#1                        ;;
        BRA LTU,$+4                     ;;
        RETURN                          ;;
	BRA W0				;;
	BRA URXDEC_GETINF_J0		;;0X1000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_GETINF_J0:			;;
        MOV #10,W0                      ;;
        ADD TMR2,WREG                   ;;
        MOV W0,DELAY_ACT_TIM            ;;
        MOVLF #1,DELAY_ACT              ;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_ACT:			        ;;
	MOV RX_CMD,W0			;;
	AND #0XFF,W0			;;
        CP W0,#8                        ;;
        BRA LTU,$+4                     ;;
        RETURN                          ;;
	BRA W0				;;
	BRA URXDEC_CMD_J0		;;
	BRA URXDEC_CMD_J1		;;
	BRA URXDEC_CMD_J2		;;
	BRA URXDEC_CMD_J3		;;
	BRA URXDEC_CMD_J4		;;
	BRA URXDEC_CMD_J5		;;
	BRA URXDEC_CMD_J6		;;
	BRA URXDEC_CMD_J7		;;
URXDEC_CMD_J0:          		;;
SSPA_POWER_ON:                          ;;
        MOV #1,W2                       ;;
        MOV SERIAL_ID,W0                ;;        
        SL W2,W0,W0                     ;;
        AND URX_PARA0                   ;;
        BRA NZ,$+4                      ;;
        RETURN                          ;;
        BSF PS_ON_F                     ;;
        MOV #25,W0                      ;;
        MUL URX_PARA3                   ;;
        MOV W2,V32ON_TIM                ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_J1:		                ;;      
SSPA_POWER_OFF:                         ;;
        MOV #1,W2                       ;;
        MOV SERIAL_ID,W0                ;;        
        SL W2,W0,W0                     ;;
        AND URX_PARA0                   ;;
        BRA NZ,$+4                      ;;
        RETURN                          ;;
        BCF PS_ON_F                     ;;
        MOV #25,W0                      ;;
        MUL URX_PARA3                   ;;
        MOV W2,V50OFF_TIM               ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_CMD_J2:		                ;;
SSPA_MODULE_ON:                          ;;
        MOV #1,W2                       ;;
        MOV SERIAL_ID,W0                ;;        
        SL W2,W0,W0                     ;;
        AND URX_PARA0                   ;;
        BRA NZ,$+4                      ;;
        RETURN                          ;;
        BSF SSPA_ON_F                   ;;
        BSET SSPA_FLAG,#1		;;              
        RETURN                          ;;
URXDEC_CMD_J3:		                ;;
SSPA_MODULE_OFF:                        ;;
        MOV #1,W2                       ;;
        MOV SERIAL_ID,W0                ;;        
        SL W2,W0,W0                     ;;
        AND URX_PARA0                   ;;
        BRA NZ,$+4                      ;;
        RETURN                          ;;
        BCF SSPA_ON_F                   ;;
        BCLR SSPA_FLAG,#1		;;              
        RETURN                          ;;
URXDEC_CMD_J4:		                ;;
LOCAL_PULSE_ON:                         ;;
        RETURN                          ;;
URXDEC_CMD_J5:		                ;;
LOCAL_PULSE_OFF:                        ;;
        RETURN                          ;;
URXDEC_CMD_J6:	                        ;;
EMERGENCY_ON:                           ;;
        BCF SSPA_ON_F                   ;;
        BCLR SSPA_FLAG,#1		;;              
        BCF PS_ON_F                     ;;
	BCLR PS_FLAG,#4			;;
        RETURN
URXDEC_CMD_J7:		                ;;
EMERGENCY_OFF:                          ;;
        RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_SYSTEM_ACT:			;;
	MOV RX_CMD,W0			;;
	AND #15,W0			;;
	BRA W0				;;
	BRA URXDEC_I_HAVE_REC		;;0
	BRA URXDEC_I_AM_BUZY		;;1
	BRA URXDEC_I_AM_ERR		;;2
	BRA URXDEC_I_AM_DONE		;;3
	BRA URXDEC_YOU_NEXT		;;4
	BRA URXDEC_YOU_WAIT		;;5
	BRA URXDEC_YOU_STOPALL		;;6
	BRA URXDEC_RXDATA_ERR		;;7
	BRA URXDEC_RESERVE		;;8
	BRA URXDEC_RESERVE		;;9
	BRA URXDEC_RESERVE		;;10
	BRA URXDEC_RESERVE		;;11
	BRA URXDEC_RESERVE		;;12
	BRA URXDEC_TEST_TXPACK		;;13
	BRA URXDEC_NODATA_TO_TX		;;14
	BRA URXDEC_TXDATA_OVERFLOW	;;15
URXDEC_RESERVE:				;;
URXDEC_RXDATA_ERR:
URXDEC_TXDATA_OVERFLOW:			;;
	RETURN				;;
URXDEC_NODATA_TO_TX:			;;
	RETURN				;;
URXDEC_I_HAVE_REC:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_I_AM_BUZY:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_I_AM_ERR:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_I_AM_DONE:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_YOU_NEXT:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_YOU_WAIT:			;;
	RETURN				;;
URXDEC_YOU_STOPALL:			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TEST_TXPACK:			;;
	DEC RX_LEN			;;
	DEC RX_LEN			;;
	CLR W3				;;
URXDEC_TEST_TXPACK_1:			;;	
	MOV [W1++],W4			;;	
	XOR W4,W3,W0			;;
	AND #255,W0			;;	
	BRA NZ,URXDEC_TEST_TXPACK_2	;;
	INC W3,W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	SWAP W4				;;
	XOR W4,W3,W0			;;
	AND #255,W0			;;
	BRA NZ,URXDEC_TEST_TXPACK_2	;;
	INC W3,W3			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV RX_LEN,W0			;;
	CP W3,W0			;;
	BRA LTU,URXDEC_TEST_TXPACK_1	;;
	CALL UTX_I_HAVE_REC		;;				
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
URXDEC_TEST_TXPACK_2:			;;
	CALL UTX_RXDATA_ERR		;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_W1_BYTE:				;;
	BTSC W1,#0			;;
	BRA LOAD_W1_BYTE_1		;;
	MOV [W1],W0			;;
	AND #255,W0			;;	
	INC W1,W1			;;
	RETURN				;;
LOAD_W1_BYTE_1:				;;
	BCLR W1,#0			;;
	MOV [W1],W0			;;	
	SWAP W0				;;
	AND #255,W0			;;	
	INC2 W1,W1			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_W1_WORD:				;;
	PUSH W2				;;
	CALL LOAD_W1_BYTE		;;	
	MOV W0,W2			;;
	CALL LOAD_W1_BYTE		;;
	SWAP W0				;;
	IOR W0,W2,W0			;;
	POP W2				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	










	








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RESP:				;;
	MOV PRE_RX_CMD,W0		;;
	BSET W0,#15			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RECOK:				;;
	MOV RX_CMD,W0			;;
	BSET RX_CMD,#15			;;
	MOV W0,UTX_CMD			;;
	CLR UTX_PARA0			;;
	CLR UTX_PARA1			;;
	CLR UTX_PARA2			;;
	CLR UTX_PARA3			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_HAVE_REC:				;;
	MOV #0x0000,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_BUZY:				;;
	MOV #0x0001,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_ERR:				;;
	MOV #0x0002,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_I_AM_DONE:				;;
	MOV #0x0003,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_YOU_NEXT:				;;
	MOV #0x0004,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_YOU_WAIT:				;;
	MOV #0x0005,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
UTX_YOU_STOPALL:			;;
	MOV #0x0006,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_RXDATA_ERR:				;;
	MOV #0x0007,W0			;;
	MOV W0,UTX_CMD			;;
	BRA UTX_STD			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_STD:				;;
	CALL UTX_START			;;
	MOV TX_DEVICE_ID,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TX_SERIAL_ID,W0		;;SERIAL ID
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV TX_GROUP_ID,W0		;;GROUP_ID
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #10,W0			;;LEN LOW BYTE
	ADD UTX_BUFFER_LEN,WREG		;;	
	ADD UTX_BUFFER_LEN,WREG		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_CMD,W0			;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA0,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA1,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA2,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV UTX_PARA3,W0		;;
	CALL LOAD_UTX_WORD		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_BUFFER:				;;
	CP0 UTX_BUFFER_LEN		;;
	BRA Z,UTX_BUFFER_END		;;
	MOV [W3++],W0			;;
	CALL LOAD_UTX_WORD		;;
	DEC UTX_BUFFER_LEN		;;
	BRA UTX_BUFFER			;;
UTX_BUFFER_END:				;;
	CALL UTX_END			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_START:				;;
	BTFSS U1U2_F			;;
	BCF U1TX_EN_F			;;
	BTFSC U1U2_F			;;
	BCF U2TX_EN_F			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	CLR UTX_BTX			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;;
	MOV W0,UTX_CHKSUM0		;;
	CLR UTX_CHKSUM1			;;
	BTFSS U1U2_F			;;
	MOV #U1TX_BUF,W1		;;
	BTFSC U1U2_F			;;
	MOV #U2TX_BUF,W1		;;
	MOV #0xEA,W0			;;
	CALL LOAD_UBYTE_A		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UTX_BYTE:				;;
	XOR UTX_CHKSUM0			;;
	ADD UTX_CHKSUM1			;;
	CALL LOAD_UBYTE_B		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UTX_WORD:				;;
	PUSH W0				;;
	CALL LOAD_UTX_BYTE		;;
	POP W0				;;
	SWAP W0				;;
	CALL LOAD_UTX_BYTE		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UTX_END:				;;
	MOV UTX_CHKSUM0,W0		;;
	CALL LOAD_UBYTE_B		;;
	MOV UTX_CHKSUM1,W0		;;
	CALL LOAD_UBYTE_B		;;
	MOV #0xEB,W0			;;
	CALL LOAD_UBYTE_A		;;
	;MOV #0xFF,W0			;;
	;CALL LOAD_UBYTE_A		;;
	BTFSC U1U2_F			;;
	BRA U2TX_END			;;
U1TX_END:				;;
	MOVFF UTX_BTX,U1TX_BTX		;;
	CLR U1TX_BCNT			;;
	BSF U1TX_EN_F			;;
	BCF U1TX_END_F			;;
	BSET IFS0,#U1TXIF		;;
	RETURN				;;
U2TX_END:				;;
	MOVFF UTX_BTX,U2TX_BTX		;;
	CLR U2TX_BCNT			;;
	BSF U2TX_EN_F			;;
        BCF U2RX_EN_F                   ;;        
	BCF U2TX_END_F			;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSF RS485_DE_O	        	;;
        BSF U2TXON_F                    ;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	BSET IFS1,#U2TXIF		;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CHK_U2TX_END:                           ;;
	BTFSS U2TX_END_F                ;;        
	RETURN                          ;;
	BTSS U2STA,#8                   ;;
	RETURN                          ;;
	BCF U2TX_END_F                  ;;
	BCF RS485_DE_O                  ;;
        BCF U2TXON_F                    ;;
        BSF U2RX_EN_F                   ;;        
	RETURN                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UBYTE_A:				;;
	AND #255,W0			;;
	BTSC UTX_BTX,#0			;;
	BRA LOAD_UBYTE_A1		;;
	MOV W0,[W1]			;;
	INC UTX_BTX			;;
	RETURN				;;
LOAD_UBYTE_A1:				;;
	SWAP W0				;;
	ADD W0,[W1],[W1]		;;
	INC2 W1,W1			;;
	INC UTX_BTX			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UBYTE_B:				;;
	PUSH W2				;;
	AND #255,W0			;;
	MOV #0xEA,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_UBYTE_B1		;;	
	MOV #0xEB,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_UBYTE_B1		;;	
	MOV #0xEC,W2			;;
	CP W0,W2			;;
	BRA Z,LOAD_UBYTE_B1		;;
	POP W2				;;
	BRA LOAD_UBYTE_A		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOAD_UBYTE_B1:				;;
	PUSH W0				;;
	MOV #0xEC,W0			;;
	CALL LOAD_UBYTE_A		;;
	MOV #0xAB,W2			;;
	POP W0				;;
	XOR W2,W0,W0			;;
	CALL LOAD_UBYTE_A		;;
	POP W2				;;	
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANS:				;;
	BTSC W0,#3			;;
	BRA BIT_TRANS_1			;;
BIT_TRANS_0:				;;
	AND #7,W0			;;
	BRA W0 				;;
	RETLW #0x0001,W0		;;
	RETLW #0x0002,W0		;;	
	RETLW #0x0004,W0		;;
	RETLW #0x0008,W0		;;
	RETLW #0x0010,W0		;;
	RETLW #0x0020,W0		;;
	RETLW #0x0040,W0		;;
	RETLW #0x0080,W0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANS_1:				;;
        CALL BIT_TRANS_0		;;
	SWAP W0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANSO:				;;
	BTSC W0,#3			;;
	BRA BIT_TRANS_1			;;
BIT_TRANSO_0:				;;
	AND #7,W0			;;
	BRA W0 				;;
	RETLW #0x0080,W0		;;
	RETLW #0x0040,W0		;;
	RETLW #0x0020,W0		;;
	RETLW #0x0010,W0		;;	
	RETLW #0x0008,W0		;;
	RETLW #0x0004,W0		;;
	RETLW #0x0002,W0		;;
	RETLW #0x0001,W0		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BIT_TRANSO_1:				;;
	CALL BIT_TRANSO_0		;;
	SWAP W0				;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__INT1Interrupt:			;;
	PUSH SR				;;
	PUSH W0				;;
	BCLR IFS1,#INT1IF		;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__INT2Interrupt:			;;
	BCLR IFS1,#INT1IF		;;	 
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#U1RXIF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U1RXREG,W1			;;
	AND #255,W1			;;
	MOV U1RXI_BUF,W0		;;
	AND #255,W0			;;	
	SWAP W0				;;
	IOR W0,W1,W0			;;
	MOV W0,U1RXI_BUF		;;
	MOV #0xAA55,W0			;;
	CP U1RXI_BUF			;;
	BRA NZ,U1RXI_CON		;;
	BSF U1RX_START_F		;;		
	CLR U1RX_BYTE_PTR		;;
	BRA U1RXI_END			;;
U1RXI_CON:				;;
	BTFSS U1RX_START_F		;;
	BRA U1RXI_END			;;
	MOV #U1RX_BUFA,W0		;;
	BTFSC U1RX_BUFAB_F		;;
	MOV #U1RX_BUFB,W0		;;
	ADD U1RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U1RX_BYTE_PTR,#0		;;
	BRA U1RXI_1			;;
	MOV W1,[W0]			;;
	BRA U1RXI_2			;;
U1RXI_1:				;;
	SWAP W1				;;
	ADD W1,[W0],[W0]		;;
	SWAP W1				;;
U1RXI_2:				;;
	INC U1RX_BYTE_PTR		;;
	MOV #9,W0
	CP U1RX_BYTE_PTR
	BRA LTU,U1RXI_END
	BCF U1RX_START_F		
	MOV #0x55AA,W0			;;
	CP U1RXI_BUF			;;
	BRA NZ,U1RXI_END		;;
	MOV U2RX_BYTE_PTR,W0		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	BTFSS U1RX_BUFAB_F		;;	
	MOV W0,U1RXA_LEN		;;
	BTFSC U1RX_BUFAB_F		;;	
	MOV W0,U1RXB_LEN		;;
	BTFSS U1RX_BUFAB_F		;;	
	BSF U1RX_PACKA_F		;;
	BTFSC U1RX_BUFAB_F		;;	
	BSF U1RX_PACKB_F		;;
	TG U1RX_BUFAB_F			;;	
U1RXI_END:				;;	
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2RXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2RXIF		;;
	MOV U2RXREG,W1			;;
	AND #255,W1			;;
	BTFSS U2RX_EN_F			;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xEA,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PS			;;	
	MOV #0xEB,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PE			;;	
	MOV #0xEC,W0			;;
	CP W0,W1			;;
	BRA Z,U2RXI_PT			;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xAB,W0			;; 
	BTFSC U2RXT_F			;;
	XOR W0,W1,W1			;;
	BCF U2RXT_F			;;
	MOV #U2RX_BUFSIZE,W0		;;
	CP U2RX_BYTE_PTR		;;
	BRA GEU,U2RXI_ERR		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2RX_BUFA,W0		;;
	BTFSC U2RX_BUFAB_F		;;
	MOV #U2RX_BUFB,W0		;;
	ADD U2RX_BYTE_PTR,WREG		;;
	BCLR W0,#0			;;
	BTSC U2RX_BYTE_PTR,#0		;;
	BRA U2RXI_1			;;
	MOV W1,[W0]			;;
	BRA U2RXI_2			;;
U2RXI_1:				;;
	SWAP W1				;;
	ADD W1,[W0],[W0]		;;
	SWAP W1				;;
U2RXI_2:				;;
	MOV U2RX_TMP0,W0		;;
	MOV W0,U2RX_TMP1		;;
	MOV W1,W0			;;
	MOV W0,U2RX_TMP0		;;
	MOV W1,W0			;;
	ADD U2RX_ADDSUM			;;	
	XOR U2RX_XORSUM			;;
U2RXI_3:				;;
	INC U2RX_BYTE_PTR		;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PS:				;;
	BCF U2RXT_F			;;
	CLR U2RX_BYTE_PTR		;;
	CLR U2RX_ADDSUM			;;
	CLR U2RX_XORSUM			;;
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PE:				;;
	BCF U2RXT_F			;;
	MOV #0xAB,W0			;;
	XOR U2RX_XORSUM,WREG		;;	
	XOR U2RX_TMP0,WREG		;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_TMP0,W0		;;
	ADD U2RX_TMP0,WREG		;;
	ADD U2RX_TMP1,WREG		;;
	XOR U2RX_ADDSUM,WREG		;;
	AND #255,W0			;;
	BRA NZ,U2RXI_END		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV U2RX_BYTE_PTR,W0		;;	
	BTFSS U2RX_BUFAB_F		;;	
	MOV W0,U2RXA_LEN		;;
	BTFSC U2RX_BUFAB_F		;;	
	MOV W0,U2RXB_LEN		;;
	BTFSS U2RX_BUFAB_F		;;	
	BSF U2RX_PACKA_F		;;
	BTFSC U2RX_BUFAB_F		;;	
	BSF U2RX_PACKB_F		;;
	TG U2RX_BUFAB_F			;;	
	BRA U2RXI_END			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
U2RXI_PT:				;;
	BSF U2RXT_F			;;
	BRA U2RXI_END			;;
U2RXI_ERR:				;;	
	NOP				;;
U2RXI_END:				;;	
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U1TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS0,#U1TXIF		;;
	BTFSS U1TX_EN_F			;;
	BRA U1TXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U1TX_BUF,W1		;;
	MOV U1TX_BCNT,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0
	MOV [W1],W0			;;
	BTSC U1TX_BCNT,#0		;;
	SWAP W0				;;
	AND #255,W0			;;
	MOV W0,U1TXREG			;;
	INC U1TX_BCNT			;;
	MOV U1TX_BTX,W0			;;
	CP U1TX_BCNT			;;
	BRA LTU,U1TXI_END		;;
	BCF U1TX_EN_F			;;
	BSF U1TX_END_F
	;BCF RS485_CTL_O		;;
U1TXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__U2TXInterrupt:			;;
	PUSH SR				;;	
	PUSH W0				;;
	PUSH W1				;;
	BCLR IFS1,#U2TXIF		;;
	BTFSS U2TX_EN_F			;;
	BRA U2TXI_END			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #U2TX_BUF,W1		;;
	MOV U2TX_BCNT,W0		;;
	ADD W0,W1,W1			;;
	BCLR W1,#0
	MOV [W1],W0			;;
	BTSC U2TX_BCNT,#0		;;
	SWAP W0				;;
	AND #255,W0			;;
	MOV W0,U2TXREG			;;
	INC U2TX_BCNT			;;
	MOV U2TX_BTX,W0			;;
	CP U2TX_BCNT			;;
	BRA LTU,U2TXI_END		;;
	BCF U2TX_EN_F			;;
	BSF U2TX_END_F			;;
	;BCF RS485_CTL_O		;;
U2TXI_END:				;;
	POP W1				;;
	POP W0				;;
	POP SR				;;
	RETFIE				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;











		





DLYX:
	CLRWDT
	DEC W0,W0
	BRA NZ,DLYX
	RETURN
	
;50MIPS TMR2 UNIT=20*256(DIVIDER)=5.12US
;66MIPS TMR2 UNIT=20*256(DIVIDER)=3.88S
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DLYMS:					;;
        MOV #1,W0       		;;
DLYMX:					;;
        PUSH  R0			;;
        PUSH  R1			;;
        MOV W0,R1			;;
DLYMX1:					;;
	MOV TMR2,W0			;;
	MOV W0,R0			;;
	MOV #195,W0			;;50MIPS
	MOV #257,W0			;;66MIPS
	ADD R0				;;
DLYMX2:					;;
	CLRWDT				;;
	MOV R0,W0			;;
	SUB TMR2,WREG			;;
	BTSC W0,#15			;;
	BRA DLYMX2			;;
        DEC R1				;;
        BRA NZ,DLYMX1 			;;
        POP R1				;;
        POP R0				;;
        RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DLYUX:
	REPEAT #14
	NOP
	DEC W0,W0
	BRA NZ,DLYUX
	RETURN 






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SIM_CSDFSDFONVERT_AD:				;;
	MOV CONVAD_CNT,W0 		;;
	BRA W0				;;
	BRA SIM_CONV_J0			;;
	BRA SIM_CONV_J1			;;
	BRA SIM_CONV_J2			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SIM_CONV_J0:				;;
	BCLR AD1CON1,#SAMP		;;
	MOV TMR2,W0			;;
	MOV W0,ADSAMP_TIM
	INC CONVAD_CNT			;;
	RETURN				;;
SIM_CONV_J1:				;;
	MOV ADSAMP_TIM,W0		;;
	SUB TMR2,WREG			;;
	MOV W0,R0			;;
	MOV #25,W0			;;100US UNIT=4US
	CP R0				;;
	BRA GEU,$+4			;;
	RETURN				;;
	INC CONVAD_CNT			;;
	RETURN
SIM_CONV_J2:				;;
	BTSS IFS0,#AD1IF		;;
	RETURN				;;
	BCLR IFS0,#AD1IF		;;
	CLR CONVAD_CNT			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INC ADIN_CNT			;;
	MOV #4,W0			;;
	CP ADIN_CNT			;;
	BRA LTU,$+4			;;
	CLR ADIN_CNT			;;
	MOV #ADIN_BUF,W1		;;	
	MOV ADIN_CNT,W0			;;
	SL W0,#3,W0			;;
	ADD W0,W1,W1			;;
	MOV ADC1BUF0,W0			;;AN3 V34V
	MOV W0,[W1++]			;;
	MOV ADC1BUF3,W0			;;AN2 I34V
	MOV W0,[W1++]			;;
	MOV ADC1BUF2,W0			;;AN1 TEMPR
	MOV W0,[W1++]			;;
	MOV ADC1BUF1,W0			;;FAULT_IOI
	MOV W0,[W1++]			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #ADIN_BUF,W1		;;	
	MOV [W1],W0			;;
	MOV W0,R0			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R1			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R2			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R3			;;
	CALL FILTER			;;
	MOV W0,V34V_ADV			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #ADIN_BUF+2,W1		;;	
	MOV [W1],W0			;;
	MOV W0,R0			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R1			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R2			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R3			;;
	CALL FILTER			;;
	MOV W0,I34V_ADV			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #ADIN_BUF+4,W1		;;	
	MOV [W1],W0			;;
	MOV W0,R0			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R1			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R2			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R3			;;
	CALL FILTER			;;
	MOV W0,TEMP_ADV			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #ADIN_BUF+6,W1		;;	
	MOV [W1],W0			;;
	MOV W0,R0			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R1			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R2			;;
	ADD #8,W1			;;
	MOV [W1],W0			;;
	MOV W0,R3			;;
	CALL FILTER			;;
	MOV W0,FAULT_ADV		;;
	BSET FAULT_ADV,#15		;;	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	RETURN


FILTER:
	MOV R0,W0
	CP R1
	BRA LEU,FILTER_1
	MOV R0,W0
	XOR R1,WREG
	XOR R0
	XOR R1
FILTER_1:
	MOV R1,W0
	CP R2
	BRA LEU,FILTER_2
	MOV R1,W0
	XOR R2,WREG
	XOR R1
	XOR R2
FILTER_2:
	MOV R2,W0
	CP R3
	BRA LEU,FILTER_3
	MOV R2,W0
	XOR R3,WREG
	XOR R2
	XOR R3
FILTER_3:
	MOV R1,W0
	CP R2
	BRA LEU,FILTER_4
	MOV R1,W0
	XOR R2,WREG
	XOR R1
	XOR R2
FILTER_4:
	MOV R0,W0
	CP R1
	BRA LEU,FILTER_5
	MOV R0,W0
	XOR R1,WREG
	XOR R0
	XOR R1
FILTER_5:
	MOV R2,W0
	ADD R1,WREG
	LSR W0,#1,W0
	RETURN




	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONVERT_AD:				;;
	MOV CONVAD_CNT,W0 		;;
	AND #3,W0
	BRA W0				;;
	BRA CONV_J0			;;
	BRA CONV_J1			;;
	BRA CONV_J2			;;
	CLR CONVAD_CNT
	RETURN
CONV_J0:	
	CLR ADTEST			;;
	MOV ADCH_CNT,W0			;;
	MOV W0,AD1CHS0			;;
	BSET AD1CON1,#SAMP		;;
	MOV #10,W0			;;
	CALL DLYUX			;;
	INC CONVAD_CNT			;;
	RETURN				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CONV_J1:				;;
	BCLR AD1CON1,#SAMP		;;
	INC CONVAD_CNT
	RETURN				;;
CONV_J2:				;;
	BTSC AD1CON1,#DONE		;;
	BRA CONV_J21
	INC ADTEST
	MOV #10000,W0
	CP ADTEST
	BRA GEU,$+4
	RETURN	
	NOP
	CLR CONVAD_CNT
	RETURN
CONV_J21:				;;
	CLR CONVAD_CNT			;;
	MOV #ADBUF0,W1			;;
	MOV ADBUF_CNT,W0		;;
	SL W0,#1,W0			;;
	ADD W0,W1,W1			;;
	MOV ADC1BUF0,W0			;;
	MOV W0,[W1]			;;
	INC ADBUF_CNT			;;
	MOV #4,W0			;;
	CP ADBUF_CNT			;;
	BRA GEU,$+4			;;
	RETURN 				;;
	CLR ADBUF_CNT			;;
	MOVFF ADBUF0,R0			;;
	MOVFF ADBUF1,R1			;;
	MOVFF ADBUF2,R2			;;	
	MOVFF ADBUF3,R3			;;
	CALL FILTER			;;
	MOV #I50VADI,W1			;;
	MOV ADCH_CNT,W2			;;
	ADD W2,W1,W1			;;
	ADD W2,W1,W1			;;
	MOV W0,[W1]			;;
	INC ADCH_CNT			;;
	MOV #6,W0			;;
	CP ADCH_CNT			;;
	BRA GEU,$+4			;;
	RETURN				;;
	CLR ADCH_CNT			;;
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;














;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T4Interrupt:			;;250 US
	PUSH SR			;;
	PUSH W0			;;
	PUSH W1			;;
	BCLR IFS1,#T4IF		;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
T4I_END:			;;
	POP W1			;;
	POP W0			;;
	POP SR			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__T1Interrupt:			;;10 US
	PUSH.S			;;PUSH W0,1,2,3,SR.C.Z.N.OV.DC
	BCLR IFS0,#T1IF		;;
T1I_END:                        ;;
	POP.S			;;
	RETFIE			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	



			





;$4











;EP128 1024 INSTRUCTION,ADRESS+0x800
;DONT USE THE LAST BLOCK,CAUSE THE CONFIGURE BYTES ARE ERASED TOO;


;W2=WFLASH_REGISTER BUFFER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOADLH_FLASH24:				;;
	MOV #0xFA,W0			;;
	MOV W0,TBLPAG			;;
	MOV #0,W1			;; Perform the TBLWT instructions to write the latches; W2 is incremented in the TBLWTH instruction to point to the; next instruction location
	TBLWTL [W2++],[W1]		;;
	TBLWTH [W2++],[W1++]		;;
	TBLWTL [W2++],[W1]		;;
	TBLWTH [W2++],[W1++]		;;
	CLR TBLPAG			;; 
	RETURN				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LREG_F24SETBUF:					;;
	MOV W1,R5				;;
	CLR R4					;;	
LREG_F24SETBUF_1:				;;
	CLR TBLPAG 				;;
	MOV #tbloffset(FSET_LOC_TBL),W1		;;
	MOV R4,W0				;;
	SL W0,#3,W0				;;
	ADD W0,W1,W1				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	TBLRDL [W1++],W0			;;
	MOV W0,R0				;;
	TBLRDL [W1++],W0			;;
	MOV W0,R1				;;
	TBLRDL [W1++],W0			;;
	MOV W0,R2				;;
	TBLRDL [W1++],W0			;;
	MOV W0,R3				;;
	CP0 R0					;;
	BRA NZ,$+4				;;
	RETURN					;;
	MOV R0,W0				;;
	CP R5					;;
	BRA Z,LREG_F24SETBUF_2			;;
	INC R4					;;
	BRA LREG_F24SETBUF_1			;;
LREG_F24SETBUF_2:				;;
	MOV #F24SET_BUF,W1			;;
	MOV R4,W0				;;
	ADD W0,W1,W1				;;	
	ADD W0,W1,W1				;;	
	MOV R5,W2				;;
	MOV [W2],W0				;;
	MOV W0,[W1]				;;
	RETURN					;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;INTPUT W1,REG ADDR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_F24WORD:					;;
	PUSH W1					;;	
	CALL LF24_F24SETBUF			;;
	POP W1					;;
	CALL LREG_F24SETBUF			;;
SAVE_F24EXE:					;;
	CALL VER_F24SET				;;
	BRA NZ,$+4				;;				
	RETURN					;;
	CALL ERASE_F24SET			;;
	CALL SAVE_F24SET			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LF24_F24SETBUF:					;;
	MOV #F24SET_BUF,W2			;;
LF24_F24SET:
	CLR TBLPAG 				;;	
	MOV #tbloffset(F24SET_FADR),W1		;;
	MOV #F24SET_LEN_K,W3 			;;
LF24_F24SETBUF_1:				;;
	TBLRDL [W1++],W0			;;
	MOV W0,[W2++]				;;
	DEC W3,W3				;;
	BRA NZ,LF24_F24SETBUF_1			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
VER_F24SET:					;;
	CLR TBLPAG 				;;	
	MOV #tbloffset(F24SET_FADR),W1		;;
	MOV #F24SET_LEN_K,W3 			;;
	MOV #F24SET_BUF,W2			;;
VER_F24SET_1:					;;
	TBLRDL [W1++],W0			;;
	XOR W0,[W2++],W0			;;
	BRA Z,$+4				;;
	RETURN					;;
	DEC W3,W3				;;
	BRA NZ,VER_F24SET_1			;;
	RETURN 					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ERASE_F24SET:					;;
	BCLR INTCON2,#GIE			;;
	MOV #0,W0				;;0=FRC
	CALL OSC_PRG				;;
	CALL WAIT_FLASH24_READY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #tblpage(F24SET_FADR),W0		;;
	MOV W0,NVMADRU				;;
	MOV #tbloffset(F24SET_FADR),W0		;;
	MOV W0,NVMADRL				;;
	MOV #0x4003,W0 				;;	
	MOV W0,NVMCON 				;;	
	DISI #10				;;
	MOV #0x55,W0				;;				
	MOV W0,NVMKEY 				;;	
	MOV #0xAA,W0 				;;	
	MOV W0,NVMKEY 				;;
	BSET NVMCON,#15 			;;	
	NOP					;;
	NOP 					;;	
	NOP 					;;
	NOP					;;
	NOP					;;
	CALL WAIT_FLASH24_READY			;;
	MOV #0,W0				;;
	MOV W0,NVMCON				;;
	CALL INIT_OSC				;;
	BSET INTCON2,#GIE			;;
 	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
WAIT_FLASH24_READY:				;;
	CLRWDT					;;
	BTSC NVMCON,#15				;;
	BRA WAIT_FLASH24_READY			;;
	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_F24SET:					;;
	BCLR INTCON2,#GIE			;;
	MOV #0,W0				;;0=FRC
	CALL OSC_PRG				;;
	CALL WAIT_FLASH24_READY			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLR W3					;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAVE_F24SET_1:					;;
	MOV #tblpage(F24SET_FADR),W0		;;
	MOV W0,NVMADRU				;;
	MOV #tbloffset(F24SET_FADR),W0		;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	ADD W0,W3,W0				;;
	MOV W0,NVMADR				;;
	MOV #F24SET_BUF,W2			;;
	ADD W3,W2,W2				;;
	ADD W3,W2,W2				;;
	ADD W3,W2,W2				;;
	ADD W3,W2,W2				;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0xFA,W0				;;
	MOV W0,TBLPAG				;;
	MOV #0,W1				;; Perform the TBLWT instructions to write the latches; W2 is incremented in the TBLWTH instruction to point to the; next instruction location
	TBLWTL [W2++],[W1]			;;
	TBLWTH W3,[W1++]			;;
	TBLWTL [W2++],[W1]			;;
	TBLWTH W3,[W1++]			;;
	CLR TBLPAG				;; 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0x4001,W0				;;
	MOV W0,NVMCON				;;
	DISI #10				;;
	MOV #0x55,W0				;;				
	MOV W0,NVMKEY 				;;	
	MOV #0xAA,W0 				;;	
	MOV W0,NVMKEY 				;;
	BSET NVMCON,#15 			;;	
	NOP 					;;	
	NOP 					;;
	NOP					;;
	NOP					;;
	NOP					;;
	CALL WAIT_FLASH24_READY			;;
	INC W3,W3				;;
	MOV #F24SET_LEN_K,W0			;;
	INC W0,W0				;;
	ASR W0,#1,W0 				;;
	CP W3,W0				;;				
	BRA LTU,SAVE_F24SET_1			;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MOV #0,W0				;;
	MOV W0,NVMCON				;;
	CALL INIT_OSC				;;
	BSET INTCON2,#GIE			;;
 	RETURN					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









.EQU F24SET_LEN_K	,(FSET_LOC_TBL_END-FSET_LOC_TBL)/8
FSET_LOC_TBL:
	.WORD PARA0_FSET		,0	,0,0	
	.WORD PARA1_FSET		,1	,0,0	
	.WORD PARA2_FSET		,2	,0,0	
	.WORD PARA3_FSET		,3	,0,0	
FSET_LOC_TBL_END:
	.WORD 0		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.ORG (F24SET_FADR-0x204)	;;
F24SET_TBL:				;;
	.WORD 0x1234			;;00	
	.WORD 0x5678			;;01	
	.WORD 0x9ABC			;;02	
	.WORD 0xDEF0			;;03	
	.WORD 0x0009			;;04	
	.WORD 0x0001			;;05	
	.WORD 0x0000			;;06
	.WORD 0x0000			;;07
	.WORD 0x0000			;;08
	.WORD 0x0000			;;09
	.WORD 0x0000			;;10
	.WORD 0x0000			;;11
	.WORD 0x0000			;;12
	.WORD 0x0000			;;13
	.WORD 0x0000			;;14
	.WORD 0x0000			;;15
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0000			;;16	
	.WORD 0x0000			;;17	
	.WORD 0x0000			;;18	
	.WORD 0x0000			;;19	
	.WORD 0x0009			;;20	
	.WORD 0x0001			;;21	
	.WORD 0x0000			;;22
	.WORD 0x0000			;;23
	.WORD 0x0000			;;24
	.WORD 0x0000			;;25
	.WORD 0x0000			;;26
	.WORD 0x0000			;;27
	.WORD 0x0000			;;28
	.WORD 0x0000			;;29
	.WORD 0x0000			;;30
	.WORD 0x0000			;;31
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0000			;;32	
	.WORD 0x0000			;;33	
	.WORD 0x0000			;;34	
	.WORD 0x0000			;;35	
	.WORD 0x0009			;;36	
	.WORD 0x0001			;;37	
	.WORD 0x0000			;;38
	.WORD 0x0000			;;39
	.WORD 0x0000			;;40
	.WORD 0x0000			;;41
	.WORD 0x0000			;;42
	.WORD 0x0000			;;43
	.WORD 0x0000			;;44
	.WORD 0x0000			;;45
	.WORD 0x0000			;;46
	.WORD 0x0000			;;47
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0x0000			;;48	
	.WORD 0x0000			;;49	
	.WORD 0x0000			;;50	
	.WORD 0x0000			;;51	
	.WORD 0x0009			;;52	
	.WORD 0x0001			;;53	
	.WORD 0x0000			;;54
	.WORD 0x0000			;;55
	.WORD 0x0000			;;56
	.WORD 0x0000			;;57
	.WORD 0x0000			;;58
	.WORD 0x0000			;;59
	.WORD 0x0000			;;60
	.WORD 0x0000			;;61
	.WORD 0x0000			;;62
	.WORD 0x0000			;;63
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.WORD 0xABCD			;;10	
	.WORD 0x0000			;;11	
	.WORD 0x0000			;;12	
	.WORD 0x0000			;;13	
	.WORD 0x0009			;;14	
	.WORD 0x0001			;;15	
	.WORD 0x0000			;;16
	.WORD 0x0000			;;17
	.WORD 0x0000			;;18
	.WORD 0x0000			;;19
	.WORD 0x0000			;;10
	.WORD 0x0000			;;11
	.WORD 0x0000			;;12
	.WORD 0x0000			;;13
	.WORD 0x0000			;;14
	.WORD 0x0000			;;15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.ORG (F24SET_FADR-0x204+0x800)	;;


