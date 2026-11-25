module seg_led_7_ifelse(input wire[3:0] inp, output reg [6:0] outp, output wire [3:0]
anode);
assign anode = 4'b1110; //ANODE DEACTIVATION (segments are active low)
always @ (inp)
if(inp==4'd0) outp = 7'b0000001; // abcdefg
else if(inp==4'd1) outp = 7'b1001111;
else if(inp==4'd2) outp = 7'b0010010;
else if(inp==4'd3) outp = 7'b0000110;
else if(inp==4'd4) outp = 7'b1001100;
else if(inp==4'd5) outp = 7'b0100100;
else if(inp==4'd6) outp = 7'b0100000;
else if(inp==4'd7) outp = 7'b0001111;
else if(inp==4'd8) outp = 7'b0000000;
else if(inp==4'd9) outp = 7'b0000100;
else if(inp==4'd10) outp = 7'b0001000;
else if(inp==4'd11) outp = 7'b1100000;
else if(inp==4'd12) outp = 7'b0110001;
else if(inp==4'd13) outp = 7'b1000010;
else if(inp==4'd14) outp = 7'b0110000;
else if(inp==4'd15) outp = 7'b0111000;
endmodule
