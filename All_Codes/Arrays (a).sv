// Code your design here
// Unpacked Arrays

module tb;

byte stack [8];

int i;
 
initial begin
 
  foreach (stack [i]) begin
   
    stack[i] = $random;
    
    $display("place stack 0x%0h at index %0d", stack[i],i);

  end

  display("stack = %p",stack);

end


endmodule

