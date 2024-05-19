# MultiCycleProcessor
This multicycle processor is designed to execute the MIPS instruction set architecture (ISA) and follows the Von Neumann architecture, where a single memory space is used for both instructions and data. The design breaks down instruction execution into multiple stages, allowing for more efficient use of hardware resources compared to single cycle processors.
Instruction Set Architecture (ISA): The processor fully supports the MIPS instruction set, which includes:
- R-Type Instructions: Arithmetic and logical operations that involve registers, such as add, sub, and, or, mul.
- I-Type Instructions: Operations with immediate values, memory access instructions like lw , sw, beq, andi, ori, addi.
- J-Type Instructions: Unconditional jump instructions such as j.
