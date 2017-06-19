`timescale 1ns / 1ps
//*************************************************************************
//   > ?????: single_cycle_cpu.v
//   > ????  :??????CPU??ï…?????16?????
//   >        ???rom??????ram??????????????????????CPU?????
//   > ????  : LOONGSON
//   > ????  : 2016-04-14
//*************************************************************************
`define STARTADDR 32'd0  // ??????????
module single_cycle_cpu(
    input clk,    // ???
    input resetn,  // ??¦Ë??????????§¹

    //display data
    input  [ 4:0] rf_addr,
    input  [31:0] mem_addr,
    output [31:0] rf_data,
    output [31:0] mem_data,
    output [31:0] cpu_pc,
    output [31:0] cpu_inst
    );

//---------------------------------{??}begin------------------------------------//
    reg  [31:0] pc;
    wire [31:0] next_pc;
    wire [31:0] seq_pc;
    wire [31:0] jbr_target;
    wire jbr_taken;

    // ??????????seq_pc=pc+4
    assign seq_pc[31:2]    = pc[31:2] + 1'b1;
    assign seq_pc[1:0]     = pc[1:0];
    // ???????????????????????????????????
    assign next_pc = jbr_taken ? jbr_target : seq_pc;
    always @ (posedge clk)    // PC?????????
    begin
        if (!resetn) begin
            pc <= `STARTADDR; // ??¦Ë?????????????
        end
        else begin
            pc <= next_pc;    // ????¦Ë????????
        end
    end

    wire [31:0] inst_addr;
    wire [31:0] inst;
    assign inst_addr = pc;  // ????????????32¦Ë
    inst_rom inst_rom_module(         // ???›¥??
        .addr      (inst_addr[6:2]),  // I, 5,?????
        .inst      (inst          )   // O, 32,???
    );
    assign cpu_pc = pc;       //display pc
    assign cpu_inst = inst;
//----------------------------------{??}end-------------------------------------//

//---------------------------------{????}begin------------------------------------//
    wire [5:0] op;       
    wire [4:0] rs;       
    wire [4:0] rt;       
    wire [4:0] rd;       
    wire [4:0] sa;      
    wire [5:0] funct;    
    wire [15:0] imm;     
    wire [15:0] offset;  
    wire [25:0] target;  

    assign op     = inst[31:26];  // ??????
    assign rs     = inst[25:21];  // ???????1
    assign rt     = inst[20:16];  // ???????2
    assign rd     = inst[15:11];  // ????????
    assign sa     = inst[10:6];   // ????????????????
    assign funct  = inst[5:0];    // ??????
    assign imm    = inst[15:0];   // ??????
    assign offset = inst[15:0];   // ????????
    assign target = inst[25:0];   // ?????

    wire op_zero;  // ???????0
    wire sa_zero;  // sa???0
    assign op_zero = ~(|op);
    assign sa_zero = ~(|sa);
    
    // ???????§Ò?
    wire inst_ADDU, inst_SUBU , inst_SLT, inst_AND;
    wire inst_NOR , inst_OR   , inst_XOR, inst_SLL;
    wire inst_SRL , inst_ADDIU, inst_BEQ, inst_BNE;
    wire inst_LW  , inst_SW   , inst_LUI, inst_J;

    assign inst_ADDU  = op_zero & sa_zero    & (funct == 6'b100001);// ???????
    assign inst_SUBU  = op_zero & sa_zero    & (funct == 6'b100011);// ????????
    assign inst_SLT   = op_zero & sa_zero    & (funct == 6'b101010);// §³??????¦Ë
    assign inst_AND   = op_zero & sa_zero    & (funct == 6'b100100);// ?????????
    assign inst_NOR   = op_zero & sa_zero    & (funct == 6'b100111);// ??????????
    assign inst_OR    = op_zero & sa_zero    & (funct == 6'b100101);// ?????????
    assign inst_XOR   = op_zero & sa_zero    & (funct == 6'b100110);// ??????????
    assign inst_SLL   = op_zero & (rs==5'd0) & (funct == 6'b000000);// ???????
    assign inst_SRL   = op_zero & (rs==5'd0) & (funct == 6'b000010);// ???????
    assign inst_ADDIU = (op == 6'b001001);                  // ?????????????
    assign inst_BEQ   = (op == 6'b000100);                  // ?§Ø???????
    assign inst_BNE   = (op == 6'b000101);                  // ?§Ø???????
    assign inst_LW    = (op == 6'b100011);                  // ????????
    assign inst_SW    = (op == 6'b101011);                  // ?????›¥
    assign inst_LUI   = (op == 6'b001111);                  // ??????????????
    assign inst_J     = (op == 6'b000010);                  // ??????

    // ??????????§Ø?
    wire        j_taken;
    wire [31:0] j_target;
    assign j_taken  = inst_J;
    // ????????????????PC={PC[31:28],target<<2}
    assign j_target = {pc[31:28], target, 2'b00};

    //??????
    wire        beq_taken;
    wire        bne_taken;
    wire [31:0] br_target;
    assign beq_taken = (rs_value == rt_value);       // BEQ?????????GPR[rs]=GPR[rt]
    assign bne_taken = ~beq_taken;                   // BNE?????????GPR[rs]??GPR[rt]
    assign br_target[31:2] = pc[31:2] + {{14{offset[15]}}, offset};
    assign br_target[1:0]  = pc[1:0];    // ?????????????PC=PC+offset<<2

    //??????????????????????
    assign jbr_taken = j_taken              // ????????????????? ?? ?????????????
                     | inst_BEQ & beq_taken
                     | inst_BNE & bne_taken;
    assign jbr_target = j_taken ? j_target : br_target;

    // ???????
    wire rf_wen;
    wire [4:0] rf_waddr;
    wire [31:0] rf_wdata;
    wire [31:0] rs_value, rt_value;

    regfile rf_module(
        .clk    (clk      ),  // I, 1
        .wen    (rf_wen   ),  // I, 1
        .raddr1 (rs       ),  // I, 5
        .raddr2 (rt       ),  // I, 5
        .waddr  (rf_waddr ),  // I, 5
        .wdata  (rf_wdata ),  // I, 32
        .rdata1 (rs_value ),  // O, 32
        .rdata2 (rt_value ),   // O, 32

        //display rf
        .test_addr(rf_addr),
        .test_data(rf_data),
        .resetn(resetn)
    );
    
    
    // ????????????ALU??????????????
    wire inst_add, inst_sub, inst_slt,inst_sltu;
    wire inst_and, inst_nor, inst_or, inst_xor;
    wire inst_sll, inst_srl, inst_sra,inst_lui;
    assign inst_add = inst_ADDU | inst_ADDIU | inst_LW | inst_SW; // ????????????
    assign inst_sub = inst_SUBU; // ????
    assign inst_slt = inst_SLT;  // §³????¦Ë
    assign inst_sltu= 1'b0;      // ??¦Ä???
    assign inst_and = inst_AND;  // ?????
    assign inst_nor = inst_NOR;  // ??????
    assign inst_or  = inst_OR;   // ?????
    assign inst_xor = inst_XOR;  // ??????
    assign inst_sll = inst_SLL;  // ???????
    assign inst_srl = inst_SRL;  // ???????
    assign inst_sra = 1'b0;      // ??¦Ä???
    assign inst_lui = inst_LUI;  // ??????????¦Ë

    wire [31:0] sext_imm;
    wire   inst_shf_sa;    //???sa???????????????
    wire   inst_imm_sign;  //??????????????????????
    assign sext_imm      = {{16{imm[15]}}, imm};// ?????????????
    assign inst_shf_sa   = inst_SLL | inst_SRL;
    assign inst_imm_sign = inst_ADDIU | inst_LUI | inst_LW | inst_SW;
    
    wire [31:0] alu_operand1;
    wire [31:0] alu_operand2;
    wire [11:0] alu_control;
    assign alu_operand1 = inst_shf_sa ? {27'd0,sa} : rs_value;
    assign alu_operand2 = inst_imm_sign ? sext_imm : rt_value;
    assign alu_control = {inst_add,        // ALU?????????????
                          inst_sub,
                          inst_slt,
                          inst_sltu,
                          inst_and,
                          inst_nor,
                          inst_or, 
                          inst_xor,
                          inst_sll,
                          inst_srl,
                          inst_sra,
                          inst_lui};
//----------------------------------{????}end-------------------------------------//

//---------------------------------{???}begin------------------------------------//
    wire [31:0] alu_result;

    alu alu_module(
        .alu_control  (alu_control ),  // I, 12, ALU???????
        .alu_src1     (alu_operand1),  // I, 32, ALU??????1
        .alu_src2     (alu_operand2),  // I, 32, ALU??????2
        .alu_result   (alu_result  )   // O, 32, ALU???
    );
//----------------------------------{???}end-------------------------------------//
    
//---------------------------------{???}begin------------------------------------//
    wire [3 :0] dm_wen;
    wire [31:0] dm_addr;
    wire [31:0] dm_wdata;
    wire [31:0] dm_rdata;
    assign dm_wen   = {4{inst_SW}} & resetn;    // ???§Õ???,??resetn??????§¹
    assign dm_addr  = alu_result;               // ???§Õ??????ALU???
    assign dm_wdata = rt_value;                 // ???§Õ??????rt??????
    data_ram data_ram_module(
        .clk   (clk         ),  // I, 1,  ???
        .wen   (dm_wen      ),  // I, 1,  §Õ???
        .addr  (dm_addr[6:2]),  // I, 32, ?????
        .wdata (dm_wdata    ),  // I, 32, §Õ????
        .rdata (dm_rdata    ),  // O, 32, ??????

        //display mem
        .test_addr(mem_addr[6:2]),
        .test_data(mem_data     )
    );
//----------------------------------{???}end-------------------------------------//

//---------------------------------{§Õ??}begin------------------------------------//
    wire inst_wdest_rt;   // ???????§Õ?????rt?????
    wire inst_wdest_rd;   // ???????§Õ?????rd?????
    assign inst_wdest_rt = inst_ADDIU | inst_LW | inst_LUI;
    assign inst_wdest_rd = inst_ADDU | inst_SUBU | inst_SLT | inst_AND | inst_NOR
                          | inst_OR   | inst_XOR  | inst_SLL | inst_SRL;                   
    // ???????§Õ??????????¦Ë??????§¹
    assign rf_wen   = (inst_wdest_rt | inst_wdest_rd) & resetn;
    assign rf_waddr = inst_wdest_rd ? rd : rt;        // ???????§Õ???rd??rt
    assign rf_wdata = inst_LW ? dm_rdata : alu_result;// §Õ???????load?????ALU???
//----------------------------------{§Õ??}end-------------------------------------//
endmodule
