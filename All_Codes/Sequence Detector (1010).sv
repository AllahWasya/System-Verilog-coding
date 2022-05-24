// Code your design here
module seq_detector_1010(input clk,
                        input reset,
                        input in,
                        output out);
  
localparam           s0 = 3'b000,
                     s1 = 3'b001,
                     s2 = 3'b010,
                     s3 = 3'b011,
                     s4 = 3'b100;
  
reg [2:0] current_state; 
reg [2:0] next_state; 

always @ (posedge clk) begin
    if (reset)
      current_state <= s0;
    else 
      current_state <= next_state;
end

always @ ( in or current_state) begin 
    case (current_state)
      
    s0: begin
    if (in == 1)
    next_state <=s1;
    else
     next_state <=s0; 
    end
    
    s1: begin
    if (in == 0)
    next_state <=s2;
    else
     next_state <=s1; 
    end

    s2: begin
    if (in == 1)
    next_state <=s3;
    else
     next_state <=s0; 
    end

    s3: begin
    if (in == 0)
    next_state <=s4;
    else
     next_state <=s1; 
    end
      
    s4: begin
    if (in == 0)
    next_state <=s0;
    else
     next_state <=s3; 
    end
    endcase
end
  assign out = (current_state == s4)? 1 : 0; 
endmodule  

// Code your testbench here
// or browse Examples
module seq_detector_TB();

reg clk, reset, in;
wire out;
  
// instantiation
seq_detector_1010 dut(clk, reset, in, out);

// generating clock signal
  
always #5 clk = ~clk;  

  
initial begin
    in=0;             
    clk = 0;
    reset <= 1;
    #10
    reset <= 0;

  repeat (20) @ (negedge clk) begin
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
    