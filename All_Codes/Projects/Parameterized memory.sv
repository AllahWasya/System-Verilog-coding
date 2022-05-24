`define total_locations 8
`define size_of_locations 8


`include "parameters.sv"

interface memory_interface (input logic clock);
                logic  reset;
                logic  op;
                logic  [$clog2(`total_locations)-1:0]addr;	
                logic  [`size_of_locations-1:0] data_in;
                logic  [`size_of_locations-1:0] data_out;
  
  modport dut (input reset, op, addr, data_in, output data_out);
  modport tb (output reset, op, addr, data_in, input data_out);
  				
endinterface

// Code your design here
`include "interface.sv"

module memory (memory_interface mem_if);
  
  reg [`size_of_locations-1:0] memory_reg[`total_locations]; // unpacked array
  
  always @ (negedge mem_if.dut.clock) begin
    if (mem_if.dut.reset) begin
      mem_if.dut.data_out <= 0;
      for (int i=0; i<`total_locations; i++)
        memory_reg[i] <= 0; 
    end
    
    else begin
      if (mem_if.op) begin
        memory_reg[mem_if.dut.addr] <= mem_if.dut.data_in;
      end
      
      else begin
        mem_if.dut.data_out <= memory_reg[mem_if.dut.addr];
      end
    end
     
  end
  
endmodule


// Code your testbench here
// or browse Examples
module memory_tb;
  bit clock;
  always #5 clock = ~clock; 
  // interface object
  memory_interface mem_if_tb(clock); 
  // design instantiation
  memory dut (mem_if_tb);
function fun_reset;
  input a;
  begin
    fun_reset =a;
  end
endfunction
task write;
repeat (20) @ (posedge clock) begin
    mem_if_tb.tb.addr = $random;
    mem_if_tb.tb.op  = 1;
    mem_if_tb.tb.data_in = $random;
end
endtask
task read;
repeat (20) @ (posedge clock) begin
    mem_if_tb.tb.addr = $random;
    mem_if_tb.tb.op  = 0;
    mem_if_tb.tb.data_in = $random;
end
endtask  
initial begin
  mem_if_tb.tb.reset=fun_reset(1);
  #15
  mem_if_tb.tb.reset=fun_reset(0);
  write();
  read();
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #450
    $finish;
end  
endmodule
