---------------------------------------------------------------------------------------------
-- Universit� de Sherbrooke - D�partement de GEGI
-- Version         : 3.0
-- Nomenclature    : GRAMS
-- Date            : 21 Avril 2020
-- Auteur(s)       : R�jean Fontaine, Daniel Dalle, Marc-Andr� T�trault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: Pmod8LD PmodSSD
--
-- Outils          : vivado 2019.1 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Circuit utilitaire pour le laboratoire et la probl�matique de logique combinatoire
--
---------------------------------------------------------------------------------------------
-- � faire :
-- Voir le guide de l'APP
--    Ins�rer les modules additionneurs ("components" et "instances")
--
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity AppCombi_top is
  port ( 
          i_btn       : in    std_logic_vector (3 downto 0); -- Boutons de la carte Zybo
          i_sw        : in    std_logic_vector (3 downto 0); -- Interrupteurs de la carte Zybo
          sysclk      : in    std_logic;                     -- horloge systeme
          o_SSD       : out   std_logic_vector (7 downto 0); -- vers cnnecteur pmod afficheur 7 segments
          o_led       : out   std_logic_vector (3 downto 0); -- vers DELs de la carte Zybo
          o_led6_r    : out   std_logic;                     -- vers DEL rouge de la carte Zybo
          o_pmodled   : out   std_logic_vector (7 downto 0);  -- vers connecteur pmod 8 DELs
          
          i_ADC_th    : in    std_logic_vector (11 downto 0);-- Fait par deux imbéciles
          i_S1        : in    std_logic  ;  -- Fait par deux imbéciles
          i_S2        : in    std_logic  ;-- Fait par deux imbéciles
          o_DEL2      : out    std_logic  ;-- Fait par deux imbéciles  
          o_DEL3      : out    std_logic   -- Fait par deux imbéciles  
    
          
          );
end AppCombi_top;
 
architecture BEHAVIORAL of AppCombi_top is

   constant nbreboutons     : integer := 4;    -- Carte Zybo Z7
   constant freq_sys_MHz    : integer := 125;  -- 125 MHz 
   
   signal d_s_1Hz           : std_logic;
   signal clk_5MHz          : std_logic;
   --
   signal d_opa             : std_logic_vector (3 downto 0):= "0000";   -- operande A
   signal d_opb             : std_logic_vector (3 downto 0):= "0000";   -- operande B
   signal d_cin             : std_logic := '0';                         -- retenue entree
   signal d_sum             : std_logic_vector (3 downto 0):= "0000";   -- somme
   signal d_cout            : std_logic := '0';                         -- retenue sortie
   --

 
   

   signal d_AFF0            : std_logic_vector (3 downto 0);--:= "0000";
   signal d_AFF1            : std_logic_vector (3 downto 0);--:= "0000";
   --
    
 ----------------- BASE COMPONENTS ----------------------  

 component synchro_module_v2 is
   generic (const_CLK_syst_MHz: integer := freq_sys_MHz);
      Port ( 
           clkm        : in  STD_LOGIC;  -- Entr�e  horloge maitre
           o_CLK_5MHz  : out STD_LOGIC;  -- horloge divise utilise pour le circuit             
           o_S_1Hz     : out  STD_LOGIC  -- Signal temoin 1 Hz
            );
      end component;  

   component septSegments_Top is
    Port (   clk          : in   STD_LOGIC;                      -- horloge systeme, typique 100 MHz (preciser par le constante)
             i_AFF0       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0
             i_AFF1       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0     
             o_AFFSSD_Sim : out string(1 to 2);
             o_AFFSSD     : out  STD_LOGIC_VECTOR (7 downto 0)  
           );
   end component;


------------- APP SIGNALS ---------------------------
signal ADCbin_inter0 : std_logic_vector (3 downto 0);
signal d_JD : std_logic_vector (11 downto 0); --JSP trop comment faire
signal d_S1, d_S2, d_del2, d_del3, parite_sig : std_logic; --JSP trop comment faire
signal error_7seg : std_logic;
signal Dizaines_inter, Unites_ns_inter, Code_signe_inter, Unites_s_inter : std_logic_vector(3 downto 0); --J'ai ajouté ca comme un cave
-------------APP COMPONENTS---------------------------
component Thermo2Bin_clean is
    Port ( ADCth : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           erreur : out STD_LOGIC);
end component Thermo2Bin_clean;

component Bloc2_3_decodeur is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Led_out : out STD_LOGIC_VECTOR (7 downto 0));
end component Bloc2_3_decodeur;

component parite_calculateur is
    Port (
        ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
        S1 : in std_logic;
        parite : out STD_LOGIC
        );
end component parite_calculateur;

component Bin2DualBCD is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_s : out STD_LOGIC_VECTOR (3 downto 0));
end component Bin2DualBCD;

component Mux is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Dizaine : in STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : in STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : in STD_LOGIC_VECTOR (3 downto 0);
           erreur : in STD_LOGIC;
           BTN : in STD_LOGIC_VECTOR (1 downto 0);
           S2 : in STD_LOGIC;
           DAFF0 : out STD_LOGIC_VECTOR (3 downto 0);
           DAFF1 : out STD_LOGIC_VECTOR (3 downto 0));
end component Mux;






begin
  
    inst_synch : synchro_module_v2
     generic map (const_CLK_syst_MHz => freq_sys_MHz)
         port map (
            clkm         => sysclk,
            o_CLK_5MHz   => clk_5MHz,
            o_S_1Hz      => o_led6_r--d_S_1Hz
        );  

   inst_aff :  septSegments_Top
       port map (
           clk    => clk_5MHz,
           -- donnee a afficher definies sur 8 bits : chiffre hexa position 1 et 0
           i_AFF1  => d_AFF1, 
           i_AFF0  => d_AFF0,
           o_AFFSSD_Sim   => open,   -- ne pas modifier le "open". Ligne pour simulations seulement.
           o_AFFSSD       => o_SSD   -- sorties directement adaptees au connecteur PmodSSD
       );

                   

            
                              
   d_opa               <=  i_sw;                        -- operande A sur interrupteurs
   d_opb               <=  i_btn;                       -- operande B sur boutons
   d_cin               <=  '0';                     -- la retenue d'entr�e alterne 0 1 a 1 Hz

 ------------------- APP INSTANCIATION ----------------------                  
inst_thermo2bin : thermo2bin_clean
port map (
         ADCth => d_JD,--trouver signal in
         ADCbin => ADCbin_inter0,
         erreur => error_7seg              
);

inst_Bloc2_3_decodeur : bloc2_3_decodeur
port map (
        ADCbin => ADCbin_inter0,
        Led_out => o_pmodled
);

inst_parite_calculateur : parite_calculateur
port map (
        ADCbin => ADCbin_inter0,
        S1 => d_S1,
        parite => parite_sig
        );
o_led(0) <= parite_sig;
d_del2 <= parite_sig;
inst_Bin2DualBCD : Bin2DualBCD
port map (
        ADCbin => ADCbin_inter0,
        Dizaines => Dizaines_inter,
        Unites_s => Unites_s_inter,
        Unites_ns => Unites_ns_inter,
        Code_signe => Code_signe_inter
        
);

inst_Mux : Mux
port map (
        ADCbin => ADCbin_inter0,
        Dizaine => Dizaines_inter,
        Unites_ns => Unites_ns_inter,
        Code_signe => Code_signe_inter,
        Unite_s => Unites_s_inter,
        erreur => error_7seg,
        BTN => i_btn(1 downto 0),
        S2 => d_S2,
        DAFF0 => d_AFF0,
        DAFF1 => d_AFF1
);


----------- MAP Thermo ----------------------
    d_JD                <= i_ADC_th;
    d_S1                <= i_S1;    
    d_S2                <= i_S2;
    d_del2               <= o_DEL2;
    d_del3              <= o_DEL3;    

         

----------- MAP ZYBO ----------------------                              
   --d_opa               <=  i_sw;                        -- operande A sur interrupteurs
   --d_opb               <=  i_btn;                       -- operande B sur boutons
   --d_cin               <=  '0';                     -- la retenue d'entr�e alterne 0 1 a 1 Hz
      
   --d_AFF0              <=  d_sum(3 downto 0);           -- Le resultat de votre additionneur affich� sur PmodSSD(0)
   --d_AFF1              <=  '0' & '0' & '0' & d_Cout;    -- La retenue de sortie affich�e sur PmodSSD(1) (0 ou 1)
   --o_led6_r            <=  d_Cout;                      -- La led couleur repr�sente aussi la retenue en sortie  Cout
   --o_pmodled           <=  d_opa & d_opb;               -- Les op�randes d'entr�s reproduits combin�s sur Pmod8LD
   --o_led (3 downto 0)  <=  '0' & '0' & '0' & d_S_1Hz;   -- La LED0 sur la carte repr�sente la retenue d'entr�e        
   
   
end BEHAVIORAL;


