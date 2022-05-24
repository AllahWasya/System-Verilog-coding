module mux_2_1(input [7:0] in1,
               input [7:0] in2,
               input sel,
               output reg [7:0] out);

always@(*) // any signal change 
  begin  
    if (sel==0)
      out=in1;
    else if (sel==1)
      out=in2;
  end
endmodule

// Code your design here
`include "mux_2_1.sv"

module MUX_8_1(input  [7:0] data1,
                input [7:0] data2,
                input [7:0] data3,
                input [7:0] data4,
                input [7:0] data5,
                input [7:0] data6,
                input [7:0] data7,
                input [7:0] data8,                   
                input [2:0] select,
                output [7:0] out
               );
  
wire sig1, sig2, sig3, sig4, sig5, sig6;
  
  mux_2_1 mux1(.in1(data1), .in2(data2), .sel(select[0]), .out(sig1));
  mux_2_1 mux2(.in1(data3), .in2(data4), .sel(select[0]), .out(sig2));
  mux_2_1 mux3(.in1(data5), .in2(data6), .sel(select[0]), .out(sig3));
  mux_2_1 mux4(.in1(data7), .in2(data8), .sel(select[0]), .out(sig4));
  
  mux_2_1 mux5(.in1(sig1), .in2(sig2), .sel(select[1]), .out(sig5));
  mux_2_1 mux6(.in1(sig3), .in2(sig4), .sel(select[1]), .out(sig6));
  
  mux_2_1 mux7(.in1(sig5), .in2(sig6), .sel(select[2]), .out(out));
  
endmodule

// Code your testbench here
// or browse Examples
module TB_MUX_8_1();
  reg [7:0] d1;
  reg [7:0] d2;
  reg [7:0] d3;
  reg [7:0] d4;
  reg [7:0] d5;
  reg [7:0] d6;
  reg [7:0] d7;
  reg [7:0] d8;
  reg [2:0] select1;
  wire [7:0] out1;
  
  MUX_8_1  Sample(.data1(d1),
                  .data2(d2),
                  .data3(d3),
                  .data4(d4),
                  .data5(d5),
                  .data6(d6),
                  .data7(d7),
                  .data8(d8),
                  .select(select1),
                  .out(out1));
initial begin 
  d1=100;
  d2=150;
  d3=120;
  d4=150;
  d5=130;
  d6=170;
  d7=140;
  d8=190;
  select1= 3'b101;
  #10
  d1=105;
  d2=148;
  d3=162;
  d4=158;
  d5=137;
  d6=176;
  d7=144;
  d8=198;
  select1= 3'b110;
  #10
  d1=200;
  d2=250;
  d3=220;
  d4=250;
  d5=230;
  d6=244;
  d7=122;
  d8=142;
  select1= 3'b001;
  #10
   d1=100;
  d2=90;
  d3=120;
  d4=80;
  d5=130;
  d6=140;
  d7=120;
  d8=170;
  select1= 3'b111;
  end
initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars();
    #60
    $finsh;
  end
endmodule