// Top-level module for Adjustable Frequency Divider 
module FreqDivider( 
	input clk, reset, 							// 1-bit synchronous clock and reset
	input LOAD_P, LOAD_D, 						// 1-bit control signal for period and duty cycle
	input [2:0] PAR_LOAD, 						// 3-bits parellel load for period and duty cycle counters
	output p_active, d_active, 				// 1-bit control signals for counters
	output reg [2:0] period, dutyFrac,  	// 3-bits value holder for period and duty cycle
	output reg out, 								// 1-bit system output value
	output reg [2:0] pcounter, dcounter,   // Implement pcounter atleast input 2
	output reg [2:0] Qn, Qnxt 				 	// 3-bit present state and next state
);
	
	// Parameter declaration
	parameter IDLE = 3'd0,
				 S1   = 3'd1,
				 S2 	= 3'd2,
				 S3 	= 3'd3,
				 S4 	= 3'd4,
				 S5 	= 3'd5;
	
	// Initial reset for present state, period, and duty cycle fraction
	initial Qn = IDLE;
	initial period = 3'd0;
	initial dutyFrac = 3'd0;
	
	
	// Assignment for control signal of period and duty cycle fraction counter
	assign p_active = (pcounter != 3'd0 && pcounter != 3'd1);
	assign d_active = (dcounter != 3'd0 && pcounter != 3'd1) && p_active;
	
	// Sequential block
	always @ (posedge clk) begin
		// If RESET signal on, then reset present state, period value and duty cycle fraction value
		if (reset) begin
			Qn <= IDLE;
			period <= 3'd0;
			dutyFrac <= 3'd0;
		end
		else begin
			Qn <= Qnxt;
			period <= (LOAD_P && (PAR_LOAD > dutyFrac) && (PAR_LOAD >= 2)) ? PAR_LOAD : period;
			dutyFrac <= LOAD_D ? PAR_LOAD : dutyFrac;
			pcounter <= p_active ? pcounter - 3'd1 : period;
			dcounter <= d_active ? dcounter - 3'd1 : (p_active ? 3'd0 : dutyFrac);
		end
	end
	
	// Next state and output multiplexer block
	always @ (*) begin
		case (Qn)
			IDLE: {Qnxt, out} = p_active ? {S1, d_active} : {IDLE, 1'd0};
			S1	 : {Qnxt, out} = p_active ? {S2, d_active} : {IDLE, 1'd0};
			S2  : {Qnxt, out} = p_active ? {S3, d_active} : {IDLE, 1'd0};
			S3  : {Qnxt, out} = p_active ? {S4, d_active} : {IDLE, 1'd0};
			S4  : {Qnxt, out} = p_active ? {S5, d_active} : {IDLE, 1'd0};
			S5  : {Qnxt, out} = p_active ? {IDLE, d_active} : {IDLE, 1'd0};
			default: {Qnxt, out} = {IDLE, 1'd0}; // Resets next state and output in cases of error
		endcase
	end
	
endmodule
