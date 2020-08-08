----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:45:54 06/22/2020 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           input1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  input2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  cin : in STD_LOGIC;
           y : inout  STD_LOGIC_VECTOR (15 downto 0);
			  opcode : in  STD_LOGIC_VECTOR (3 downto 0);--4位操作码
           cf_out : out  STD_LOGIC;
           zf_out : out  STD_LOGIC;
			  of_out : out  STD_LOGIC;
			  sf_out : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
	signal a, b: std_logic_vector(15 downto 0):=(others=>'0');	-- oprand a and b, function output to y.
begin

process(rst,clk)
	begin
		if rst = '0' then
			--state <= 0;
			a <= "0000000000000000";
			b <= "0000000000000000";
			cf_out <= '0';
			zf_out <= '0';
			of_out <= '0';
			sf_out <= '0';
			y <= (others=>'0');
		elsif CLK'event and CLK = '1' then
			a <= input1;
			b <= input2;
			cf_out <= '0';
			zf_out <= '0';
			of_out <= '0';
			sf_out <= '0';
			case opcode is
				when "0000"	=>	y <= a + b;--补码加法
					if(a(15)='0' and b(15)='0' and y(15)='1') then 
						of_out <= '1';
					end if;
            	if(a(15)='1' and b(15)='1') then 
						cf_out<='1'; 
					end if;
            	if(y = "0000000000000000") then 
						zf_out <= '1'; 
					end if;
	            if(y(15) = '1') then 
						sf_out <= '1';
					end if;
				when "0001"	=>	y <= a + (not b) + 1;--补码减法，先将b取反加一得到相反数后对其进行加法运算
					if(y = "0000000000000000") then 
						zf_out <= '1'; 
					end if;
	            if(y(15) = '1') then 
						sf_out <= '1'; 
					end if;
					if(a<b) then
						cf_out <= '1';
					end if;
				when "0010" => y <= a and b;--与运算
					if(y = "0000000000000000") then 
						zf_out <= '1'; 
					end if;
	            if(y(15) = '1') then 
						sf_out <= '1'; 
					end if;
				when "0011" => y <= a or b;--或运算
					if(y = "0000000000000000") then 
						zf_out <= '1'; 
					end if;
	            if(y(15) = '1') then 
						sf_out <= '1'; 
					end if;
				when "0100" => y <= a xor b;--与或运算
					if(y = "0000000000000000") then 
						zf_out <= '1'; 
					end if;
	            if(y(15) = '1') then 
						sf_out <= '1'; 
					end if;
				when "0101" => y <= not a;--对a取非
				when "0110" => y <= to_stdlogicvector(to_bitvector(a) SLL CONV_INTEGER(b));   --a逻辑左移b位
					if(b="0000000000000001" and a(15)/=y(15)) then
						of_out <= '1';
					end if;
				when "0111" => y <= to_stdlogicvector(to_bitvector(a) SRL CONV_INTEGER(b));   --a逻辑右移b位	
				   if(b="0000000000000001" and a(15)/=y(15)) then
						of_out <= '1';
					end if;
				when "1000" => y <= to_stdlogicvector(to_bitvector(a) SLA CONV_INTEGER(b));   --a算数左移b位
					if(b="0000000000000001" and a(15)/=y(15)) then
						of_out <= '1';
					end if;
				when "1001" => y <= to_stdlogicvector(to_bitvector(a) SRA CONV_INTEGER(b));   --a算数右移b位
					if(b="0000000000000001" and a(15)/=y(15)) then
						of_out <= '1';
					end if;
				when "1010" => y <= to_stdlogicvector(to_bitvector(a) ROL CONV_INTEGER(b));	--a循环左移b位	
					if(b="0000000000000001" and a(15)/=y(15)) then
						of_out <= '1';
					end if;
					if(b/="0000000000000000")then
						cf_out <= a(16-CONV_INTEGER(b));
					end if;
				when "1011" => y <= to_stdlogicvector(to_bitvector(a) ROR CONV_INTEGER(b));	--a循环右移b位	
					if(b="0000000000000001" and a(15)/=y(15)) then
						of_out <= '1';
					end if;
					if(b/="0000000000000000")then
						cf_out <= a(CONV_INTEGER(b)-1);
					end if;
				when "1100" => y <= a+b+cin;--adc
					if(a(15)='0' and b(15)='0' and y(15)='1') then 
						of_out <= '1';
					end if;
            	if(a(15)='1' and b(15)='1' and y(15)='0') then 
						of_out <= '1'; cf_out<='1'; 
					end if;
            	if(y = "0000000000000000") then 
						zf_out <= '1'; 
					end if;
	            if(y(15) = '1') then 
						sf_out <= '1';
					end if;
				when "1101"	=>	y <= a + (not b) + 1-cin;--补码减法，先将b取反加一得到相反数后对其进行加法运算
					if(y = "0000000000000000") then 
						zf_out <= '1'; 
					end if;
	            if(y(15) = '1') then 
						sf_out <= '1'; 
					end if;
					if(a<b) then
						cf_out <= '1';
					end if;
					
				when others => y <="0000000000000000";	
			end case;
		end if;
	end process;
end Behavioral;	

