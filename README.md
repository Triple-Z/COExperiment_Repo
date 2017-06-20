# Computer Organization Experiment

计算机组成原理实验

[TOC]

> Last Revised: `6/20/2017`

## Project Assignment

[Jump to directory](Project_Assignment/)

### Instruction Set

> Total: 36 + 9

|Status		|Ins Type	|op 	|func	|ALUctr	|Compare|Jump	|RegDst	|ALUSrcB	|ALUSrcA	|MemtoReg	|RegWr	|MemWr	|ExtOp	|CopWr	|
|:----:		|:-------:	|:----:	|:----:	|:----:	|:----:	|:----:	|:----:	|:-------:	|:------:	|:------:	|:----:	|:----:	|:----:	|:----:	|
|`untested`	| addu 		|000000	|100001	|0000	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| subu 		|000000	|100011	|0001	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| slt 		|000000	|101010	|1011	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| sltu 		|000000	|101011	|1010	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| and 		|000000	|100100	|0010	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| nor 		|000000	|100111	|0100	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| or 		|000000	|100101	|0011	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| xor 		|000000	|100110	|0101	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| andi 		|001100	|x		|0010	|0		|0		|1		|1			|0			|0			|1		|0		|0		|0		|
|`untested`	| ori 		|001101	|x		|0011	|0		|0		|1		|1			|0			|0			|1		|0		|0		|0		|
|`untested`	| xori 		|001110	|x		|0101	|0		|0		|1		|1			|0			|0			|1		|0		|0		|0		|
|`untested`	| slti 		|001010	|x		|1011	|0		|0		|1		|1			|0			|0			|1		|0		|1		|0		|
|`untested`	| addiu		|001001	|x		|0000	|0		|0		|1		|1			|0			|0			|1		|0		|0		|0		|
|`untested`	| sltiu 	|001011	|x		|1010	|0		|0		|1		|1			|0			|0			|1		|0		|0		|0		|
|`untested`	| sll 		|000000	|000000	|0110	|0		|0		|1		|0			|1			|0			|1		|0		|x		|0		|
|`untested`	| srl 		|000000	|000010	|0111	|0		|0		|1		|0			|1			|0			|1		|0		|x		|0		|
|`untested`	| sllv 		|000000	|000100	|0110	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| sra 		|000000	|000011	|1000	|0		|0		|1		|0			|1			|0			|1		|0		|x		|0		|
|`untested`	| srav 		|000000	|000111	|1000	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| srlv 		|000000	|000110	|0111	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| lui 		|001111	|x		|1000	|0		|0		|1		|1			|0			|0			|1		|0		|0		|0		|
|`untested`	| lw 		|100011	|x		|0000	|0		|0		|0		|1			|0			|1			|1		|0		|1		|0		|
|`untested`	| sw 		|101011	|x		|0000	|0		|0		|x		|1			|0			|x			|0		|1		|1		|0		|
|`untested`	| lb 		|100000	|x		|0000	|0		|0		|1		|1			|0			|1			|1		|0		|1		|0		|
|`untested`	| lbu 		|100100	|x		|0000	|0		|0		|1		|1			|0			|1			|1		|0		|1		|0		|
|`untested`	| sb 		|101000	|x		|0000	|0		|0		|0		|1			|0			|0			|0		|1		|1		|0		|
|`untested`	| beq 		|000100	|x		|0001	|1		|0		|x		|0			|0			|x			|0		|0		|x		|0		|
|`untested`	| bne 		|000101	|x		|0001	|1		|0		|x		|0			|0			|x			|0		|0		|x		|0		|
|`untested`	| bgez 		|000001	|x		|x		|1		|0		|x		|0			|0			|x			|0		|0		|x		|0		|
|`untested`	| bgtz 		|000111	|x		|x		|1		|0		|x		|0			|0			|x			|0		|0		|x		|0		|
|`untested`	| blez 		|000110	|x		|x		|1		|0		|x		|0			|0			|x			|0		|0		|x		|0		|
|`untested`	| bltz 		|000001	|x		|x		|1		|0		|x		|0			|0			|x			|0		|0		|x		|0		|
|`untested`	| j 		|000010	|x		|x		|0		|1		|x		|x			|x			|x			|0		|0		|x		|0		|
|`untested`	| jalr 		|000000	|001001	|x		|0		|1		|1		|x			|x			|0			|1		|0		|x		|0		|
|`untested`	| jr 		|000000	|001000	|x		|0		|1		|1		|x			|x			|0			|0		|0		|x		|0		|
|`untested`	| jal 		|000011	|x		|x		|0		|1		|1		|x			|x			|0			|1		|0		|0		|0		|



|Status		|Ins Type	|op 	|func	|ALUctr	|Compare|Jump	|RegDst	|ALUSrcB	|ALUSrcA	|MemtoReg	|RegWr	|MemWr	|ExtOp	|CopWr	|
|:----:		|:-------:	|:----:	|:----:	|:----:	|:----:	|:----:	|:----:	|:-------:	|:------:	|:------:	|:----:	|:----:	|:----:	|:----:	|
|`untested`	| mult 		|000000	|011000	|1001	|0		|0		|x		|0			|0			|x			|0		|0		|x		|0		|
|`untested`	| mflo 		|000000	|010010	|1100	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| mfhi 		|000000	|010011	|1101	|0		|0		|1		|0			|0			|0			|1		|0		|x		|0		|
|`untested`	| mtlo 		|000000	|010011	|1111	|0		|0		|x		|x			|0			|x			|0		|0		|x		|0		|
|`untested`	| mthi 		|000000	|010001	|1110	|0		|0		|x		|x			|0			|x			|0		|0		|x		|0		|
|`untested`	| mfc0 		|010000	|x		|x		|0		|0		|0		|x			|x			|0			|1		|0		|x		|0		|
|`untested`	| mtc0 		|010000	|x		|x		|0		|0		|0		|0			|x			|0			|0		|0		|x		|1		|
|`untested`	| syscall	|000000	|001100	|x		|0		|0		|x		|x			|x			|0			|0		|0		|x		|1		|
|`untested`	| eret 		|010000	|011000	|x		|0		|0		|x		|x			|x			|0			|0		|0		|x		|1		|


### Datapath Module

- [x] [PC (Program Counter)](Project_Assignment/datapath/pc.v)
- [ ] [NPC (Next PC)](Project_Assignment/datapath/npc.v)
- [x] [RF (Register File)](Project_Assignment/datapath/rf.v)
- [x] [ALU (Arithmetic Logic Unit)](Project_Assignment/datapath/alu.v)
- [x] [EXT (Extender)](Project_Assignment/datapath/ext.v)
- [x] [IM (Instruction Memory)](Project_Assignment/datapath/im.v) `4KB (32bits*1024)`
- [x] [DM (Data Memeory)](Project_Assignment/datapath/dm.v) `4KB(32bits*1024)`
- [x] [MUX (Multiplexer)](Project_Assignment/datapath/mux.v)
- [ ] [CMP (Compare)](Project_Assignment/datapath/comp.v)
- [x] [CoP0 (CoProcessor0)](Project_Assignment/datapath/CoProcessor0RF.v)

### Control Module

- [ ] [CTRL (Controller)](Project_Assignment/control/ctrl.v)

### Creator Module

- [ ] [MIPS (Creator)](Project_Assignment/mips.v)

### Test Bench

- [ ] [TB (Test Bench)](Project_Assignment/testbench.v)

### Appendix

- [ ] [Module Explanation](Project_Assignment/Appendix.md)

-------------------------------------------------------------

## Project 2 Onboard Experiment

[Jump to directory](Project_2_OC/)

-------------------------------------------------------------

## Project 1

[Jump to directory](Project_1/)

单周期处理器开发

### Instruction Set

> Total: 12

| Status 	| Ins Type 	| op 	| func 	| ALUctr 	|Branch	| Jump	|RegDst	|ALUSrc | MemtoReg	| RegWr	| MemWr	| ExtOp	|
|:-------: 	|:--------:	|:------:	|:------:	|:------:	|:----:	|:----:	|:----:	|:----: |:----:		|:----:	|:----:	|:----:	|
|`supported`	| addu 	| 000000 	| 100001 	| 0000 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| add 	| 000000 	| 100000 	| 0001 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| subu 	| 000000 	| 100011 	| 1000 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| sub 	| 000000 	| 100010 	| 1001 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| and 	| 000000 	| 100100 	| 0010 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| or 	| 000000 	| 100101 	| 0011 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| slt 	| 000000 	| 101010 	| 1011 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| beq 	| 000100 	| x 	| 1001 	| 1 	| 0 	| x 	| 0 	| x 		| 0 	| 0 	| x 	|
|`supported`	| sltu 	| 000000 	| 101011 	| 1010 	| 0 	| 0 	| 1 	| 0 	| 0 		| 1 	| 0 	| x 	|
|`supported`	| jump 	| 000010 	| x 	| x 	| 0 	| 1 	| x 	| x 	| x 		| 0 	| 0 	| x 	|
|`supported`	| lw 	| 100011 	| x 	| 0001 	| 0 	| 0 	| 0 	| 1 	| 1 		| 1 	| 0 	| 1 	|
|`supported`	| sw 	| 101011 	| x 	| 0001 	| 0 	| 0 	| x 	| 1 	| x 		| 0 	| 1 	| 1 	|
|`supported`	| ori 	| 001101 	| x 	| 0011 	| 0 	| 0 	| 0 	| 1 	| 0 		| 1 	| 0 	| 0 	|


### Datapath Module

- [x] [PC (Program Counter)](Project_1/datapath/pc.v)
- [x] [NPC (Next PC)](Project_1/datapath/npc.v)
- [x] [RF (Register File)](Project_1/datapath/rf.v)
- [x] [ALU (Arithmetic Logic Unit)](Project_1/datapath/alu.v)
- [x] [EXT (Extender)](Project_1/datapath/ext.v)
- [x] [IM (Instruction Memory)](Project_1/datapath/im.v) `4KB (32bits*1024)`
- [x] [DM (Data Memeory)](Project_1/datapath/dm.v) `4KB(32bits*1024)`
- [x] [MUX (Multiplexer)](Project_1/datapath/mux.v)

### Control Module

- [x] [CTRL (Controller)](Project_1/control/ctrl.v)

### Creator Module

- [x] [MIPS (Creator)](Project_1/mips.v)

### Test Bench

- [x] [TB (Test Bench)](Project_1/testbench.v)

### Appendix

[Module Explanation](Project_1/Appendix.md)
