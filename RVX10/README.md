# RISC‑V Single‑Cycle :RVX10 extended

This repo contains a **single‑cycle RISC‑V extended with 10 new R type operation ** and a  test program.


Follow these steps to build and run the simulation with **Icarus Verilog**.

---

## Files

- `riscvsingle.sv` — SystemVerilog source
- `rvx10.hx` — **Instruction memory image** loaded by `$readmemh` (one 32‑bit hex word per line).


> ✅ The test prints **“Simulation succeeded”** when the CPU writes the value **25 (0x19)** to **address 100 (0x64)**.

---

## Requirements

- **Icarus Verilog** (iverilog / vvp)
  - Ubuntu/Debian: `sudo apt-get install iverilog`
  - macOS (Homebrew): `brew install icarus-verilog`
  - Windows: install from the official site or MSYS2; ensure `iverilog` and `vvp` are on **PATH**.
- (Optional) **GTKWave** for viewing waveforms: `sudo apt-get install gtkwave` / `brew install gtkwave`

---


> **Important:** The simulation reads `rvx10.hex` using a **relative path**. Run the simulator **from the folder** that contains the file (or edit the path inside `riscvsingle.sv`).

---

## Build & Run (Terminal)




### Windows (PowerShell or CMD)
```bat
cd C:\path\to\riscv_single
iverilog -g2012 -o cpu_tb riscvsingle.sv
vvp cpu_tb
```

**Expected console output**
```
Simulation succeeded
```

---



## Waveforms (Optional, with GTKWave)

The testbench is set up to dump `wave.vcd`. To open it:

```bash
# after running the simulation:
gtkwave wave.vcd
```

If you don’t see a VCD file, ensure the following block exists inside `module testbench;` in `riscvsingle.sv`:
```systemverilog
initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, testbench);
end
```


---


