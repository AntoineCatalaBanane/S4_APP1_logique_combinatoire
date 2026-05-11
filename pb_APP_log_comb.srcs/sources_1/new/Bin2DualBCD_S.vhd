----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2026 01:44:26 PM
-- Design Name: 
-- Module Name: Bin2DualBCD_S - Behavioral
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

entity Bin2DualBCD_S is
    Port ( Moins6 : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : out STD_LOGIC_VECTOR (3 downto 0));
end Bin2DualBCD_S;

architecture Behavioral of Bin2DualBCD_S is

begin
    process (Moins6)
    begin
            
       case (Moins6) is
          when "0000" =>
            Code_signe <= "0000"; 
             Unite_s <= "0000"; --0
          when "0001" =>
            Code_signe <= "0000";
             Unite_s <= "0001"; --1
          when "0010" =>
            Code_signe <= "0000";
             Unite_s <= "0010"; --2
          when "0011" =>
            Code_signe <= "0000";
             Unite_s <= "0011"; --3
          when "0100" =>
            Code_signe <= "0000";
             Unite_s <= "0100"; --4
          when "0101" =>
            Code_signe <= "0000";
             Unite_s <= "0101";  --5
          when "0110" =>
              Code_signe <= "0000";
             Unite_s <= "0110";  --6 impossible
          when "0111" =>
            Code_signe <= "0000";
             Unite_s <= "0111";  --7 impossible
          when "1000" =>
            Code_signe <= "1111"; -- place holder pour negatif a reverifier
             Unite_s <= "1000";  -- -8? impossible 
          when "1001" =>
            Code_signe <= "1111";
             Unite_s <= "0001";  -- -1
          when "1010" =>
            Code_signe <= "1111";
             Unite_s <= "0010";  -- -2
          when "1011" =>
            Code_signe <= "1111";
             Unite_s <= "0011";  -- -3 
          when "1100" =>
            Code_signe <= "1111";
             Unite_s <= "0100"; -- -4
          when "1101" =>
            Code_signe <= "1111";
             Unite_s <= "0101"; -- -5
          when "1110" =>
            Code_signe <= "1111";
             Unite_s <= "0110"; -- -6
          when "1111" =>
            Code_signe <= "1111";
             Unite_s <= "0111";  -- -7 impossible
          when others =>
            Code_signe <= "0000";
             Unite_s <= "0000";  -- others
       end case;

end process;

end Behavioral;
