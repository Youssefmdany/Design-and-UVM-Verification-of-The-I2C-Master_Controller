
///////////////////////////////
//Base_sequence/////////////////////////////
///////////////////////////////

class Base_sequence extends uvm_sequence #(I2C_seq_item);

  
  
  `uvm_object_utils(Base_sequence)
   
  
  
  
  
  function  new(string name = "Base_sequence");
  
  
     super.new(name);
	  
  
  endfunction: new
  

  

endclass: Base_sequence







///////////////////////////////
//Reset_sequence/////////////////////////////
///////////////////////////////

class Reset_seq extends Base_sequence;



  `uvm_object_utils(Reset_seq)
  
  
   I2C_seq_item reset_item;
	

   function  new(string name = "Reset_seq");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    reset_item = I2C_seq_item::type_id::create("reset_item");
  
  
    start_item(reset_item);
	 
	 
	 if(!(reset_item.randomize() with { reset==1;  data_in==8'b0; cmd!=3'b000 ;} ))
	   
		   `uvm_error(get_type_name(),"randomization failed in Reset_seq")
		
	 
	 finish_item(reset_item);
	 
  
  endtask: body
  
  


  
endclass: Reset_seq









///////////////////////////////
//write_sequence/////////////////////////////
///////////////////////////////

class I2C_seq1 extends Base_sequence;



  `uvm_object_utils(I2C_seq1)
  
  
   I2C_seq_item item;
	

   function  new(string name = "I2C_seq1");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    item = I2C_seq_item::type_id::create("item");
  
  
    start_item(item);
	 
	 
	 if(!(item.randomize() with { reset==0;  cmd==3'b011; dvsr==3;  wr_i2c==1;} ))
	 
	    	`uvm_error(get_type_name(),"randomization failed in I2C_seq1")
 
	 
	 finish_item(item);
	 
  
  endtask: body
  
  


  
endclass: I2C_seq1












///////////////////////////////
//read_sequence/////////////////////////////
///////////////////////////////

class I2C_seq2 extends Base_sequence;



  `uvm_object_utils(I2C_seq2)
  
  
   I2C_seq_item item;
	

   function  new(string name = "I2C_seq2");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    item = I2C_seq_item::type_id::create("item");
  
  
    start_item(item);
	 
	 
	 if(!(item.randomize() with { reset==0;  cmd==3'b010; dvsr==3; wr_i2c==1;} ))
	 
	    	`uvm_error(get_type_name(),"randomization failed in I2C_seq2")

			
	 finish_item(item);
	 
  
  endtask: body
  
  


  
endclass: I2C_seq2












///////////////////////////////
//restart_sequence/////////////////////////////
///////////////////////////////

class I2C_seq3 extends Base_sequence;



  `uvm_object_utils(I2C_seq3)
  
  
   I2C_seq_item item;
	

   function  new(string name = "I2C_seq3");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    item = I2C_seq_item::type_id::create("item");
  
  
    start_item(item);
	 
	 
	 if(!(item.randomize() with { reset==0;  cmd==3'b100;  dvsr==3; wr_i2c==1; data_in==8'b0; } ))
	 
	    	`uvm_error(get_type_name(),"randomization failed in I2C_seq3")

			
	 finish_item(item);
	 
  
  endtask: body
  
  


  
endclass: I2C_seq3
















///////////////////////////////
//stop_sequence/////////////////////////////
///////////////////////////////

class I2C_seq4 extends Base_sequence;



  `uvm_object_utils(I2C_seq4)
  
  
   I2C_seq_item item;
	

   function  new(string name = "I2C_seq4");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    item = I2C_seq_item::type_id::create("item");
  
  
    start_item(item);
	 
	 
	 if(!(item.randomize() with { reset==0;  cmd==3'b001;  dvsr==3; wr_i2c==1; data_in==8'b0; } ))
	 
	    	`uvm_error(get_type_name(),"randomization failed in I2C_seq4")

			
	 finish_item(item);
	 
  
  endtask: body
  
  endclass: I2C_seq4 





///////////////////////////////
//start_sequence/////////////////////////////
///////////////////////////////

class I2C_seq5 extends Base_sequence;



  `uvm_object_utils(I2C_seq5)
  
  
   I2C_seq_item item;
	

   function  new(string name = "I2C_seq5");
  
  
     super.new(name);
	  
  
   endfunction: new
  
  
  
  
  
  task body();
  
  
    item = I2C_seq_item::type_id::create("item");
  
  
    start_item(item);
	 
	 
	 if(!(item.randomize() with { reset==0;  cmd==3'b000;  dvsr==3; wr_i2c==1; data_in==8'b0; } ))
	 
	    	`uvm_error(get_type_name(),"randomization failed in I2C_seq5")

			
	 finish_item(item);
	 
  
  endtask: body
  
  


  
endclass: I2C_seq5




