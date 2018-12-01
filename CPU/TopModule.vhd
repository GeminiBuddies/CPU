----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:29:43 12/01/2018 
-- Design Name: 
-- Module Name:    TopModule - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopModule is
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC
	);
end TopModule;

architecture Behavioral of TopModule is

	component PC
		port(
			clk : in STD_LOGIC;
			PCKeep : in STD_LOGIC;
			PCIn : in STD_LOGIC_VECTOR(15 downto 0);
			PCOut : out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;
	
	component PCAdder
		port(
			PC : in STD_LOGIC_VECTOR(15 downto 0);
			AddedPC : out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;
	
	component PCMux
		port(
			PCChoose: in STD_LOGIC_VECTOR(1 downto 0);
			AddedPC : in STD_LOGIC_VECTOR(15 downto 0);
			RegJump : in STD_LOGIC_VECTOR(15 downto 0);
			ConditionalJump : in STD_LOGIC_VECTOR(15 downto 0);
			NextPC : out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;
	
	component Controller
		port ( AluOp : out  STD_LOGIC_VECTOR (3 downto 0);
           Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           SignExtend : out  STD_LOGIC;
           ImmOrReg2 : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           WriteReg : out  STD_LOGIC;
			  UsePc : out STD_LOGIC;
			  Reg1Choose : out STD_LOGIC_VECTOR (2 downto 0);
			  Reg2Choose : out STD_LOGIC_VECTOR (1 downto 0);
			  ImmChoose : out STD_LOGIC_VECTOR (2 downto 0);
			  RegDstChoose : out STD_LOGIC_VECTOR (2 downto 0);
			  HazardKind : out STD_LOGIC_VECTOR(1 downto 0);
           MemOrAlu : out  STD_LOGIC);
	end component;
	
	component HazardDetection
		port (LoadDst : in STD_LOGIC_VECTOR(3 downto 0);
			  RegSrc1 : in STD_LOGIC_VECTOR(3 downto 0);	
			  RegSrc2 : in STD_LOGIC_VECTOR(3 downto 0);
			  HazardKind : in STD_LOGIC_VECTOR(1 downto 0);
			  AluRes : in STD_LOGIC_VECTOR(15 downto 0);
			  PCKeep : out  STD_LOGIC;
			  IFIDKeep : out STD_LOGIC;
			  IFIDFlush : out STD_LOGIC;
			  IDEXEFlush : out STD_LOGIC;
           PCChoose : out STD_LOGIC_VECTOR(1 downto 0));
	end component;
	
	component Reg1Mux
		Port ( Reg1Choose : in  STD_LOGIC_VECTOR (2 downto 0);	--control生成的选择哪个寄存器的控制信号
           Instruction : in  STD_LOGIC_VECTOR (15 downto 0); --指令
           Reg1Index : out  STD_LOGIC_VECTOR (3 downto 0)); --四位寄存器编号
	end component;
	
	component Reg2Mux
		Port ( Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           Reg2Choose : in  STD_LOGIC_VECTOR(1 downto 0);
           Reg2Index : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component ImmediateMux
		Port ( Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           SignExtend : in  STD_LOGIC;
			  ImmChoose : in STD_LOGIC_VECTOR(2 downto 0);
           ExtendedImm : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component RegisterGroup
		Port ( 
			  clk : in STD_LOGIC;
			  Reg1Data : out  STD_LOGIC_VECTOR (15 downto 0);
           Reg2Data : out  STD_LOGIC_VECTOR (15 downto 0);
           WriteReg : in  STD_LOGIC;
           WriteData : in  STD_LOGIC_VECTOR(15 downto 0);
           DstReg : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg1Index : in  STD_LOGIC_VECTOR (3 downto 0);
           Reg2Index : in  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component CPU_ALU
		port(
			srcA		: in STD_LOGIC_VECTOR(15 downto 0);
			srcB		: in STD_LOGIC_VECTOR(15 downto 0);
			op			: in STD_LOGIC_VECTOR(3 downto 0);
			result	: out STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"
		);
	end component;
	
	component CPU_ADDER
		port(
			PC			: in STD_LOGIC_VECTOR(15 downto 0);
			Imm		: in STD_LOGIC_VECTOR(15 downto 0);
			result	: out STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000"
		);
	end component;
	
	component CPU_FORWARD_SRCA
		port(
			if_pc				: in STD_LOGIC;
			pc					: in STD_LOGIC_VECTOR(15 downto 0);
			origin_data		: in STD_LOGIC_VECTOR(15 downto 0);
			r_src				: in STD_LOGIC_VECTOR(3 downto 0);
			exe_mem_data	: in STD_LOGIC_VECTOR(15 downto 0);
			exe_mem_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			mem_wb_data		: in STD_LOGIC_VECTOR(15 downto 0);
			mem_wb_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			result			: out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;
	
	component CPU_FORWARD_SRCB
		port(
			imm				: in STD_LOGIC_VECTOR(15 downto 0);
			origin_r_data	: in STD_LOGIC_VECTOR(15 downto 0);
			imm_or_r			: in std_logic;
			r_src				: in STD_LOGIC_VECTOR(3 downto 0);
			exe_mem_data	: in STD_LOGIC_VECTOR(15 downto 0);
			exe_mem_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			mem_wb_data		: in STD_LOGIC_VECTOR(15 downto 0);
			mem_wb_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			result			: out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;
	
	component mem
		port(
			clk0: in std_logic;
			nclk0: in std_logic;
			clk_wb: in std_logic;
			nclk_wb: in std_logic;
			ram_addr: out std_logic_vector(17 downto 0);
			ram_data: inout std_logic_vector(15 downto 0);
			ram_en: out std_logic;
			ram_oe: out std_logic;
			ram_we: out std_logic;
			pc: in std_logic_vector(15 downto 0);
			instr: out std_logic_vector(15 downto 0);
			rw: in std_logic; -- r = 0, w = 1
			addr: in std_logic_vector(15 downto 0);
			idata: in std_logic_vector(15 downto 0);
			odata: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component splitter
		port(
			clk, rst: in std_logic;
			clk0, clk1, clk2, clk3: out std_logic;
			nclk0, nclk1, nclk2, nclk3: out std_logic
		);
	end component;
	
	component WBMux
		port(
			output: out std_logic_vector(15 downto 0);
			memdata: in std_logic_vector(15 downto 0);
			aludata: in std_logic_vector(15 downto 0);
			mem_or_alu: in std_logic -- '1' = mem
		);
	end component;
	
	component IF_ID_PILLAR
		port(
			clk : in STD_LOGIC;
			IFIDKeep : in STD_LOGIC;
			IFIDFlush : in STD_LOGIC;
			PCIn : in STD_LOGIC_VECTOR(15 downto 0);
			PCOut : out STD_LOGIC_VECTOR(15 downto 0);
			InstructionOut : out STD_LOGIC_VECTOR(15 downto 0);
			InstructionIn	: in STD_LOGIC_VECTOR(15 downto 0)	
		);
	end component;
	
	component ID_EXE_PILLAR
	port(
			clk : in STD_LOGIC;
			PCIn : in STD_LOGIC_VECTOR(15 downto 0);
			PCOut : out STD_LOGIC_VECTOR(15 downto 0);
			AluOpIn : in STD_LOGIC_VECTOR(3 downto 0);
			AluOpOut : out STD_LOGIC_VECTOR(3 downto 0);
			ImmOrReg2In : in STD_LOGIC;
			ImmOrReg2Out : out STD_LOGIC;
			UsePcIn : in STD_LOGIC;
			UsePcOut : out STD_LOGIC;
			Reg1DataIn : in STD_LOGIC_VECTOR(15 downto 0);
			Reg1DataOut : out STD_LOGIC_VECTOR(15 downto 0);
			Reg2DataIn : in STD_LOGIC_VECTOR(15 downto 0);
			Reg2DataOut : out STD_LOGIC_VECTOR(15 downto 0);
			ImmIn : in STD_LOGIC_VECTOR(15 downto 0);
			ImmOut : out STD_LOGIC_VECTOR(15 downto 0);
			Reg1IndexIn : in STD_LOGIC_VECTOR(3 downto 0);
			Reg1IndexOut : out STD_LOGIC_VECTOR(3 downto 0);
			Reg2IndexIn : in STD_LOGIC_VECTOR(3 downto 0);
			Reg2IndexOut : out STD_LOGIC_VECTOR(3 downto 0);
			DstIndexIn : in STD_LOGIC_VECTOR(3 downto 0);
			DstIndexOut : out STD_LOGIC_VECTOR(3 downto 0);
			HazardKindIn : in STD_LOGIC_VECTOR(1 downto 0);
			HazardKindOut : out STD_LOGIC_VECTOR(1 downto 0);
			MemReadIn : in STD_LOGIC;
			MemReadOut : out STD_LOGIC;
			MemWriteIn : in STD_LOGIC;
			MemWriteOut : out STD_LOGIC;
			WriteRegIn : in STD_LOGIC;
			WriteRegOut : out STD_LOGIC;
			MemOrAluIn : in STD_LOGIC;
			MemOrAluOut : out STD_LOGIC;
		
			IDEXEFlush : in STD_LOGIC
		);
	end component;
	
	component MEM_WB_PILLAR
    port(
        mem_or_alu_in: in std_logic;
        write_reg_in: in std_logic;
        reg_dst_in: std_logic_vector(3 downto 0);
        mem_data_in: in std_logic_vector(15 downto 0);
        alu_data_in: in std_logic_vector(15 downto 0);
        mem_or_alu_out: out std_logic;
        write_reg_out: out std_logic;
        reg_dst_out: out std_logic_vector(3 downto 0);
        mem_data_out: out std_logic_vector(15 downto 0);
        alu_data_out: out std_logic_vector(15 downto 0);
        clk: in std_logic
    );
	end component;
	
	component EXE_MEM_PILLAR is
		port(
			clk : in STD_LOGIC;
			MemReadIn : in STD_LOGIC;
			MemReadOut : out STD_LOGIC;
			MemWriteIn : in STD_LOGIC;
			MemWriteOut : out STD_LOGIC;
			AluResultIn : in STD_LOGIC_VECTOR(15 downto 0);
			AluResultOut : out STD_LOGIC_VECTOR(15 downto 0);
			WriteDataIn : in STD_LOGIC_VECTOR(15 downto 0);
			WriteDataOut : out STD_LOGIC_VECTOR(15 downto 0);
			DstIndexIn : in STD_LOGIC_VECTOR(3 downto 0);
			DstIndexOut : out STD_LOGIC_VECTOR(3 downto 0);
			MemOrAluIn : in STD_LOGIC;
			MemOrAluOut : out STD_LOGIC;
			WriteRegIn: in STD_LOGIC;
			WriteRegOut : out STD_LOGIC
	);
	end component;
	
	component CPU_FORWARD_SRCC
		port(
			origin_data		: in STD_LOGIC_VECTOR(15 downto 0);
			r_src				: in STD_LOGIC_VECTOR(3 downto 0);
			exe_mem_data	: in STD_LOGIC_VECTOR(15 downto 0);
			exe_mem_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			mem_wb_data		: in STD_LOGIC_VECTOR(15 downto 0);
			mem_wb_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			result			: out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;
	
	signal m_PCKeep: STD_LOGIC;
	signal m_PCFromMux : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromReg : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromAdder : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromIFID : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCChoose: STD_LOGIC_VECTOR(1 downto 0);
	signal m_CondJumpDst : STD_LOGIC_VECTOR(15 downto 0);
	
	signal m_InstructionFromMem : STD_LOGIC_VECTOR(15 downto 0);
	signal m_InstructionFromIFID : STD_LOGIC_VECTOR(15 downto 0);

	signal m_AluOpFromController : STD_LOGIC_VECTOR(3 downto 0);
	signal m_AluOpFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	
	signal m_SignExtend : STD_LOGIC;
	
	signal m_ImmOrReg2FromController : STD_LOGIC;
	signal m_ImmOrReg2FromIDEXE : STD_LOGIC;
	signal m_MemReadFromController : STD_LOGIC;
	signal m_MemReadFromIDEXE : STD_LOGIC;
	signal m_MemReadFromEXEMEM : STD_LOGIC;
	signal m_MemWriteFromController : STD_LOGIC;
	signal m_MemWriteFromIDEXE : STD_LOGIC;
	signal m_MemWriteFromEXEMEM : STD_LOGIC;
	signal m_WriteRegFromController : STD_LOGIC;
	signal m_WriteRegFromIDEXE : STD_LOGIC;
	signal m_WriteRegFromEXEMEM : STD_LOGIC;
	signal m_WriteRegFromMEMWB : STD_LOGIC;
	signal m_UsePCFromController : STD_LOGIC;
	signal m_UsePCFromIDEXE : STD_LOGIC;
	signal m_Reg1Choose : STD_LOGIC_VECTOR(2 downto 0);
	signal m_Reg2Choose : STD_LOGIC_VECTOR(1 downto 0);
	signal m_ImmChoose : STD_LOGIC_VECTOR(2 downto 0);
	signal m_RegDstChoose : STD_LOGIC_VECTOR(2 downto 0);
	signal m_HazardKindFromController : STD_LOGIC_VECTOR(1 downto 0);
	signal m_HazardKindFromIDEXE : STD_LOGIC_VECTOR(1 downto 0);
	signal m_MemOrAluFromController : STD_LOGIC;
	signal m_MemOrAluFromIDEXE : STD_LOGIC;
	signal m_MemOrAluFromEXEMEM : STD_LOGIC;
	signal m_MemOrAluFromMEMWB : STD_LOGIC;
	
	signal m_Reg1IndexFromMux : STD_LOGIC_VECTOR(3 downto 0);
	signal m_Reg1IndexFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	signal m_Reg2IndexFromMux : STD_LOGIC_VECTOR(3 downto 0);
	signal m_Reg2IndexFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	signal m_RegDstIndexFromMux : STD_LOGIC_VECTOR(3 downto 0);
	signal m_RegDstIndexFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	signal m_RegDstIndexFromEXEMEM : STD_LOGIC_VECTOR(3 downto 0);
	signal m_RegDstIndexFromMEMWB : STD_LOGIC_VECTOR(3 downto 0);
	signal m_ImmFromMux : STD_LOGIC_VECTOR(15 downto 0);
	signal m_ImmFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	
	signal m_Reg1DataFromRegs : STD_LOGIC_VECTOR(15 downto 0);
	signal m_Reg1DataFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	signal m_Reg2DataFromRegs : STD_LOGIC_VECTOR(15 downto 0);
	signal m_Reg2DataFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	
	signal m_AluResFromAlu : STD_LOGIC_VECTOR(15 downto 0);
	signal m_AluResFromEXEMEM : STD_LOGIC_VECTOR(15 downto 0);
	signal m_AluResFromMEMWB : STD_LOGIC_VECTOR(15 downto 0);
	signal m_AluSrc1 : STD_LOGIC_VECTOR(15 downto 0);
	signal m_AluSrc2 : STD_LOGIC_VECTOR(15 downto 0);
	
	signal m_WriteMemDataFromEXEMEM : STD_LOGIC_VECTOR(15 downto 0);
	signal m_WriteMemDataFromMux : STD_LOGIC_VECTOR(15 downto 0);
	
	signal m_WriteDataFromMux : STD_LOGIC_VECTOR(15 downto 0);
	signal m_IFIDKeep : STD_LOGIC;
	signal m_IFIDFlush : STD_LOGIC;
	signal m_IDEXEFlush : STD_LOGIC;
	
	signal m_MemDataFromMem : STD_LOGIC_VECTOR(15 downto 0);
	signal m_MemDataFromMEMWB : STD_LOGIC_VECTOR(15 downto 0);
	
	
begin
	u1 : PC
	PORT MAP(
	clk, 
	m_PCKeep,
	m_PCFromMux, 
	m_PCFromReg);
	
	
	u2 : PCAdder
	PORT MAP(
	m_PCFromReg,
	m_PCFromAdder);
	
	
	u3 : PCMux 
	PORT MAP(
	m_PCChoose, 
	m_PCFromAdder,
	m_Reg1DataFromIDEXE,
	m_CondJumpDst,
	m_PCFromMux);
	
	
	u4 : IF_ID_PILLAR 
	PORT MAP(
	clk, 
	m_IFIDKeep, 
	m_IFIDFlush, 
	m_PCFromAdder, 
	m_PCFromIFID,
	m_InstructionFromIFID, 
	m_InstructionFromMem); 
	
	
	u5 : Controller 
	PORT MAP(
	m_AluOpFromController, 
	m_InstructionFromIFID, 
	m_SignExtend, 
	m_ImmOrReg2FromController, 
	m_MemReadFromController,
	m_MemWriteFromController,
	m_WriteRegFromController,
	m_UsePCFromController,
	m_Reg1Choose,
	m_Reg2Choose,
	m_ImmChoose,
	m_RegDstChoose,
	m_HazardKindFromController,
	m_MemOrAluFromController);
	
	u6 : Reg1Mux		--reg1mux
	PORT MAP(
	m_Reg1Choose,
	m_InstructionFromIFID,
	m_Reg1IndexFromMux
	);
	
	u7 : Reg1Mux 		--regDstMux
	PORT MAP(
	m_RegDstChoose,
	m_InstructionFromIFID,
	m_RegDstIndexFromMux
	);
	
	u8 : Reg2Mux 		
	PORT MAP(
	m_InstructionFromIFID,
	m_Reg2Choose,
	m_Reg2IndexFromMux
	);
	
	u9 : ImmediateMux
	PORT MAP(
	m_InstructionFromIFID,
	m_SignExtend,
	m_ImmChoose,
	m_ImmFromMux
	);
	
	u10 : RegisterGroup
	PORT MAP(
	clk,
	m_Reg1DataFromRegs,
	m_Reg2DataFromRegs,
	m_WriteRegFromMEMWB,
	m_WriteDataFromMux,
	m_RegDstIndexFromMEMWB,
	m_Reg1IndexFromMux,
	m_Reg2IndexFromMux
	);
	
	u11 : ID_EXE_PILLAR
	PORT MAP(
	clk,
	m_PCFromIFID,
	m_PCFromIDEXE,
	m_AluOpFromController,
	m_AluOpFromIDEXE,
	m_ImmOrReg2FromController,
	m_ImmOrReg2FromIDEXE,
	m_UsePCFromController,
	m_UsePCFromIDEXE,
	m_Reg1DataFromRegs,
	m_Reg1DataFromIDEXE,
	m_Reg2DataFromRegs,
	m_Reg2DataFromIDEXE,
	m_ImmFromMux,
	m_ImmFromIDEXE,
	m_Reg1IndexFromMux,
	m_Reg1IndexFromIDEXE,
	m_Reg2IndexFromMux,
	m_Reg2IndexFromIDEXE,
	m_RegDstIndexFromMux,
	m_RegDstIndexFromIDEXE,
	m_HazardKindFromController,
	m_HazardKindFromIDEXE,
	m_MemReadFromController,
	m_MemReadFromIDEXE,
	m_MemWriteFromController,
	m_MemWriteFromIDEXE,
	m_WriteRegFromController,
	m_WriteRegFromIDEXE,
	m_MemOrAluFromController,
	m_MemOrAluFromIDEXE,
	m_IDEXEFlush
	);
	
	u12 : HazardDetection
	PORT MAP(
	m_RegDstIndexFromIDEXE,
	m_Reg1IndexFromMux,
	m_Reg2IndexFromMux,
	m_HazardKindFromIDEXE,
	m_AluResFromAlu,
	m_PCKeep,
	m_IFIDKeep,
	m_IFIDFlush,
	m_IDEXEFlush,
	m_PCChoose
	);
	
	u13 : CPU_ADDER
	PORT MAP(
	m_PCFromIDEXE,
	m_ImmFromIDEXE,
	m_CondJumpDst
	);
	
	u14 : CPU_FORWARD_SRCA
	PORT MAP(
	m_UsePCFromIDEXE,
	m_PCFromIDEXE,
	m_Reg1DataFromIDEXE,
	m_Reg1IndexFromIDEXE,
	m_AluResFromEXEMEM,
	m_RegDstIndexFromEXEMEM,
	m_AluResFromMEMWB,
	m_RegDstIndexFromMEMWB,
	m_AluSrc1
	);
	
	u15 : CPU_FORWARD_SRCB
	PORT MAP(
	m_ImmFromIDEXE,
	m_Reg2DataFromIDEXE,
	m_ImmOrReg2FromIDEXE,
	m_Reg2IndexFromIDEXE,
	m_AluResFromEXEMEM,
	m_RegDstIndexFromEXEMEM,
	m_AluResFromMEMWB,
	m_RegDstIndexFromMEMWB,
	m_AluSrc2
	);
	
	u16 : CPU_ALU
	PORT MAP(
	m_AluSrc1,
	m_AluSrc2,
	m_AluOpFromIDEXE,
	m_AluResFromAlu
	);
	
	u17 : EXE_MEM_PILLAR
	PORT MAP(
	clk,
	m_MemReadFromIDEXE,
	m_MemReadFromEXEMEM,
	m_MemWriteFromIDEXE,
	m_MemWriteFromEXEMEM,
	m_AluResFromAlu,
	m_AluResFromEXEMEM,
	m_WriteMemDataFromMux,
	m_WriteMemDataFromEXEMEM,
	m_RegDstIndexFromIDEXE,
	m_RegDstIndexFromEXEMEM,
	m_MemOrAluFromIDEXE,
	m_MemOrAluFromEXEMEM,
	m_WriteRegFromIDEXE,
	m_WriteRegFromEXEMEM
	);
	
	u18 : MEM_WB_PILLAR
	PORT MAP(
	m_MemOrAluFromEXEMEM,
	m_WriteRegFromEXEMEM,
	m_RegDstIndexFromEXEMEM,
	m_MemDataFromMem,
	m_AluResFromEXEMEM,
	m_MemOrAluFromMEMWB,
	m_WriteRegFromMEMWB,
	m_RegDstIndexFromMEMWB,
	m_MemDataFromMEMWB,
	m_AluResFromMEMWB,
	clk
	);
	
	u19 : WBMux
	PORT MAP(
	m_WriteDataFromMux,
	m_MemDataFromMEMWB,
	m_AluResFromMEMWB,
	m_MemOrAluFromMEMWB
	);
	
	u20 : CPU_FORWARD_SRCC
	PORT MAP(
	m_Reg2DataFromIDEXE,
	m_Reg2IndexFromIDEXE,
	m_AluResFromEXEMEM,
	m_RegDstIndexFromEXEMEM,
	m_AluResFromMEMWB,
	m_RegDstIndexFromMEMWB,
	m_WriteMemDataFromMux
	);
	

end Behavioral;

