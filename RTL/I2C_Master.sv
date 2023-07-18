



module I2C_Master#( 
                   
						 parameter Start_CMD = 3'b000,
						 parameter Stop_CMD = 3'b001,
						 parameter Read_CMD = 3'b010,
						 parameter Write_CMD = 3'b011,
						 parameter Restart_CMD = 3'b100
                                                    ) 
               
				  	  (
           	input logic clk,
						input logic reset,
						input logic wr_i2c,
            input logic[7:0]  data_in,
            input logic[2:0] cmd,
						input logic[15:0] dvsr,
						output logic[7:0] data_out,
						output logic ready,
						output logic done_tick,
						output logic ACK,
						output tri SCL,
						inout tri SDA 
						                 );
								
	

	
	
 // FSM state data type
  typedef enum {idle, hold, start1, start2, data1, data2, data3, data4, 
      data_end, restart, stop1, stop2   } State_Type;




		
//Intermediate signals declaration

State_Type State_reg, State_next;

logic[8:0] TX_reg, TX_next; // 8 bit data + ack bit

logic[8:0] RX_reg, RX_next; // 8 bit data + ack bit

logic[2:0] CMD_reg, CMD_next;

logic[15:0] Count_reg, Count_next;

logic[3:0] NumBits_reg, NumBits_next; //number of bits transmitted or received

logic[15:0] Quarter, Half; //quarter cycle counts,half cycle counts

logic sda_t,sda_reg,scl_t,scl_reg,data_proc;

logic link,NACK; //write into bus , negative acknowledgement

logic done_tick_reg,done_tick_next, ready_t; 
	

	
	
// SCL and SDA are pulled up resistors so the high by default
	
assign SCL = scl_reg ? 1'b1 : 1'b0 ;  // master is the only device that drives clock signal
	
	
	
/*	if master read and the num bits less than 8 
   or write and the current bit is the 8th
   then connect the sda line to the master */
	
assign link = (data_proc && CMD_reg==Write_CMD && NumBits_reg==8) || 
                    (data_proc && CMD_reg==Read_CMD && NumBits_reg<8);
				  
	
	
assign SDA = (link || sda_reg) ? 1'b1 : 1'b0 ;


assign Quarter = dvsr;


assign Half = dvsr * 2;





always_ff@(posedge clk, posedge reset) begin 



   if(reset) begin 
	
	    scl_reg <= 1;
		 sda_reg <= 1;

	      end
   
	
	else begin 
	
	    scl_reg <= scl_t;
		 sda_reg <= sda_t;

	
	      end
			
			

end









always_ff@(posedge clk, posedge reset) begin 



   if(reset) begin 
	
	    State_reg = idle;
	    TX_reg <= 0;
		 RX_reg <= 0;
       CMD_reg <= 0;
		 Count_reg <= 0; 
		 NumBits_reg <= 0;       
		 done_tick_reg <= 0;
	      end
   
	
	else begin 
	
	    State_reg = State_next;
	    TX_reg <= TX_next;
		 RX_reg <= RX_next;
       CMD_reg <= CMD_next;
		 Count_reg <= Count_next; 
		 NumBits_reg <= NumBits_next; 
	   done_tick_reg <= done_tick_next;
	      end
			
			

end










always_comb begin 

   
      State_next = State_reg;
	   TX_next = TX_reg;
	   RX_next = RX_reg;
      CMD_next = CMD_reg;
	   Count_next = Count_reg +1 ; 
	   NumBits_next = NumBits_reg; 	
      sda_t = 1'b1;
		scl_t = 1'b1;
      done_tick_next = done_tick_reg;
      ready_t = 1'b0;
		data_proc = 1'b0;
		
		
		 case (State_reg) 
		 
		 
		 
		 
		    idle: begin 
			 
			         
				  ready_t = 1'b1;
			     
				  if(wr_i2c && cmd==Start_CMD) begin 
				  
				     State_next = start1;
				     Count_next = 0;
				  
				  end
			 

			 end
			
		
		
		
		
		
		
		    start1: begin 
			 
			         
				  sda_t = 1'b0;
			     
				  if(Count_reg==Half) begin 
				  
				     State_next = start2;
				     Count_next = 0;
				  
				  end
			 

			 end
		
		
		
		
		
		
		    start2: begin 
			 
			         
				  sda_t = 1'b0;
				  scl_t = 1'b0;
			     
				  if(Count_reg==Quarter) begin 
				  
				     State_next = hold;
				     Count_next = 0;
				  
				  end
				  

			 end




			 
			 		
		
		
		
		    hold: begin 
			 
			 
				  ready_t = 1'b1;			         
				  sda_t = 1'b0;
				  scl_t = 1'b0;
			     
				  if(wr_i2c) begin 
				  
				     CMD_next = cmd;
				     Count_next = 0;
					  
					    case(cmd) 
						 
						 
						   Restart_CMD: begin 
							
				             State_next = restart;
							  
							
							end


						   Stop_CMD: begin 
							
				             State_next = stop1;
							  
							
							end


						   default: begin 
							
				             State_next = data1;
							    NumBits_next = 0;
							    TX_next = { data_in , NACK };
								 
							end
							
				    endcase
				  
				  end
			 

			 
			 end

			 
			 
			 
		
		
		
		
		    data1: begin 
			 
			         
				  sda_t = TX_reg[8];
				  scl_t = 1'b0;
			     data_proc = 1'b1;
				  
				  if(Count_reg==Quarter) begin 
				  
				     State_next = data2;
				     Count_next = 0;
				  
				  end
			 

			 end




		
		
		
		
		    data2: begin 
			 
			         
				  sda_t = TX_reg[8];
				  scl_t = 1'b1;    // if we removed it nothing would change as it's pulled up by default
			     data_proc = 1'b1;
			     
				  if(Count_reg==Quarter) begin 
				  
				     State_next = data3;
				     Count_next = 0;
				     RX_next = { RX_reg[7:0] , SDA } ;
					  
				  end
			 

			 end



		
		
		
		
		    data3: begin 
			 
			         
				  sda_t = TX_reg[8];
				  scl_t = 1'b1;    // if we removed it nothing would change as it's pulled up by default
			     data_proc = 1'b1;
			     
				  if(Count_reg==Quarter) begin 
				  
				     State_next = data4;
				     Count_next = 0;
				  
				  end
			 

			 end



		
		
		
		
		    data4: begin 
			 
			         
				  sda_t = TX_reg[8];
				  scl_t = 1'b0;    
			     data_proc = 1'b1;
			     
				  if(Count_reg==Quarter) begin 
				  
				     Count_next = 0;
				  
				     if(NumBits_reg==8) begin 
					  
				       State_next = data_end;
					    done_tick_next = 1'b1;

					  end
				  
				     
					  
					  else begin 
					  
					    TX_next = { TX_reg[7:0] , 1'b0 };
                   NumBits_next = NumBits_reg + 1;
				       State_next = data1;
					  
					  end
					  
					  
				  
				  end
			 

			 end



		
		
		
		
		    data_end: begin 
			 
			         
				  sda_t = 1'b0;
				  scl_t = 1'b0;    
			     
				  if(Count_reg==Quarter) begin 
				     
				     done_tick_next= 1'b0;
				     State_next = hold;
				     Count_next = 0;
				  
				  end
			 

			 end



		
		
		
		
		    restart: begin 
			 
			         			     
				  if(Count_reg==Half) begin 
				  
				     State_next = start1;
				     Count_next = 0;
				  
				  end
			 

			 end



		
		
		
		
		    stop1: begin 
			 
			         
				  sda_t = 1'b0;
			     
				  if(Count_reg==Quarter) begin 
				  
				     State_next = stop2;
				     Count_next = 0;
				  
				  end
			 

			 end



		
		
		
		
		    stop2: begin 
			 
			         
				  sda_t = 1'b1; // if we removed it nothing would change as it's pulled up by default
				  scl_t = 1'b1; // if we removed it nothing would change as it's pulled up by default   
			     
				  if(Count_reg==Half) begin 
				  
				     State_next = idle;
				     Count_next = 0;
				  
				  end
			 

			 end


		
		
		
		
		    default: begin 
			 
	           // equivalent to stop2 state		         
			     
				  if(Count_reg==Half) begin 
				  
				     State_next = idle;
				     Count_next = 0;
				  
				  end
			 

			 end





	   endcase		 
			 
	

	
end

	
	
	
	
	
	
assign  data_out = RX_reg[8:1];
	
assign  ACK = RX_reg[0];
	
assign  NACK = data_in[0];
	
assign  done_tick = done_tick_reg;	
	
assign  ready = ready_t;	
	
	
	
								
endmodule 			