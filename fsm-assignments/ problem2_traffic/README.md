# Traffic Light Controller (FSM)

This project implements a **traffic light controller** using a finite state machine (FSM) in Verilog.  
It simulates the behavior of a two-way traffic signal system (North-South and East-West) with configurable green/yellow/red durations.

---

##  Files
- `traffic_light.v` – FSM implementation of the traffic light.
- `tick_divider.v` – Clock divider that generates a 1 Hz tick signal (1 second pulse).
- `top.v` – Top-level module connecting the tick divider with the traffic light FSM.
- `tb_traffic_light.v` – Testbench for functional simulation.
- `traffic_light_tb.vcd` – Waveform dump for GTKWave.

---

## FSM Design
The FSM has **4 states**:
- `S0`: NS Green, EW Red
- `S1`: NS Yellow, EW Red
- `S2`: NS Red, EW Green
- `S3`: NS Red, EW Yellow

Each state is held for a **delay**:
- Green: 5 ticks (5 seconds)
- Yellow: 2 ticks (2 seconds)

After the delay expires, the FSM transitions to the next state.

---

## Tick Generation
The FSM needs a **1-second tick** to measure real-time delays.

- `tick_divider.v` generates a **1 Hz pulse** from a 50 MHz clock.
  - Counts clock cycles up to `50,000,000`
  - Asserts `tick = 1` for **1 cycle** when the counter resets
- The FSM increments an internal counter (`tick_count`) on each `tick`
- When `tick_count == delay - 1`, the FSM changes state

This ensures **time-accurate traffic light switching**.

---

##  Verification
1. **In simulation (Testbench):**
   - A clock (`clk`) with `#5` period = 100 MHz is generated.
   - A software-based tick generator produces `tick` every 20 cycles (for faster simulation).
   - FSM behavior is observed via `$dumpvars` in `traffic_light_tb.vcd`.
   - Waveforms show correct light transitions:
     - NS Green → NS Yellow → EW Green → EW Yellow → repeat
     - Durations match delays (5 ticks for green, 2 ticks for yellow).

2. **Tick Divider Verification:**
   - In `tb_traffic_light`, `tick` pulses are monitored.
   - Every rising edge of `tick` increments the FSM’s `tick_count`.
   - When `tick_count` reaches its threshold (`delay`), FSM transitions to the next state.

Thus, correctness is verified by:
- **Cycle counting**
- **Expected state transitions**
- **Waveform analysis in GTKWave**

---

##  Running Simulation
1. Open a terminal and compile:
   iverilog -o traffic_light_tb traffic_light.v tick_divider.v top.v tb_traffic_light.v
   vvp traffic_light_tb
   gtkwave traffic_light_tb.vcd


