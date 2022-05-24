// Code your design here
module seq_detector_101(input clk,
                        input reset,
                        input in,
                        output out);
  
localparam           s0 = 2'b00,
                     s1 = 2'b01,
                     s2 = 2'b10,
                     s3 = 2'b11;
  
reg [1:0] current_state; 
reg [1:0] next_state; 

always @ (posedge clk) begin
    if (reset)
      current_state <= s0;
    else 
      current_state <= next_state;
end

always @ ( in or current_state) begin 
    case (current_state)
      
    s0: begin
    if (in == 0)
    next_state <=s0;
    else
     next_state <=s1; 
    end
    
    s1: begin
    if (in == 1)
    next_state <=s1;
    else
     next_state <=s2; 
    end

    s2: begin
    if (in == 0)
    next_state <=s3;
    else
     next_state <=s1; 
    end

    s3: begin
    if (in == 0)
    next_state <=s0;
    else
     next_state <=s1; 
    end
    endcase
end

  assign out = (current_state == s3)? 1 : 0;
   
endmodule  
  
// Code your testbench here
// or browse Examples
module seq_detector_TB();

reg clk, reset, in;
wire out;
  
// instantiation
seq_detector_101 dut(clk, reset, in, out);

// generating clock signal
  
always #5 clk = ~clk;  

initial begin
    in=0;             
    clk = 0;
    reset <= 1;
    #10
    reset <= 0;

  repeat (30) @ (negedge clk) begin
      in = $random;
end
end
  
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #300
    $finish;
end  
endmodule  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
                 