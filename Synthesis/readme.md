##  Synthesis – APB-SPI Core

This folder contains the **synthesis flow** for the APB-SPI Core using **Synopsys Design Compiler (DC Shell)**.  
Synthesis is the process of mapping the Verilog RTL into a **gate-level netlist** optimized for a given target technology library.

---

##  What is Synthesis?

- **Input:** Verilog RTL (from `../rtl/`) + Technology Library (`lsi_10k.db`).  
- **Output:** Optimized gate-level netlist (`top_mod.v`) and reports (`report.txt`).  
- **Purpose:** Ensure the design can be implemented in silicon with area, power, and timing goals satisfied.

---

##  Tool Used

- **Synopsys Design Compiler (DC Shell)**  
Industry-standard tool for RTL-to-gates synthesis.

---

##  Synthesis Script (`top_mod.tcl`)

```tcl
# Clear existing design
remove_design -all

# Search path and technology library setup
set search_path {../lib}
set target_library {lsi_10k.db}
set link_library "* lsi_10k.db"

# Read RTL sources
analyze -format verilog {../rtl/top_mod.v ../rtl/spi_slave_select.v ../rtl/spi_slave_interface.v ../rtl/spi_shift_reg.v ../rtl/spi_baud_generator.v}

# Elaborate the top-level module
elaborate top_mod

# Link the design with libraries
link 

# Clock and constraints
create_clock -period 20 -name PCLK [get_ports PCLK] ;# 50 MHz clock
set_max_area 800.0                                  ;# Area constraint

# Design sanity checks
check_design

# Set current design
current_design top_mod

# Perform synthesis
compile_ultra -no_autoungroup

# Write synthesized netlist
write_file -f verilog -hier -output top_mod.v

# Generate reports
redirect -file report.txt {
	report_timing -path full
	report_area
}
````

---

##  How to Run

1. **Launch DC Shell in terminal:**

   ```bash
   dc_shell
   ```

2. **Run the synthesis script:**

   ```tcl
   source top_mod.tcl
   ```

3. **(Optional) Open GUI after synthesis:**

   ```tcl
   start_gui
   ```

---

##  Outputs

* **Gate-level netlist:**
  `top_mod.v` (synthesized version of the RTL).

* **Reports:**
  `report.txt` containing:

  * `report_timing` → full path timing analysis.
  * `report_area` → standard cell area utilization.

---

##  Example Constraints

* **Clock period:** `20 ns` → equivalent to 50 MHz operating frequency.
* **Max area:** `800.0` → soft area constraint to guide optimization.

---

##  Design Checks

Before synthesis, DC runs:

* **check_design** → verifies connectivity, clocks, library mapping.
* **link** → resolves all references to cells/modules.

After synthesis, review:

* **report_timing** → ensure timing slack is non-negative.
* **report_area** → confirm area within limits.

---

##  Summary

This synthesis flow:

* Reads RTL modules (`top_mod.v`, `spi_slave_select.v`, `spi_slave_interface.v`, `spi_shift_reg.v`, `spi_baud_generator.v`).
* Elaborates and links the top-level (`top_mod`).
* Applies constraints (50 MHz clock, area < 800).
* Runs `compile_ultra` for optimized mapping.
* Produces a **synthesized netlist + reports** for timing and area.

**Run it with:**

```bash
dc_shell
source top_mod.tcl
```

and review results in `top_mod.v` and `report.txt`.


