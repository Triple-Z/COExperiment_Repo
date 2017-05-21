# Computer Organization Experiment

计算机组成原理实验

[TOC]

> Last Revised: `5/21/2017`

## Project 1

[Jump to directory](Project_1/)

单周期处理器开发

#### Instruction Set

> Total: 9

| Status 	| Ins Type 	| op 	| func 	| ALUctr 	|
|:-------:	|:--------:	|:------:	|:------:	|:----:	|
|``	| addu 	| 000000 	| 100000 	| 0000 	|
|``	| add 	| 000000 	| 100000 	| 0001 	|
|``	| sub 	| 000000 	| 100010 	| 1001 	|
|``	| and 	| 000000 	| 100100 	| 0010 	|
|``	| or 	| 000000 	| 100101 	| 0011 	|
|``	| slt 	| 000000 	| 101010 	| 1011 	|
|``	| beq 	| 000100 	| / 	| 1001 	|
|``	| J 	| 000010 	| / 	| / 	|
|``	| lw 	| 100011 	| / 	| / 	|
|``	| sw 	| 101011 	| / 	| / 	|


### Datapath Module

- [x] [PC (Program Counter)](Project_1/datapath/pc.v)
- [x] [NPC (Next PC)](Project_1/datapath/npc.v)
- [x] [RF (Register File)](Project_1/datapath/rf.v)
- [x] [ALU (Arithmetic Logic Unit)](Project_1/datapath/alu.v)
- [x] [EXT (Extended Unit)](Project_1/datapath/ext.v)
- [x] [IM (Instruction Memory)](Project_1/datapath/im.v) `4KB (32bits*1024)`
- [x] [DM (Data Memeory)](Project_1/datapath/dm.v) `4KB(32bits*1024)`

### Control Module

- [ ] [CTRL (Controller)](Project_1/control/ctrl.v)
