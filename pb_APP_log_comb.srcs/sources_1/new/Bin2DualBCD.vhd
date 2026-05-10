----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2026 09:55:07 AM
-- Design Name: 
-- Module Name: Bin2DualBCD - Behavioral
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

entity Bin2DualBCD is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_s : out STD_LOGIC_VECTOR (3 downto 0));
end Bin2DualBCD;

architecture Behavioral of Bin2DualBCD is

component Bin2DualBCD_NS is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0));
end component Bin2DualBCD_NS;

component Bin2DualBCD_S is
    Port ( Moins6 : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : out STD_LOGIC_VECTOR (3 downto 0));
end component Bin2DualBCD_S;

component moins_6 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Moins6 : out STD_LOGIC_VECTOR (3 downto 0));
end component moins_6;

signal inter1 : std_logic_vector (3 downto 0) ;

begin

inst_Bin2DualBCD_NS : Bin2DualBCD_NS
port map (
   ADCbin => ADCbin ,
   dizaines => dizaines,
   Unites_ns => Unites_ns
);

inst_Bin2DualBCD_S : Bin2DualBCD_S
port map (
   moins6 => inter1 ,
   Code_signe => Code_signe,
   Unite_s => Unites_s
);

inst_Moins_6 : Moins_6
port map (
   ADcbin => ADCbin,
   moins6 => inter1
);

end Behavioral;
