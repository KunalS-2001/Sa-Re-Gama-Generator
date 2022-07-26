LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity toneGenerator is
port (toneOut : out std_logic;
	clk : in std_logic;
	LED : out std_logic_vector(7 downto 0);
	tone : in std_logic_vector(3 downto 0));
end entity toneGenerator;
	
architecture tngn of toneGenerator is

begin
	process(clk)
	variable count_sa1 : integer range 0 to 104167 := 0;
	variable count_re : integer range 0 to 92593:= 0;
	variable count_ga : integer range 0 to 83333:= 0;
	variable count_ma : integer range 0 to 78125:= 0;
	variable count_pa : integer range 0 to 69444:= 0;
	variable count_dha : integer range 0 to 62500:= 0;
	variable count_ni : integer range 0 to 55555:= 0;
	variable count_sa2 : integer range 0 to 52083:= 0;
	variable sa1, re, ga, ma, pa, dha, ni, sa2: std_logic := '0';
	begin
		
		if (clk'event and clk = '1') then
			if (tone = "0000") then
				if (count_sa1 = 104168) then--240Hz
					count_sa1 := 1;
					sa1 := not sa1;
				else
					count_sa1 := count_sa1 + 1; 
				end if;
				
				toneOut <= sa1;
				LED <= (0 => '1', others => '0');
				
			elsif tone = "0001" then
			
				if (count_re = 92594) then--480Hz
					count_re := 0;
					re := not re;
				else
					count_re := count_re + 1; 
				end if;
				
				toneOut <= re;
				LED <= (1 => '1', others => '0');
				
			elsif tone = "0010" then
			
				if (count_ga = 83334) then--480Hz
					count_ga := 0;
					ga := not ga;
				else
					count_ga := count_ga + 1; 
				end if;
				
				toneOut <= ga;
				LED <= (2 => '1', others => '0');
				
			elsif tone = "0011" then
			
				if (count_ma = 78126) then--480Hz
					count_ma := 0;
					ma := not ma;
				else
					count_ma := count_ma + 1; 
				end if;
				
				toneOut <= ma;
				LED <= (3 => '1', others => '0');
				
			elsif tone = "0100" then
			
				if (count_pa = 69445) then--480Hz
					count_pa := 0;
					pa := not pa;
				else
					count_pa := count_pa + 1; 
				end if;
				
				toneOut <= pa;
				LED <= (4 => '1', others => '0');
				
			elsif tone = "0101" then
			
				if (count_dha = 62501) then--480Hz
					count_dha := 0;
					dha := not dha;
				else
					count_dha := count_dha + 1; 
				end if;
				
				toneOut <= dha;
				LED <= (5 => '1', others => '0');
				
			elsif tone = "0110" then
			
				if (count_ni = 55556) then--480Hz
					count_ni := 0;
					ni := not ni;
				else
					count_ni := count_ni + 1; 
				end if;
				
				toneOut <= ni;
				LED <= (6 => '1', others => '0');

			elsif tone = "0111" then
			
				if (count_sa2 = 52084) then--480Hz
					count_sa2 := 0;
					sa2 := not sa2;
				else
					count_sa2 := count_sa2 + 1; 
				end if;
				
				toneOut <= sa2;
				LED <= (7 => '1', others => '0');
			else
				toneOut <= '0';
				LED <= (others => '0');
			end if;
		end if;	
	end process;
end tngn;