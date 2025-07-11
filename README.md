16-bit RISC Processor (Verilog Implementation)
This project showcases the design and implementation of a basic 16-bit RISC-style processor architecture using Verilog HDL. It includes core modules like an ALU, Control Unit, Register File, and Memory system. The processor supports arithmetic, logical, and jump instructions, with a 4-bit opcode instruction set. It is verified through simulation and synthesized using Xilinx Vivado for FPGA implementation.

Table of Contents

•	Features

•	Architecture

•	Instruction Set

•	File Structure

•	How to Run

•	Tools & Technologies Used

•	Screenshots / Outputs

•	Challenges Faced

•	Future Improvements

•	Author

•	License


Features

•	16-bit processor design using Verilog

•	RISC-style architecture with 4-bit opcode

•	Support for 16 instructions (Arithmetic, Logic, Jump)

•	ALU with ADD, SUB, MUL, AND, OR operations

•	Separate Control Unit and Register File

•	Program Counter with Instruction Fetch and Decode

•	Memory interfacing for instructions and data

•	Synthesizable on FPGA (Xilinx Artix-7 or similar)

•	Modular Verilog structure with simulation testbench



Architecture



The processor includes the following blocks:

- ALU: Performs core arithmetic and logic operations based on opcode.
- Control Unit: Decodes the opcode and generates control signals.
- Register File: Holds general-purpose registers.
- Program Counter: Keeps track of instruction sequence.
- Instruction Memory: Stores instruction set.
- Data Memory: Temporary storage for operands and results.
- Clock and Reset System: Drives and resets the processor.
<img width="707" height="534" alt="image" src="https://github.com/user-attachments/assets/ecb877de-72c9-4c3c-912c-4d90e2143ce8" />



File Structure

•	src/ - Verilog source files

•	testbench/ - Simulation testbenches

•	synthesis/ - Vivado or FPGA implementation files

•	doc/ - Documentation, diagrams

•	output/ - Simulation waveforms or screenshots


How to Run Simulation:

 Clone the repository.
 
 Compile and simulate using ModelSim or Icarus Verilog.
 
 Use GTKWave to view outputs.

FPGA Synthesis:

1. Open Vivado → Import from synthesis/.

2. Synthesize, implement and generate bitstream.

3. Flash using Hardware Manager.

Tools & Technologies Used

•	Verilog HDL

•	Xilinx Vivado

Challenges Faced

• Designing the Control Unit FSM

• Synchronization between ALU, registers, and memory

• Synthesizing memory blocks

• Debugging instruction execution in simulation

Future Improvements

•	Add branching, stack operations, I/O instructions

•	Pipeline the processor for performance

•	Peripheral interfacing (GPIO, UART, etc.)

•	Extend instruction support similar to RISC-V


Author

Pratham Bhojawala

Electronics & Communication Engineering

LD College of Engineering, Ahmedabad

License
This project is licensed under the MIT License.
