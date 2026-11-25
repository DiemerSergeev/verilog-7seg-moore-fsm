module seg_led_7_fsm_TB;
reg [3:0] inp; //inputs
wire [6:0] outp; //outputs
wire [3:0] anode; //outputs
reg clk;//output

reg reset; 
wire [3:0] state_out; 
reg [2:0] abc;

fsm uut1(.clk(clk),.reset(reset), .abc(abc), .state_out(state_out));
seg_led_7 uut2 (.inp(state_out), .outp(outp), .anode(anode)); // Instantiate seg_led_7
initial
begin
$display ("Start simulation.......");
clk = 0;
inp = 4'd0;
abc = 0; 
reset = 1;
// Wait 2 ns for global reset to finish
#20;
reset = 0;
//terminate simulation after 100 ns
#100 $finish;
end
initial forever
#1 clk = ~clk;
always @ (posedge clk)
begin
inp = inp + 4'd1;
abc <= abc + 3'd1;
$display ("time = %d, reset = %b, abc= %b, state_out= %d,", $time, reset, abc, state_out);
$display ("inp = %b, outp1 = %b", inp, outp);
end
endmodule
