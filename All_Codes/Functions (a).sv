// Code your design here
module calculator();
reg [15:0] out;
///////////////////////////////////////////
function [8:0] sum;
input [7:0] a, b;
begin
     sum =a+b;
end
endfunction
///////////////////////////////////////////
function [15:0] mul;
  input [8:0] a, b;
begin
     mul =a*b;
end
endfunction
///////////////////////////////////////////
function [15:0] net;
begin
     net = sum(10,20) + mul(10,20);
end
endfunction
///////////////////////////////////////////
reg [15:0] net1;
assign net1 = mul(40,50)/sum(20,30); 
///////////////////////////////////////////
initial begin
integer out = net();
  $display("Net value is=%0d",out); // 0d means decimal with 0 points
$display("Net value is=%0d",net1); // 0d means decimal with 0 points
end

endmodule
