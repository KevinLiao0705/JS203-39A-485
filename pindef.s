

.IFDEF JS203_39A_K01_01
;=======================PIN1 
.EQU SWS0_I		,PORTA
.EQU SWS0_IO		,TRISA
.EQU SWS0_I_P		,7
.EQU SWS0_IO_P		,7
;=======================PIN2 
.EQU SWS1_I		,PORTB
.EQU SWS1_IO		,TRISB
.EQU SWS1_I_P		,14
.EQU SWS1_IO_P		,14
;=======================PIN3 
.EQU SWS2_I		,PORTB
.EQU SWS2_IO		,TRISB
.EQU SWS2_I_P		,15
.EQU SWS2_IO_P		,15
;=======================PIN4 
.EQU SWS3_I		,PORTG
.EQU SWS3_IO		,TRISG
.EQU SWS3_I_P		,6
.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
.EQU NC12_O		,LATA
.EQU NC12_IO		,TRISA
.EQU NC12_O_P		,11
.EQU NC12_IO_P		,11
;=======================PIN13 
.EQU ADI_12V_I		,PORTA
.EQU ADI_12V_IO		,TRISA
.EQU ADI_12V_I_P	,0
.EQU ADI_12V_IO_P	,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
.EQU ADS0_I		,PORTB
.EQU ADS0_IO		,TRISB
.EQU ADS0_I_P		,0
.EQU ADS0_IO_P	        ,0
;=======================PIN16 
.EQU ADS1_I		,PORTB
.EQU ADS1_IO		,TRISB
.EQU ADS1_I_P		,1
.EQU ADS1_IO_P	        ,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU DB0_O		,LATC
.EQU DB0_I		,PORTC
.EQU DB0_IO		,TRISC
.EQU DB0_O_P		,0
.EQU DB0_I_P		,0
.EQU DB0_IO_P		,0
;=======================PIN22 
.EQU DB1_O		,LATC
.EQU DB1_I		,PORTC
.EQU DB1_IO		,TRISC
.EQU DB1_O_P		,1
.EQU DB1_I_P		,1
.EQU DB1_IO_P		,1
;=======================PIN23 
.EQU DB2_O		,LATC
.EQU DB2_I		,PORTC
.EQU DB2_IO		,TRISC
.EQU DB2_O_P		,2
.EQU DB2_I_P		,2
.EQU DB2_IO_P		,2
;=======================PIN24 
.EQU NC24_O		,LATC
.EQU NC24_IO		,TRISC
.EQU NC24_O_P		,11
.EQU NC24_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
.EQU ADS2_I		,PORTE
.EQU ADS2_IO		,TRISE
.EQU ADS2_I_P		,12
.EQU ADS2_IO_P	        ,12
;=======================PIN28 
.EQU ADS3_I		,PORTE
.EQU ADS3_IO		,TRISE
.EQU ADS3_I_P		,13
.EQU ADS3_IO_P	        ,13
;=======================PIN29 
.EQU ADS4_I		,PORTE
.EQU ADS4_IO		,TRISE
.EQU ADS4_I_P		,14
.EQU ADS4_IO_P	        ,14
;=======================PIN30 ;TP3
.EQU ADS5_I		,PORTE
.EQU ADS5_IO		,TRISE
.EQU ADS5_I_P		,15
.EQU ADS5_IO_P	        ,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
;=======================PIN35
.EQU DB3_O		,LATC
.EQU DB3_I		,PORTC
.EQU DB3_IO		,TRISC
.EQU DB3_O_P		,3
.EQU DB3_I_P		,3
.EQU DB3_IO_P		,3
;=======================PIN36
.EQU DB4_O		,LATC
.EQU DB4_I		,PORTC
.EQU DB4_IO		,TRISC
.EQU DB4_O_P		,4
.EQU DB4_I_P		,4
.EQU DB4_IO_P		,4
;=======================PIN37 
.EQU DB5_O		,LATC
.EQU DB5_I		,PORTC
.EQU DB5_IO		,TRISC
.EQU DB5_O_P		,5
.EQU DB5_I_P		,5
.EQU DB5_IO_P		,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
.EQU LDLO_TR_O		,LATB
.EQU LDLO_TR_IO		,TRISB
.EQU LDLO_TR_O_P	,6 
.EQU LDLO_TR_IO_P	,6 
;=======================PIN45
.EQU LSEO_TR_O		,LATC
.EQU LSEO_TR_IO		,TRISC
.EQU LSEO_TR_O_P	,10 
.EQU LSEO_TR_IO_P	,10
 ;=======================PIN46 TP8
.EQU LDFO_TR_O		,LATB
.EQU LDFO_TR_IO		,TRISB
.EQU LDFO_TR_O_P	,7 
.EQU LDFO_TR_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;=======================PIN48
.EQU RS485EX_RO_I	,PORTB
.EQU RS485EX_RO_IO	,TRISB
.EQU RS485EX_RO_I_P	,8 
.EQU RS485EX_RO_IO_P	,8
;=======================PIN49
.EQU RS485EX_DI_O	,LATB
.EQU RS485EX_DI_IO	,TRISB
.EQU RS485EX_DI_O_P	,9 
.EQU RS485EX_DI_IO_P	,9
;=======================PIN50 
.EQU DB6_O		,LATC
.EQU DB6_I		,PORTC
.EQU DB6_IO		,TRISC
.EQU DB6_O_P		,6
.EQU DB6_I_P		,6
.EQU DB6_IO_P		,6
;=======================PIN51 
.EQU DB7_O		,LATC
.EQU DB7_I		,PORTC
.EQU DB7_IO		,TRISC
.EQU DB7_O_P		,7
.EQU DB7_I_P		,7
.EQU DB7_IO_P		,7
;=======================PIN52
.EQU LSEI_CS_O		,LATC
.EQU LSEI_CS_IO	        ,TRISC
.EQU LSEI_CS_O_P	,8 
.EQU LSEI_CS_IO_P	,8
;=======================PIN53
.EQU LDFI_CS_O		,LATD
.EQU LDFI_CS_IO	        ,TRISD
.EQU LDFI_CS_O_P	,5 
.EQU LDFI_CS_IO_P	,5
;=======================PIN54
.EQU SEO_EN_N_O		,LATD
.EQU SEO_EN_N_IO	,TRISD
.EQU SEO_EN_N_O_P	,6 
.EQU SEO_EN_N_IO_P	,6 
;=======================PIN55
.EQU DFO_EN_N_O		,LATC
.EQU DFO_EN_N_IO	,TRISC
.EQU DFO_EN_N_O_P	,9 
.EQU DFO_EN_N_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
.EQU DFO_EN_P_O		,LATF
.EQU DFO_EN_P_IO	,TRISF
.EQU DFO_EN_P_O_P	,0 
.EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF



.IFDEF JS203_39A_C01_03
;=======================PIN1 
.EQU SWS0_I		,PORTA
.EQU SWS0_IO		,TRISA
.EQU SWS0_I_P		,7
.EQU SWS0_IO_P		,7
;=======================PIN2 
.EQU SWS1_I		,PORTB
.EQU SWS1_IO		,TRISB
.EQU SWS1_I_P		,14
.EQU SWS1_IO_P		,14
;=======================PIN3 
.EQU SWS2_I		,PORTB
.EQU SWS2_IO		,TRISB
.EQU SWS2_I_P		,15
.EQU SWS2_IO_P		,15
;=======================PIN4 
.EQU SWS3_I		,PORTG
.EQU SWS3_IO		,TRISG
.EQU SWS3_I_P		,6
.EQU SWS3_IO_P		,6
;=======================PIN5 
.EQU SWS4_I		,PORTG
.EQU SWS4_IO		,TRISG
.EQU SWS4_I_P		,7
.EQU SWS4_IO_P		,7
;=======================PIN6 
.EQU SWS5_I		,PORTG
.EQU SWS5_IO		,TRISG
.EQU SWS5_I_P		,8
.EQU SWS5_IO_P		,8
;=======================PIN7	MCLR 
;=======================PIN8 
.EQU SWS6_I		,PORTG
.EQU SWS6_IO		,TRISG
.EQU SWS6_I_P		,9
.EQU SWS6_IO_P		,9
;=======================PIN9	VSS 
;=======================PIN10 	VDD
;=======================PIN11 
.EQU SWS7_I		,PORTA
.EQU SWS7_IO		,TRISA
.EQU SWS7_I_P		,12
.EQU SWS7_IO_P		,12
;=======================PIN12 
.EQU NC12_O		,LATA
.EQU NC12_IO		,TRISA
.EQU NC12_O_P		,11
.EQU NC12_IO_P		,11
;=======================PIN13 
.EQU ADI_12V_I		,PORTA
.EQU ADI_12V_IO		,TRISA
.EQU ADI_12V_I_P	,0
.EQU ADI_12V_IO_P	,0
;=======================PIN14 
.EQU ADI_5V_I		,PORTA
.EQU ADI_5V_IO		,TRISA
.EQU ADI_5V_I_P		,1
.EQU ADI_5V_IO_P	,1
;=======================PIN15 
;EQU ADS0_I		,PORTB
;EQU ADS0_IO		,TRISB
;EQU ADS0_I_P		,0
;EQU ADS0_IO_P	        ,0
;=======================PIN16 
;EQU ADS1_I		,PORTB
;EQU ADS1_IO		,TRISB
;EQU ADS1_I_P		,1
;EQU ADS1_IO_P	        ,1
;=======================PIN17	PGC 
;=======================PIN18 	PGD
;=======================PIN19	VDD 
;=======================PIN20 	VSS
;=======================PIN21 
.EQU DB0_O		,LATC
.EQU DB0_I		,PORTC
.EQU DB0_IO		,TRISC
.EQU DB0_O_P		,0
.EQU DB0_I_P		,0
.EQU DB0_IO_P		,0
;=======================PIN22 
.EQU DB1_O		,LATC
.EQU DB1_I		,PORTC
.EQU DB1_IO		,TRISC
.EQU DB1_O_P		,1
.EQU DB1_I_P		,1
.EQU DB1_IO_P		,1
;=======================PIN23 
.EQU DB2_O		,LATC
.EQU DB2_I		,PORTC
.EQU DB2_IO		,TRISC
.EQU DB2_O_P		,2
.EQU DB2_I_P		,2
.EQU DB2_IO_P		,2
;=======================PIN24 
.EQU NC24_O		,LATC
.EQU NC24_IO		,TRISC
.EQU NC24_O_P		,11
.EQU NC24_IO_P		,11
;=======================PIN25	VSS 
;=======================PIN26 	VDD
;=======================PIN27 
.EQU ADS2_I		,PORTE
.EQU ADS2_IO		,TRISE
.EQU ADS2_I_P		,12
.EQU ADS2_IO_P	        ,12
;=======================PIN28 
.EQU ADS3_I		,PORTE
.EQU ADS3_IO		,TRISE
.EQU ADS3_I_P		,13
.EQU ADS3_IO_P	        ,13
;=======================PIN29 
.EQU FIB_RX0_CHK_I	,PORTE
.EQU FIB_RX0_CHK_IO	,TRISE
.EQU FIB_RX0_CHK_I_P	,14
.EQU FIB_RX0_CHK_IO_P	,14
;=======================PIN30 ;TP3
.EQU FIB_RX1_CHK_I      ,PORTE
.EQU FIB_RX1_CHK_IO	,TRISE
.EQU FIB_RX1_CHK_I_P	,15
.EQU FIB_RX1_CHK_IO_P	,15
;=======================PIN31 ;TP4
.EQU TP1_O		,LATA
.EQU TP1_IO		,TRISA
.EQU TP1_O_P		,8
.EQU TP1_IO_P		,8
;=======================PIN32 
.EQU TP2_O		,LATB
.EQU TP2_IO		,TRISB
.EQU TP2_O_P		,4
.EQU TP2_IO_P		,4
;=======================PIN33 
.EQU TP3_O		,LATA
.EQU TP3_IO		,TRISA
.EQU TP3_O_P		,4
.EQU TP3_IO_P		,4
;=======================PIN34 
.EQU TP4_O		,LATA
.EQU TP4_IO		,TRISA
.EQU TP4_O_P		,9
.EQU TP4_IO_P		,9
;=======================PIN35
.EQU DB3_O		,LATC
.EQU DB3_I		,PORTC
.EQU DB3_IO		,TRISC
.EQU DB3_O_P		,3
.EQU DB3_I_P		,3
.EQU DB3_IO_P		,3
;=======================PIN36
.EQU DB4_O		,LATC
.EQU DB4_I		,PORTC
.EQU DB4_IO		,TRISC
.EQU DB4_O_P		,4
.EQU DB4_I_P		,4
.EQU DB4_IO_P		,4
;=======================PIN37 
.EQU DB5_O		,LATC
.EQU DB5_I		,PORTC
.EQU DB5_IO		,TRISC
.EQU DB5_O_P		,5
.EQU DB5_I_P		,5
.EQU DB5_IO_P		,5
;=======================PIN38 	VDD
;=======================PIN39 	OSC1
.EQU SLOTSW_S0_I	,PORTC
.EQU SLOTSW_S0_IO	,TRISC
.EQU SLOTSW_S0_I_P	,12 
.EQU SLOTSW_S0_IO_P	,12 
;=======================PIN40 	OSC2
.EQU SLOTSW_S1_I	,PORTC
.EQU SLOTSW_S1_IO	,TRISC
.EQU SLOTSW_S1_I_P	,15 
.EQU SLOTSW_S1_IO_P	,15 
;=======================PIN41 	VSS
;=======================PIN42 
.EQU SLOTSW_S2_I	,PORTD
.EQU SLOTSW_S2_IO	,TRISD
.EQU SLOTSW_S2_I_P	,8 
.EQU SLOTSW_S2_IO_P	,8 
;=======================PIN43
.EQU SLOTSW_S3_I	,PORTB
.EQU SLOTSW_S3_IO	,TRISB
.EQU SLOTSW_S3_I_P	,5 
.EQU SLOTSW_S3_IO_P	,5 
;=======================PIN44 
;EQU LDLO_TR_O		,LATB
;EQU LDLO_TR_IO		,TRISB
;EQU LDLO_TR_O_P	,6 
;EQU LDLO_TR_IO_P	,6 
;=======================PIN45
;EQU LSEO_TR_O		,LATC
;EQU LSEO_TR_IO		,TRISC
;EQU LSEO_TR_O_P	,10 
;EQU LSEO_TR_IO_P	,10
 ;=======================PIN46 TP8
;EQU LDFO_TR_O		,LATB
;EQU LDFO_TR_IO		,TRISB
;EQU LDFO_TR_O_P	,7 
;EQU LDFO_TR_IO_P	,7
;=======================PIN47 
.EQU RS485EX_DE_O	,LATC
.EQU RS485EX_DE_IO	,TRISC
.EQU RS485EX_DE_O_P	,13 
.EQU RS485EX_DE_IO_P	,13
;======================PIN48
;EQU RS485EX_RO_I	,PORTB
;EQU RS485EX_RO_IO	,TRISB
;EQU RS485EX_RO_I_P	,8 
;EQU RS485EX_RO_IO_P	,8
;=======================PIN49
;EQU RS485EX_DI_O	,LATB
;EQU RS485EX_DI_IO	,TRISB
;EQU RS485EX_DI_O_P	,9 
;EQU RS485EX_DI_IO_P	,9
;=======================PIN50 
.EQU FIB_TX0_CHK_O	,LATC
.EQU FIB_TX0_CHK_IO	,TRISC
.EQU FIB_TX0_CHK_O_P	,6
.EQU FIB_TX0_CHK_IO_P	,6
;=======================PIN51 
.EQU FIB_TX1_CHK_O	,LATC
.EQU FIB_TX1_CHK_IO	,TRISC
.EQU FIB_TX1_CHK_O_P	,7
.EQU FIB_TX1_CHK_IO_P	,7
;=======================PIN52
;EQU LSEI_CS_O		,LATC
;EQU LSEI_CS_IO	        ,TRISC
;EQU LSEI_CS_O_P	,8 
;EQU LSEI_CS_IO_P	,8
;=======================PIN53
;EQU LDFI_CS_O		,LATD
;EQU LDFI_CS_IO	        ,TRISD
;EQU LDFI_CS_O_P	,5 
;EQU LDFI_CS_IO_P	,5
;=======================PIN54
;EQU SEO_EN_N_O		,LATD
;EQU SEO_EN_N_IO	,TRISD
;EQU SEO_EN_N_O_P	,6 
;EQU SEO_EN_N_IO_P	,6 
;=======================PIN55
;EQU DFO_EN_N_O		,LATC
;EQU DFO_EN_N_IO	,TRISC
;EQU DFO_EN_N_O_P	,9 
;EQU DFO_EN_N_IO_P	,9 
;=======================PIN56 	VCAP
;=======================PIN57	VDD
;=======================PIN58
;EQU DFO_EN_P_O		,LATF
;EQU DFO_EN_P_IO	,TRISF
;EQU DFO_EN_P_O_P	,0 
;EQU DFO_EN_P_IO_P	,0 
;=======================PIN59
.EQU RS485_DE_O	        ,LATF
.EQU RS485_DE_IO	,TRISF
.EQU RS485_DE_O_P	,1 
.EQU RS485_DE_IO_P	,1
;=======================PIN60
.EQU RS485_RO_I	        ,PORTB
.EQU RS485_RO_IO	,TRISB
.EQU RS485_RO_I_P	,10 
.EQU RS485_RO_IO_P	,10
;=======================PIN61
.EQU RS485_DI_O	        ,LATB
.EQU RS485_DI_IO	,TRISB
.EQU RS485_DI_O_P	,11 
.EQU RS485_DI_IO_P	,11
;=======================PIN62
.EQU LEDB_O		,LATB
.EQU LEDB_IO		,TRISB
.EQU LEDB_O_P		,12
.EQU LEDB_IO_P		,12
;=======================PIN63
.EQU LEDG_O		,LATB
.EQU LEDG_IO		,TRISB
.EQU LEDG_O_P		,13
.EQU LEDG_IO_P		,13
;=======================PIN64
.EQU LEDR_O		,LATA
.EQU LEDR_IO		,TRISA
.EQU LEDR_O_P		,10
.EQU LEDR_IO_P		,10

.ENDIF