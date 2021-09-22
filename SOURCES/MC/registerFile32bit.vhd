----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:04:57 04/05/2021 
-- Design Name: 
-- Module Name:    registerFile32bit - Behavioral 
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

entity registerFile32bit is
    Port ( clk : in  STD_LOGIC;
           Ard1 : in  STD_LOGIC_vector(4 downto 0);
           Ard2 : in  STD_LOGIC_vector(4 downto 0);
           WrEn : in  STD_LOGIC;
			  Reset : in std_logic;
           Awr : in  STD_LOGIC_vector(4 downto 0);
           Din : in  STD_LOGIC_vector(31 downto 0);
           Dout1 : out  STD_LOGIC_vector(31 downto 0);
           Dout2 : out  STD_LOGIC_vector(31 downto 0)
			  );
end registerFile32bit;

architecture structural of registerFile32bit is


    COMPONENT mux32bit
    PORT(
         input0 : IN  std_logic_vector(31 downto 0);
         input1 : IN  std_logic_vector(31 downto 0);
         input2 : IN  std_logic_vector(31 downto 0);
         input3 : IN  std_logic_vector(31 downto 0);
         input4 : IN  std_logic_vector(31 downto 0);
         input5 : IN  std_logic_vector(31 downto 0);
         input6 : IN  std_logic_vector(31 downto 0);
         input7 : IN  std_logic_vector(31 downto 0);
         input8 : IN  std_logic_vector(31 downto 0);
         input9 : IN  std_logic_vector(31 downto 0);
         input10 : IN  std_logic_vector(31 downto 0);
         input11 : IN  std_logic_vector(31 downto 0);
         input12 : IN  std_logic_vector(31 downto 0);
         input13 : IN  std_logic_vector(31 downto 0);
         input14 : IN  std_logic_vector(31 downto 0);
         input15 : IN  std_logic_vector(31 downto 0);
         input16 : IN  std_logic_vector(31 downto 0);
         input17 : IN  std_logic_vector(31 downto 0);
         input18 : IN  std_logic_vector(31 downto 0);
         input19 : IN  std_logic_vector(31 downto 0);
         input20 : IN  std_logic_vector(31 downto 0);
         input21 : IN  std_logic_vector(31 downto 0);
         input22 : IN  std_logic_vector(31 downto 0);
         input23 : IN  std_logic_vector(31 downto 0);
         input24 : IN  std_logic_vector(31 downto 0);
         input25 : IN  std_logic_vector(31 downto 0);
         input26 : IN  std_logic_vector(31 downto 0);
         input27 : IN  std_logic_vector(31 downto 0);
         input28 : IN  std_logic_vector(31 downto 0);
         input29 : IN  std_logic_vector(31 downto 0);
         input30 : IN  std_logic_vector(31 downto 0);
         input31 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic_vector(4 downto 0);
         muxout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT decoder
    PORT(
         input : IN  std_logic_vector(4 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT register32bit
    PORT(
         clk : IN  std_logic;
         we : IN  std_logic;
			rst : IN std_logic;
         datain : IN  std_logic_vector(31 downto 0);
         dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	 signal dec_out: std_logic_vector(31 downto 0);
	 signal reg_in :  std_logic_vector(31 downto 0);
	 type in_array_32 is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal reg2mux : in_array_32;


begin

decoder_unit : decoder port map(input=>Awr, output=>dec_out);
--INPUTS OF REGISTERS AFTER DECODER TO AND!
Dec_And_WrEn : 
	for I in 0 to 31 generate
		reg_in(I) <= (WrEn AND dec_out(I)) after 2ns;
	end generate Dec_And_WrEn;
	
	-- To make R0 always have '0' as output. Also make generate start from 1.
	R0 : register32bit port map (clk=>Clk, we=>'0',rst=>Reset, datain=>(others=>'0'), dataout=>reg2mux(0));
	
	GEN_REGS : 
	for I in 1 to 31 generate
		reg : register32bit port map (clk=>clk, we=>reg_in(I),rst=>Reset, datain=>Din, dataout=>reg2mux(I));
	end generate GEN_REGS;
	
	mux1 : mux32bit port map (input0=>reg2mux(0),input1=>reg2mux(1),input2=>reg2mux(2),input3=>reg2mux(3),
	input4=>reg2mux(4),input5=>reg2mux(5),input6=>reg2mux(6),input7=>reg2mux(7),input8=>reg2mux(8),
	input9=>reg2mux(9),input10=>reg2mux(10),input11=>reg2mux(11),input12=>reg2mux(12),input13=>reg2mux(13),
	input14=>reg2mux(14),input15=>reg2mux(15),input16=>reg2mux(16),input17=>reg2mux(17),input18=>reg2mux(18),
	input19=>reg2mux(19),input20=>reg2mux(20),input21=>reg2mux(21),input22=>reg2mux(22),input23=>reg2mux(23),
	input24=>reg2mux(24),input25=>reg2mux(25),input26=>reg2mux(26),input27=>reg2mux(27),input28=>reg2mux(28),
	input29=>reg2mux(29),input30=>reg2mux(30),input31=>reg2mux(31), 
	sel=>Ard1, muxout=>Dout1);
	
	mux2 : mux32bit port map (input0=>reg2mux(0),input1=>reg2mux(1),input2=>reg2mux(2),input3=>reg2mux(3),
	input4=>reg2mux(4),input5=>reg2mux(5),input6=>reg2mux(6),input7=>reg2mux(7),input8=>reg2mux(8),
	input9=>reg2mux(9),input10=>reg2mux(10),input11=>reg2mux(11),input12=>reg2mux(12),input13=>reg2mux(13),
	input14=>reg2mux(14),input15=>reg2mux(15),input16=>reg2mux(16),input17=>reg2mux(17),input18=>reg2mux(18),
	input19=>reg2mux(19),input20=>reg2mux(20),input21=>reg2mux(21),input22=>reg2mux(22),input23=>reg2mux(23),
	input24=>reg2mux(24),input25=>reg2mux(25),input26=>reg2mux(26),input27=>reg2mux(27),input28=>reg2mux(28),
	input29=>reg2mux(29),input30=>reg2mux(30),input31=>reg2mux(31), 
	sel=>Ard2, muxout=>Dout2);
	
	
end structural;

