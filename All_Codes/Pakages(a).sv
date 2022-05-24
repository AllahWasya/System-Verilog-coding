package pkg;

function int add( int a,b);

return a+b;

endfunction

function  print(int c);
  $display("addition=%0d", c);

endfunction

endpackage  

import pkg ::*;
// import the pakage

module top;

int a=10; int b=20; int c;

initial begin

  c= add(10,20);
  print(c);

end 
endmodule
