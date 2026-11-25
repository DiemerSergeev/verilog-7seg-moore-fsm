module seg_led_7_TB;
reg [3:0] inp; //inputs
wire [6:0] outp1; //outputs
wire [6:0] outp2; //outputs
wire [3:0] anode; //outputs
reg clk;//output
seg_led_7 uut1 (.inp(inp), .outp(outp1), .anode(anode)); // Instantiate seg_led_7
seg_led_7_ifelse uut2 (.inp(inp), .outp(outp2), .anode(anode)); // Instantiate seg_led_7
initial
begin
$display ("Start simulation.......");
clk = 1'd0;
inp = 4'd0;
end
always
#5 clk = ~clk;
always @ (posedge clk)
begin
$display ("inp = %b, outp1 = %b", inp, outp1);
$display ("inp = %b, outp2 = %b", inp, outp2);
inp = inp + 4'd1;
end
endmodule
