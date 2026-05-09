----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2026 10:27:29 AM
-- Design Name: 
-- Module Name: La_Parite - Behavioral
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

entity parite_calculateur is
    Port (
        ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
        S1 : in std_logic;
        parite : out STD_LOGIC
        );
end parite_calculateur;

architecture Behavioral of parite_calculateur is
    
begin
    process (ADCbin(0), ADCbin(1), ADCbin(2), ADCbin(3), S1)
    begin
        case S1 is
          when '1' =>
            parite <= ADCbin(0) xor ADCbin(1) xor ADCbin(2) xor ADCbin(3);
          when '0' =>
            parite  <= not (ADCbin(0) xor ADCbin(1) xor ADCbin(2) xor ADCbin(3));
          when others =>
            parite <= '0';       
       end case;
   end process;
end Behavioral;
