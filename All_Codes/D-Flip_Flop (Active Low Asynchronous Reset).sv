// Code your design here
module D_flip_flop (input D,
                    input reset,
                    input clock,
                    output reg Q,
                    output Qbar
                   );
  
  always @ (negedge clock, posedge reset) begin
    if (~reset)
      Q <= 0;
    else begin
      Q <= D;
    end
  end
  assign Qbar = ~Q;
endmodule

// TB

// Code your testbench here
// or browse Examples

module D_flip_flop_tb();
  reg D, reset, clock;    
  wire Q, Qbar;
  
  //inst
  D_flip_flop dut (D, reset, clock, Q, Qbar);
  
  always #5 clock = ~clock;
  
  initial begin
    D=0;             
    clock = 0;
    reset <= 0;
    #10
    reset <= 1;
    
    repeat (10) @ (posedge clock) begin
      D = $random;
    end
    
    reset <= 1;
    
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #150
    $finish;
  end
  
endmodule