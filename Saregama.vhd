LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Saregama is
port (toneOut : out std_logic;
	clk_50, resetn : in std_logic;
	LED : out std_logic_vector(7 downto 0);
	start : in std_logic);
end entity Saregama;

architecture fsm of Saregama is
type state_type is (silent, sa1, re, ga, ma, pa, dha, ni, sa2);
signal y_present : state_type;
signal tone_code : std_logic_vector(3 downto 0);
signal clk_c : std_logic;

component toneGenerator is
port (toneOut : out std_logic;
	clk : in std_logic;
	LED : out std_logic_vector(7 downto 0);
	tone : in std_logic_vector(3 downto 0));
end component;

begin

	process(start, y_present, clk_50, resetn, clk_c)
	variable timecounter : integer range 0 to 100000000 := 0;
	variable y_next_var : state_type := silent;
	variable tone_code_var : std_LOGIC_vector(3 downto 0) := (others => '0');
	begin
-- Control Path =================================================================
		y_next_var := y_present;
		case y_present is
			when Silent=>
				if start='0' then
					y_next_var :=silent;
					tone_code_var := "1111";
				else
					y_next_var :=sa1;
					tone_code_var := "0000";
				end if;
				
			When sa1 =>
				y_next_var := re ;
				tone_code_var :="0001";
				
			When re =>
				y_next_var := ga ;
				tone_code_var :="0010";
			
			When ga =>
				y_next_var := ma ;
				tone_code_var :="0011";
				
			When ma =>
				y_next_var := pa ;
				tone_code_var :="0100";
			
			When pa =>
				y_next_var := dha ;
				tone_code_var :="0101";
				
			When dha =>
				y_next_var := ni ;
				tone_code_var :="0110";
				
			When ni =>
				y_next_var := sa2 ;
				tone_code_var :="0111";

			When sa2 =>
				y_next_var := sa1 ;
				tone_code_var :="0000";
			
				
		END CASE ;
		tone_code <= tone_code_var;
-- Let's generate the slow clock=================================================
		if (clk_50 = '1' and clk_50' event) then

			if timecounter = 6250000 then --*******FILL IT*********
			--count value for slow clock, clk_c is the slow clock.
				timecounter := 0;
				clk_c <= not clk_c;
			else
				timecounter := timecounter + 1;
				
			end if;
		end if;
				
-- FSM will run on this slow clock below=========================================		
		if (clk_c = '1' and clk_c' event) then
			if (resetn = '0') then
				y_present<=y_next_var;
			else 
				y_present<=silent;
			end if;
		end if;
	end process;
-- Date Path ====================================================================	
	tone_gen: toneGenerator port map(toneOut, clk_50, LED, tone_code);
end fsm;