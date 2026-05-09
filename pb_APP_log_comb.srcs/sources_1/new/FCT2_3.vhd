----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2026 08:43:27 PM
-- Design Name: 
-- Module Name: FCT2_3 - Behavioral
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

entity FCT2_3 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           A2_3 : out STD_LOGIC_VECTOR (2 downto 0));
end FCT2_3;

architecture Behavioral of FCT2_3 is

component Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC;
           Ci : in STD_LOGIC);
end component Add4bits;

signal term0_5, term0_125, sum: std_logic_vector (3 downto 0); 


begin

term0_5 <= '0' & ADCbin(3) &ADCbin(2) & ADCbin(1);
term0_125 <= '0' &'0'  & ADCbin(3)& ADCbin(2);  -- 0.75

   inst_add4bit : Add4bits
        port map (
            X => term0_5,
            Y => term0_125, 
            Ci => '0', 
            S => sum, 
            Co => open);
    
    A2_3 <= sum(2 downto 0);
    
end Behavioral;
