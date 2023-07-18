
`timescale 1ns/1ns

`include "Interface.sv"



module Top();


import I2C_pkg::*;
import uvm_pkg::*;


logic clk;




Interface intf(.clk(clk));




I2C_Master DUT(  .clk(intf.clk),
					  .reset(intf.reset),
					  .wr_i2c(intf.wr_i2c),
                 .data_in(intf.data_in),
                 .cmd(intf.cmd),
					  .dvsr(intf.dvsr),
					  .data_out(intf.data_out),
					  .ready(intf.ready),
					  .done_tick(intf.done_tick),
					  .ACK(intf.ACK),
					  .SCL(intf.SCL),
					  .SDA(intf.SDA)   );



initial begin 


  clk = 0;
  
  forever  #5 clk = ~clk;


end







initial begin 


  uvm_config_db #(virtual Interface)::set(null,"*","intf",intf);
  
  
  run_test("I2C_Test");
  

end







initial begin 


  #1750000

  $finish();


end









endmodule 