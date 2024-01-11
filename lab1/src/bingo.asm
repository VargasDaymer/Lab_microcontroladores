;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"bingo.c"
	list	p=12f683
	radix dec
	include "p12f683.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__moduint
	extern	__mulint
	extern	__modsint
	extern	__divsint
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_num
	global	_numeros_usados
	global	_cont
	global	_seed
	global	_fue_utilizado
	global	_generar_numero_unico
	global	_rand
	global	_delay

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
UD_bingo_0	udata
_numeros_usados	res	10

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_bingo_0	udata
r0x102B	res	1
r0x102C	res	1
r0x102D	res	1
r0x102E	res	1
r0x102F	res	1
r0x1030	res	1
r0x1031	res	1
r0x1023	res	1
r0x1024	res	1
r0x1025	res	1
r0x1026	res	1
r0x1029	res	1
r0x1028	res	1
r0x102A	res	1
r0x101F	res	1
r0x1020	res	1
r0x1018	res	1
r0x1017	res	1
r0x1019	res	1
r0x101A	res	1
r0x101B	res	1
r0x101C	res	1
r0x101D	res	1
r0x101E	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

IDD_bingo_0	idata
_seed
	db	0x00, 0x02	; 512


IDD_bingo_1	idata
_cont
	db	0x00	; 0


IDD_bingo_2	idata
_num
	db	0xfc	; 252
	db	0x60	; 96
	db	0xda	; 218
	db	0xf2	; 242
	db	0x66	; 102	'f'
	db	0xb6	; 182
	db	0xbe	; 190
	db	0xe0	; 224
	db	0xfe	; 254
	db	0xf7	; 247

;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_bingo	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _generar_numero_unico
;   __divsint
;   __modsint
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _generar_numero_unico
;   __divsint
;   __modsint
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;10 compiler assigned registers:
;   r0x102B
;   r0x102C
;   r0x102D
;   STK02
;   STK01
;   STK00
;   r0x102E
;   r0x102F
;   r0x1030
;   r0x1031
;; Starting pCode block
S_bingo__main	code
_main:
; 2 exit points
;	.line	28; "bingo.c"	TRISIO = 0b00001000; //Poner todos los pines como salidas y GP3 como entrada.
	MOVLW	0x08
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	29; "bingo.c"	GPIO = 0x00; //Poner pines en bajo
	BANKSEL	_GPIO
	CLRF	_GPIO
_00105_DS_:
;	.line	34; "bingo.c"	while (GP3 == 0x00){} //Esperar que el boton se presione.
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,3
	GOTO	_00105_DS_
;	.line	36; "bingo.c"	uint8_t num_gen = generar_numero_unico();
	PAGESEL	_generar_numero_unico
	CALL	_generar_numero_unico
	PAGESEL	$
;	.line	38; "bingo.c"	uint8_t dato1 = num[num_gen / 10]; //Obtener las unidades.
	BANKSEL	r0x102B
	MOVWF	r0x102B
	MOVWF	r0x102C
	CLRF	r0x102D
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x102C,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	__divsint
	CALL	__divsint
	PAGESEL	$
	BANKSEL	r0x102E
	MOVWF	r0x102E
	MOVF	STK00,W
	MOVWF	r0x102B
	ADDLW	(_num + 0)
	MOVWF	r0x102B
	MOVF	r0x102E,W
	BTFSC	STATUS,0
	INCFSZ	r0x102E,W
	ADDLW	high (_num + 0)
	MOVWF	r0x102E
	MOVF	r0x102B,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x102E
	BTFSC	r0x102E,0
	BSF	STATUS,7
	BANKSEL	INDF
	MOVF	INDF,W
	BANKSEL	r0x102F
	MOVWF	r0x102F
;	.line	40; "bingo.c"	uint8_t dato2 = num[num_gen % 10]; //Obtener las decenas.
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x102C,W
	MOVWF	STK00
	MOVF	r0x102D,W
	PAGESEL	__modsint
	CALL	__modsint
	PAGESEL	$
	BANKSEL	r0x102C
	MOVWF	r0x102C
	MOVF	STK00,W
	MOVWF	r0x102B
	ADDLW	(_num + 0)
	MOVWF	r0x102B
	MOVF	r0x102C,W
	BTFSC	STATUS,0
	INCFSZ	r0x102C,W
	ADDLW	high (_num + 0)
	MOVWF	r0x102C
	MOVF	r0x102B,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x102C
	BTFSC	r0x102C,0
	BSF	STATUS,7
	BANKSEL	INDF
	MOVF	INDF,W
	BANKSEL	r0x102D
	MOVWF	r0x102D
;	.line	44; "bingo.c"	GP1 = 0x00; //Aceptar en bajo.
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
;;unsigned compare: left < lit(0xA=10), size=1
;	.line	46; "bingo.c"	if(cont >= MAX_NUMEROS){ //Si se llega a la cantidad de números repetido se excriben 9.
	MOVLW	0x0a
	BANKSEL	_cont
	SUBWF	_cont,W
	BTFSS	STATUS,0
	GOTO	_00146_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	48; "bingo.c"	for (uint8_t i = 0; i < 3; i++)
	BANKSEL	r0x102B
	CLRF	r0x102B
;;unsigned compare: left < lit(0x3=3), size=1
_00126_DS_:
	MOVLW	0x03
	BANKSEL	r0x102B
	SUBWF	r0x102B,W
	BTFSC	STATUS,0
	GOTO	_00110_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	51; "bingo.c"	uint16_t dato3 = 0xF7F7; //Numero 99.
	MOVLW	0xf7
	MOVWF	r0x102C
	MOVWF	r0x102E
;	.line	53; "bingo.c"	GP1 = 0x00; //Aceptar en bajo
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
;	.line	55; "bingo.c"	for (uint8_t i = 0; i < 16; i++)
	BANKSEL	r0x1030
	CLRF	r0x1030
;;unsigned compare: left < lit(0x10=16), size=1
_00120_DS_:
	MOVLW	0x10
	BANKSEL	r0x1030
	SUBWF	r0x1030,W
	BTFSC	STATUS,0
	GOTO	_00108_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	60; "bingo.c"	salida =  dato3 & 0b0000000000000001; //Toma el valor el LSB.
	MOVF	r0x102C,W
	MOVWF	r0x1031
	MOVLW	0x01
	ANDWF	r0x1031,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=1, offr=0
;	.line	61; "bingo.c"	dato3 = dato3 >> 1; //Desplaza los bits para leer el siguiente.
	BCF	STATUS,0
	RRF	r0x102E,F
	RRF	r0x102C,F
;	.line	64; "bingo.c"	GP2 = salida; //Coloca el valor an enviar.
	RRF	r0x1031,W
	BTFSC	STATUS,0
	GOTO	_00001_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
_00001_DS_:
	BTFSS	STATUS,0
	GOTO	_00002_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
_00002_DS_:
;	.line	65; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	68; "bingo.c"	GP0 = 0x01;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	69; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	70; "bingo.c"	GP0 = 0x00;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	71; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	55; "bingo.c"	for (uint8_t i = 0; i < 16; i++)
	BANKSEL	r0x1030
	INCF	r0x1030,F
	GOTO	_00120_DS_
_00108_DS_:
;	.line	75; "bingo.c"	GP1 = 0x01; //Aceptar en alto
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
;	.line	77; "bingo.c"	delay(100);
	MOVLW	0x64
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	79; "bingo.c"	GP1 = 0x00; //Aceptar en bajo
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
;	.line	81; "bingo.c"	for (uint8_t i = 0; i < 16; i++)
	BANKSEL	r0x102C
	CLRF	r0x102C
;;unsigned compare: left < lit(0x10=16), size=1
_00123_DS_:
	MOVLW	0x10
	BANKSEL	r0x102C
	SUBWF	r0x102C,W
	BTFSC	STATUS,0
	GOTO	_00109_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	84; "bingo.c"	GP2 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	85; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	88; "bingo.c"	GP0 = 0x01;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	89; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	90; "bingo.c"	GP0 = 0x00;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	91; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	81; "bingo.c"	for (uint8_t i = 0; i < 16; i++)
	BANKSEL	r0x102C
	INCF	r0x102C,F
	GOTO	_00123_DS_
_00109_DS_:
;	.line	95; "bingo.c"	GP1 = 0x01; //Aceptar en alto
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
;	.line	96; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	48; "bingo.c"	for (uint8_t i = 0; i < 3; i++)
	BANKSEL	r0x102B
	INCF	r0x102B,F
	GOTO	_00126_DS_
_00110_DS_:
;	.line	101; "bingo.c"	cont = 0;
	BANKSEL	_cont
	CLRF	_cont
	GOTO	_00115_DS_
_00146_DS_:
;	.line	109; "bingo.c"	for (uint8_t i = 0; i < 8; i++)
	BANKSEL	r0x102B
	CLRF	r0x102B
;;unsigned compare: left < lit(0x8=8), size=1
_00129_DS_:
	MOVLW	0x08
	BANKSEL	r0x102B
	SUBWF	r0x102B,W
	BTFSC	STATUS,0
	GOTO	_00111_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	113; "bingo.c"	salida = dato1 & 0b00000001;
	MOVLW	0x01
	ANDWF	r0x102F,W
	MOVWF	r0x102C
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=1, offr=0
;	.line	114; "bingo.c"	dato1 = dato1 >> 1;
	BCF	STATUS,0
	RRF	r0x102F,F
;	.line	117; "bingo.c"	GP2 = salida;
	RRF	r0x102C,W
	BTFSC	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
_00003_DS_:
	BTFSS	STATUS,0
	GOTO	_00004_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
_00004_DS_:
;	.line	118; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	121; "bingo.c"	GP0 = 0x01;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	122; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	123; "bingo.c"	GP0 = 0x00;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	124; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	109; "bingo.c"	for (uint8_t i = 0; i < 8; i++)
	BANKSEL	r0x102B
	INCF	r0x102B,F
	GOTO	_00129_DS_
_00111_DS_:
;	.line	128; "bingo.c"	for (uint8_t i = 0; i < 8; i++)
	BANKSEL	r0x102B
	CLRF	r0x102B
;;unsigned compare: left < lit(0x8=8), size=1
_00132_DS_:
	MOVLW	0x08
	BANKSEL	r0x102B
	SUBWF	r0x102B,W
	BTFSC	STATUS,0
	GOTO	_00115_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	132; "bingo.c"	salida = dato2 & 0b00000001;
	MOVLW	0x01
	ANDWF	r0x102D,W
	MOVWF	r0x102C
;;shiftRight_Left2ResultLit:5474: shCount=1, size=1, sign=0, same=1, offr=0
;	.line	133; "bingo.c"	dato2 = dato2 >> 1;
	BCF	STATUS,0
	RRF	r0x102D,F
;	.line	136; "bingo.c"	GP2 = salida;
	RRF	r0x102C,W
	BTFSC	STATUS,0
	GOTO	_00005_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
_00005_DS_:
	BTFSS	STATUS,0
	GOTO	_00006_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
_00006_DS_:
;	.line	137; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	140; "bingo.c"	GP0 = 0x01;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	141; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	142; "bingo.c"	GP0 = 0x00;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	143; "bingo.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	128; "bingo.c"	for (uint8_t i = 0; i < 8; i++)
	BANKSEL	r0x102B
	INCF	r0x102B,F
	GOTO	_00132_DS_
_00115_DS_:
;	.line	148; "bingo.c"	GP1 = 0x01; //Aceptar en alto
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
;	.line	149; "bingo.c"	cont++; //Se registra que se mostro un numero.
	BANKSEL	_cont
	INCF	_cont,F
	GOTO	_00105_DS_
;	.line	153; "bingo.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x1017
;   STK00
;   r0x1018
;   r0x1019
;   r0x101A
;   r0x101B
;   r0x101C
;   r0x101D
;   r0x101E
;; Starting pCode block
S_bingo__delay	code
_delay:
; 2 exit points
;	.line	195; "bingo.c"	void delay(unsigned int tiempo)
	BANKSEL	r0x1017
	MOVWF	r0x1017
	MOVF	STK00,W
	MOVWF	r0x1018
;	.line	200; "bingo.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x1019
	CLRF	r0x101A
_00177_DS_:
	BANKSEL	r0x1017
	MOVF	r0x1017,W
	SUBWF	r0x101A,W
	BTFSS	STATUS,2
	GOTO	_00198_DS_
	MOVF	r0x1018,W
	SUBWF	r0x1019,W
_00198_DS_:
	BTFSC	STATUS,0
	GOTO	_00179_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	201; "bingo.c"	for(j=0;j<1275;j++);
	MOVLW	0xfb
	BANKSEL	r0x101B
	MOVWF	r0x101B
	MOVLW	0x04
	MOVWF	r0x101C
_00175_DS_:
	MOVLW	0xff
	BANKSEL	r0x101B
	ADDWF	r0x101B,W
	MOVWF	r0x101D
	MOVLW	0xff
	MOVWF	r0x101E
	MOVF	r0x101C,W
	BTFSC	STATUS,0
	INCFSZ	r0x101C,W
	ADDWF	r0x101E,F
	MOVF	r0x101D,W
	MOVWF	r0x101B
	MOVF	r0x101E,W
	MOVWF	r0x101C
	MOVF	r0x101E,W
	IORWF	r0x101D,W
	BTFSS	STATUS,2
	GOTO	_00175_DS_
;	.line	200; "bingo.c"	for(i=0;i<tiempo;i++)
	INCF	r0x1019,F
	BTFSC	STATUS,2
	INCF	r0x101A,F
	GOTO	_00177_DS_
_00179_DS_:
;	.line	202; "bingo.c"	}
	RETURN	
; exit point of _delay

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __mulint
;   __moduint
;   __moduint
;   __mulint
;   __moduint
;   __moduint
;7 compiler assigned registers:
;   r0x101F
;   r0x1020
;   STK02
;   STK01
;   STK00
;   r0x1021
;   r0x1022
;; Starting pCode block
S_bingo__rand	code
_rand:
; 2 exit points
;	.line	189; "bingo.c"	seed = (118 * seed + 455) % 685; // Algoritmo GLC simple
	BANKSEL	_seed
	MOVF	_seed,W
	BANKSEL	r0x101F
	MOVWF	r0x101F
	BANKSEL	_seed
	MOVF	(_seed + 1),W
	BANKSEL	r0x1020
	MOVWF	r0x1020
	MOVF	r0x101F,W
	MOVWF	STK02
	MOVF	r0x1020,W
	MOVWF	STK01
	MOVLW	0x76
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	__mulint
	CALL	__mulint
	PAGESEL	$
	BANKSEL	r0x1020
	MOVWF	r0x1020
	MOVF	STK00,W
	MOVWF	r0x101F
	MOVLW	0xc7
	ADDWF	r0x101F,F
	BTFSC	STATUS,0
	INCF	r0x1020,F
	INCF	r0x1020,F
	MOVLW	0xad
	MOVWF	STK02
	MOVLW	0x02
	MOVWF	STK01
	MOVF	r0x101F,W
	MOVWF	STK00
	MOVF	r0x1020,W
	PAGESEL	__moduint
	CALL	__moduint
	PAGESEL	$
	BANKSEL	r0x1020
	MOVWF	r0x1020
	MOVF	STK00,W
	MOVWF	r0x101F
	BANKSEL	_seed
	MOVWF	_seed
	BANKSEL	r0x1020
	MOVF	r0x1020,W
	BANKSEL	_seed
	MOVWF	(_seed + 1)
;	.line	192; "bingo.c"	return seed % 100;
	MOVF	_seed,W
	BANKSEL	r0x101F
	MOVWF	r0x101F
	BANKSEL	_seed
	MOVF	(_seed + 1),W
	BANKSEL	r0x1020
	MOVWF	r0x1020
	MOVLW	0x64
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x101F,W
	MOVWF	STK00
	MOVF	r0x1020,W
	PAGESEL	__moduint
	CALL	__moduint
	PAGESEL	$
	BANKSEL	r0x1020
	MOVWF	r0x1020
	MOVF	STK00,W
	MOVWF	r0x101F
;;1	MOVWF	r0x1021
	MOVWF	STK00
;;100	MOVF	r0x1022,W
	MOVF	r0x1020,W
;	.line	193; "bingo.c"	}
	RETURN	
; exit point of _rand

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _rand
;   _fue_utilizado
;   _rand
;   _fue_utilizado
;4 compiler assigned registers:
;   r0x1028
;   STK00
;   r0x1029
;   r0x102A
;; Starting pCode block
S_bingo__generar_numero_unico	code
_generar_numero_unico:
; 2 exit points
_00162_DS_:
;	.line	177; "bingo.c"	num = rand(); // Genera un número aleatorio entre 0 y 100.
	PAGESEL	_rand
	CALL	_rand
	PAGESEL	$
	BANKSEL	r0x1028
	MOVWF	r0x1028
	MOVF	STK00,W
	MOVWF	r0x1029
;	.line	178; "bingo.c"	} while (fue_utilizado(num)); // Verifica si ya fue utilizado
	MOVWF	r0x102A
	PAGESEL	_fue_utilizado
	CALL	_fue_utilizado
	PAGESEL	$
	BANKSEL	r0x1029
	MOVWF	r0x1029
	MOVF	r0x1029,W
	BTFSS	STATUS,2
	GOTO	_00162_DS_
;	.line	181; "bingo.c"	numeros_usados[cont] = num;
	BANKSEL	_cont
	MOVF	_cont,W
	ADDLW	(_numeros_usados + 0)
	BANKSEL	r0x1029
	MOVWF	r0x1029
	MOVLW	high (_numeros_usados + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1028
	MOVF	r0x1029,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1028
	BTFSC	r0x1028,0
	BSF	STATUS,7
	MOVF	r0x102A,W
	BANKSEL	INDF
	MOVWF	INDF
;	.line	183; "bingo.c"	return num;
	BANKSEL	r0x102A
	MOVF	r0x102A,W
;	.line	184; "bingo.c"	}
	RETURN	
; exit point of _generar_numero_unico

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;5 compiler assigned registers:
;   r0x1023
;   r0x1024
;   r0x1025
;   r0x1026
;   r0x1027
;; Starting pCode block
S_bingo__fue_utilizado	code
_fue_utilizado:
; 2 exit points
;	.line	162; "bingo.c"	uint8_t fue_utilizado(uint8_t num) {
	BANKSEL	r0x1023
	MOVWF	r0x1023
;	.line	164; "bingo.c"	for (uint8_t i = 0; i < MAX_NUMEROS; i++) {
	CLRF	r0x1024
;;unsigned compare: left < lit(0xA=10), size=1
_00155_DS_:
	MOVLW	0x0a
	BANKSEL	r0x1024
	SUBWF	r0x1024,W
	BTFSC	STATUS,0
	GOTO	_00153_DS_
;;genSkipc:3307: created from rifx:0x7ffc6a9a1390
;	.line	165; "bingo.c"	if (numeros_usados[i] == num) {
	MOVF	r0x1024,W
	ADDLW	(_numeros_usados + 0)
	MOVWF	r0x1025
	MOVLW	high (_numeros_usados + 0)
	BTFSC	STATUS,0
	ADDLW	0x01
	MOVWF	r0x1026
	MOVF	r0x1025,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1026
	BTFSC	r0x1026,0
	BSF	STATUS,7
	BANKSEL	INDF
	MOVF	INDF,W
;;1	MOVWF	r0x1027
	BANKSEL	r0x1023
	XORWF	r0x1023,W
	BTFSS	STATUS,2
	GOTO	_00156_DS_
;	.line	166; "bingo.c"	return 1; // Si el número ya se ha utilizado, retorna 1.
	MOVLW	0x01
	GOTO	_00157_DS_
_00156_DS_:
;	.line	164; "bingo.c"	for (uint8_t i = 0; i < MAX_NUMEROS; i++) {
	BANKSEL	r0x1024
	INCF	r0x1024,F
	GOTO	_00155_DS_
_00153_DS_:
;	.line	169; "bingo.c"	return 0;
	MOVLW	0x00
_00157_DS_:
;	.line	170; "bingo.c"	}
	RETURN	
; exit point of _fue_utilizado


;	code size estimation:
;	  360+  129 =   489 instructions ( 1236 byte)

	end
