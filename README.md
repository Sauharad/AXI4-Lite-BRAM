# AXI4-Lite-RAM

This project implements a 32-bit single-port RAM with a depth of 2<sup>16</sup> locations, designed to operate as an AXI4-Lite slave for memory-mapped read and write access. The module is written in Verilog and conforms to the AXI4-Lite protocol specification, making it suitable for integration into ARM-based SoCs, microcontrollers, or FPGA designs requiring external host access to memory.

✅ Features
32-bit data width, 16-bit address space (64 KB memory)

Fully compliant with AXI4-Lite protocol

Supports all five AXI-Lite channels:

Write Address (AW) – Receives write address from master

Write Data (W) – Receives data to be written

Write Response (B) – Acknowledges completion of write

Read Address (AR) – Receives read address

Read Data (R) – Returns data to master

Implements valid–ready handshake for each channel

Synchronous write and read operations with minimal latency

📦 Use Case
This RAM module is ideal for testing AXI-Lite-based communication or for embedding small blocks of memory in a larger system design. It can be connected to a processor or DMA master for simple memory-mapped I/O.

🛠️ Simulation
The module is testable using standard AXI-Lite transaction sequences. Sample testbenches can be constructed to simulate read and write operations and validate response behavior.

