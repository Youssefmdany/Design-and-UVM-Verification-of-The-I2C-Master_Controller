
class Driver  extends uvm_driver #(I2C_seq_item);



  `uvm_component_utils(Driver)
  
  
  virtual Interface intf;
  
  
  I2C_seq_item item;
  
  
  
  
  
  
  
  function new(string name = "Driver" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Driver Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Driver Class",UVM_LOW)
   
   
   if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside Driver class")
  


  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Driver Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Driver Class",UVM_LOW)
    
	 
	 
	 
	 forever begin 
	 
	 
	 
	  item = I2C_seq_item::type_id::create("item");

	 
	  seq_item_port.get_next_item(item);
	  
	  
	  drive(item);
	  
	  
	  
	  seq_item_port.item_done();
	  
	  
	 
	 end
	 
 
 
 
  endtask :run_phase
  
  
  
  
  
  
  
  
  task  drive (I2C_seq_item item);
  
      
     
	 	  @(posedge intf.clk);	
	 	  
	 	  
      intf.reset = item.reset;
		
      intf.wr_i2c = item.wr_i2c;
		
      intf.data_in = item.data_in;
		
      intf.cmd = item.cmd;
		
      intf.dvsr = item.dvsr;

      
		
      
		
		
		
  
  endtask: drive

  
  
  
  
  
  
  
  
  
endclass :Driver