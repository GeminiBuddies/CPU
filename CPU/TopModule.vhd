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
		--Debug		
				Reg00 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg01 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg02 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg03 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg04 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg05 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg06 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg07 : out STD_LOGIC_VECTOR(15 downto 0);
				IH : out STD_LOGIC_VECTOR(15 downto 0);
				SP : out STD_LOGIC_VECTOR(15 downto 0);
				RA : out STD_LOGIC_VECTOR(15 downto 0);
				T : out STD_LOGIC_VECTOR(15 downto 0);
			RegPC : out STD_LOGIC_VECTOR(15 downto 0);
--				
 			clk0 : out STD_LOGIC;
			clk1 : out STD_LOGIC;
		--Debug
--		
--		ram_addr: out std_logic_vector(17 downto 0) := (others => '0');
--		ram_data: inout std_logic_vector(15 downto 0);
--		ram_en: out std_logic;
--		ram_oe: out std_logic;
--		ram_we: out std_logic;
--		wrn: out std_logic;
--		tbre: in std_logic;
--		tsre: in std_logic;
--		rdn: out std_logic;
--		data_ready: in std_logic;
--		
--		-- flash bus
--		flash_byte: out std_logic; 
--		flash_vpen: out std_logic;
--		flash_ce: out std_logic; 
--		flash_oe: out std_logic; 
--		flash_we: out std_logic; 
--		flash_rp: out std_logic; 
--		flash_addr: out std_logic_vector(22 downto 1);
--		flash_data: inout std_logic_vector(15 downto 0);
	
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
			  --Debug		
				Reg00 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg01 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg02 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg03 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg04 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg05 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg06 : out STD_LOGIC_VECTOR(15 downto 0);
				Reg07 : out STD_LOGIC_VECTOR(15 downto 0);
				IH : out STD_LOGIC_VECTOR(15 downto 0);
				SP : out STD_LOGIC_VECTOR(15 downto 0);
				RA : out STD_LOGIC_VECTOR(15 downto 0);
				T : out STD_LOGIC_VECTOR(15 downto 0);
		--Debug
				
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
			origin_data		: in STD_LOGIC_VECTOR(15 downto 0);
			r_src				: in STD_LOGIC_VECTOR(3 downto 0);
			exe_mem_data	: in STD_LOGIC_VECTOR(15 downto 0);
			exe_mem_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			mem_wb_data		: in STD_LOGIC_VECTOR(15 downto 0);
			mem_wb_r_dst	: in STD_LOGIC_VECTOR(3 downto 0);
			result			: out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;
	
	component AluPCMux
		port(
			UsePC : in STD_LOGIC;
			PC : in STD_LOGIC_VECTOR(15 downto 0);
			ForwardAData : in STD_LOGIC_VECTOR(15 downto 0);
			AluSrc1 : out STD_LOGIC_VECTOR(15 downto 0)
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
	
--	component mem
--		port(
--			clk0: in std_logic;
--			nclk0: in std_logic;
--			clk_wb: in std_logic;
--			nclk_wb: in std_logic;
--			ram_addr: out std_logic_vector(17 downto 0);
--			ram_data: inout std_logic_vector(15 downto 0);
--			ram_en: out std_logic;
--			ram_oe: out std_logic;
--			ram_we: out std_logic;
--			pc: in std_logic_vector(15 downto 0);
--			instr: out std_logic_vector(15 downto 0);
--			r: in std_logic;
--			w: in std_logic;
--			addr: in std_logic_vector(15 downto 0);
--			idata: in std_logic_vector(15 downto 0);
--			odata: out std_logic_vector(15 downto 0);
--			wrn: out std_logic;
--			tbre: in std_logic;
--			tsre: in std_logic;
--			rdn: out std_logic;
--			data_ready: in std_logic
--		);
--	end component;
	
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
	
	component fucker
		port(
			iclk: in std_logic;
			oclk: out std_logic := '0'
		);
	end component;
	
	
	
	component memfuck
		port(
		clk : in std_logic;
		clk0: out std_logic;
		clk1: out std_logic;
		pc: in std_logic_vector(15 downto 0);
		instr: out std_logic_vector(15 downto 0);
		r: in std_logic;
		w: in std_logic;
		addr: in std_logic_vector(15 downto 0);
		idata: in std_logic_vector(15 downto 0);
		odata: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component mem
	port(
		-- clock
		clk: in std_logic;

		-- clocks output
		clk0: out std_logic := '0';
		clk1: out std_logic := '0';
		
		-- ram and serial bus
		ram_addr: out std_logic_vector(17 downto 0) := (others => '0');
		ram_data: inout std_logic_vector(15 downto 0);
		ram_en: out std_logic;
		ram_oe: out std_logic;
		ram_we: out std_logic;
		wrn: out std_logic;
		tbre: in std_logic;
		tsre: in std_logic;
		rdn: out std_logic;
		data_ready: in std_logic;
		
		-- flash bus
		flash_byte: out std_logic; 
		flash_vpen: out std_logic; 
		flash_ce: out std_logic; 
		flash_oe: out std_logic; 
		flash_we: out std_logic; 
		flash_rp: out std_logic; 
		flash_addr: out std_logic_vector(22 downto 1); 
		flash_data: inout std_logic_vector(15 downto 0);
			
		-- debug output
--		lcd: out std_logic_vector(15 downto 0);
		
		-- interface
		pc: in std_logic_vector(15 downto 0);
		instr: out std_logic_vector(15 downto 0);
		r: in std_logic;
		w: in std_logic;
		addr: in std_logic_vector(15 downto 0);
		idata: in std_logic_vector(15 downto 0);
		odata: out std_logic_vector(15 downto 0)
	);
	end component;
	
	signal m_PCKeep: STD_LOGIC;
	signal m_PCFromMux : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromReg : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromAdder : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromIFID : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCFromIDEXE : STD_LOGIC_VECTOR(15 downto 0);
	signal m_PCChoose: STD_LOGIC_VECTOR(1 downto 0):= "00";
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
	
	
	signal m_ForwardA : STD_LOGIC_VECTOR(15 downto 0);
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
	
	signal m_clk0 : STD_LOGIC;
	signal m_clk1 : STD_LOGIC;
	signal m_clk2 : STD_LOGIC;
	signal m_clk3 : STD_LOGIC;
	signal m_nclk0 : STD_LOGIC;
	signal m_nclk1 : STD_LOGIC;
	signal m_nclk2 : STD_LOGIC;
	signal m_nclk3 : STD_LOGIC;
	
	signal m_FuckerClk : STD_LOGIC;
	
	
	
	
begin
	u1_PC : PC
	PORT MAP(
	clk => m_clk0, 
	PCKeep => m_PCKeep,
	PCIn => m_PCFromMux, 
	PCOut => m_PCFromReg);
	
	
	u2_PCAdder : PCAdder
	PORT MAP(
	PC => m_PCFromReg,
	AddedPC => m_PCFromAdder);

	
	u3_PCMux : PCMux 
	PORT MAP(
	PCChoose => m_PCChoose, 
	AddedPC => m_PCFromAdder,
	RegJump => m_ForwardA,
	ConditionalJump => m_CondJumpDst,
	NextPC => m_PCFromMux);
	
	
	u4_IF_ID_PILLAR : IF_ID_PILLAR 
	PORT MAP(
	clk => m_clk0, 
	IFIDKeep => m_IFIDKeep, 
	IFIDFlush => m_IFIDFlush, 
	PCIn => m_PCFromAdder, 
	PCOut => m_PCFromIFID,
	InstructionOut => m_InstructionFromIFID, 
	InstructionIn => m_InstructionFromMem); 
	
	
	u5_Controller : Controller 
	PORT MAP(
	AluOp => m_AluOpFromController, 
	Instruction => m_InstructionFromIFID, 
	SignExtend => m_SignExtend, 
	ImmOrReg2 => m_ImmOrReg2FromController, 
	MemRead => m_MemReadFromController,
	MemWrite => m_MemWriteFromController,
	WriteReg => m_WriteRegFromController,
	UsePc => m_UsePCFromController,
	Reg1Choose => m_Reg1Choose,
	Reg2Choose => m_Reg2Choose,
	ImmChoose => m_ImmChoose,
	RegDstChoose => m_RegDstChoose,
	HazardKind => m_HazardKindFromController,
	MemOrAlu => m_MemOrAluFromController);
	
	
	u6_Reg1Mux : Reg1Mux		--reg1mux
	PORT MAP(
	Reg1Choose => m_Reg1Choose,
	Instruction => m_InstructionFromIFID,
	Reg1Index => m_Reg1IndexFromMux
	);
	
	
	u7_RegDstMux : Reg1Mux 		--regDstMux
	PORT MAP(
	Reg1Choose => m_RegDstChoose,
	Instruction => m_InstructionFromIFID,
	Reg1Index => m_RegDstIndexFromMux
	);
	
	u8_Reg2Mux : Reg2Mux 		
	PORT MAP(
	Instruction => m_InstructionFromIFID,
	Reg2Choose => m_Reg2Choose,
	Reg2Index => m_Reg2IndexFromMux
	);

	
	u9_ImmediateMux : ImmediateMux
	PORT MAP(
	Instruction => m_InstructionFromIFID,
	SignExtend => m_SignExtend,
	ImmChoose => m_ImmChoose,
	ExtendedImm => m_ImmFromMux
	);
	
	
	u10_RegisterGroup : RegisterGroup
	PORT MAP(
	Reg00,
	Reg01,
	Reg02,
	Reg03,
	Reg04,
	Reg05,
	Reg06,
	Reg07,
	IH,
	SP,
	RA,
	T,	
	clk => m_clk0,
	Reg1Data => m_Reg1DataFromRegs,
	Reg2Data => m_Reg2DataFromRegs,
	WriteReg => m_WriteRegFromMEMWB,
	WriteData => m_WriteDataFromMux,
	DstReg => m_RegDstIndexFromMEMWB,
	Reg1Index => m_Reg1IndexFromMux,
	Reg2Index => m_Reg2IndexFromMux
	);

	u11_ID_EXE_PILLAR : ID_EXE_PILLAR
	PORT MAP(
	clk => m_clk0,
	PCIn => m_PCFromIFID,
	PCOut => m_PCFromIDEXE,
	AluOpIn => m_AluOpFromController,
	AluOpOut => m_AluOpFromIDEXE,
	ImmOrReg2In => m_ImmOrReg2FromController,
	ImmOrReg2Out => m_ImmOrReg2FromIDEXE,
	UsePcIn => m_UsePCFromController,
	UsePcOut => m_UsePCFromIDEXE,
	Reg1DataIn => m_Reg1DataFromRegs,
	Reg1DataOut => m_Reg1DataFromIDEXE,
	Reg2DataIn => m_Reg2DataFromRegs,
	Reg2DataOut => m_Reg2DataFromIDEXE,
	ImmIn => m_ImmFromMux,
	ImmOut => m_ImmFromIDEXE,
	Reg1IndexIn => m_Reg1IndexFromMux,
	Reg1IndexOut => m_Reg1IndexFromIDEXE,
	Reg2IndexIn => m_Reg2IndexFromMux,
	Reg2IndexOut => m_Reg2IndexFromIDEXE,
	DstIndexIn => m_RegDstIndexFromMux,
	DstIndexOut => m_RegDstIndexFromIDEXE,
	HazardKindIn => m_HazardKindFromController,
	HazardKindOut => m_HazardKindFromIDEXE,
	MemReadIn => m_MemReadFromController,
	MemReadOut => m_MemReadFromIDEXE,
	MemWriteIn => m_MemWriteFromController,
	MemWriteOut => m_MemWriteFromIDEXE,
	WriteRegIn => m_WriteRegFromController,
	WriteRegOut => m_WriteRegFromIDEXE,
	MemOrAluIn => m_MemOrAluFromController,
	MemOrAluOut => m_MemOrAluFromIDEXE,
	IDEXEFlush => m_IDEXEFlush
	);
	
	
	u12_HazardDetection : HazardDetection
	PORT MAP(
	LoadDst => m_RegDstIndexFromIDEXE,
	RegSrc1 => m_Reg1IndexFromMux,
	RegSrc2 => m_Reg2IndexFromMux,
	HazardKind => m_HazardKindFromIDEXE,
	AluRes => m_AluResFromAlu,
	PCKeep => m_PCKeep,
	IFIDKeep => m_IFIDKeep,
	IFIDFlush => m_IFIDFlush,
	IDEXEFlush => m_IDEXEFlush,
	PCChoose => m_PCChoose
	);
	
	u13_CPU_ADDER : CPU_ADDER
	PORT MAP(
	PC => m_PCFromIDEXE,
	Imm => m_ImmFromIDEXE,
	result => m_CondJumpDst
	);
	
	u14_CPU_FORWARD_SRCA : CPU_FORWARD_SRCA
	PORT MAP(
	origin_data => m_Reg1DataFromIDEXE,
	r_src => m_Reg1IndexFromIDEXE,
	exe_mem_data => m_AluResFromEXEMEM,
	exe_mem_r_dst => m_RegDstIndexFromEXEMEM,
	mem_wb_data => m_AluResFromMEMWB,
	mem_wb_r_dst => m_RegDstIndexFromMEMWB,
	result => m_ForwardA
	);
	
	u15_CPU_FORWARD_SRCB : CPU_FORWARD_SRCB
	PORT MAP(
	imm => m_ImmFromIDEXE,
	origin_r_data => m_Reg2DataFromIDEXE,
	imm_or_r => m_ImmOrReg2FromIDEXE,
	r_src => m_Reg2IndexFromIDEXE,
	exe_mem_data => m_AluResFromEXEMEM,
	exe_mem_r_dst => m_RegDstIndexFromEXEMEM,
	mem_wb_data => m_AluResFromMEMWB,
	mem_wb_r_dst => m_RegDstIndexFromMEMWB,
	result => m_AluSrc2
	);
	
	u16_CPU_ALU : CPU_ALU
	PORT MAP(
	srcA => m_AluSrc1,
	srcB => m_AluSrc2,
	op => m_AluOpFromIDEXE,
	result => m_AluResFromAlu
	);
	
	u17_EXE_MEM_PILLAR : EXE_MEM_PILLAR
	PORT MAP(
	clk => m_clk0,
	MemReadIn => m_MemReadFromIDEXE,
	MemReadOut => m_MemReadFromEXEMEM,
	MemWriteIn => m_MemWriteFromIDEXE,
	MemWriteOut => m_MemWriteFromEXEMEM,
	AluResultIn => m_AluResFromAlu,
	AluResultOut => m_AluResFromEXEMEM,
	WriteDataIn => m_WriteMemDataFromMux,
	WriteDataOut => m_WriteMemDataFromEXEMEM,
	DstIndexIn => m_RegDstIndexFromIDEXE,
	DstIndexOut => m_RegDstIndexFromEXEMEM,
	MemOrAluIn => m_MemOrAluFromIDEXE,
	MemOrAluOut => m_MemOrAluFromEXEMEM,
	WriteRegIn => m_WriteRegFromIDEXE,
	WriteRegOut => m_WriteRegFromEXEMEM
	);
	
	u18_MEM_WB_PILLAR : MEM_WB_PILLAR
	PORT MAP(
	mem_or_alu_in => m_MemOrAluFromEXEMEM,
	write_reg_in => m_WriteRegFromEXEMEM,
	reg_dst_in => m_RegDstIndexFromEXEMEM,
	mem_data_in => m_MemDataFromMem,
	alu_data_in => m_AluResFromEXEMEM,
	mem_or_alu_out => m_MemOrAluFromMEMWB,
	write_reg_out => m_WriteRegFromMEMWB,
	reg_dst_out => m_RegDstIndexFromMEMWB,
	mem_data_out => m_MemDataFromMEMWB,
	alu_data_out => m_AluResFromMEMWB,
	clk => m_clk0
	);
	
	u19_WBMux : WBMux
	PORT MAP(
	output => m_WriteDataFromMux,
	memdata => m_MemDataFromMEMWB,
	aludata => m_AluResFromMEMWB,
	mem_or_alu => m_MemOrAluFromMEMWB
	);
	
	u20_CPU_FORWARD_SRCC : CPU_FORWARD_SRCC
	PORT MAP(
	origin_data => m_Reg2DataFromIDEXE,
	r_src => m_Reg2IndexFromIDEXE,
	exe_mem_data => m_AluResFromEXEMEM,
	exe_mem_r_dst => m_RegDstIndexFromEXEMEM,
	mem_wb_data => m_AluResFromMEMWB,
	mem_wb_r_dst => m_RegDstIndexFromMEMWB,
	result => m_WriteMemDataFromMux
	);
	
	u22_memf : memfuck
	PORT MAP(
	clk,
	m_clk0,
	m_clk1,
	m_PCFromReg,
	m_InstructionFromMem,
	m_MemReadFromEXEMEM,
	m_MemWriteFromEXEMEM,
	m_AluResFromEXEMEM,
	m_WriteMemDataFromEXEMEM,
	m_MemDataFromMem
	);
	
	u23_AluPCMux : AluPCMux
	PORT MAP(
	UsePC => m_UsePCFromIDEXE,
	PC => m_PCFromIDEXE,
	ForwardAData => m_ForwardA,
	AluSrc1 => m_AluSrc1
	);
	
--	u24_mem : mem
--	PORT MAP(
--	clk => m_FuckerClk,
--	clk0 => m_clk0,
--	clk1 => m_clk1,
--	
--	ram_addr => ram_addr,
--	ram_data => ram_data,
--	ram_en => ram_en,
--	ram_oe => ram_oe,
--	ram_we => ram_we,
--	wrn => wrn,
--	tbre => tbre,
--	tsre => tsre,
--	rdn => rdn,
--	data_ready => data_ready,
--	
--	flash_byte => flash_byte,
--	flash_vpen => flash_vpen,
--	flash_ce => flash_ce,
--	flash_oe => flash_oe,
--	flash_we => flash_we,
--	flash_rp => flash_rp,
--	flash_addr => flash_addr,
--	flash_data => flash_data,
--	
--	pc => m_PCFromReg,
--	instr => m_InstructionFromMem,
--	r => m_MemReadFromEXEMEM,
--	w => m_MemWriteFromEXEMEM,
--	addr => m_AluResFromEXEMEM,
--	idata => m_WriteMemDataFromEXEMEM,
--	odata => m_MemDataFromMem
--	);
	
	u25_fucker : fucker
	PORT MAP(
	iclk => clk,
	oclk => m_FuckerClk
	);
	
	RegPC <= m_PCFromReg;
	clk0 <= m_clk0;
	clk1 <= m_clk1;

end Behavioral;

