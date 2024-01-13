/*
 Copyright (C) 2018  Intel Corporation. All rights reserved.
 Your use of Intel Corporation's design tools, logic functions 
 and other software and tools, and its AMPP partner logic 
 functions, and any output files from any of the foregoing 
 (including device programming or simulation files), and any 
 associated documentation or information are expressly subject 
 to the terms and conditions of the Intel Program License 
 Subscription Agreement, the Intel Quartus Prime License Agreement,
 the Intel FPGA IP License Agreement, or other applicable license
 agreement, including, without limitation, that your use is for
 the sole purpose of programming logic devices manufactured by
 Intel and sold by Intel or its authorized distributors.  Please
 refer to the applicable agreement for further details.
*/
MODEL
/*MODEL HEADER*/
/*
 This file contains Slow Corner delays for the design using part 10M50DAF484C7G
 with speed grade 7, core voltage 1.2V, and temperature 0 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "testfreq";
DATE "01/13/2024 23:28:24";
PROGRAM "Quartus Prime";



INPUT clk;
INPUT PAR_LOAD[0];
INPUT PAR_LOAD[1];
INPUT PAR_LOAD[2];
INPUT reset;
INPUT LOAD_P;
INPUT LOAD_D;
INPUT outselect[0];
INPUT outselect[1];
INPUT outselect[2];
OUTPUT sevenseg0[0];
OUTPUT sevenseg0[1];
OUTPUT sevenseg0[2];
OUTPUT sevenseg0[3];
OUTPUT sevenseg0[4];
OUTPUT sevenseg0[5];
OUTPUT sevenseg0[6];
OUTPUT sevenseg1[0];
OUTPUT sevenseg1[1];
OUTPUT sevenseg1[2];
OUTPUT sevenseg1[3];
OUTPUT sevenseg1[4];
OUTPUT sevenseg1[5];
OUTPUT sevenseg1[6];
OUTPUT sevenseg2[0];
OUTPUT sevenseg2[1];
OUTPUT sevenseg2[2];
OUTPUT sevenseg2[3];
OUTPUT sevenseg2[4];
OUTPUT sevenseg2[5];
OUTPUT sevenseg2[6];
OUTPUT sevenseg3[0];
OUTPUT sevenseg3[1];
OUTPUT sevenseg3[2];
OUTPUT sevenseg3[3];
OUTPUT sevenseg3[4];
OUTPUT sevenseg3[5];
OUTPUT sevenseg3[6];
OUTPUT sevenseg5[0];
OUTPUT sevenseg5[1];
OUTPUT sevenseg5[2];
OUTPUT sevenseg5[3];
OUTPUT sevenseg5[4];
OUTPUT sevenseg5[5];
OUTPUT sevenseg5[6];
OUTPUT pinout[0];
OUTPUT pinout[1];
OUTPUT pinout[2];
OUTPUT out;

/*Arc definitions start here*/
pos_LOAD_D__clk__setup:		SETUP (POSEDGE) LOAD_D clk ;
pos_LOAD_P__clk__setup:		SETUP (POSEDGE) LOAD_P clk ;
pos_PAR_LOAD[0]__clk__setup:		SETUP (POSEDGE) PAR_LOAD[0] clk ;
pos_PAR_LOAD[1]__clk__setup:		SETUP (POSEDGE) PAR_LOAD[1] clk ;
pos_PAR_LOAD[2]__clk__setup:		SETUP (POSEDGE) PAR_LOAD[2] clk ;
pos_reset__clk__setup:		SETUP (POSEDGE) reset clk ;
pos_LOAD_D__clk__hold:		HOLD (POSEDGE) LOAD_D clk ;
pos_LOAD_P__clk__hold:		HOLD (POSEDGE) LOAD_P clk ;
pos_PAR_LOAD[0]__clk__hold:		HOLD (POSEDGE) PAR_LOAD[0] clk ;
pos_PAR_LOAD[1]__clk__hold:		HOLD (POSEDGE) PAR_LOAD[1] clk ;
pos_PAR_LOAD[2]__clk__hold:		HOLD (POSEDGE) PAR_LOAD[2] clk ;
pos_reset__clk__hold:		HOLD (POSEDGE) reset clk ;
pos_clk__out__delay:		DELAY (POSEDGE) clk out ;
pos_clk__pinout[0]__delay:		DELAY (POSEDGE) clk pinout[0] ;
pos_clk__pinout[1]__delay:		DELAY (POSEDGE) clk pinout[1] ;
pos_clk__pinout[2]__delay:		DELAY (POSEDGE) clk pinout[2] ;
pos_display:display7seg|seconds_clk__sevenseg0[1]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg0[1] ;
pos_display:display7seg|seconds_clk__sevenseg0[3]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg0[3] ;
pos_display:display7seg|seconds_clk__sevenseg0[4]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg0[4] ;
pos_display:display7seg|seconds_clk__sevenseg0[6]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg0[6] ;
pos_display:display7seg|seconds_clk__sevenseg1[0]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg1[0] ;
pos_display:display7seg|seconds_clk__sevenseg1[3]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg1[3] ;
pos_display:display7seg|seconds_clk__sevenseg1[4]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg1[4] ;
pos_display:display7seg|seconds_clk__sevenseg2[1]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg2[1] ;
pos_display:display7seg|seconds_clk__sevenseg2[4]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg2[4] ;
pos_display:display7seg|seconds_clk__sevenseg2[5]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg2[5] ;
pos_display:display7seg|seconds_clk__sevenseg3[0]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg3[0] ;
pos_display:display7seg|seconds_clk__sevenseg3[1]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg3[1] ;
pos_display:display7seg|seconds_clk__sevenseg3[3]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg3[3] ;
pos_display:display7seg|seconds_clk__sevenseg3[4]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg3[4] ;
pos_display:display7seg|seconds_clk__sevenseg3[5]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg3[5] ;
pos_display:display7seg|seconds_clk__sevenseg5[0]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg5[0] ;
pos_display:display7seg|seconds_clk__sevenseg5[1]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg5[1] ;
pos_display:display7seg|seconds_clk__sevenseg5[2]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg5[2] ;
pos_display:display7seg|seconds_clk__sevenseg5[3]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg5[3] ;
pos_display:display7seg|seconds_clk__sevenseg5[4]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg5[4] ;
pos_display:display7seg|seconds_clk__sevenseg5[5]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg5[5] ;
pos_display:display7seg|seconds_clk__sevenseg5[6]__delay:		DELAY (POSEDGE) display:display7seg|seconds_clk sevenseg5[6] ;
___9.075__delay:		DELAY  9.075 ;
___12.378__delay:		DELAY  12.378 ;
___12.721__delay:		DELAY  12.721 ;

ENDMODEL
