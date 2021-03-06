`ifndef TOP__SV
`define TOP__SV

// test top level module
//just run_test is missing here

`include "uvm_macros.svh"

`include "wb_test.sv"  
`include "all_interfaces.incl"


module top();

   import uvm_pkg::*;

//vif
 typedef virtual wb_master_if mst_if ;
 typedef virtual wb_slave_if slv_if ;
 
 logic clk;
 logic rst;
 // Clock Generation
 parameter sim_cycle = 10;
// Reset Delay Parameter
   parameter rst_delay = 10;
 //clk gen  
 initial begin 
	clk  = 0;
	#10;
  forever clk = #(sim_cycle/2) ~clk;
	  #10000 $finish;
end 
//itf
   wb_master_if mast_if(clk,rst);
   wb_slave_if slave_if(clk,rst); 
// dut
  dut dut(mast_if,slave_if);

   //Driver reset depending on rst_delay
   initial
      begin
         clk = 0;
         rst = 0;
      #5 rst = 1;
         repeat (rst_delay) @(clk);
         rst = 1'b0;
         @(clk);
   end

// set virtual env
// run_test()
   initial begin
      uvm_config_db #(mst_if)::set(null,"uvm_test_top.env.master_agent","mst_if",top.mast_if); 
      uvm_config_db #(slv_if)::set(null,"uvm_test_top.env.slave_agent","slv_if",top.slave_if);
      //run_test();
	  run_test("wb_test"); 
   end

endmodule: top

`endif // WB_ENV_TOP__SV
