--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:40:04 06/23/2020
-- Design Name:   
-- Module Name:   C:/Users/wcx71/alu/test.vhd
-- Project Name:  alu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
			cin : IN  std_logic;
         input1 : IN  std_logic_vector(15 downto 0);
         input2 : IN  std_logic_vector(15 downto 0);
         y : INOUT  std_logic_vector(15 downto 0);
         opcode : IN  std_logic_vector(3 downto 0);
         cf_out : OUT  std_logic;
         zf_out : OUT  std_logic;
         of_out : OUT  std_logic;
         sf_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
	signal cin : std_logic := '0';
   signal input1 : std_logic_vector(15 downto 0) := (others => '0');
   signal input2 : std_logic_vector(15 downto 0) := (others => '0');
   signal opcode : std_logic_vector(3 downto 0) := (others => '0');

	--BiDirs
   signal y : std_logic_vector(15 downto 0);

 	--Outputs
   signal cf_out : std_logic;
   signal zf_out : std_logic;
   signal of_out : std_logic;
   signal sf_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          clk => clk,
          rst => rst,
			 cin => cin,
          input1 => input1,
          input2 => input2,
          y => y,
          opcode => opcode,
          cf_out => cf_out,
          zf_out => zf_out,
          of_out => of_out,
          sf_out => sf_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for 10ns;
		rst <= '1';
		cin <= '1';
		input1<="0000000000011101";
		input2<="0000000000000011";
		opcode<="1100";
		clk <= '1';
		wait for 10ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
