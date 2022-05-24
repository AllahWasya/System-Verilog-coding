// Code your design here
module counter(input clk,
               input reset,
               input increment,
               input decrement,
               output reg [3:0]count);

reg enable;
reg [3:0] mux_out;

  always @ (posedge clk) begin
 
   enable = increment | decrement ;

end

  always @ (posedge clk) begin
  case (increment) 
  1'b0: mux_out = count-1;
  1'b1: mux_out = count+1;
    endcase
end

  always @(posedge clk or reset) begin

if (reset)
      count <= #1 0;
else if (enable)
      count <= #1 mux_out;  
end
endmodule

// Code your testbench here
// or browse Examples
module tb_counter;

reg clk;
reg reset;
reg increment;
reg decrement;
wire [3:0] count;
// intialization

counter counter_inst(.clk(clk),
                     .reset(reset),
                     .increment(increment),
                     .decrement(decrement),
                     .count(count));
// clock generation  
always #5 clk = ~clk;  


// Main code

initial begin
reset = 1;
clk =0;
#1
reset = 0;
  repeat(5) @(posedge clk) begin
 increment = $random;
 decrement = $random;
end
end  
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #300
    $finish;
end  
endmodule