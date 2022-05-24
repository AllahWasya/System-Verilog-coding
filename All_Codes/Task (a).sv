module task1(input clock);
   
task cal;  
        input  [7:0] a, b;  
        output [7:0] c, d;  
        begin  
            c = a + b; 
            d = a - b;
        end  
endtask  

initial begin  
  reg [7:0] y,z; 
  cal(15,6,y,z); 
  $display("sum is=%0d",y);
  $display("difference is=%0d",z);
end 
endmodule