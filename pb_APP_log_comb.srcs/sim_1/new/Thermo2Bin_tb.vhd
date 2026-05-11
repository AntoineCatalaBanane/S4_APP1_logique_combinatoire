----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2026 08:24:19 PM
-- Design Name: 
-- Module Name: Thermo2Bin_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Thermo2Bin_tb is
end Thermo2Bin_tb;

architecture Behavioral of Thermo2Bin_tb is

--instanciation component
component Thermo2Bin is
    Port ( ADCth : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
end component Thermo2Bin;

signal vect_test_in : std_logic_vector (11 downto 0);
signal ADCbin_sim : std_logic_vector (3 downto 0);
signal erreur_sim : std_logic;

 constant period : time :=  10 ns;
begin
UUT :Thermo2Bin

port map (
        ADCth  => vect_test_in,
        ADCbin => ADCbin_sim,
        erreur => erreur_sim
);
			

Thermo2bin_test : process 
begin
   
for i in 0 to 12 loop
    vect_test_in <= STD_LOGIC_VECTOR (TO_UNSIGNED(i, 12));
    WAIT for period;
end loop;

-- cas valides
for i in 1 to 11 loop
    vect_test_in <= (i downto 0 => '1', others => '0');
    WAIT for period;
end loop;    

-- cas derreurs
vect_test_in <= "000100010001";
wait for period;
vect_test_in <= "100000000000";
wait for period;
vect_test_in <= "111111111110";
wait for period;
vect_test_in <= "111111101111";
wait for period;
vect_test_in <= "000000000000";
WAIT;

end process;
			
			

end Behavioral;
