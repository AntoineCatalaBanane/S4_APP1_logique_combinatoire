----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2026 01:12:22 PM
-- Design Name: 
-- Module Name: Add4bits - Behavioral
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

entity Add4bits is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           Y : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC;
           Ci : in STD_LOGIC);
end Add4bits;

architecture Behavioral of Add4bits is

component Add1bitA is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component Add1bitA;

component Add1bitB is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component Add1bitB;

signal Coa1: std_logic;
signal Coa2: std_logic;
signal Cob1: std_logic;

begin

add1A1: Add1bitA port map(X => X(0),Y => Y(0),Ci=>Ci, S=> S(0),Co=>Coa1);
add1A2: Add1bitA port map(X => X(1),Y => Y(1),Ci => Coa1,S => S(1),Co => Coa2);
add1B1: Add1bitB port map(X => X(2),Y => Y(2),Ci => Coa2,S => S(2),Co => Cob1);
add1B2: Add1bitB port map(X => X(3),Y => Y(3),Ci => Cob1,S => S(3),Co => Co);




end Behavioral;
