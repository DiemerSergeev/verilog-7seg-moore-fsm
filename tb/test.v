module test;
reg clk, reset;  
wire [6:0] outp; //outputs
wire [3:0] anode; //outputs
reg [2:0] abc;

Seg_Led_Counter uut (.clk(clk), .reset(reset), .abc(abc), .outp(outp), .anode(anode)); // Instantiate seg_led_7_me
initial
begin
abc = 3'd0; 
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
$display ("time = %d, reset = %b, abc= %b, outp= %b,", $time, reset, abc, outp);
abc <= abc + 3'd1;
end
endmodule
