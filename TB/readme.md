#  Top-Level Testbench – APB-SPI Core

This directory contains the **top-level testbench** `top_tb.v` used to verify the full APB-SPI core design.  
The testbench validates the **integration of all RTL blocks** (APB interface, baud generator, shifter, and slave select) and ensures the SPI protocol operates correctly in various configurations.

---

##  Purpose
- Verify **end-to-end functionality** of the APB-SPI core.  
- Exercise the **APB bus interface** (read/write transactions).  
- Validate **SPI protocol operations** including:  
  - Clock generation (SCLK).  
  - Slave select timing (SS).  
  - Data shifting on MOSI/MISO.  
  - Interrupt and status flag behavior.  
- Ensure correct operation in all four SPI modes (Mode 0–3).  
- Provide waveform outputs for debugging and verification.  

---

##  File: `top_mod_tb.v`

### Key Functions
- **DUT Instantiation:**  
  Instantiates the top-level RTL module `top.v` as the Device Under Test (DUT).  

- **APB Bus Driver:**  
  Generates APB protocol signals (`PADDR`, `PWRITE`, `PENABLE`, `PWDATA`, `PSEL`) to mimic processor writes and reads.  

- **SPI Configuration:**  
  - Programs SPI Control Registers (master/slave mode, CPOL, CPHA, LSBFE).  
  - Configures Baud Rate Register (SPPR, SPR).  

- **Data Transfer Tests:**  
  - Writes transmit data to the Data Register (`SPI_DR`).  
  - Checks MOSI shifting and MISO sampling across SPI clock edges.  
  - Verifies full-duplex transfer behavior.  

- **Mode Testing:**  
  - Runs separate transactions for SPI Modes 0, 1, 2, and 3.  
  - Confirms data alignment with CPOL/CPHA combinations.  

- **Monitoring and Logging:**  
  - Prints debug messages (`$display`) for pass/fail conditions.  
  - Dumps waveforms (`$dumpfile`, `$dumpvars`) for post-simulation analysis.  

---

