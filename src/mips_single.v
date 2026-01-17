module mips_single (clk, rst);
	
	input clk, rst;
	
	// segmented wires are named wire_1, wire_2, etc....
	// pipeline module i/o ports are named wire_in, wire_out, etc....

	// instruction bus
	wire [31:0] instr_1, instr_2;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct_1, funct_2;
	wire [4:0] rs, rt_1, rt_2, rd_1, rd_2, shamt;
	wire [15:0] immed;
	wire [31:0] extend_immed_1, extend_immed_2, b_offset;
	wire [25:0] jumpoffset;
	
	// datapath signals
	wire [4:0] rfile_wn_1, rfile_wn_2, rfile_wn_3;
	wire [31:0] rfile_rd1_1, rfile_rd1_2, rfile_rd2_1, rfile_rd2_2, rfile_rd2_3, rfile_wd,
				alu_b, alu_out_1, alu_out_2, alu_out_3, b_gtg, pc_next, pc, 
				pc_incr_1, pc_incr_2, dmem_rdata_1, dmem_rdata_2, jump_addr, branch_addr, jmux_addr;

	// control signals
	wire RegWrite_1, RegWrite_2, RegWrite_3, RegWrite_4, Branch, PCSrc, RegDst_1, RegDst_2, 
		 MemtoReg_1, MemtoReg_2, MemtoReg_3, MemtoReg_4, MemRead_1, MemRead_2, MemRead_3, 
		 MemWrite_1, MemWrite_2, MemWrite_3, ALUSrc_1, ALUSrc_2, Zero, Jump, Nop, JumpR;
	wire [1:0] ALUOp_1, ALUOp_2;
	wire [5:0] Operation;
	
	assign opcode = instr_2[31:26];
	assign rs = instr_2[25:21];
	assign rt_1 = instr_2[20:16];
	assign rd_1 = instr_2[15:11];
	assign shamt = instr_2[10:6];
	assign funct_1 = instr_2[5:0];
	assign immed = instr_2[15:0];
	assign jumpoffset = instr_2[25:0];

	// jump offset shifter & concatenation
	assign jump_addr = {pc_incr_2[31:28], jumpoffset << 2};

	// module instantiations
	
	reg32 PC (.clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc));

	// sign-extender
	sign_extend SignExt (.immed_in(immed), .ext_immed_out(extend_immed_1));
	
	// branch offset shifter
  	assign b_offset = extend_immed_1 << 2;
	
	add32 PCADD (.a(pc), .b(32'd4), .result(pc_incr_1));
	
	TotalALU alu (.clk(clk), .dataA(rfile_rd1_2) , .dataB(alu_b) ,
				  .Signal(Operation),.Output(alu_out_1), .reset(rst));
	
	mux2 #(5) RFMUX (.sel(RegDst_2), .a(rt_2), .b(rd_2), .y(rfile_wn_1));
	
	mux2 #(32) ALUMUX (.sel(ALUSrc_2), .a(rfile_rd2_2), .b(extend_immed_2), .y(alu_b));
	
	mux2 #(32) WRMUX (.sel(MemtoReg_4), .a(alu_out_3), .b(dmem_rdata_2), .y(rfile_wd));
	
	IF_ID ifid (.reset(rst), .clk(clk), .Instr_in(instr_1), .Instr_out(instr_2),
			    .pc_incr_in(pc_incr_1), .pc_incr_out(pc_incr_2));
	
	muxNop nop (.instr(instr_1), .Nop(Nop));
	
	control_single CTL (.opcode(opcode), .Funct(funct_1), .NOP(Nop), .RegDst(RegDst_1), .ALUSrc(ALUSrc_1),
						.MemtoReg(MemtoReg_1), .RegWrite(RegWrite_1), .MemRead(MemRead_1), .MemWrite(MemWrite_1),
						.Branch(Branch), .Jump(Jump), .ALUOp(ALUOp_1), .JumpR(JumpR));
	
	ID_EX idex (.reset(rst), .clk(clk), .RD1_in(rfile_rd1_1), .RD1_out(rfile_rd1_2),.RD2_in(rfile_rd2_1), .RD2_out(rfile_rd2_2), 
				.extend_immed_in(extend_immed_1), .extend_immed_out(extend_immed_2), .funct_in(funct_1), .funct_out(funct_2),
				.rt_in(rt_1), .rt_out(rt_2), .rd_in(rd_1), .rd_out(rd_2), .RegDst_in(RegDst_1), .RegDst_out(RegDst_2), 
				.ALUSrc_in(ALUSrc_1), .ALUSrc_out(ALUSrc_2), .MemtoReg_in(MemtoReg_1), .MemtoReg_out(MemtoReg_2), 
				.RegWrite_in(RegWrite_1), .RegWrite_out(RegWrite_2), .MemRead_in(MemRead_1), .MemRead_out(MemRead_2),
				.MemWrite_in(MemWrite_1), .MemWrite_out(MemWrite_2), .ALUOp_in(ALUOp_1), .ALUOp_out(ALUOp_2));

	EX_MEM exmem (.reset(rst), .clk(clk), .rfile_wn_in(rfile_wn_1), .rfile_wn_out(rfile_wn_2), 
				  .alu_out_in(alu_out_1), .alu_out_out(alu_out_2), .rfile_rd2_in(rfile_rd2_2), .rfile_rd2_out(rfile_rd2_3),
				  .MemRead_in(MemRead_2), .MemRead_out(MemRead_3), .MemWrite_in(MemWrite_2), .MemWrite_out(MemWrite_3), 
				  .RegWrite_in(RegWrite_2), .RegWrite_out(RegWrite_3), .MemtoReg_in(MemtoReg_2), .MemtoReg_out(MemtoReg_3));
	
	MEM_WB memwb (.reset(rst), .clk(clk), .rfile_wn_in(rfile_wn_2), .rfile_wn_out(rfile_wn_3),
				  .alu_out_in(alu_out_2), .alu_out_out(alu_out_3), .rd_in(dmem_rdata_1), .rd_out(dmem_rdata_2),
				  .MemtoReg_in(MemtoReg_3), .MemtoReg_out(MemtoReg_3), .RegWrite_in(RegWrite_3), .RegWrite_out(RegWrite_4));
	
	alu_ctl ALUCTL (.ALUOp(ALUOp_2), .Funct(funct_2), .ALUOperation(Operation));
	
	reg_file RegFile (.clk(clk), .RegWrite(RegWrite_4), .RN1(rs), .RN2(rt_1), .WN(rfile_wn_3), .WD(rfile_wd),
					  .RD1(rfile_rd1_1), .RD2(rfile_rd2_1));
					          
	muxZero zero (.RD1(rfile_rd1_1), .RD2(rfile_rd2_1), .Zero(Zero));
					          
	add32 BRADD (.a(pc_incr_2), .b(b_offset), .result(b_gtg));
					          
	and BR_AND (PCSrc, Branch, Zero);
	
	mux2 #(32) PCMUX (.sel(PCSrc), .a(pc_incr_1), .b(b_gtg), .y(branch_addr));
	
	mux2 #(32) JMUX (.sel(Jump), .a(branch_addr), .b(jump_addr), .y(jmux_addr));
	
	mux2 #(32) JRMUX (.sel(JumpR), .a(jmux_addr), .b(rfile_rd1_1), .y(pc_next));

	memory InstrMem (.clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr_1));

	memory DatMem (.clk(clk), .MemRead(MemRead_3), .MemWrite(MemWrite_3), .wd(rfile_rd2_3), .addr(alu_out_2), .rd(dmem_rdata_1));	   
				   
endmodule
