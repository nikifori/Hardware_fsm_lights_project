module fsm2_behavioral (output reg GRN, YLW, RED,
			input wire Clock, Reset, CAR);

	reg [1:0] current_state, next_state;
	reg [4:0] CNT;
	reg TIMEOUT, YLWTIMEOUT, Reset_sy;

	parameter green = 2'b00,
		  yellow = 2'b01,
		  red = 2'b10;


	// Sichrono reset-------------------------------------------------------------------------------------------------------------------------
	always @ (posedge Clock)
	 begin
		Reset_sy <= Reset;
	 end


	// Apothikeush Katastashs----------------------------------------------------------------------------------------------------------------------------
	always @ (posedge Clock or negedge Reset_sy)
	 begin: STATE_MEMORY
	  if (!Reset_sy)
		current_state <= yellow;
	  else
		current_state <= next_state;
	end
	  
	
	// Aparithmiths--------------------------------------------------------------------------------------------------------------------
	always @ (posedge Clock or negedge Reset_sy)
	 begin: COUNTER
	  if (!Reset_sy)
	   begin
		CNT <= 13;
		TIMEOUT <= 0;
		YLWTIMEOUT <= 0;
	   end
	  else
	   begin
		case (current_state)
		 green: begin
			 CNT <= 14;
			 TIMEOUT <= 0;
			 YLWTIMEOUT <= 0;
			 end
	  	 yellow: if (CNT==11)
			 begin
			 CNT <= 15;
			 YLWTIMEOUT <= 1;
			 end
			else
			 begin
			 CNT <= CNT-1;
			 YLWTIMEOUT <= 0;
			 TIMEOUT <= 0;
			 end
		 red: if (CNT==1)
			 begin
			 CNT <= 15;
			 TIMEOUT <= 1;
			 end
			else
			 begin
			 CNT <= CNT-1;
			 TIMEOUT <= 0;
			 YLWTIMEOUT <= 0;
			 end
	      	endcase
	   end
	end
	  


	// Epomenh Katastash--------------------------------------------------------------------------------------------------------------------
	always @ (current_state or CAR or YLWTIMEOUT or TIMEOUT)
	 begin: NEXT_STATE_LOGIC
	  case (current_state)
	   green : if (CAR==1'b1) next_state = yellow;
	  	else next_state = green;

	   yellow : if (YLWTIMEOUT==1) next_state = red;
		else next_state = yellow;
	   
	    red : if (TIMEOUT==1) next_state = green;
		else next_state = red;
	   endcase
	  end
 



	// Exodos--------------------------------------------------------------------------------------------------------------------
	always @ (current_state or CAR)
	 begin: OUTPUT_LOGIC
	  case (current_state)
	   green : 
		begin
		 GRN = 1'b1;
		 YLW = 1'b0;
		 RED = 1'b0;
		end
	   yellow :
		begin
		 GRN = 1'b0;
		 YLW = 1'b1;
		 RED = 1'b0;
		end
	   red : 
		begin
		 GRN = 1'b0;
		 YLW = 1'b0;
		 RED = 1'b1;
		end

	  endcase
	end

endmodule
