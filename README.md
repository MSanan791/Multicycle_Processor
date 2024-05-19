# MultiCycleProcessor
This multicycle processor is designed to execute the MIPS instruction set architecture (ISA) and follows the Von Neumann architecture, where a single memory space is used for both instructions and data. The design breaks down instruction execution into multiple stages, allowing for more efficient use of hardware resources compared to single cycle processors.

Instruction Set Architecture (ISA): 
The processor fully supports the MIPS instruction set, which includes:
- R-Type Instructions: Arithmetic and logical operations that involve registers, such as add, sub, and, or, mul.
- I-Type Instructions: Operations with immediate values, memory access instructions like lw , sw, beq, andi, ori, addi.
- J-Type Instructions: Unconditional jump instructions such as j.

Multicycle Operation:
- Instruction Fetch: The instruction is fetched from memory.
- Instruction Decode/Register Fetch: The instruction is decoded, and operands are fetched from the register file.
- Execution/Effective Address Calculation: The ALU performs the required computation or calculates the effective address for memory operations.
- Memory Access/Branch Completion: Data memory is accessed for load/store instructions, or the branch target address is computed.
- Write-Back: The result of an operation is written back to the register file.

Optimized Hardware Utilization:
- By spreading the execution of an instruction over multiple cycles, the processor reuses functional units, reducing hardware complexity.
