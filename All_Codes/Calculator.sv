// Code your design here
module calculator_p (input wire [7:0] first_num,
                   input wire [7:0] second_num,
                   output wire [15:0] out,
                   input wire [1:0] operation);
  
  reg [15:0] temp_out;
  
  always@(*)
   
    begin
    
      if (operation == 2'b00)
        
        temp_out = first_num + second_num;
        
      else if (operation == 2'b01)
        
        temp_out = first_num - second_num;
      
      else if (operation == 2'b10)
        
        temp_out = first_num * second_num;
      
      else if (operation == 2'b11)
        
        temp_out = first_num / second_num;
      
    end
  
  assign out=temp_out;
  
endmodule

// TB

module calculator_TB();
  
  reg [7:0] inp1;
  reg [7:0] inp2;
  reg [1:0] oper;
  wire [15:0] out;
  
  
  calculator_p calculator_p1(.first_num(inp1),
                             .second_num(inp2),
                             .operation(oper),
                             .out(out));
  initial 
    begin
       
    inp1=200;
    inp2=100;
    oper=2'b00;
    #10
      
    inp1=200;
    inp2=100;
    oper=2'b01;
    #10       
      
    inp1=200;
    inp2=100;
    oper=2'b10;
    #10
          
    inp1=200;
    inp2=100;
    oper=2'b11;
    end
  initial
  begin
    $dumpfile("dump.vcd");
    $dumpvars();
    #50
    $finish;
    
  end
endmodule 