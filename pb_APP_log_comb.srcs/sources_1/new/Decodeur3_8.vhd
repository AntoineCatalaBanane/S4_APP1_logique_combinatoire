----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2026 12:16:47 PM
-- Design Name: 
-- Module Name: Decodeur3_8 - Behavioral
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

entity Decodeur3_8 is
    Port ( A2_3 : in STD_LOGIC_VECTOR (2 downto 0);
           Led : out STD_LOGIC_VECTOR (7 downto 0));
end Decodeur3_8;

architecture Behavioral of Decodeur3_8 is

begin
 
   Led <=   (0=> '1', others => '0') when A2_3 = "000" else 
            (1=> '1', others => '0') when A2_3 = "001" else 
            (2=> '1', others => '0') when A2_3 = "010" else 
            (3=> '1', others => '0') when A2_3 = "011" else 
            (4=> '1', others => '0') when A2_3 = "100" else 
            (5=> '1', others => '0') when A2_3 = "101" else 
            (6=> '1', others => '0') when A2_3 = "110" else 
            (7=> '1', others => '0') when A2_3 = "111" else 
            (others => '0');

end Behavioral;
