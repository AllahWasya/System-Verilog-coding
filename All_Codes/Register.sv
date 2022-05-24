// Code your design here
module register(input clk,
                input clr,
                input [4:0] readreg1,
                input [4:0] readreg2,
                input [4:0] writereg,
                input op,
                input [31:0] data_in,
                output reg [31:0] read1,
                output reg [31:0] read2);
// 4byte (32 bits) addressable  memory of this register file
reg [31:0] register_memory [32];   
// clear data   
always @ (negedge clk) begin
    
  if (clr) begin
      read1 <= 0;
      read2 <= 0;
    for (int i=0; i<32;i++)
      register_memory [i] <=0; 
  end

  else begin
    
  if (op) begin     // if op==1 then write data in memory 
         
     register_memory [writereg] <= data_in;
  end 
end
end


always @ (*) begin
   read1 = register_memory [readreg1];  
   read2 = register_memory [readreg2];  
  end
endmodule

// Code your testbench here
// or browse Examples

module register_tb();
reg clk;
reg clr;
reg [4:0] readreg1;
reg [4:0] readreg2;
reg [4:0] writereg;
reg op;
reg [31:0] data_in;
wire [31:0] read1;
wire [31:0] read2;

  register dut(clk,clr,readreg1,readreg2,writereg,op,data_in,read1,read2);

always #5 clk = ~clk ;
  
  initial begin
    data_in=0;             
    clk = 0;
    clr <= 1;  // reset all memory to zero
    #10
    clr <= 0;  // reset =0 to change data_in

  repeat (25) @ (posedge clk) begin
    writereg = $random;
    readreg1 = $random;
    readreg2 = $random;
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
    