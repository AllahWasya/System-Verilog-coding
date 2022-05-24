// Code your design here
module func();
  function automatic [7:0] factorial;
    input [7:0]a;
    if (a==1)
      factorial=1;
    else
      factorial= a*factorial(a-1);
  endfunction

  initial
    begin
      $dumpfile("file.vcd");
      $dumpvars(1);
      $display("Factorial of 1 = %0d", factorial(1));
      $display("Factorial of 2 = %0d", factorial(2));
      $display("Factorial of 3 = %0d", factorial(3));
      $display("Factorial of 4 = %0d", factorial(4));
      $display("Factorial of 5 = %0d", factorial(5));
    end
endmodule