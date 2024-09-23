# Multicycle MIPS Processor Overview

This multicycle processor is designed to execute the MIPS instruction set architecture (ISA) and adheres to the Von Neumann architecture. In this design, both instructions and data share a single memory space. Unlike single-cycle processors, which complete every instruction in one clock cycle, this multicycle processor divides the execution process into multiple steps, allowing for more efficient utilization of hardware resources.

### MIPS Instruction Set Architecture (ISA)
The processor fully implements the MIPS instruction set, encompassing three main types of instructions:

- **R-Type Instructions**: These are register-based arithmetic and logical operations, such as `add`, `sub`, `and`, `or`, and `mul`. The operands and results are stored in registers.
- **I-Type Instructions**: These include operations involving immediate values, memory access instructions, and branching. Common instructions are `lw` (load word), `sw` (store word), `beq` (branch if equal), `addi` (add immediate), `andi`, and `ori`.
- **J-Type Instructions**: These are unconditional jump instructions, with `j` being a common example.

### Multicycle Operation Stages
The execution of each instruction is divided into the following distinct stages:

1. **Instruction Fetch**: In this stage, the instruction is retrieved from memory based on the program counter (PC). The PC is updated for the next instruction.
   
2. **Instruction Decode/Register Fetch**: The fetched instruction is decoded, identifying the type and operands involved. Simultaneously, the required source operands are read from the register file.

3. **Execution/Effective Address Calculation**: 
   - For arithmetic and logical instructions, the Arithmetic Logic Unit (ALU) performs the computation.
   - For memory-related instructions, the ALU calculates the effective memory address.
   
4. **Memory Access/Branch Resolution**: 
   - If the instruction is a load or store, the processor accesses the data memory to either read or write.
   - For branch instructions, the processor computes the branch target address and decides whether to alter the program flow.

5. **Write-Back**: Finally, the result of the computation (if applicable) is written back to the appropriate register, completing the execution of the instruction.

### Optimized Hardware Utilization
By breaking down instruction execution into multiple cycles, the multicycle processor efficiently reuses key hardware components such as the ALU and memory units. This leads to lower hardware complexity, as the same functional units are employed across different stages of instruction execution. The trade-off is that each instruction takes multiple cycles to complete, but the overall hardware design is simpler and more cost-effective compared to single-cycle processors.

This approach strikes a balance between performance and resource utilization, making it a practical design choice for certain applications where hardware efficiency is prioritized.
