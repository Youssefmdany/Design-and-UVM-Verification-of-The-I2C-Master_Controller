interface Interface (input logic clk);

		 
		 logic reset;
		 
		 logic wr_i2c;
		 
       logic[7:0]  data_in;
		 
       logic[2:0] cmd;
		 
		 logic[15:0] dvsr;
		 
		 logic[7:0] data_out;
		 
		 logic ready;
		 
		 logic done_tick;
		 
		 logic ACK;
		 
		 tri SCL;
		 
		 tri SDA;



endinterface 