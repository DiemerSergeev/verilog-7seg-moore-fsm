module seg_led_7_TB_2;
reg [3:0] inp; //inputs
reg reset;
wire [6:0] outp; //outputs
wire [3:0] anode; //outputs
reg clk;//output
seg_led_7_me uut (.clk(clk),.reset(reset),.outp(outp), .anode(anode)); // Instantiate seg_led_7_me
initial
begin
$display ("Start simulation.......");
clk = 1'd0;
inp = 4'd0;
reset = 1;
#6 reset = 0;
end
always
#5 clk = ~clk;
always @ (posedge clk)
begin
inp = inp + 4'd1;
$display ("inp = %b, outp = %b", inp, outp);
end
endmodule
