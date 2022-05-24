// Code your design here
module decoder_2_4(a,b,w,x,y,z);

output w,x,y,z;
input a,b;

assign w = (~a) & (~b);
assign x = (~a) & b;
assign y = a & (~b);
assign z = a & b;
endmodule
// TB
// Code your testbench here
// or browse Examples
module decoder_2_4_test;
reg a,b;
wire w,x,y,z;

decoder_2_4 decoder_2_4_test(a,b,w,x,y,z);
initial

begin
#000 a=0; b=0;
#100 a=0; b=1;
#100 a=1; b=0;
#100 a=1; b=1;
end
  
  
initial
    begin
  // dum waves
    $dumpfile("dump.vcd");
    $dumpvars();
    #500
    $finish;
  end
endmodule