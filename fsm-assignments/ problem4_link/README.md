# Link Protocol FSM (Master–Slave Handshake)

This project demonstrates a simple synchronous request/acknowledge (req/ack) handshake protocol between a master and a slave using Verilog finite state machines (FSMs).



## Protocol Description

 Goal: Two FSMs (Master, Slave) with 4-phase req/ack and 8-bit data bus.
 Per byte:
 1 Master drives data, raises req.
 2 Slave latches data on req, asserts ack (hold 2 cycles).
 3 Master sees ack, drops req; Slave then drops ack.
 4 Repeat for 4 bytes; Master asserts done (1 cycle) at end.

## State Machines
### Master FSM

S_IDLE → Load first byte (0xA0) and assert req.

S_REQ → Wait one cycle before checking ack.

S_WAIT_ACK → Wait for slave to assert ack.

S_DROP_REQ → Deassert req.

S_WAIT_ACK0 → Wait for ack to return low, then send next byte (up to 4 total).

S_DONE → Assert done.

### Slave FSM

R_IDLE → Wait for rising edge of req.

R_ACK_HOLD → Assert ack for 2 cycles.

R_WAIT_REQ0 → Wait for req to drop, then deassert ack.

Simulation
Run with Icarus Verilog
iverilog -o simout tb_link_top.v link_top.v slave_fsm.v master_fsm.v
vvp simout

Generate & View Waveforms
gtkwave link_wave.vcd


