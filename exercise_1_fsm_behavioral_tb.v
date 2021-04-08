`timescale 1ns/1ns

module fsm1_behavioral_tb;

	wire Dout_tb;
	reg Clock_tb, Reset_tb, Din_tb;

	fsm1_behavioral DUT (Dout_tb, Clock_tb, Reset_tb, Din_tb);

	// Reset-------------------------------------------------
	initial
	 begin
			Reset_tb = 1'b0;
		#10	Reset_tb = 1'b1;
		#5	Reset_tb = 1'b0; // reset sto mid 15 ns
		#5	Reset_tb = 1'b1; // epanafora reset sto 1
		#5	Reset_tb = 1'b0; // reset sto start sto 25ns
		#5	Reset_tb = 1'b1; // epanafora reset sto 1
		#15	Reset_tb = 1'b0; // reset sto start sto 45ns
		#5	Reset_tb = 1'b1; // epanafora reset sto 1
		

		

	 end
	// Clock signal---------------------------------------------
	initial
 	 begin 
  	  	Clock_tb = 1'b1;
 	 end

	always 
 	 begin
  	 	#5 Clock_tb = ~Clock_tb; // Periodos rologiou 10ns
 	 end


	// Shma Din--------------------------------------------------
	initial 
	 begin
			Din_tb = 1'b1; // start->mid->reset sto 10ns
		#19	Din_tb = 1'b0; // start->start->reset sto 20ns
		#10	Din_tb = 1'b1; // start->mid(Din=1)->done->reset sto 30ns
		#30 	Din_tb = 1'b0; // start->mid(Din=0)->done
		#4	Din_tb = 1'b1; // start->mid(Din=0)->done(Dout=1)
		#27 	Din_tb = 1'b0; // start->mid->done(Dout=0)


	 end 




endmodule 