# Verilog 7-Segment Display Controller and Moore FSM (FPGA)

University lab work (Peter the Great St. Petersburg Polytechnic University, 2024). Verilog design of a 7-segment display decoder, a clock-divided counter that counts from 0 to F on the display, and a Moore finite state machine whose state is shown on the display. Simulated with testbenches and implemented on an FPGA board.

## Contents

- 7-segment decoder written two ways: `case` and `if / else`
- 4-bit counter with a clock divider (about one step per second) driving the decoder
- Moore FSM with three states and an error state, with the state shown on the display
- Testbenches for every module
- Pin constraints (UCF) for loading the designs onto the board

## Repository structure

```
src/
  seg_led_7.v             7-segment decoder (case)
  seg_led_7_ifelse.v      7-segment decoder (if / else)
  seg_led_7_me.v          counter with clock divider + decoder (0 to F)
  fsm.v                   Moore FSM
  Seg_Led_Counter.v       top level: FSM output shown on the 7-segment display
tb/
  seg_led_7_TB.v          compares the case and if/else decoders
  seg_led_7_TB_2.v        counter with clock divider
  fsm_TB.v                FSM
  seg_led_7_fsm_TB.v      FSM connected to the decoder
  test.v                  top-level testbench (Seg_Led_Counter)
constraints/
  seg_led_7_me.ucf        pins for the counter design
  Seg_Led_Counter.ucf     pins for the FSM design
```

## Design

### 7-segment decoder

The decoder converts a 4-bit value (0 to F) into the segment pattern of an active-low 7-segment display. It is implemented with both `case` and `if / else`; the testbench prints both outputs side by side and they match.

### Counter with clock divider

A 31-bit register increments on every clock edge. The lower 27 bits act as the clock divider and the upper 4 bits (`a[30:27]`) form the counter that drives the decoder, so the display counts from 0 to F. With a 100 MHz clock one step takes 2^27 clock cycles, about 1.3 s.

### Moore FSM

The FSM input is a 3-bit one-hot style code `abc` (`100`, `010`, `001`) that selects the next state. The design has three working states and an error state:

| State | Output (`state_out`) | Shown on display |
|---|---|---|
| `STATE_1` | 1 | 1 |
| `STATE_2` | 2 | 2 |
| `STATE_3` | 3 | 3 |
| `ERR_STATE` | 14 | E |

- Any input code other than the three valid ones sends the FSM to `ERR_STATE`; from there it returns to a working state as soon as a valid code arrives.
- Reset puts the FSM into `ERR_STATE`.
- States are `localparam`: they are internal constants that must not be overridden from outside the module.
- Without `ERR_STATE`, a latch is inferred for undefined inputs: the FSM drops into the first state of the `case` and holds there instead of reaching a defined error state.
- One-hot state encoding would use N flip-flops for N states and is generally faster; it can be adopted by changing the `localparam` values.

## Simulation

Each file in `tb/` is a self-contained testbench; use a Verilog simulator of your choice. `seg_led_7_TB.v` and `seg_led_7_TB_2.v` have no `$finish`, so stop them manually or set a run time. Example with Icarus Verilog:

```bash
iverilog -o decoders tb/seg_led_7_TB.v src/seg_led_7.v src/seg_led_7_ifelse.v && vvp decoders
iverilog -o counter tb/seg_led_7_TB_2.v src/seg_led_7_me.v && vvp counter
iverilog -o fsm tb/fsm_TB.v src/fsm.v && vvp fsm
iverilog -o fsm_seg tb/seg_led_7_fsm_TB.v src/fsm.v src/seg_led_7.v && vvp fsm_seg
iverilog -o top tb/test.v src/Seg_Led_Counter.v src/fsm.v src/seg_led_7.v && vvp top
```

## Implementation

The `.ucf` files in `constraints/` assign the clock, reset, input switches, the four anodes, and the seven segments to FPGA pins (LVCMOS33). Create a project in Xilinx ISE for the desired top module (`seg_led_7_me` or `Seg_Led_Counter`), add the matching `.ucf`, and program the board.

## Notes

- The two testbenches named `seg_led_7_TB` in the original report were saved under different module names here (`seg_led_7_TB` and `seg_led_7_fsm_TB`) so they can coexist in one project.
- In `seg_led_7_TB_2.v` a leftover `.inp` port connection, which the counter module does not have, was removed.

## Author

Dmitrii Sergeev
