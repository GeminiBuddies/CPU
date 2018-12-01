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
	
	signal _PCKeep: STD_LOGIC;
	signal _PCFromMux : STD_LOGIC_VECTOR(15 downto 0);
	signal _PCFromReg : STD_LOGIC_VECTOR(15 downto 0);
	signal _PCFromAdder : STD_LOGIC_VECTOR(15 downto 0);
	signal _PCFromIFID : STD_LOGIC_VECTOR(15 downto 0);
	signal _PCFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	signal _PCChoose: STD_LOGIC_VECTOR(1 downto 0);
	signal _CondJumpDst : STD_LOGIC_VECTOR(15 downto 0);
	
	signal _InstructionFromMem : STD_LOGIC_VECTOR(15 downto 0);
	signal _InstructionFromIFID : STD_LOGIC_VECTOR(15 downto 0);
	
	signal _AluOpFromController : STD_LOGIC_VECTOR(3 downto 0);
	signal _AluOpFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	
	signal _SignExtend : STD_LOGIC;
	
	signal _ImmOrReg2FromController : STD_LOGIC;
	signal _ImmOrReg2FromIDEXE : STD_LOGIC;
	signal _MemReadFromController ： STD_LOGIC;
	signal _MemReadFromIDEXE : STD_LOGIC;
	signal _MemReadFromEXEMEM : STD_LOGIC;
	signal _MemWriteFromController : STD_LOGIC;
	signal _MemWriteFromIDEXE ： STD_LOGIC;
	signal _MemWriteFromEXEMEM : STD_LOGIC;
	signal _WriteRegFromController : STD_LOGIC;
	signal _WriteRegFromIDEXE : STD_LOGIC;
	signal _WriteRegFromEXEMEM : STD_LOGIC;
	signal _WriteRegFromMEMRB : STD_LOGIC;
	signal _UsePCFromController : STD_LOGIC;
	signal _UsePCFromIDEXE : STD_LOGIC;
	signal _Reg1Choose : STD_LOGIC_VECTOR(2 downto 0);
	signal _Reg2Choose : STD_LOGIC_VECTOR(1 downto 0);
	signal _ImmChoose : STD_LOGIC_VECTOR(2 downto 0);
	signal _RegDstChoose : STD_LOGIC_VECTOR(2 downto 0);
	signal _HazardKindFromController : STD_LOGIC_VECTOR(1 downto 0);
	signal _HazardKindFromIDEXE : STD_LOGIC_VECTOR(1 downto 0);
	signal _MemOrAluFromController : STD_LOGIC;
	signal _MemOrAluFromIDEXE : STD_LOGIC;
	signal _MemOrAluFromEXEMEM : STD_LOGIC;
	
	signal _Reg1IndexFromMux : STD_LOGIC_VECTOR(3 downto 0);
	signal _Reg1IndexFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	signal _Reg2IndexFromMux : STD_LOGIC_VECTOR(3 downto 0);
	signal _Reg2IndexFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	signal _RegDstIndexFromMux : STD_LOGIC_VECTOR(3 downto 0);
	signal _RegDstIndexFromIDEXE : STD_LOGIC_VECTOR(3 downto 0);
	signal _RegDstIndexFromEXEMEM : STD_LOGIC_VECTOR(3 downto 0);
	signal _RegDstIndexFromMEMWB : STD_LOGIC_VECTOR(3 downto 0);
	signal _ImmFromMux : STD_LOGIC_VECTOR(15 downto 0);
	signal _ImmFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	
	signal _Reg1DataFromRegs : STD_LOGIC_VECTOR(15 downto 0);
	signal _Reg1DataFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	signal _Reg2DataFromRegs : STD_LOGIC_VECTOR(15 downto 0);
	signal _Reg2DataFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	
	
begin
	u1 : PC
	PORT MAP(
	clk, 
	_PCKeep,
	_PCFromMux, 
	_PCFromReg);
	
	
	u2 : PCAdder
	PORT MAP(
	_PCFromReg,
	_PCFromAdder);
	
	
	u3 : PCMux 
	PORT MAP(
	_PCChoose, 
	_PCFromAdder,
	_Reg1DataFromIDEXE,
	_CondJumpDst,
	_PCFromMux);
	
	
	u4 : IF_ID_PILLAR 
	PORT MAP(
	clk, 
	_IFIDKeep, 
	_IFIDFlush, 
	_PCFromAdder, 
	_PCFromIFID,
	_InstructionFromIFID, 
	_InstructionFromMem); 
	
	
	u5 : Controller 
	PORT MAP(
	_AluOpFromController, 
	_InstructionFromIFID, 
	_SignExtend, 
	_ImmOrReg2FromController, 
	_MemReadFromController,
	_MemWriteFromController,
	_WriteRegFromController,
	_UsePCFromController,
	_Reg1Choose,
	_Reg2Choose,
	_ImmChoose,
	_RegDstChoose,
	_HazardKindFromController,
	_MemOrAluFromController);
	
	u6 : Reg1Mux		--reg1mux
	PORT MAP(
	_Reg1Choose,
	_InstructionFromIFID,
	_Reg1IndexFromMux
	);
	
	u7 : Reg1Mux 		--regDstMux
	PORT MAP(
	_RegDstChoose,
	_InstructionFromIFID,
	_RegDstIndexFromMux
	);
	
	u8 : Reg2Mux 		
	PORT MAP(
	_InstructionFromIFID,
	_Reg2Choose,
	_Reg2IndexFromMux
	);
	
	u9 : ImmediateMux
	PORT MAP(
	_InstructionFromIFID,
	_SignExtend,
	_ImmChoose,
	_ImmFromMux
	);
	
	u10 : RegiterGroup
	PORT MAP(
	clk,
	_Reg1DataFromRegs,
	_Reg2DataFromRegs,
	_WriteRegFromMEMRB,
	_WriteDataFromMux,
	_RegDstFromMEMRB,
	_Reg1IndexFromMux,
	_Reg2IndexFromMux
	);
	
	u11 : ID_EXE_PILLAR
	PORT MAP(
	clk,
	_PCFromIFID,
	_PCFromIDEXE,
	_AluOpFromController,
	_AluOpFromIDEXE,
	_ImmOrReg2FromController,
	_ImmOrReg2FromIDEXE,
	_UsePCFromController,
	_UsePCFromIDEXE,
	_Reg1DataFromRegs,
	_Reg1DataFromIDEXE,
	_Reg2DataFromRegs,
	_Reg2DataFromIDEXE,
	_ImmFromMux,
	_ImmFromIDEXE,
	_Reg1IndexFromMux,
	_Reg1IndexFromIDEXE,
	_Reg2IndexFromMux,
	_Reg2IndexFromIDEXE,
	_RegDstIndexFromMux,
	_RegDstIndexFromIDEXE,
	_HazardKindFromController,
	_HazardKindFromIDEXE,
	_MemReadFromController,
	_MemReadFromIDEXE,
	_MemWriteFromController,
	_MemWriteFromIDEXE,
	_WriteRegFromController,
	_WriteRegFromIDEXE,
	_MemOrAluFromController,
	_MemOrAluFromIDEXE,
	_IDEXEFlush,
	);
	
	u12 : HazardDetection
	PORT MAP(
	_RegDstIndexFromIDEXE,
	_Reg1IndexFromMux,
	_Reg2IndexFromMux,
	_HazardKindFromIDEXE,
	_AluResFromAlu,
	_PCKeep,
	_IFIDKeep,
	_IFIDFlush,
	_IDEXEFlush,
	_PCChoose
	);
	
	u13 : CPU_ADDER
	PORT MAP(
	_PCFromIDEXE,
	_ImmFromIDEXE,
	_CondJumpDst
	);
	
	u14 : 
	
	

end Behavioral;

