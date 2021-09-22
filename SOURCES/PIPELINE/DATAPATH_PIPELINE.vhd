----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:53 05/20/2021 
-- Design Name: 
-- Module Name:    DATAPATH_PIPELINE - Behavioral 
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH_PIPELINE is
 Port (    PC_sel : in  STD_LOGIC;
			  Imm_Ext : in STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
			  AB_WrEn : in STD_LOGIC;
			  RT_WrEn : in STD_LOGIC;
			  RS_WrEn : in STD_LOGIC;
			  RD_WrEn : in STD_LOGIC;
			  BAfter_WrEn : in STD_LOGIC;
			  WRA_WrEn : in STD_LOGIC;
			  Imm_WrEn : in STD_LOGIC; 
			  ALU_WrEn : in STD_LOGIC;
			  Instr_WrEn : in STD_LOGIC;	  
			  OP_WrEn : in std_logic;
			  OP2_WrEn : in std_logic;
			  ALUBin_WrEn : in std_logic;
			  Dest_WrEn : in std_logic;
			  RFWrSel_WrEn : in std_logic;
			  RFWrSel2_WrEn : in std_logic;
			  RFWrSel3_WrEn : in std_logic;
			  WRA2_WrEn : in std_logic;
			  ImmExt_WrEn : in std_logic;
			  RS2_WrEn : in std_logic;
			  RT2_WrEn : in std_logic;  
			  RFWr1_WrEn : in std_logic;
			  RFWr2_WrEn : in std_logic;
			  RFWr3_WrEn : in std_logic;
			  RFWr4_WrEn : in std_logic;
			  ALUAfter_WrEn : in STD_LOGIC;
			  MemReg_WrEn : in std_logic;  
           RF_B_sel : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
			  Byteop : in std_logic;
			  Mem_WrEn : in STD_LOGIC;
			  MemA_WrEn : in STD_LOGIC;
			  MemA2_WrEn : in STD_LOGIC; 
			  Opcode : out STD_LOGIC_VECTOR (5 downto 0));

end DATAPATH_PIPELINE;

architecture Behavioral of DATAPATH_PIPELINE is
 component IFSTAGE is
    Port ( PC_Immed : in  std_logic_vector(31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_Lden : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Pc : out  std_logic_vector(31 downto 0)
			  );
	end component;


component RAM is
    Port ( Clk : in  STD_LOGIC;
           inst_addr : in  STD_LOGIC_vector(10 downto 0);
           inst_dout  : out  STD_LOGIC_vector(31 downto 0);
           data_we  : in  STD_LOGIC;
           data_addr : in  STD_LOGIC_vector(10 downto 0);
           data_din : in  STD_LOGIC_vector(31 downto 0);
           data_dout : out STD_LOGIC_vector(31 downto 0)
			  );
end component;

component EX_DEC_Module is
Port (   
          Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
			  pcld : in std_logic;
			  pcldout : out std_logic;
			  AB_WrEn : in STD_LOGIC;
			  RT_WrEn : in STD_LOGIC;
			  RS_WrEn : in STD_LOGIC;
			  RD_WrEn : in STD_LOGIC;
			  WRA_WrEn : in STD_LOGIC;
			  BAfter_WrEn : in STD_LOGIC;
			  Imm_WrEn : in STD_LOGIC;
			  ALU_WrEn : in STD_LOGIC;
			  ALUAfter_WrEn : in STD_LOGIC;
			  Instr_WrEn : in STD_LOGIC;
			  PC_sig : in std_logic_vector(31 downto 0);
			  RFWr1_WrEn : in std_logic;
			  RFWr2_WrEn : in std_logic;
			  RFWr3_WrEn : in std_logic;
			  RFWr4_WrEn : in std_logic;
			  RS2_WrEn : in std_logic;
			  RT2_WrEn : in std_logic;
			  toMem_WrEn : in std_logic;
			  OP_WrEn : in std_logic;
			  OP2_WrEn : in std_logic;
			  ALUBin_WrEn : in std_logic;
			  Dest_WrEn : in std_logic;
			  RFWrSel_WrEn : in std_logic;
			  RFWrSel2_WrEn : in std_logic;
			  RFWrSel3_WrEn : in std_logic;
			  WRA2_WrEn : in std_logic;
			  ImmExt_WrEn : in std_logic; 
           RF_WrData_sel : in  STD_LOGIC;
			  memforw : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Bin_sel : in  STD_LOGIC;
           Imm_Ext : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Reset : in std_logic;
			  ALU_MEM_ADDR : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_Bb : out std_logic_vector(31 downto 0);
			  Immed_out : out STD_LOGIC_VECTOR (31 downto 0);
			  Zero_out : out std_logic 
			  
			  );
end component;			

component mux_1to1 is
    Port ( input : in  STD_LOGIC_vector(31 downto 0);
           output : out  STD_LOGIC_vector(31 downto 0);
           sel : in  STD_LOGIC);
end component;
  
  component register32bit is
    Port ( clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           datain : in  STD_LOGIC_vector(31 downto 0);
           dataout : out  STD_LOGIC_vector(31 downto 0)
			  );
end component;

component register1bit is
    Port ( clk : in  STD_LOGIC;
           we : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           datain : in  STD_LOGIC;
           dataout : out  STD_LOGIC
			  );
end component;


signal Pc_LdenAfter : STD_LOGIC;
signal instr_RAMtoDec :STD_LOGIC_vector(31 downto 0);
signal PCtoRAM :STD_LOGIC_vector(31 downto 0);
signal Mem_WrEnAfter1: STD_LOGIC;
signal Mem_WrEnAfter2: STD_LOGIC;
signal RF_Bb_sig :STD_LOGIC_vector(31 downto 0);
signal Imm_res: STD_LOGIC_VECTOR (31 downto 0);
signal memToRF_sig:STD_LOGIC_vector(31 downto 0);
signal memToRF_mod:STD_LOGIC_vector(31 downto 0);
signal memToRF_sig_reg:STD_LOGIC_vector(31 downto 0);

signal RF_Bb_sig_mod:STD_LOGIC_vector(31 downto 0);
signal pc_choice: STD_LOGIC_VECTOR (31 downto 0);
signal temp: STD_LOGIC_VECTOR (10 downto 0); 
signal alu_mem : unsigned (10 downto 0);
signal ALU_MEM_addr : STD_LOGIC_VECTOR (31 downto 0);
signal pcsel : STD_LOGIC;
signal alu_zero: STD_LOGIC;



begin
  temp <= ALU_MEM_addr(12 downto 2);
	alu_mem <= unsigned(temp) + 1024;
pcsel <= PC_sel AND(NOT alu_zero);
Opcode <= instr_RAMtoDec(31 downto 26);
Imm_res <= pc_choice;

EX_DEC_PIPELINE : EX_DEC_Module  Port MAP 
         (Instr => instr_RAMtoDec,----
           RF_B_sel => RF_B_sel,
			  RF_WrEn =>RF_WrEn,
			  pcld =>Pc_Lden,
			  pcldout => Pc_LdenAfter,
			  AB_WrEn => AB_WrEn,
			  RT_WrEn => RT_WrEn,
			  RS_WrEn => RS_WrEn,
			  RD_WrEn => RD_WrEn ,
			  WRA_WrEn => WRA_WrEn,
			  BAfter_WrEn => BAfter_WrEn,
			  Imm_WrEn => Imm_WrEn,
			  ALU_WrEn => ALU_WrEn,
			  ALUAfter_WrEn => ALUAfter_WrEn,
			  Instr_WrEn => Instr_WrEn,
			  PC_sig =>PCtoRAM,------
			  RFWr1_WrEn => RFWr1_WrEn,
			  RFWr2_WrEn => RFWr2_WrEn,
			  RFWr3_WrEn => RFWr3_WrEn,
			  RFWr4_WrEn => RFWr4_WrEn,
			  RS2_WrEn => RS2_WrEn,
			  RT2_WrEn => RT2_WrEn,
			  toMem_WrEn =>Mem_WrEnAfter1,
			  OP_WrEn => OP_WrEn,
			  OP2_WrEn => OP2_WrEn,
			  ALUBin_WrEn => ALUBin_WrEn,
			  Dest_WrEn => Dest_WrEn,
			  RFWrSel_WrEn => RFWrSel_WrEn,
			  RFWrSel2_WrEn => RFWrSel2_WrEn,
			  RFWrSel3_WrEn => RFWrSel3_WrEn,
			  WRA2_WrEn =>  WRA2_WrEn,
			  ImmExt_WrEn => ImmExt_WrEn,
           RF_WrData_sel => RF_WrData_sel,
			  memforw =>memToRF_mod,
           MEM_out =>memToRF_sig_reg,
			  ALU_Bin_sel => ALU_Bin_sel,
           Imm_Ext =>Imm_Ext,
           Clk =>Clk,
			  Reset =>Reset,
			  ALU_MEM_ADDR =>ALU_MEM_addr,
			  RF_Bb =>RF_Bb_sig,
			  Immed_out =>Imm_res,
			  Zero_out =>alu_zero

);

 PIPELINE_IFTAGE: IFSTAGE PORT MAP
          ( PC_Immed =>pc_choice,
           PC_sel =>pcsel,
           PC_Lden =>Pc_LdenAfter,
           Reset =>Reset,
           Clk =>Clk,
           Pc =>PCtoRAM
			  );
	

PIPELINE_RAM : RAM PORT MAP 
           ( Clk =>Clk,
           inst_addr =>PCtoRAM(12 downto 2),
           inst_dout  => instr_RAMtoDec,
           data_we  =>Mem_WrEnAfter2,
           data_addr =>std_logic_vector(alu_mem),
           data_din =>RF_Bb_sig_mod,
           data_dout =>memToRF_mod
			  );

------------------------------------------
REG_MemEN1 : register1bit PORT MAP (clk => clk, we => MemA_WrEn, reset => Reset, dataIn => Mem_WrEn, dataOut => Mem_WrEnAfter1);
	
REG_MemEN2 : register1bit PORT MAP (clk => clk, we => MemA2_WrEn, reset => Reset, dataIn => Mem_WrEnAfter1, dataOut => Mem_WrEnAfter2);


REG_Mem : register32bit PORT MAP (clk => clk, we => MEMReg_WrEn, rst => Reset, dataIn => memToRF_sig, dataOut => memToRF_sig_reg);

storeselector: mux_1to1	
				port map( input =>RF_Bb_sig,
							output =>RF_Bb_sig_mod,
							sel => Byteop
								);
		
loadselector: mux_1to1	
				port map( input =>memToRF_mod,
							output =>memToRF_sig,
								sel => Byteop
									);		


end Behavioral;


