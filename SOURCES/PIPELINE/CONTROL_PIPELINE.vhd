----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:16 05/20/2021 
-- Design Name: 
-- Module Name:    CONTROL_PIPELINE - Behavioral 
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

entity CONTROL_PIPELINE is
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
			  
end CONTROL_PIPELINE;

architecture Behavioral of CONTROL_PIPELINE is

type state_type is(step,stop,start,none,add,lw,sw,li,finish);
							
signal state, next_state : state_type;

begin
process(state,Clk, control_Reset)
begin

if (control_Reset = '1' ) then
state <= stop;
			
		elsif (Clk'event and clk = '1' ) then
			state <= next_state;
	end if;
end process ;
process(state,CLK,next_state,Opcode, control_Reset)
begin
next_state <= stop;
	case state is
		when stop =>
			if ( Opcode = "100000") then -- r-type(add)
					next_state <= add;
				elsif( Opcode = "111000") then -- li
					next_state <= li;
				elsif( Opcode = "001111") then -- lw
					next_state <= lw;
				elsif( Opcode = "011111") then -- sw
					next_state <= sw;
				else
					next_state <= finish;
				end if;
		when add =>
			if ( Opcode = "100000") then -- r-type(add)
					next_state <= add;
				elsif( Opcode = "111000") then -- li
					next_state <= li;
				elsif( Opcode = "001111") then -- lw
					next_state <= lw;
				elsif( Opcode = "011111") then -- sw
					next_state <= sw;
				else
					next_state <= finish;
				end if;
				
			when li =>
			if ( Opcode = "100000") then -- r-type(add)
					next_state <= add;
				elsif( Opcode = "111000") then -- li
					next_state <= li;
				elsif( Opcode = "001111") then -- lw
					next_state <= lw;
				elsif( Opcode = "011111") then -- sw
					next_state <= sw;
				else
					next_state <= finish;
				end if;	
				
				when lw =>
			if ( Opcode = "100000") then -- r-type(add)
					next_state <= add;
				elsif( Opcode = "111000") then -- li
					next_state <= li;
				elsif( Opcode = "001111") then -- lw
					next_state <= lw;
				elsif( Opcode = "011111") then -- sw
					next_state <= sw;
				else
					next_state <= finish;
				end if;
				
				when sw =>
			if ( Opcode = "100000") then -- r-type(add)
					next_state <= add;
				elsif( Opcode = "111000") then -- li
					next_state <= li;
				elsif( Opcode = "001111") then -- lw
					next_state <= lw;
				elsif( Opcode = "011111") then -- sw
					next_state <= sw;
				else
					next_state <= finish;
				
				end if;
					when finish =>
					next_state <= finish;
		when others =>
			
		end case;
	end process;
	
process ( state, Opcode)
	begin	
	case state is
	when stop =>
           PC_sel <='0';
			  Imm_Ext <="00";
           PC_LdEn <='0';
           RF_WrData_sel <='0';
           RF_WrEn <='0';
			  AB_WrEn <='0';
			  RT_WrEn <='0';
			  RS_WrEn <='0';
			  RD_WrEn <='0';
			  BAfter_WrEn <='0';
			  WRA_WrEn <='0';
			  Imm_WrEn <='0';
			  ALU_WrEn <='0';
			  Instr_WrEn <='0';
			  OP_WrEn <='0';
			  OP2_WrEn <='0';
			  ALUBin_WrEn <='0';
			  Dest_WrEn <='0';
			  RFWrSel_WrEn <='0';
			  RFWrSel2_WrEn <='0';
			  RFWrSel3_WrEn <='0';
			  WRA2_WrEn <='0';
			  ImmExt_WrEn <='0';
			  RS2_WrEn <='0';
			  RT2_WrEn <='0'; 
			  RFWr1_WrEn <='0';
			  RFWr2_WrEn <='0';
			  RFWr3_WrEn <='0';
			  RFWr4_WrEn <='0';
			  ALUAfter_WrEn <='0';
			  MemReg_WrEn <='0';
           RF_B_sel <='0';
           Reset <='1';
           ALU_Bin_sel <='0';
			  Byteop <='0';
			  Mem_WrEn <='0';
			  MemA_WrEn <='0';
			  MemA2_WrEn <='0';
			  
			  
	when add =>----------------------
			  PC_sel <= '0';
           Imm_Ext <= "00";
           PC_LdEn <= '1';
           RF_WrData_sel <= '1';
           RF_WrEn <= '1';
			  AB_WrEn <= '1';
			  ALU_WrEn <= '1';
			  Instr_WrEn <= '1';
			  MemReg_WrEn <= '1';
           RF_B_sel <= '0';
           Reset <= '0';
           ALU_Bin_sel <= '0';
           Byteop<= '0';
			  Mem_WrEn <= '0';
			  
			  RT_WrEn <= '1';
			  RS_WrEn <= '1';
			  RD_WrEn <= '1';
			  BAfter_WrEn <= '1';
			  ALUAfter_WrEn <= '1';
			  WRA_WrEn <= '1';
			  Imm_WrEn <= '1';
			  OP_WrEn <= '1';
			  ALUBin_WrEn <= '1';
			  Dest_WrEn <= '1';
			  RFWrSel_WrEn <= '1';
			  RFWrSel2_WrEn <= '1';
			  RFWrSel3_WrEn <= '1';
			  MemA_WrEn <= '1';
			  MemA2_WrEn <= '1';
			  WRA2_WrEn <= '1';
			  ImmExt_WrEn <= '1';
			  RFWr1_WrEn <= '1';
			  RFWr2_WrEn <= '1';
			  RFWr3_WrEn <= '1';
			  RS2_WrEn <= '1';
			  RT2_WrEn <= '1';
			  RFWr4_WrEn <= '1';
			  OP2_WrEn <= '1';


	when li =>------------------------------------------------------------------------------------
			  PC_sel <= '0';
           Imm_Ext <= "01";
           PC_LdEn <= '1';
           RF_WrData_sel <= '1';
           RF_WrEn <= '1';
			  AB_WrEn <= '1';
			  ALU_WrEn <= '1';
			  Instr_WrEn <= '1';
			  MemReg_WrEn <= '1';
           RF_B_sel <= '0';
           Reset <= '0';
           ALU_Bin_sel <= '1';
          Byteop <= '0';
			  Mem_WrEn <= '0';
			  
			  RT_WrEn <= '1';
			  RS_WrEn <= '1';
			  RD_WrEn <= '1';
			  BAfter_WrEn <= '1';
			  ALUAfter_WrEn <= '1';
			  WRA_WrEn <= '1';
			  Imm_WrEn <= '1';
			  OP_WrEn <= '1';
			  ALUBin_WrEn <= '1';
			  Dest_WrEn <= '1';
			  RFWrSel_WrEn <= '1';
			  RFWrSel2_WrEn <= '1';
			  RFWrSel3_WrEn <= '1';
			  MemA_WrEn <= '1';
			  MemA2_WrEn <= '1';
			  WRA2_WrEn <= '1';
			  ImmExt_WrEn <= '1';
			  RFWr1_WrEn <= '1';
			  RFWr2_WrEn <= '1';
			  RFWr3_WrEn <= '1';
			  RS2_WrEn <= '1';
			  RT2_WrEn <= '1';
			  RFWr4_WrEn <= '1';
			  OP2_WrEn <= '1';
			  
			  
			  
			  when sw =>----------------------
           PC_sel <= '0';
           Imm_Ext <= "01";
           PC_LdEn <= '1';
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
			  AB_WrEn <= '1';
			  ALU_WrEn <= '1';
			  Instr_WrEn <= '1';
			  MemReg_WrEn <= '1';
           RF_B_sel <= '1';
           Reset <= '0';
           ALU_Bin_sel <= '1';
           Byteop <= '0';
			  Mem_WrEn <= '1';
			  ImmExt_WrEn <= '1';
			  Mem_WrEn <= '1';
			  
			  RT_WrEn <= '1';
			  RS_WrEn <= '1';
			  RD_WrEn <= '1';
			  BAfter_WrEn <= '1';
			  ALUAfter_WrEn <= '1';
			  WRA_WrEn <= '1';
			  Imm_WrEn <= '1';
			  OP_WrEn <= '1';
			  ALUBin_WrEn <= '1';
			  Dest_WrEn <= '1';
			  RFWrSel_WrEn <= '1';
			  RFWrSel2_WrEn <= '1';
			  RFWrSel3_WrEn <= '1';
			  MemA_WrEn <= '1';
			  MemA2_WrEn <= '1';
			  WRA2_WrEn <= '1';
			  ImmExt_WrEn <= '1';
			  RFWr1_WrEn <= '1';
			  RFWr2_WrEn <= '1';
			  RFWr3_WrEn <= '1';
			  RS2_WrEn <= '1';
			  RT2_WrEn <= '1';
			  RFWr4_WrEn <= '1';
			  OP2_WrEn <= '1';

	when lw =>------------------------------------------------------------------------------------
    			  PC_sel <= '0';
           Imm_Ext <= "01";
           PC_LdEn <= '1';
           RF_WrData_sel <= '0';
           RF_WrEn <= '1';
			  AB_WrEn <= '1';
			  ALU_WrEn <= '1';
			  Instr_WrEn <= '1';
			  MemReg_WrEn <= '1';
           RF_B_sel <= '0';
           Reset <= '0';
           ALU_Bin_sel <= '1';
           Byteop<= '0';
			  Mem_WrEn <= '0';
			  
			  RT_WrEn <= '1';
			  RS_WrEn <= '1';
			  RD_WrEn <= '1';
			  BAfter_WrEn <= '1';
			  ALUAfter_WrEn <= '1';
			  WRA_WrEn <= '1';
			  Imm_WrEn <= '1';
			  OP_WrEn <= '1';
			  ALUBin_WrEn <= '1';
			  Dest_WrEn <= '1';
			  RFWrSel_WrEn <= '1';
			  RFWrSel2_WrEn <= '1';
			  RFWrSel3_WrEn <= '1';
			  MemA_WrEn <= '1';
			  MemA2_WrEn <= '1';
			  WRA2_WrEn <= '1';
			  ImmExt_WrEn <= '1';
			  RFWr1_WrEn <= '1';
			  RFWr2_WrEn <= '1';
			  RFWr3_WrEn <= '1';
			  RS2_WrEn <= '1';
			  RT2_WrEn <= '1';
			  RFWr4_WrEn <= '1';
			  OP2_WrEn <= '1';


			  
			  
			 
when finish =>
			  PC_sel <= '0';
           Imm_Ext <= "00";
           PC_LdEn <= '0';
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
			  AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';
           RF_B_sel <= '0';
           Reset <= '0';
           ALU_Bin_sel <= '0';
           Byteop <= '0';
			  Mem_WrEn <= '0';
			  RFWr1_WrEn <= '0';
			  RFWr2_WrEn <= '0';
			  RFWr3_WrEn <= '0';

when others =>-----------------------------------
			  PC_sel <= '0';
           Imm_Ext <= "00";
           PC_LdEn <= '0';
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
			  AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';
           RF_B_sel <= '0';
           Reset <= '0';
           ALU_Bin_sel <= '0';
           Byteop <= '0';
			  Mem_WrEn <= '0';
			  RFWr1_WrEn <= '0';
			  RFWr2_WrEn <= '0';
			  RFWr3_WrEn <= '0';
	end case;
	end process ;

end Behavioral;

