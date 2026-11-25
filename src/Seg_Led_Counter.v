module Seg_Led_Counter(clk, reset, abc, outp, anode);
input wire clk, reset;
input wire [2:0] abc;
wire[3:0] state_out;
output wire [6:0] outp;
output wire [3:0] anode;

fsm fsm0(clk, reset, abc, state_out);
seg_led_7 seg0(state_out, outp, anode);
endmodule
