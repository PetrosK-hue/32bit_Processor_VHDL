----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:18:31 03/31/2021 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.std_logic_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity ALU is
    Port ( A : in  STD_LOGIC_vector(31 downto 0);
           B : in  STD_LOGIC_vector(31 downto 0);
			  Opcode : in STD_LOGIC_VECTOR (5 downto 0);
           alu_func: in  STD_LOGIC_vector(3 downto 0);
           Outt : out  STD_LOGIC_vector(31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal zeros : signed(31 downto 0) := (others=>'0');
signal extended_A : signed(32 downto 0);
signal extended_B : signed(32 downto 0);
signal inter_Outt : signed(31 downto 0);
signal extended_Out : signed(32 downto 0);
signal unsignedA : unsigned (31 downto 0);
signal MSBForCarry1 : std_logic;
signal MSBForCarry2 : std_logic;

begin
process(alu_func,opcode,inter_Outt,A,B)
	begin
		case Opcode is
	
	when "100000" =>
		case alu_func is
			when "0000" =>
		Zero <= '0';
		Ovf <= '0';
		Cout <= '0';
				inter_Outt <= signed(A) + signed(B) after 10ns;
				Outt <= std_logic_vector(inter_Outt);
				if inter_Outt = zeros then
					Outt <= std_logic_vector(zeros);
					Zero <= '1'; -- after 10ns;
				else
					Zero <= '0'; -- after 10ns;
				end if;
				
				if (signed(A) < 0 and signed(B) < 0) or (signed(A) > 0 and signed(B) > 0) then
				extended_A <= resize(signed(A), 33);
				extended_B <= resize(signed(B), 33);
				extended_Out <= extended_A + extended_B;
				if extended_A(32) /= extended_Out(31) then
					Ovf <= '1';-- after 10ns;
				else
					Ovf <= '0';-- after 10ns;
				end if;
				end if;
				
				if (signed(A) < 0 and signed(B) <0) or (signed(A) > 0 and signed(B) > 0) then
							MSBForCarry1 <= A(30);
							MSBForCarry2 <= B(30);
							if (MSBForCarry1 = '1') and (MSBForCarry2 = '1') then
								Cout <= '1'; -- after 10ns;
							end if;
				end if;
				

         when "0001" =>
			Zero <= '0';
			Ovf <= '0';
			Cout <= '0';
				inter_Outt <= signed(A) - signed(B) after 10ns;
				Outt <= std_logic_vector(inter_Outt) ;
				if inter_Outt = zeros then
					Zero <= '1'; --after 10ns;
				else
					Zero <= '0'; --after 10ns;
				end if;
				if (signed(A) < 0 and signed(B) > 0 and extended_Out > 0) or (signed(A) > 0 and signed(B) < 0 and extended_Out < 0) then
				
				extended_A <= resize(signed(A), 33);
				extended_B <= resize(signed(B), 33);
				extended_Out <= signed(extended_A) - signed(extended_B);
				if extended_A(32) /= extended_Out(31) then
				--if (signed(A) < 0 and signed(B) > 0 and extended_Out > 0) or (signed(A) > 0 and signed(B) < 0 and extended_Out < 0) then
				
					Ovf <= '1';--after 10ns;
				else
					Ovf <= '0';--after 10ns;
				end if;
				end if;
				
				if (signed(A) < 0 and signed(B) > 0) or (signed(A) > 0 and signed(B) < 0) then
							MSBForCarry1 <= A(30);
							MSBForCarry2 <= B(30);
							if (MSBForCarry1 = '1') and (MSBForCarry2 = '1') then
								Cout <= '1';  -- after 10ns;
							end if;
				end if;
				
				
				when "0010" =>
				Outt <= A and B after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf  <= '0'; --after 10 ns;
				
				when "0011" =>
				Outt <= A or B after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf  <= '0'; --after 10 ns;

				when "0100" =>
				Outt <= NOT A after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf  <= '0'; --after 10 ns;
				
	         when "0101" =>
				Outt <= A nand B after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf  <= '0'; --after 10 ns;
				
				when "0110" =>
				Outt <= A nor B after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf  <= '0'; --after
				
	when "1000" => 
				Outt <= std_logic_vector(SHIFT_RIGHT(signed(A),1)) after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf <=  '0'; --after 10 ns;
			when "1001" =>
				Outt <= std_logic_vector(SHIFT_RIGHT(unsigned(A),1)) after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf <=  '0'; --after 10 ns;
			when "1010" =>
				Outt <=  std_logic_vector(SHIFT_LEFT(unsigned(A),1)) after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf <=  '0'; --after 10 ns;
			when "1100" =>
				Outt <= std_logic_vector(ROTATE_LEFT(signed(A),1)) after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf <=  '0'; --after 10 ns;
			when "1101" =>
				Outt <= std_logic_vector(ROTATE_RIGHT(signed(A),1)) after 10 ns;
				Zero <= '0'; --after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf <=  '0'; --after 10 ns;
			when others =>
				Outt <= std_logic_vector(zeros) after 10 ns;
				Zero <= '0';-- after 10 ns;
				Cout <= '0'; --after 10 ns;
				Ovf <=  '0'; --after 10 ns;
		end case;
		when "111000" =>--------li
				Outt <= B  after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "111001" =>----------lui
				Outt <= B  after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "110000" =>----------addi
				Outt <= A + B after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "110010" =>----------nandi
				Outt <= A NAND B after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "110011" =>----------ori
				Outt <= A OR B after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "111111" =>----------b
				Outt <= (others => '1') after 10 ns;
				Zero <= '0';
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "000000" => ------beq
				if(A = B) then 
					Zero <= '1' after 10 ns;
				else
					Zero <= '0' after 10 ns;
				end if;
		when "000001" =>-------bne
				if(A /= B) then 
					Zero <= '1' after 10 ns;
				else
					Zero <= '0' after 10 ns;
				end if;
		when "000011" =>-------lb
				Outt <=  A + B after 10 ns; 
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "000111" =>--------sb
				Outt <= A + B after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "001111" =>-------lw
				Outt <= A + B after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		when "011111" =>-----------sw
				Outt <= A + B after 10 ns;
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;

		when others =>
				Zero <= '0' after 10 ns;
				Cout <= '0' after 10 ns;
				Ovf <=  '0' after 10 ns;
		end case;
	end process;

end Behavioral;