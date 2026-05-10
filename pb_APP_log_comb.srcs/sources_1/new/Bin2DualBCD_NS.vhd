----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2026 01:44:26 PM
-- Design Name: 
-- Module Name: Bin2DualBCD_NS - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bin2DualBCD_NS is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0));
end Bin2DualBCD_NS;

architecture Behavioral of Bin2DualBCD_NS is

begin
    process (ADCbin)
    begin
            
       case (ADCbin) is
          when "0000" =>
            dizaines <= "0000";
             Unites_ns <= "0000"; --0
          when "0001" =>
            dizaines <= "0000";
             Unites_ns <= "0001"; --1
          when "0010" =>
            dizaines <= "0000";
             Unites_ns <= "0010"; --2
          when "0011" =>
            dizaines <= "0000";
             Unites_ns <= "0011"; --3
          when "0100" =>
            dizaines <= "0000";
             Unites_ns <= "0100"; --4
          when "0101" =>
            dizaines <= "0000";
             Unites_ns <= "0101";  --5
          when "0110" =>
            dizaines <= "0000";
             Unites_ns <= "0110";  --6 
          when "0111" =>
            dizaines <= "0000";
             Unites_ns <= "0111";  --7
          when "1000" =>
            dizaines <= "0000";
             Unites_ns <= "1000";  --8
          when "1001" =>
            dizaines <= "0000";
             Unites_ns <= "1001";  --9
          when "1010" =>
            dizaines <= "0001";
             Unites_ns <= "0000";  --10
          when "1011" =>
            dizaines <= "0001";
             Unites_ns <= "0001";  --11 
          when "1100" =>
            dizaines <= "0001";
             Unites_ns <= "0010"; --12 
          when "1101" =>
            dizaines <= "0001";
             Unites_ns <= "0011"; --13
          when "1110" =>
            dizaines <= "0001";
             Unites_ns <= "0100"; --14 
          when "1111" =>
            dizaines <= "0001";
             Unites_ns <= "0101";  --15
          when others =>
            dizaines <= "0000";
             Unites_ns <= "0000";  -- others
       end case;

end process;
			

				
				

end Behavioral;
