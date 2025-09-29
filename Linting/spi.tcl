set search_path "./"
set library_path "./"

set_app_var enable_lint true

configure_lint -setup -goal lint_rtl

analyze -verbose -format verilog "../rtl/*.v"

elaborate top_mod

check_lint

report_lint -verbose -file spi_project_report.txt

