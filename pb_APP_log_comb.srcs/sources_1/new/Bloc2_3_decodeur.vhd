----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2026 09:46:04 AM
-- Design Name: 
-- Module Name: Bloc2_3_decodeur - Behavioral
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

entity Bloc2_3_decodeur is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Led_out : out STD_LOGIC_VECTOR (7 downto 0));
end Bloc2_3_decodeur;



architecture Behavioral of Bloc2_3_decodeur is

signal inter1 : std_logic_vector (2 downto 0);

component FCT2_3 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           A2_3 : out STD_LOGIC_VECTOR (2 downto 0));
end component FCT2_3;

component Decodeur3_8 is
    Port ( A2_3 : in STD_LOGIC_VECTOR (2 downto 0);
           Led : out STD_LOGIC_VECTOR (7 downto 0));
end component Decodeur3_8;


begin

inst_FCT2_3 : FCT2_3
port map (
   ADCbin => ADCbin,
   A2_3 => inter1
);

inst_Decodeur3_8 : Decodeur3_8
port map (
  A2_3 => inter1,
  Led => Led_out
);


end Behavioral;
