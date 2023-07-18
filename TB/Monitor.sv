class Monitor  extends uvm_monitor;



  `uvm_component_utils(Monitor)
  
  
  virtual Interface intf;
  
  
  
  uvm_analysis_port #(I2C_seq_item) monitor_port;
  
  
  I2C_seq_item item;
  
  

  
  
  
  
  
  
  
  function new(string name = "Monitor" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Monitor Class",UVM_LOW)
    
    
    
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Monitor Class",UVM_LOW)
	 
    
	 if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside Monitor class")
  
  
    
	 monitor_port = new("monitor_port",this);
	 
	 
	 
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Monitor Class",UVM_LOW)
	
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Monitor Class",UVM_LOW)
  
    
	 item = I2C_seq_item::type_id::create("item");
  
    
	 
	 forever begin 
	 
	 
	   item = I2C_seq_item::type_id::create("item");
		
	   
		wait(!intf.reset);

		    wait(intf.cmd == (3'b010 || 3'b011));		
		    
     repeat(171) @(posedge intf.clk);
      	 		
      item.wr_i2c = intf.wr_i2c;
		
      item.data_in = intf.data_in;
		
      item.cmd = intf.cmd;	
     
		  sample_the_results(item);

		  monitor_port.write(item);
		
	 end
	 
	 
	 
	 
 
  endtask :run_phase
  
  
   
    
  
  
  task sample_the_results(  I2C_seq_item item);
  
  
	   item.data_out = intf.data_out;
		
      item.ready = intf.ready;
		
      item.done_tick = intf.done_tick;
		
      item.ACK = intf.ACK;
		
      item.SCL = intf.SCL;
			  
      item.SDA = intf.SDA;

  
  endtask: sample_the_results
  
  
  
  
  
  
  
  
  
  
  
endclass :Monitor