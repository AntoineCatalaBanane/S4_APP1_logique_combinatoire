
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2026 10:33:55 AM
-- Design Name: 
-- Module Name: compteurDe1_4bit - Behavioral
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

entity compteurDe1_4bit is
    Port ( Adcth : in STD_LOGIC_VECTOR (3 downto 0);
           nb1 : out STD_LOGIC_VECTOR (2 downto 0));
end compteurDe1_4bit;


architecture Behavioral of compteurDe1_4bit is
signal temp: std_logic_vector (2 downto 0);

begin

temp(0) <= (Adcth(0) and not Adcth(1)) or (Adcth(2) and not Adcth(3));
temp(1) <= Adcth(1) and not Adcth(3);
temp(2) <=  Adcth(3);

nb1 <= temp;

end Behavioral;