remove_design -all
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

analyze -format verilog {../rtl/top_mod.v ../rtl/spi_slave_select.v ../rtl/spi_slave_interface.v ../rtl/spi_shift_reg.v ../rtl/spi_baud_generator.v}

elaborate top_mod

link 

create_clock -period 20 -name PCLK [get_ports PCLK]
set_max_area 800.0

check_design

current_design top_mod

compile_ultra -no_autoungroup

write_file -f verilog -hier -output top_mod.v

redirect -file report.txt {
	report_timing -path full
	report_area
}


