# Overlapping Sequence Detector

## Goal
1) Detect serial bit pattern 1101 on din with overlap
2) Output y is a 1-cycle pulse when the last bit arrives.
2) Type: Mealy Reset: synchronous, active-high 

# FSM Description
S0 00: Idle (no match yet)
S1 01: Matched 1
S2 10: Matched 11
S3 11: Matched 110
Output y = 1 when FSM is in S3 and current input din=1 (completes 1101).
### why one binary encoding 
Small FSM (only 4 states)
With 4 states, binary encoding only needs 2 flip-flops.
One-hot would need 4 flip-flops.


| Input Stream (`din`) | Detection Pulses (`y`)                    |
| -------------------- | ----------------------------------------- |
| `1101`               | Pulse at **last bit** (index 3)           |
| `1101101`            | **Two pulses** (overlap at indices 3,6)   |
| `11101`              | Pulse when **last `1`** arrives (index 4) |
| `01101101`           | **Two pulses** (indices 4,7)              |

# How to run in  IcarusVerilog + GTKWave
 iverilog -o sim.out seq_detect_mealy.v tb_seq_detect_mealy
 vvp sim.out
 gtkwave dump.vcd

 


