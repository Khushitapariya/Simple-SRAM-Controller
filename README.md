# Simple-SRAM-Controller
This project implements a simple FSM based SRAM controller using Verilog HDL.
The controller manages read and write operations between a processor interface and an SRAM memory model by generating appropriate chip select and control signals.

The design is fully synchronous, verified through RTL simulation, and intended for digital VLSI and computer architecture learning.

# Key Features

1. FSM based control logic

2. Supports read and write memory operations

3. Separate CPU side and SRAM side interfaces

4. One cycle wait state for memory access

5. Clean synchronous reset design

6. Fully verified using a Verilog testbench
