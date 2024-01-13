// Top-level module for Adjustable Frequency Divider 

// General workflow of the system: 
// 	1) Set value and press bottom button (period). (2-6)
// 	2) Set value and press upper bottom (duty cycle in fractions). (0-6 and smaller than period)
//      3) Waveform is generated and period and duty cycle can be adjusted 
//			anytime as long as values are logical.

module testfreq ( 
	// I/O Declarations (Verilog 2001 format)
	output [6:0] sevenseg0, 					// 5 7-bits output vectors for seven segment displays
		     sevenseg1,
		     sevenseg2, 
		     sevenseg3, 
		     sevenseg5,
	input [2:0] outselect, 						// 3-bits output line selection
	output reg [2:0] pinout,					// 3-bit pinout of the overall system
	input clk, reset, 						// 1-bit synchronous clock and reset
	input LOAD_P, LOAD_D, 						// 1-bit control signal for period and duty cycle (active LOW)
	input [2:0] PAR_LOAD, 						// 3-bits parellel load for period and duty cycle counters
	output reg out							// 1-bit system output value
);

	
	// Non I/O Declarations:
	reg [2:0] period, dutyFrac;				// 3-bits value holder for period and duty cycle
	reg [2:0] pcounter, dcounter;   			// 3-bit register of counters
	reg [2:0] Qn, Qnxt; 				 	// 3-bit present state and next state
	wire p_active, d_active; 				// 1-bit control signals for period and duty cycle counters
	
	
	// Parameter declaration for states
	parameter IDLE = 3'd0,
		  S1   = 3'd1,
		  S2   = 3'd2,
		  S3   = 3'd3,
		  S4   = 3'd4,
		  S5   = 3'd5;
	
	
	// Initial reset for present state, period, and duty cycle fraction
	initial begin
		Qn 	 = IDLE;
		period   = 3'd0;
		dutyFrac = 3'd0;
	end
	
	
	// Assignment for control signal of period and duty cycle fraction counter
	assign p_active = pcounter > 3'd1;
	assign d_active = dcounter != 3'd0 && p_active;
	
	
	// Sequential block for the overall system
	always @ (posedge clk) begin
		// If RESET signal on, then reset present state, period value and duty cycle fraction value
		if (reset) begin
			Qn <= IDLE;
			period <= 3'd0;
			dutyFrac <= 3'd0;
		end
		
		else begin
			// present state <- current state
			Qn <= Qnxt;
			
			
			// Hold/Load conditions for period and duty cycle load registers
			// Check for period hold/load
			if (~LOAD_P && (PAR_LOAD >= dutyFrac) && (PAR_LOAD >= 2 && PAR_LOAD <= 6)) begin
				period <= PAR_LOAD;
			end
			
			// Check for duty cycle hold/load
			if (~LOAD_D && (PAR_LOAD <= period)) begin
				dutyFrac <= PAR_LOAD ;
			end
			
			// Extra condition to make sure duty cycle never exceeds period
			if (period < dutyFrac) begin
				dutyFrac <= 3'd0;
			end
			
			
			// Decrement logic for period and duty cycle counters
			pcounter <= p_active ? pcounter - 3'd1 : period;
			dcounter <= d_active ? dcounter - 3'd1 : (p_active ? 3'd0 : dutyFrac); // extra logic incase period counter gets cutoff prematurely
		end
	end
	
	// Next state and output multiplexer block
	always @ (*) begin
		case (Qn) // Present state as selector
			IDLE: {Qnxt, out} = p_active ? {S1,   d_active} : {IDLE, 1'd0};
			S1  : {Qnxt, out} = p_active ? {S2,   d_active} : {IDLE, 1'd0}; 
			S2  : {Qnxt, out} = p_active ? {S3,   d_active} : {IDLE, 1'd0};
			S3  : {Qnxt, out} = p_active ? {S4,   d_active} : {IDLE, 1'd0};
			S4  : {Qnxt, out} = p_active ? {S5,   d_active} : {IDLE, 1'd0};
			S5  : {Qnxt, out} = p_active ? {IDLE, d_active} : {IDLE, 1'd0};
			default: {Qnxt, out} = {IDLE, 1'd0}; // Resets next state and output in cases of error
		endcase

		// Pinout selection (2 to 3 encoder logic) (Means 1 output neglected)
		pinout[2] = outselect[2] ? out : 1'b0;
		pinout[1] = outselect[1] ? out : 1'b0;
		pinout[0] = outselect[0] ? out : 1'b0;
	end
	
	// Display module call
	display display7seg (sevenseg0, sevenseg1, sevenseg2, sevenseg3, sevenseg5, clk, period, dutyFrac);
endmodule




// Display module using on-board 7-segment displays
/*
	7-bit arrangement: abcdefg
		    a
		  f   b
		    g
		  e   c
		    d
*/
module display (
	// I/O Declarations
	output reg [6:0] sevenseg0, 	// 5 7-bit output vectors & registers for seven segment displays
			 sevenseg1, 
			 sevenseg2, 
			 sevenseg3, 
			 sevenseg5, 
	input clk,			// 1-bit clock input
	input [2:0] period, dutyFrac    // 3-bit inputs period and duty fraction
);
	
	// Non I/O Declarations:
	reg [24:0] delay1s;			// Counter register for 1Hz clock based on 50MHz internal clock

	reg seconds_clk;			// Resultant 1Hz clock signal 
	reg state;				// State holder for period/duty cycle display
	reg [6:0] period7seg, 			// Value holder in decoded state for period and duty cycle
		  duty7seg;
	
	
	// Counter logic for 1Hz clock generator
	always @ (posedge clk) begin
		if (delay1s > 25'd24_999_999) begin
			delay1s <= 25'd0;
			seconds_clk <= ~seconds_clk;
		end
		else
			delay1s <= delay1s + 25'd1;
	end
	// 7-segment display logic
	always @ (posedge seconds_clk) begin
	if (seconds_clk) begin
		if (state) begin
			// Prd : X
			sevenseg0 <= 7'b0011000;
			sevenseg1 <= 7'b1111010;
			sevenseg2 <= 7'b1000010;
			sevenseg3 <= 7'b1111111;
			sevenseg5 <= ~period7seg;
		end
		else begin
			// Duty: X
			sevenseg0 <= 7'b1000010;
			sevenseg1 <= 7'b1100011;
			sevenseg2 <= 7'b1110000;
			sevenseg3 <= 7'b1000100;
			sevenseg5 <= ~duty7seg;
		end
		state <= ~state;
	end
	end
	
	// 3 to 7 decoder for 7 segment format
	always @ (*) begin
		// Decoder for period 
		case (period)
			3'd0	 : period7seg <= 7'b1111110;
			3'd1	 : period7seg <= 7'b0110000;
			3'd2	 : period7seg <= 7'b1101101;
			3'd3	 : period7seg <= 7'b1111001;
			3'd4	 : period7seg <= 7'b0110011;
			3'd5	 : period7seg <= 7'b1011011;
			3'd6	 : period7seg <= 7'b1011111;
			default  : period7seg <= 7'b1101111;
		endcase
		// Decoder for duty cycle
		case (dutyFrac)
			3'd0	 : duty7seg <= 7'b1111110;
			3'd1	 : duty7seg <= 7'b0110000;
			3'd2	 : duty7seg <= 7'b1101101;
			3'd3	 : duty7seg <= 7'b1111001;
			3'd4	 : duty7seg <= 7'b0110011;
			3'd5	 : duty7seg <= 7'b1011011;
			3'd6	 : duty7seg <= 7'b1011111;
			default  : duty7seg <= 7'b1101111;
		endcase
	end
	

endmodule

