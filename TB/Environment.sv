

class Environment  extends uvm_env;



  `uvm_component_utils(Environment)
  
  
  Agent I2C_Agent;
  
  Scoreboard I2C_Scoreboard;
  
  
  
  
  function new(string name = "Environment" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Environment Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Environment Class",UVM_LOW)

    
	 I2C_Agent = Agent::type_id::create("I2C_Agent",this);
   
   
   I2C_Scoreboard = Scoreboard::type_id::create("I2C_Scoreboard",this);
   
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Environment Class",UVM_LOW)
	 
	 I2C_Agent.I2C_monitor.monitor_port.connect(I2C_Scoreboard.Scoreboard_port);
	 
	
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Environment Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
endclass :Environment