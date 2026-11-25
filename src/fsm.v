`timescale 1ns/1ps
//module description
module fsm (clk, reset, abc, state_out);
input wire clk, reset;
input wire [2:0] abc;
output reg [3:0] state_out;

localparam STATE_1 = 2'd1; //state 1
localparam STATE_2 = 2'd2; //state 2
localparam STATE_3 = 2'd3; //state 3
localparam ERR_STATE = 2'd0; //error state

reg [1:0] present_state;
reg [1:0] next_state;
//state logic
always @ (*)

begin
case (present_state)
	STATE_1:
	begin
		case (abc)
		3'b100: next_state = STATE_1;
		3'b010: next_state = STATE_2;
		3'b001: next_state = STATE_3;
		default: next_state = ERR_STATE;
		endcase
	end
	STATE_2:
	begin
		case (abc)
		3'b010: next_state = STATE_2;
		3'b100: next_state = STATE_1;
		3'b001: next_state = STATE_3;
		default: next_state = ERR_STATE;
		endcase
	end
	STATE_3:
	begin
		case (abc)
		3'b001: next_state = STATE_3;
		3'b010: next_state = STATE_2;
		3'b100: next_state = STATE_1;
		default: next_state = ERR_STATE;
		endcase
	end
	ERR_STATE:
	begin
		case(abc)
		3'b001: next_state = STATE_3;
		3'b010: next_state = STATE_2;
		3'b100: next_state = STATE_1;
		default: next_state = ERR_STATE;
		endcase
	end
	default:
		next_state = ERR_STATE;

endcase
end

//state register
always @ (posedge clk)
if (reset)
present_state <= ERR_STATE;
else
present_state <= next_state;

//output state decoder
always @ (*)
begin
	case (present_state)
	STATE_1: state_out = 4'd1;
	STATE_2: state_out = 4'd2;
	STATE_3: state_out = 4'd3;
	ERR_STATE: state_out = 4'd14;
	default: state_out = 4'd14;
	endcase
end
endmodule
