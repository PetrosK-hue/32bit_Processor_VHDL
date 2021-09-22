----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:01:42 05/20/2021 
-- Design Name: 
-- Module Name:    PROCESSOR_PIPELINE - Behavioral 
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

entity PROCESSOR_PIPELINE is
Port ( CLK : in  STD_LOGIC;
       RESET : in  STD_LOGIC
			  );
end PROCESSOR_PIPELINE;

architecture Behavioral of PROCESSOR_PIPELINE is
component CONTROL_PIPELINE is
 Port (    PC_sel : out  STD_LOGIC;
			  Imm_Ext : out STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           PC_LdEn : out STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
			  AB_WrEn : out STD_LOGIC;
			  RT_WrEn : out STD_LOGIC;
			  RS_WrEn : out STD_LOGIC;
			  RD_WrEn : out STD_LOGIC;
			  BAfter_WrEn :out STD_LOGIC;
			  WRA_WrEn : out STD_LOGIC;
			  Imm_WrEn : out STD_LOGIC; 
			  ALU_WrEn : out STD_LOGIC;
			  Instr_WrEn : out STD_LOGIC;	  
			  OP_WrEn : out std_logic;
			  OP2_WrEn : out std_logic;
			  ALUBin_WrEn : out std_logic;
			  Dest_WrEn : out std_logic;
			  RFWrSel_WrEn : out std_logic;
			  RFWrSel2_WrEn : out std_logic;
			  RFWrSel3_WrEn : out std_logic;
			  WRA2_WrEn : out std_logic;
			  ImmExt_WrEn : out std_logic;
			  RS2_WrEn : out std_logic;
			  RT2_WrEn : out std_logic;  
			  RFWr1_WrEn : out std_logic;
			  RFWr2_WrEn : out std_logic;
			  RFWr3_WrEn : out std_logic;
			  RFWr4_WrEn : out std_logic;
			  ALUAfter_WrEn : out STD_LOGIC;
			  MemReg_WrEn : out std_logic;  
           RF_B_sel : out  STD_LOGIC;
           Reset : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
			  Byteop : out std_logic;
			  Mem_WrEn : out STD_LOGIC;
			  MemA_WrEn : out STD_LOGIC;
			  MemA2_WrEn : out STD_LOGIC; 
			  Opcode : in STD_LOGIC_VECTOR (5 downto 0);
			  control_Reset: in STD_LOGIC);
			  
end component;

component DATAPATH_PIPELINE is
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

end component;

signal sg_PC_sel :  STD_LOGIC;
signal sg_Imm_Ext :  STD_LOGIC_VECTOR(1 downto 0);
signal sg_PC_LdEn :  STD_LOGIC;
signal sg_RF_WrData_sel :  STD_LOGIC;
signal sg_RF_WrEn :  STD_LOGIC;
signal sg_AB_WrEn :  STD_LOGIC;
signal sg_RT_WrEn :  STD_LOGIC;
signal sg_RS_WrEn :  STD_LOGIC;
signal sg_RD_WrEn :  STD_LOGIC;
signal sg_BAfter_WrEn : STD_LOGIC;
signal sg_WRA_WrEn :  STD_LOGIC;
signal sg_Imm_WrEn : STD_LOGIC; 
signal sg_ALU_WrEn :  STD_LOGIC;
signal sg_Instr_WrEn :  STD_LOGIC;	  
signal sg_OP_WrEn :  std_logic;
signal sg_OP2_WrEn :  std_logic;
signal sg_ALUBin_WrEn :  std_logic;
signal sg_Dest_WrEn :  std_logic;
signal sg_RFWrSel_WrEn :  std_logic;
signal sg_RFWrSel2_WrEn :  std_logic;
signal sg_RFWrSel3_WrEn :  std_logic;
signal sg_WRA2_WrEn :  std_logic;
signal sg_ImmExt_WrEn :  std_logic;
signal sg_RS2_WrEn :  std_logic;
signal sg_RT2_WrEn :  std_logic;  
signal sg_RFWr1_WrEn :  std_logic;
signal sg_RFWr2_WrEn :  std_logic;
signal sg_RFWr3_WrEn :  std_logic;
signal sg_RFWr4_WrEn :  std_logic;
signal sg_ALUAfter_WrEn :  STD_LOGIC;
signal sg_MemReg_WrEn :  std_logic;  
signal sg_RF_B_sel :   STD_LOGIC;
signal sg_Reset :   STD_LOGIC;
signal sg_ALU_Bin_sel :  STD_LOGIC;
signal sg_Byteop :  std_logic;
signal sg_Mem_WrEn :  STD_LOGIC;
signal sg_MemA_WrEn :  STD_LOGIC;
signal sg_MemA2_WrEn :  STD_LOGIC; 
signal sg_Opcode :  STD_LOGIC_VECTOR(5 downto 0);



begin

PROC_Datapath :DATAPATH_PIPELINE  Port MAP
        (   PC_sel =>sg_PC_sel,
			  Imm_Ext =>sg_Imm_Ext,
           Clk =>CLK,
           PC_LdEn =>sg_PC_LdEn,
           RF_WrData_sel =>sg_RF_WrData_sel,
           RF_WrEn =>sg_RF_WrEn,
			  AB_WrEn =>sg_AB_WrEn,
			  RT_WrEn =>sg_RT_WrEn,
			  RS_WrEn =>sg_RS_WrEn,
			  RD_WrEn =>sg_RD_WrEn,
			  BAfter_WrEn =>sg_BAfter_WrEn,
			  WRA_WrEn =>sg_WRA_WrEn,
			  Imm_WrEn =>sg_Imm_WrEn,
			  ALU_WrEn =>sg_ALU_WrEn,
			  Instr_WrEn =>sg_Instr_WrEn, 
			  OP_WrEn =>sg_OP_WrEn,
			  OP2_WrEn =>sg_OP2_WrEn,
			  ALUBin_WrEn =>sg_ALUBin_WrEn ,
			  Dest_WrEn =>sg_Dest_WrEn,
			  RFWrSel_WrEn =>sg_RFWrSel_WrEn,
			  RFWrSel2_WrEn =>sg_RFWrSel2_WrEn,
			  RFWrSel3_WrEn =>sg_RFWrSel3_WrEn,
			  WRA2_WrEn =>sg_WRA2_WrEn,
			  ImmExt_WrEn =>sg_ImmExt_WrEn,
			  RS2_WrEn =>sg_RS2_WrEn,
			  RT2_WrEn =>sg_RT2_WrEn ,
			  RFWr1_WrEn =>sg_RFWr1_WrEn,
			  RFWr2_WrEn =>sg_RFWr2_WrEn,
			  RFWr3_WrEn =>sg_RFWr3_WrEn,
			  RFWr4_WrEn =>sg_RFWr4_WrEn,
			  ALUAfter_WrEn =>sg_ALUAfter_WrEn,
			  MemReg_WrEn =>sg_MemReg_WrEn,
           RF_B_sel =>sg_RF_B_sel,
           Reset =>sg_Reset,
           ALU_Bin_sel =>sg_ALU_Bin_sel,
			  Byteop =>sg_Byteop,
			  Mem_WrEn =>sg_Mem_WrEn,
			  MemA_WrEn =>sg_MemA_WrEn,
			  MemA2_WrEn =>sg_MemA2_WrEn,
			  Opcode =>sg_Opcode
);

PROC_CONTROL :CONTROL_PIPELINE PORT MAP 
        (   PC_sel =>sg_PC_sel,
			  Imm_Ext =>sg_Imm_Ext,
           Clk =>CLK,
           PC_LdEn =>sg_PC_LdEn,
           RF_WrData_sel =>sg_RF_WrData_sel,
           RF_WrEn =>sg_RF_WrEn,
			  AB_WrEn =>sg_AB_WrEn,
			  RT_WrEn =>sg_RT_WrEn,
			  RS_WrEn =>sg_RS_WrEn,
			  RD_WrEn =>sg_RD_WrEn,
			  BAfter_WrEn =>sg_BAfter_WrEn,
			  WRA_WrEn =>sg_WRA_WrEn,
			  Imm_WrEn =>sg_Imm_WrEn,
			  ALU_WrEn =>sg_ALU_WrEn,
			  Instr_WrEn =>sg_Instr_WrEn, 
			  OP_WrEn =>sg_OP_WrEn,
			  OP2_WrEn =>sg_OP2_WrEn,
			  ALUBin_WrEn =>sg_ALUBin_WrEn ,
			  Dest_WrEn =>sg_Dest_WrEn,
			  RFWrSel_WrEn =>sg_RFWrSel_WrEn,
			  RFWrSel2_WrEn =>sg_RFWrSel2_WrEn,
			  RFWrSel3_WrEn =>sg_RFWrSel3_WrEn,
			  WRA2_WrEn =>sg_WRA2_WrEn,
			  ImmExt_WrEn =>sg_ImmExt_WrEn,
			  RS2_WrEn =>sg_RS2_WrEn,
			  RT2_WrEn =>sg_RT2_WrEn ,
			  RFWr1_WrEn =>sg_RFWr1_WrEn,
			  RFWr2_WrEn =>sg_RFWr2_WrEn,
			  RFWr3_WrEn =>sg_RFWr3_WrEn,
			  RFWr4_WrEn =>sg_RFWr4_WrEn,
			  ALUAfter_WrEn =>sg_ALUAfter_WrEn,
			  MemReg_WrEn =>sg_MemReg_WrEn,
           RF_B_sel =>sg_RF_B_sel,
           Reset =>sg_Reset,
           ALU_Bin_sel =>sg_ALU_Bin_sel,
			  Byteop =>sg_Byteop,
			  Mem_WrEn =>sg_Mem_WrEn,
			  MemA_WrEn =>sg_MemA_WrEn,
			  MemA2_WrEn =>sg_MemA2_WrEn,
			  Opcode =>sg_Opcode,
			  control_Reset=> RESET
			  );
			  


end Behavioral;
