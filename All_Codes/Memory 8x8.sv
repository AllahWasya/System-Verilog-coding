// Code your design here
module memory (input clk,
               input reset,
               input op,
               input  [2:0] addr,
               input  [7:0] data_in,
               output reg [7:0] data_out);
  
  
  reg [7:0] memory_reg [8];
  
  always @ (negedge clk) begin
    
  if (reset) begin
      data_out <= 0;
    for (int i=0; i<8;i++) 
      memory_reg [i] <=0; 
  end
    
    
  else begin
    
  if (op) begin     // if op==1 then write data in memory 
      memory_reg [addr] <= data_in;
  end 
    
    
  else begin       // if op==0 read data from memory
    
    data_out <= memory_reg [addr];  
end
end
end
endmodule

// Code your testbench here
// or browse Examples
module memory_tb();
  
  
reg  clk;
reg  reset;
reg  op;
reg  [2:0] addr;
reg  [7:0] data_in;
wire [7:0] data_out;

// instantiation
memory dut(clk,reset,op,addr,data_in,data_out);

// clock generation  
always #5 clk = ~clk;  

  
initial begin
    data_in=0;             
    clk = 0;
    reset <= 1;  // reset all memory to zero
    #10
    reset <= 0;  // reset =0 to change data_in

repeat (20) @ (posedge clk) begin
    addr = $random;
    op  = $random;
    data_in = $random;
end
end
  
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #300
    $finish;
end  

endmodule