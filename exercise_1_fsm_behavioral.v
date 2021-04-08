module fsm1_behavioral (output reg Dout,
	 		input wire Clock, Reset, Din);
	
	reg [1:0] current_state, next_state;
	parameter Start = 2'b00,
		  Midway = 2'b01,
		  Done = 2'b10;

	// Apothikeush Katastashs---------------------------------
	always @ (posedge Clock or negedge Reset)
	 begin: STATE_MEMORY
	  if (!Reset)
		current_state <= Start;
	  else
		current_state <= next_state;
	end

	// Gia Epomenh Katastash--------------------------------------
	always @ (current_state or Din)
	 begin: NEXT_STATE_LOGIC
	  case (current_state)
	   Start : if (Din==1'b1) next_state = Midway;
		   else next_state = Start;
	   Midway : next_state = Done;
	   Done : next_state = Start;
	   default : next_state = Start;
	  endcase
	end

	// Exodos-------------------------------------------------------
	always @ (current_state or Din)
	 begin: OUTPUT_LOGIC
	  case (current_state)
	   Start : Dout = 1'b0;
	   Midway : Dout = 1'b0;
	   Done : if (Din==1) Dout=1'b1;
		  else Dout = 1'b0;
	  endcase
	end

endmodule 
