----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2026 12:20:14 PM
-- Design Name: 
-- Module Name: moins_6 - Behavioral
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

entity moins_6 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Moins6 : out STD_LOGIC_VECTOR (3 downto 0));
end moins_6;

architecture Behavioral of moins_6 is

component Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC;
           Ci : in STD_LOGIC);
end component Add4bits;

signal m6c2, moins6temp, moins6c2, notmoins6temp : std_logic_vector (3 downto 0);

begin

m6c2 <= "1010";

inst_Add4bits1 : Add4bits
port map (
   X => ADCbin,
   Y =>  m6c2,
   S => moins6temp,
   Co => open,
   Ci => '0' -- peut etre a changer
);

notmoins6temp <= not moins6temp;

inst_Add4bits2 : Add4bits
port map (
   X => notmoins6temp,
   Y =>  "0000",
   S => moins6c2,
   Co => open,
   Ci => '1' -- peut etre a changer
);
   
moins6(3 downto 0) <= ('1' & moins6c2(2 downto 0)) when moins6temp(3) = '1' else	
          moins6temp;

end Behavioral;
