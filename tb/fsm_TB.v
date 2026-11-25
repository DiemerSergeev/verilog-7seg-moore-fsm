`timescale 1ns / 1ps
//TB module definition
module fsm_TB;
reg clk, reset; 
wire [3:0] state_out; 
reg [2:0] abc;
// Instantiate the Unit Under Test (UUT)
fsm uut (.state_out(state_out), .clk(clk), .reset(reset), .abc(abc));
// Initialize Inputs
initial 
begin
abc = 0; 
clk = 0; 
reset = 1;
// Wait 2 ns for global reset to finish
#20;
reset = 0;
//terminate simulation after 100 ns
#100 $finish;
end
// Add stimulus here
initial forever
#1 clk = ~clk;
always @ (posedge clk)
begin
abc <= abc + 3'd1;
$display ("time = %d, reset = %b, abc= %b, state_out= %d,", $time, reset, abc, state_out);
end
endmodule
