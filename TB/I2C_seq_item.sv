class I2C_seq_item extends uvm_sequence_item;




  `uvm_object_utils(I2C_seq_item)
  
  
  
  
  		 rand logic reset;
		 
		 rand logic wr_i2c;
		 
       rand logic[7:0]  data_in;
		 
       rand logic[2:0] cmd;
		 
		 rand logic[15:0] dvsr;
		 
		 logic[7:0] data_out;
		 
		 logic ready;
		 
		 logic done_tick;
		 
		 logic ACK;
		 
		 logic SCL;
		 
		 logic SDA;

  
  
  
  
  constraint c1 { cmd inside {[0:4]}; }
  
 constraint c2 { dvsr==3; }

 
  
  
  function new(string name = "I2C_seq_item");
  
  
    super.new(name);
  
    `uvm_info(get_type_name(),"Inside constructor of I2C seq item Class",UVM_HIGH)
  
  
  endfunction :new
  
  
  
  
  
  
  
  
  
endclass :I2C_seq_item