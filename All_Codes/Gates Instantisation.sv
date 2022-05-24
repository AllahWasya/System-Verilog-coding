// Code your design here

`include "AND.sv"
`include "OR.sv"
`include "NOT.sv"
`include "NAND.sv"
`include "NOR.sv"
`include "xor.sv"

module GATES( input  data1,
              input  data2, 
              output out,
              input  reg Enable,
              input  [2:0] op_cntrl  
                );
reg and_out,or_out,not_out,nand_out,nor_out,xor_out;
  
  and_gate  var1(.A(data1),.B(data2),.S(and_out));
  or_gate   var2(.A(data1),.B(data2),.S(or_out));
  invert    var3(.A(data1),.B(data2),.S(not_out));
  nand_gate var4(.A(data1),.B(data2),.S(nand_out));
  nor_gate  var5(.A(data1),.B(data2),.S(nor_out));
  xor_gate  var6(.A(data1),.B(data2),.S(xor_out));

reg temp_out;
  
  always @(*)
   begin
   
     if (Enable == 1 && op_cntrl == 3'b000)
       
     temp_out = and_out;
     
     else if (Enable == 1 && op_cntrl == 3'b001)
     
        temp_out = or_out; 
        
     else if (Enable == 1 && op_cntrl == 3'b010)
     
        temp_out = not_out;  
       
     else if (Enable == 1 && op_cntrl == 3'b011)
     
        temp_out = nand_out;  
       
     else if (Enable == 1 && op_cntrl == 3'b100)
     
        temp_out = nor_out;
     
     else if (Enable == 1 && op_cntrl == 3'b101)
     
        temp_out = xor_out;  
     
    else if (Enable == 0) 
  
        temp_out = 0;
      
      end
      
  assign out = temp_out;

  
endmodule

module and_gate (input A, 
                 input B,
                 output S);
  
  assign S = A&&B;
endmodule

module or_gate ( input A, 
                 input B,
                 output S);
  
  assign S = A||B;
  
endmodule

module invert (input A, 
                input B,
                output S);

   assign S = !A;
  
endmodule

module nand_gate (input A, 
                  input B,
                  output S);

  assign S = !(A&&B);
  
endmodule

module nor_gate (input A, 
                 input B,
                 output S);

  
  assign S = !(A||B);
  
endmodule

module xor_gate(input A, 
                 input B,
                 output S);
  
  assign S = (((!A)&&B)||(A&&(!B)));
    
endmodule

// Code your testbench here
// or browse Examples

module TB_GATES ();
  
  reg d1,d2,enable1;
  reg [2:0] op_cntrl1;
  
  wire out1;

  GATES dut(.data1(d1),
            .data2(d2),
            .Enable(enable1),
            .out(out1),
            .op_cntrl(op_cntrl1));

initial 
   
    begin
      enable1=1;
      
      d1 = 1;
      d2 = 0;
      op_cntrl1 = 3'b000; 
      #10
      op_cntrl1 = 3'b001; 
      #10
      op_cntrl1 = 3'b010;
      #10
      op_cntrl1 = 3'b011;
      #10
      op_cntrl1 = 3'b100;
      #10
      op_cntrl1 = 3'b101;
    end
  
initial  
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
      #100
      $finish;
    end
endmodule
