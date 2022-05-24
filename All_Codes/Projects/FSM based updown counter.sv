// Code your design here
module counter_fsm(input clk,
                   input reset,
                   input enable,
                   input ctrl,
                   output reg [3:0] count,
                   output overflow);
  
// start encoding 
  localparam idle       = 2'b00,
             count_up   = 2'b01,
             count_down = 2'b10,
             ovrflw     = 2'b11;
// state registers
  
  reg [1:0] current_state, next_state;
  
// state memory : state register
  
  always @ (posedge clk) begin
    if (reset)
      current_state <= idle;
    else
      current_state <= next_state;
  end
  
  
// next_state : transition state
  
  always @ (enable, ctrl, current_state) begin
    case (current_state)
      idle: begin
        if (enable && ctrl)
          next_state <= count_up;
        else if (enable && ~ctrl)
          next_state <= count_down;
        else
          next_state <= idle;
       end
        
       count_up: begin
        if (~enable)
          next_state <= idle;
        if (enable && ctrl)
          next_state <= count_up;
        if (enable && ~ctrl)
          next_state <= count_down;
         else if (count == 15)
          next_state <= ovrflw;
       end
      
       count_down: begin
        if (~enable)
          next_state <= idle;
        if (enable && ctrl)
          next_state <= count_up;
        if (enable && ~ctrl)
          next_state <= count_down;
         else if (count == 0)
          next_state <= ovrflw;
       end
          
       ovrflw: begin
         next_state <= ovrflw;
       end
      
      default: next_state <= idle;
    
    endcase
  end
// output overflow
  
  assign overflow = (current_state == ovrflw)?  1:0;  

// count 
  
  always @ (posedge clk, current_state) begin
    case (next_state) 
      idle: begin
      count <= 0;
      end
      count_up: begin
        count <= count + 1;
      end
      count_down: begin
        count <=count - 1;
      end
      ovrflw: begin
        count <= count;
      end
      
      default: count <= 0;
      endcase
    end
endmodule
    
// Code your testbench here
// or browse Examples

module counter_fsm_tb();
  
reg clk;
reg reset;
reg enable;
reg ctrl;
wire [3:0] count;
wire overflow;

// instantiation
counter_fsm dut(clk,reset,enable,ctrl,count,overflow);

// clock generation  
always #5 clk = ~clk; 

initial begin
clk = 0;
reset <= 1;
enable = 1;
#5
reset <= 0;

  repeat (20) @ (posedge clk) begin
ctrl = 1;
end  
end    
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #150
    $finish;
end  
endmodule