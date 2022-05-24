module processing_unit(input  [1:0]  alu_op,
                       input clk,
                       input clr,
                       input [4:0] readreg1,
                       input [4:0] readreg2,
                       input [4:0] writereg,
                       input wr_op,
                       input [31:0] data_in,
                       output [31:0] sig1,
                       output [31:0] sig2,
                       output reg [63:0] out);

// instantiating Reg File
             
register reg_inst(.clk(clk),
                  .clr(clr),
                  .readreg1(readreg1),
                  .readreg2(readreg2),
                  .writereg(writereg),
                  .wr_op(wr_op),
                  .data_in(data_in),
                  .read1(sig1),
                  .read2(sig2));

// instantiating ALU File

alu alu_inst(.alu_op(alu_op),
             .A(sig1),
             .B(sig2),
             .out(out));
 
endmodule

// RegFile32x32

// inputs 1. clock signal      ::  clk 
//        2. To reset          ::  reset/clear
//        3. read address1     ::  readreg1 
//        4. read address2     ::  readreg2 
//        5. write reg address ::  writereg
//        6. Enble write oper. ::  wr_op
//        7. Data to write     ::  data_in

//Outputs 1. read1
//        2. read2


module register(input clk,
                input clr,
                input [4:0] readreg1,
                input [4:0] readreg2,
                input [4:0] writereg,
                input wr_op,
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
    
    if (wr_op) begin     // if op==1 then write data in memory 
         
     register_memory [writereg] <= data_in;

  end 
end
end

always @ (*) begin

read1 <= register_memory [readreg1];  
read2 <= register_memory [readreg2];  

end
endmodule


// ALU FiLE
// Two inputs A and B and one output is out
// ALU operation is base on alu_op

 
module alu(input [1:0] alu_op,
           input [31:0] A,
           input [31:0] B,
           output reg [63:0] out) ;


always @ (*) begin 

if (alu_op == 2'b00) 

     out = A + B;

else if (alu_op == 2'b10) 

     out = A - B;

else if (alu_op == 2'b10) 

      out = A * B;

else if (alu_op == 2'b11) 

      out = A / B;

else 

out = 0;

end

endmodule


module processing_unit_tb();

reg [1:0 ]alu_op;
reg clk;
reg clr;
reg [4:0] readreg1;
reg [4:0] readreg2;
reg [4:0] writereg;
reg wr_op;
reg [31:0] data_in;
wire [31:0] sig1;
wire [31:0] sig2;
wire [63:0] out;

processing_unit dut(.alu_op(alu_op),
                    .clk(clk),
                    .clr(clr),
                    .readreg1(readreg1),
                    .readreg2(readreg2),
                    .writereg(writereg),
                    .wr_op(wr_op),
                    .data_in(data_in),
                    .sig1(sig1),
                    .sig2(sig2),
                    .out(out));

// clock generation

always #5 clk = ~clk ;

initial begin
    data_in=0;             
    clk = 0;
    clr <= 1;  // reset all memory to zero
    #15  
    clr <= 0;  // reset =0 to change data_in

for (int i=0; i<32; i++) @ (posedge clk) begin
    
    writereg = i;
    readreg1 = i;
    readreg2 = i;
    wr_op  = 1;
    data_in = 64+i;
    alu_op  = $random;

end
end
  
initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #230
    $finish;
end  
endmodule
