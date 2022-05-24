// Task implementation with IO declared in body
module AB;

task pulse_generate1;
  input time pulse_length;
  output pulse;
  begin
    pulse = 1'b0;
    #pulse_length
    pulse = 1'b1;
  end
endtask : pulse_generate1

initial begin
reg z;
  pulse_generate1(10,z); // pulse after delay of 10mili seconds.
end

initial begin
  $dumpfile("dump.vcd");
  $dumpvars();
  #20
  $finish;
end 
endmodule