# 📝 RTL Modules – APB-SPI Core

This directory contains the **Register-Transfer Level (RTL) design files** for the APB-based Serial Peripheral Interface (SPI) Core.  
Each module in this directory performs a **specific role** in the SPI protocol, and together they implement a complete, configurable, and synthesizable SPI controller that can be integrated into an SoC or FPGA project.

The design follows a **modular approach**:
- Each functional block (APB interface, baud rate generator, shifter, slave select) is implemented as a separate module.
- The `top.v` file instantiates and connects all submodules.
- All modules are coded in **synthesizable Verilog** with proper resets, parameterization, and configurability.

---

## 📂 Files and Functionality

### 1. `top.v`
- **Role:**  
  The **top-level integration module** of the APB-SPI Core.
- **Functionality:**  
  - Instantiates all lower-level modules:
    - `interface.v`
    - `baud.v`
    - `slave.v`
    - `shift.v`
  - Provides glue logic to connect APB bus signals to SPI core internals.
  - Exposes **external SPI pins**:
    - `MOSI`, `MISO`, `SCLK`, `SS`
  - Exposes **APB bus interface**:
    - `PADDR`, `PWRITE`, `PSEL`, `PENABLE`, `PWDATA`, `PRDATA`
- **Notes:**  
  `top.v` acts as the **bridge between SoC bus logic and the SPI peripheral**.  
  This modularity allows the core to be dropped into any APB-compliant SoC with minimal changes.

---

### 2. `interface.v`
- **Role:**  
  Implements the **APB3 slave interface** for register-based control and status monitoring.
- **Functionality:**  
  - Decodes APB bus transactions and updates internal control registers.  
  - Provides **registers**:
    - **Control Register 1:** Enable bit, Master/Slave select, CPOL, CPHA, LSB-first, interrupts.  
    - **Control Register 2:** Mode fault detection, bidirectional enable, wait-in-stop.  
    - **Baud Rate Register:** SPPR (prescaler) and SPR (divider).  
    - **Status Register:** Transfer complete (SPIF), transmit buffer empty (SPTEF), mode fault (MODF).  
    - **Data Register:** SPI_DR for transmit/receive data.  
  - Generates internal signals:
    - `send_data`
    - `receive_data`
    - `mosi_data`
    - interrupt request (`spi_int_req`)
- **Notes:**  
  The APB interface ensures that **software drivers** can easily configure the SPI by writing to these registers.

---

### 3. `baud.v`
- **Role:**  
  Generates the **serial clock (SCLK)** used by SPI transfers.
- **Functionality:**  
  - Divides the APB clock (PCLK) using prescaler (SPPR) and divider (SPR).  
  - Implements:
    ```
    BaudDivisor = (SPPR + 1) × 2^(SPR + 1)
    BaudRate    = PCLK / BaudDivisor
    ```
  - Supports **CPOL (polarity)** and **CPHA (phase)** configurations for all four SPI modes.  
  - Produces timing flags for:
    - Sampling MISO on correct edges.  
    - Driving MOSI at the right instants.  
- **Notes:**  
  The baud generator ensures SPI can work at a wide range of clock speeds, making it flexible across peripherals that require different timing.

---

### 4. `slave.v`
- **Role:**  
  Handles the **slave select (SS) logic** for SPI in master mode.
- **Functionality:**  
  - Asserts SS (active-low) when a transfer starts.  
  - Keeps SS low for the duration of the transfer, based on the baud divisor.  
  - Releases SS after the transfer ends.  
  - Generates:
    - `TIP` (Transfer In Progress) signal.  
    - `receive_data` flag to notify the shifter when new data is ready.  
- **Notes:**  
  This module ensures **synchronization between data transfer and slave device selection**, which is crucial for reliable communication.

---

### 5. `shift.v`
- **Role:**  
  Implements the **shifter logic** for SPI’s parallel-to-serial and serial-to-parallel conversion.
- **Functionality:**  
  - On **transmit**:
    - Loads data from the APB Data Register (`SPI_DR`) into an internal shift register.
    - Shifts out data bit-by-bit on **MOSI**, aligned with SCLK edges (depending on CPOL/CPHA).
    - Supports **MSB-first** or **LSB-first** transmission.  
  - On **receive**:
    - Samples incoming bits from **MISO** on correct edges.  
    - Collects them into a temporary register.  
    - Updates the Data Register (`SPI_DR`) when a full word is received.  
  - Works in full-duplex: while transmitting, it simultaneously receives.  
- **Notes:**  
  The shifter is the **core engine of SPI communication**, ensuring proper serialization/deserialization.

---

## 🔧 Design Notes
- **Reset Strategy:** All registers and counters reset to known states (typically zero or idle).  
- **Parameterization:** Word sizes, prescaler ranges, and mode options are configurable.  
- **Synthesizability:** Code adheres to synthesizable Verilog practices (no delays, no behavioral-only constructs).  
- **Interrupts:** Designed for event-driven communication to reduce CPU polling overhead.  
- **Power Modes:** Integration with APB control allows **run, wait, stop** modes for low power consumption.

---

##  Summary
The RTL in this folder represents a **complete APB-SPI controller**.  
- The **APB interface** provides configuration and control via registers.  
- The **baud generator** creates the correct SPI clock.  
- The **slave select logic** ensures correct device selection and timing.  
- The **shifter** manages actual data transfer.  
- The **top module** ties everything together.  

This modular design makes the APB-SPI core **easy to verify, synthesize, and integrate into larger systems**. It also allows individual modules to be tested in isolation, improving design reliability.
