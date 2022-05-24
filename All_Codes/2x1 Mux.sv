// Code your design here
module mux(input wire [0:7]a,
           input wire [0:7]b,
           input wire s,
           output wire [0:7]out);
  reg [0:7]temp_out;
  
  always@(*)
    
    begin
      temp_out=s?a:b;
      
    end
       assign out=temp_out;
endmodule

// Code your testbench here
// or browse Examples
module tb_mux();
  reg [0:7] inp1;
  reg [0:7] inp2;
  reg select;
  wire [7:0] out;
  
  mux mux1 (.a(inp1),
            .b(inp2),
            .s(select),
            .out(out));
  initial 
  begin
    inp1=200;
    inp2=150;
    select=1;
    #10
    inp1=600;
    inp2=250;
    select=0;
    #30
    inp1=200;
    inp2=150;
    select=1;
  end
  
  initial
  
    begin
  // dum waves
    $dumpfile("dump.vcd");
    $dumpvars();
    #60
    $finish;
  end
endmodule 