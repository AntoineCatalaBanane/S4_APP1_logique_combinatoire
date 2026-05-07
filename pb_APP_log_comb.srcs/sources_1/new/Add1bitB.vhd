----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2026 01:11:10 PM
-- Design Name: 
-- Module Name: Add1bitB - Behavioral
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

entity Add1bitB is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end Add1bitB;

architecture Behavioral of Add1bitB is
signal sig1 : std_logic ;
signal sig2 : std_logic ; 
signal sig3 : std_logic ; 

begin
Co <= sig1 or sig3;
sig3 <= Ci and sig2;
sig2 <= X or Y;
sig1 <= X and Y;

S <= X xor Y xor Ci;



end Behavioral;
