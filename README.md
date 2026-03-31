# vlsi-design-projects
# VLSI Design & Verification Projects

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)
![Simulator](https://img.shields.io/badge/Simulator-Icarus%20Verilog%2012.0-green)
![Platform](https://img.shields.io/badge/Platform-EDA%20Playground-orange)
![Status](https://img.shields.io/badge/Status-Verified-brightgreen)

RTL design and functional verification projects implemented in Verilog HDL.  
All designs are simulated and verified using **Icarus Verilog** on **EDA Playground**  
with waveform analysis on **EPWave**.

---

## Projects

### 1. 8-bit ALU — Arithmetic Logic Unit
📁 [`RTL-ALU-8bit/`](./RTL-ALU-8bit)

| Feature | Details |
|---|---|
| Language | Verilog HDL |
| Operations | ADD, SUB, AND, OR, XOR, NOT, LSHIFT, RSHIFT |
| Flags | Zero flag, Carry/Borrow flag |
| Testbench | Self-checking with PASS/FAIL display |
| Simulator | Icarus Verilog 12.0 |
| Live Demo | [EDA Playground](https://edaplayground.com/x/Nkhz) |

**Waveform:**
![ALU Waveform](./RTL-ALU-8bit/docs/alu_waveform.png)

---

### 2. Synchronous FIFO — 8-bit, depth 16
📁 [`FIFO-Sync-16depth/`](./FIFO-Sync-16depth)

| Feature | Details |
|---|---|
| Language | Verilog HDL |
| Architecture | Synchronous, single clock domain |
| Parameters | Configurable DATA_WIDTH & DEPTH |
| Flags | Full, Empty with pointer logic |
| Test Coverage | Normal R/W, Overflow, Underflow, Simultaneous R/W |
| Simulator | Icarus Verilog 12.0 |
| Live Demo | [EDA Playground](https://edaplayground.com/x/DdYs) |

**Waveform:**
![FIFO Waveform](./FIFO-Sync-16depth/docs/fifo_waveform.png)

---

## Tools Used

| Tool | Purpose |
|---|---|
| Icarus Verilog 12.0 | Simulation & compilation |
| EPWave | Waveform viewing & analysis |
| EDA Playground | Cloud-based HDL simulation platform |
| Git + GitHub | Version control |

---

## About Me
Final year B.E. ECE student | Targeting VLSI Design Verification roles  
📍 Tamil Nadu, India  
🔗 [EDA Playground Profile](https://edaplayground.com)
