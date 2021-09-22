----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:45 05/18/2021 
-- Design Name: 
-- Module Name:    CONTROL_MC - Behavioral 
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

entity CONTROL_MC is
Port (     PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
			  Imm_Ext : out STD_LOGIC_VECTOR(1 downto 0);
           RF_WrData_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           AB_WrEn : out STD_LOGIC;
			  ALU_WrEn : out STD_LOGIC;
			  ALU_Bin_sel : out  STD_LOGIC;
			  Instr_WrEn : out STD_LOGIC;
			  MemReg_WrEn : out std_logic;   
           Byteop: out std_logic;
			  Mem_WrEn :out STD_LOGIC;
			  control_Reset:in STD_LOGIC;
			   Clk : in  STD_LOGIC;
			  Reset : out  STD_LOGIC;
			   Zero : in  STD_LOGIC;
				Flag  : in  STD_LOGIC;
			  opcode : in STD_LOGIC_VECTOR (5 downto 0)
			  );
			  
end CONTROL_MC;

architecture Behavioral of CONTROL_MC is

type state_type is(step,stop,start,none,R_type,R_type2,R_type3,addi,addi2,addi3,I_type,I_type2,I_type3,Branch_B,SW_2,SW_3,LW_3,LB_3,LW_4,LB_4,
                    Branch, Branch2,LB_1,LB_2,SB,SB_2,SB_3,LW_1,LW_2,SW,Final,Li_1,Li_2,Lui_1,Lui_2,finish);
							
signal state, next_state : state_type;

begin
fsm_sync :process(state,clk, control_Reset)
begin

if (control_Reset = '1' ) then
state <= stop;

			
		elsif (clk'event and clk = '1' ) then
			state <= next_state;
	end if;
end process fsm_sync;


fsm :process(state,CLK,next_state,opcode, control_Reset)
begin
next_state <= start;
	case state is

			
	when start => --------after reset-----
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '1';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state <= step;
	   when step => --------default situation-----
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			 
        if (Flag ='1') then 
        next_state <= finish;
         elsif (opcode ="100000") then -- ALU
								next_state	<=	R_type;
			              
					  
					  elsif(opcode="111000") then -- li
								next_state	<=	Li_1;
					  elsif(opcode="111001") then -- lui
								next_state	<= Lui_1;
								
			        elsif(opcode ="110000") then -- addi
								next_state	<= addi;
							
					  elsif(opcode ="110010") then -- nandi
								next_state	<= I_type;
							
					  elsif(opcode ="110011") then -- ori
								next_state	<= I_type;
							
			        
					  elsif(opcode ="111111") then -- b
								next_state	<=	Branch_b;
			        elsif(opcode  ="000000") then -- beq
								next_state	<= Branch;
			        elsif(opcode ="000001") then -- bneq
								next_state	<= Branch;
			        
					  elsif(opcode ="000111") then -- sb
								next_state	<= SB;
			        elsif(opcode ="011111") then -- sw
								next_state	<= SW;
			        elsif(opcode ="000011") then -- lb
								next_state	<=	LB_1;
					  elsif(opcode ="001111") then -- lw
								next_state	<= LW_1;
				else  
              next_state <= none;
end if;

	  
	when stop => --------reset-----
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '1';
			  
          
			next_state <= start;
		  
			

			-- next_state <=final;

when R_type => --------R-type#1-----
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '1';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= R_type2;


when R_type2 => --------R-type#2-----
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			   next_state	<= R_type3;
			  
when R_type3 => --------R-type#3-----
           PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '1';
           RF_WrEn <= '1';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= start;	


when Li_1 =>------li#1 -----		
            PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '1';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= Li_2;
			  
			  
when Li_2 =>------li#2 -----				  
			  
           PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '1';
           RF_WrEn <= '1';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= start;
		  
when Lui_1 =>------lui#1 -----		
            PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "10";
           RF_WrData_sel <= '1';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= Lui_2;	


when Lui_2 =>------lui#2 -----		
           PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "10";
           RF_WrData_sel <= '1';
           RF_WrEn <= '1';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= start;	


when I_type=>----------------Itype#1------------			  
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '1';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= I_type2;
			  
when I_type2=>----------------Itype#2------------			  
             PC_sel <= '0';
            PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			 next_state	<= I_type3;	
when I_type3=>	----------------Itype#3------------			  
            PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '1';
           RF_WrEn <= '1';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= start;	
			  
			  
when addi=>----------------addi#1------------			  
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '1';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= addi2;

when addi2=>----------------addi#2------------			  
           PC_sel <= '0';
          PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			 next_state	<= addi3;			  
when addi3=>	----------------addi#3------------			  
            PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '1';
           RF_WrEn <= '1';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= start;	
			  



when LB_1=>----------------LB#1------------
			  PC_sel <= '0';
           Imm_Ext <= "01";
           PC_LdEn <= '0';
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
			  AB_WrEn <= '1';
			  ALU_WrEn <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';
           RF_B_sel <= '0';
           Reset <= '0';
           ALU_Bin_sel <= '1';
           Byteop <= '1';
			  Mem_WrEn <= '0';
			  next_state	<= LB_2;
when LB_2=>----------------LB#2------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='1';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= LB_3;			  
when LB_3=>----------------LB#3------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '1';  
           Byteop <='1';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= LB_4;	
when LB_4=>----------------LB#4------------
			  PC_sel <= '0';
           Imm_Ext <= "01";
           PC_LdEn <= '1';
           RF_WrData_sel <= '0';
           RF_WrEn <= '1';
			  AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '1';
           RF_B_sel <= '0';
           Reset <= '0';
           ALU_Bin_sel <= '1';
           Byteop <= '1';
			  Mem_WrEn <= '0';
			  next_state	<= start;
						  

when LW_1=>----------------LW#1------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '1';
           AB_WrEn <= '1';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '1';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= LW_2;
when LW_2=>----------------LW#2------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= LW_3;			  
when LW_3=>----------------LW#3------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= LW_4;	
when LW_4=>----------------LW#4------------
           PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '1';
           RF_B_sel <= '1';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '1';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			  next_state	<= start;

when SW=>----------------SW#1------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '1';
           AB_WrEn <= '1';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			   next_state	<= SW_2;

when SW_2=>----------------SW#2------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';

			   next_state	<= SW_3;			  
		 
WHEN SW_3 => ----------------SW#3------------
           PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '1';
			  Reset <= '0';

			   next_state	<= start;



when SB=>----------------SB#1------------
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '1';
           AB_WrEn <= '1';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='1';
			  Mem_WrEn <= '0';
			  Reset <= '0';
			   next_state	<= SB_2;

when SB_2=>----------------SB#2------------
           PC_sel <= '0';
          PC_LdEn <= '0';
			 Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			 ALU_WrEn <= '1';
			 ALU_Bin_sel <= '1';
			 Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='1';
			  Mem_WrEn <= '0';
			  Reset <= '0';

			  next_state	<= SB_3;			  
		 
WHEN SB_3 => ----------------SB#3------------
           PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "01";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='1';
			  Mem_WrEn <= '1';
			  Reset <= '0';
           next_state	<=start;
	
when Branch_B=>------B----------	
           PC_sel <= '1';
           PC_LdEn <= '1';
			  Imm_Ext<= "11";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
           next_state	<=start;

when Branch =>------BRANCH----------	
           PC_sel <= '1';
           PC_LdEn <= '0';
			  Imm_Ext<= "11";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '1';
           AB_WrEn <= '1';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
           next_state	<=Branch2;
			  
when Branch2 =>------BRANCH#2----------	
           PC_sel <= '1';
           PC_LdEn <= '1';
			  Imm_Ext<= "11";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '1';
           AB_WrEn <= '0';
			  ALU_WrEn <= '1';
			  ALU_Bin_sel <= '1';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
           next_state	<=start;			 
when none =>	         
           PC_sel <= '0';
           PC_LdEn <= '1';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';

			   next_state	<= start;	 

when finish =>	         
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';

			   next_state	<= finish;	 

		



When others =>
           PC_sel <= '0';
           PC_LdEn <= '0';
			  Imm_Ext<= "00";
           RF_WrData_sel <= '0';
           RF_WrEn <= '0';
           RF_B_sel <= '0';
           AB_WrEn <= '0';
			  ALU_WrEn <= '0';
			  ALU_Bin_sel <= '0';
			  Instr_WrEn <= '0';
			  MemReg_WrEn <= '0';  
           Byteop <='0';
			  Mem_WrEn <= '0';
			  Reset <= '0';
          next_state	<= start;	
			 
end case;
end process fsm;				
end Behavioral;
