class I2C_Test  extends uvm_test;



  `uvm_component_utils(I2C_Test)
  
  
  
  Environment I2C_environment;
  
  
  
  Reset_seq reset_seq;
  
  I2C_seq1 seq1;

  I2C_seq2 seq2;

  I2C_seq3 seq3;

  I2C_seq4 seq4;
  
  I2C_seq5 seq5;

  
  
  
  function new(string name = "I2C_Test" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of I2C Test Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of I2C Test Class",UVM_LOW)

	 
	 I2C_environment = Environment::type_id::create("I2C_environment",this);
	 
	 
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of I2C Test Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of I2C Test Class",UVM_LOW)
  
   
	
	 phase.raise_objection(this);
  
    
	    //apply reset sequence
		 
	    reset_seq = Reset_seq::type_id::create("reset_seq");
	 
	    reset_seq.start(I2C_environment.I2C_Agent.I2C_sequencer);
	    
		 #150;
		 
		 
		 
		 
		 repeat(1000) begin 
		 
		 
		  seq5 = I2C_seq5::type_id::create("seq5");
	 
	    seq5.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		  #100;
		 
	    seq1 = I2C_seq1::type_id::create("seq1");
	 
	    seq1.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		  #1450;
		 
		 
		  seq4 = I2C_seq4::type_id::create("seq4");
	 
	    seq4.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		  
		 #200;
		 
		 
		 end
	 
	 
	 
	 /*
	 
		 repeat(100) begin 
		 
		 
	     seq5 = I2C_seq5::type_id::create("seq5");
	 
	    seq5.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		 #200;
		 
	    seq2 = I2C_seq2::type_id::create("seq2");
	 
	    seq2.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		 #1450;
		 
		 
		  seq4 = I2C_seq4::type_id::create("seq4");
	 
	    seq4.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		 #200;
		 
		 end
	 	 
	 
	 
	 
		 
		 
	    seq3 = I2C_seq3::type_id::create("seq3");
	 
	    seq3.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		 
		 
		 
	 
	 
	    seq4 = I2C_seq4::type_id::create("seq4");
	 
	    seq4.start(I2C_environment.I2C_Agent.I2C_sequencer);
		 
		 #10;  
	
	
	 */
	 
	 
	 phase.drop_objection(this);
  
  
  
  
 
  endtask :run_phase
  
  
  
  
  
  
  
  
endclass :I2C_Test