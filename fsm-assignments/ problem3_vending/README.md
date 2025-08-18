# Vending Machine (Mealy FSM)

This project implements a Mealy Finite State Machine (FSM) vending machine in Verilog. The vending machine accepts coins of value 5 and 10 units, dispenses a product at 15 units, and returns change if needed.
# Features
Accepts two types of coins:
01 → 5 units
10 → 10 units
00 → No coin inserted

Tracks balance using 4 states:
S0 → total = 0

S5 → total = 5

S10 → total = 10

S15 → total = 15

Outputs:

dispense → 1-cycle pulse when product is dispensed

chg5 → 1-cycle pulse when 5 units change is returned

Handles overpayments:

At S10 + 10 coin → dispense product, reset to S0

At S15 + 5 coin → dispense product, reset to S0

At S15 + 10 coin → dispense product + return change (5), reset to S0

# Files
vending_mealy.v 
tb_vending_mealy.v

## How It Works
State Transitions (Mealy Logic):

From S0:
Insert 5 → S5
Insert 10 → S10

From S5:
Insert 5 → S10
Insert 10 → S15

From S10:
Insert 5 → S15
Insert 10 → dispense, go to S0

From S15:
Insert 5 → dispense, go to S0
Insert 10 → dispense + change (5), go to S0

# How to Run
Using Icarus Verilog:
iverilog -o vending_tb vending_mealy.v
vvp vending_tb


Generates waveform file:

gtkwave vending_mealy.vcd

## Expected Monitor Output (snippet):
T=11 | state=00 | coin=01 | dispense=0 | chg5=0

T=21 | state=01 | coin=00 | dispense=0 | chg5=0

T=41 | state=10 | coin=00 | dispense=0 | chg5=0

T=71 | state=00 | coin=00 | dispense=1 | chg5=0
...

##  Why Mealy FSM?

This vending machine is implemented as a Mealy FSM because:

Immediate Response – Outputs (dispense, chg5) depend on both the current state and the current input (coin). This allows the machine to dispense/change in the same clock cycle when the final coin is inserted, instead of waiting one extra cycle.

Fewer States – In a Moore FSM, outputs depend only on states. That would require adding extra “dispense” and “change” states. The Mealy design avoids this by asserting outputs directly on the transitions, keeping the FSM simpler.

