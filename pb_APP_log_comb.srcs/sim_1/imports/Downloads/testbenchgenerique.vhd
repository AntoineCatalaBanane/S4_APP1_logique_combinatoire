----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2019 08:34:20 PM
-- Design Name: 
-- Module Name: testBench - Behavioral
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;

--> L'entity du test bench est vide et elle doit le demeurer
--> L'entity peut porter le nom que vous voulez mais il est de bonne pratique 
--> d'utiliser le nom du module � tester avec un suffixe par exemple.

ENTITY Top_tb IS          --> Remarquez que l'ENTITY est vide et doit le demeurer pour un test bench !!!  
END Top_tb;


ARCHITECTURE behavioral OF Top_tb IS 

--> Remplacer ce COMPONENT par celui de votre COMPONENT � tester 
    -- Note: vous pouvez copier la partie PORT ( .. ) de l'entity de votre code VHDL 
    -- et l'ins�rer dans la d�claration COMPONENT.
--> Si vous voulez comparer 2 modules VHDL, vous pouvez d�clarer 2 COMPONENTS 
    -- distincts avec leurs PORT MAP respectif. 

component  Add1bitA is
    Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component Add1bitA;
   
--> G�n�rez des signaux internes au test bench avec des noms associ�s et les m�me types que dans le port
    -- Note: les noms peuvent �tre identiques, dans l'exemple on a ajout� un suffixe pour
    -- identifier clairement le signal qui appartient au test bench

   SIGNAL sortie_sim    : STD_LOGIC;
   SIGNAL b_sim         : STD_LOGIC;
   SIGNAL c_sim         : STD_LOGIC;
   SIGNAL a_sim         : STD_LOGIC;

--> S'il y a plusieurs bits en entr�e pour lesquels il faut d�finir des valeurs de test, 
    -- par exemple a, b, c dans l'exemple pr�sent, on recommande de cr�er un vecteur de test,
    -- ce qui facilitera l'�criture du test et la lisibilit� du code,
    -- notamment en faisant appara�tre clairement une structure de table de v�rit�

   SIGNAL vect_test : STD_LOGIC_VECTOR (2 downto 0);  -- Cr�ation d'un signal interne (3 bits)
   
--> D�clarez la constante PERIOD qui est utilis�e pour la simulation

   CONSTANT PERIOD    : time := 10 ns;                  --  *** � ajouter avant le premier BEGIN

--> Il faut faire un port map entre vos signaux internes et le component � tester
--> NOTE: Si vous voulez comparer 2 modules VHDL, vous devez g�nr�er 2 port maps 


BEGIN
  -- Par le "port-map" suivant, cela revient � connecter le composant aux signaux internes du tests bench
  -- UUT Unit Under Test: ce nom est habituel mais non impos�.
  -- Si on simule deux composantes, on pourrait avoir UUT1, UUT2 par exemple
  
  UUT: Add1bitA PORT MAP(
      sortie => sortie_sim, 
      b => b_sim, 
      c => c_sim, 
      a => a_sim
   );

 --> on assigne les signaux du vecteur de test vers les signaux connect�s au port map. 
a_sim <= vect_test(2); 
b_sim <= vect_test(1);
c_sim <= vect_test(0);
 
-- *** Test Bench - User Defined Section ***
-- l'int�r�t de cette structure de test bench est que l'on recopie la table de v�rit�.

   tb : PROCESS
   BEGIN
         wait for PERIOD; vect_test <="000";   --> Remarquez que "vect_test" contient exactement la table de v�rit�.  
         wait for PERIOD; vect_test <="001";   --> Avec cette fa�on, on s'assure de ne pas manquer de cas
         wait for PERIOD; vect_test <="010";
         wait for PERIOD; vect_test <="011";
         wait for PERIOD; vect_test <="100";
         wait for PERIOD; vect_test <="101";
         wait for PERIOD; vect_test <="110";
         wait for PERIOD; vect_test <="111";
         
       --> Cette partie est un exemple pour simuler le thermom�trique
--         wait for PERIOD; Thermometrique <="000000000000"; --> Code normal
--         wait for PERIOD; Thermometrique <="000000000001";
--         wait for PERIOD; Thermometrique <="000000000011";
--         wait for PERIOD; Thermometrique <="000000000111";
--         wait for PERIOD; Thermometrique <="000000001111";
--         wait for PERIOD; Thermometrique <="000000011111";
--         wait for PERIOD; Thermometrique <="000000111111";
--         wait for PERIOD; Thermometrique <="000001111111";
--         wait for PERIOD; Thermometrique <="000011111111";
--         wait for PERIOD; Thermometrique <="000111111111";
--         wait for PERIOD; Thermometrique <="001111111111";
--         wait for PERIOD; Thermometrique <="011111111111";
--         wait for PERIOD; Thermometrique <="111111111111";
--         wait for PERIOD; Thermometrique <="000000000010";  --> Code avec erreur
--         wait for PERIOD; Thermometrique <="000000101111";
--         wait for PERIOD; Thermometrique <="111100001111";
                  
         WAIT; -- will wait forever
   END PROCESS;
END;


