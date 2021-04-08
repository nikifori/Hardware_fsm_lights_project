`timescale 1ms/1ms

module fsm2_behavioral_tb;

	wire GRN_tb, YLW_tb, RED_tb;
	reg Clock_tb, Reset_tb, CAR_tb;


	fsm2_behavioral DUT (.GRN(GRN_tb), .YLW(YLW_tb), .RED(RED_tb), 
		     	     .Clock(Clock_tb), .Reset(Reset_tb), .CAR(CAR_tb));


	// Reset----------------------------------------------------
	initial
	 begin
		Reset_tb = 1'b0; //Elegxw synchrono reset
	#1000	Reset_tb = 1'b1; // reset->1 , xekinaei o elegxos toy fsm
	#49500	Reset_tb = 1'b0; // reset->0 , elegxos metavashs green->yellow->red me to reset.
	#1000	Reset_tb = 1'b1; // epanafora reset se 1 meta apo mia periodo
	#27000	Reset_tb = 1'b0; // kanw reset otan exw yellow gia na paw yellow->yellow->red
	#1000	Reset_tb = 1'b1; // epanafora reset se 1 meta apo mia periodo
	#33000 	Reset_tb = 1'b0; // reset sto red gia na paw red->yellow->red
	#1000	Reset_tb = 1'b1; // epanafora reset se 1 meta apo mia periodo



	  end

	// Clock-----------------------------------------------------
	initial
	 begin
		Clock_tb = 1'b0;
	 end

	always 
	 begin
		#500 Clock_tb = ~Clock_tb;
	 end


	// Shma CAR_tb ------------------------------------------------
	initial 
	 begin
		  	CAR_tb = 1'b0; //20500 me 25500 elegxw to green an sinexizei na einai green
		#25400	CAR_tb = 1'b1; // kanw CAR_tb=1 gia na elegxw green->yellow->red meta apo 20 second
		#1000	CAR_tb = 1'b0; // xanakanw CAR_tb=0 wste otan girisw sto green na meinw sto green
		#49000	CAR_tb = 1'b1; // CAR_tb=1 gia na paw yellow kai na testarw reset sto yellow
		#1000	CAR_tb = 1'b0; // xana CAR_tb=0
		#24000	CAR_tb = 1'b1; // CAR_tb=1 gia na paw red na kanw reset
		#1000 	CAR_tb = 1'b0; // epanafora car wste otan paw green na meinw


	 end

endmodule
