## APB-Based Serial Peripheral Interface (SPI) Core

This document provides a summary of the APB-Based SPI Core, including its register map, signal descriptions, and operational details.

---

## Register Address Map

The SPI Core registers are mapped to the following addresses.

| Address | Register | Access |
| :--- | :--- | :--- |
| `0x0` | SPI Control Register 1 | RW |
| `0x1` | SPI Control Register 2 | RW |
| `0x2` | SPI Baud Rate Register | RW |
| `0x3` | SPI Status Register | RO |
| `0x5` | SPI Data Register | RW |

---

## Register Descriptions

### SPI Control Register 1 (Address `0x0`)

This register is used to configure the main functionalities of the SPI core. The reset value is `8'b0000 0100`.

| Bit | Name | Description |
| :--- | :--- | :--- |
| `SPIE` | SPI Interrupt Enable | Enables SPI interrupt requests if the SPIF or MODF status flag is set. |
| `SPE` | SPI System Enable | Enables the SPI system and its port pins. |
| `SPTIE` | SPI Transmit Interrupt Enable | Enables SPI interrupt requests if the SPTEF flag is set. |
| `MSTR` | Master Mode Select | Configures the SPI Core to work as a Master. |
| `CPOL` | Clock Polarity | Selects an inverted or non-inverted SPI clock. |
| `CPHA` | Clock Phase | Selects the SPI clock format. |
| `SSOE` | Slave Select Output Enable | Enables the SS output feature in master mode. |
| `LSBFE` | LSB First Enable | When set, data is transferred least significant bit first. |

### SPI Control Register 2 (Address `0x1`)

This register provides additional control options. The reset value is `8'b0000 0000`.

| Bit | Name | Description |
| :--- | :--- | :--- |
| `MODFEN` | Mode Fault Enable | Allows the Mode Fault (MODF) failure to be detected. |
| `BIDIROE` | Bidirectional Mode Output Enable | Enables output in the Bidirectional mode of operation. |
| `SPISWAI` | SPI Stop in Wait Mode | Used for power conservation while in wait mode. |
| `SPC0` | Serial Pin Control Bit 0 | Serial Pin Control Bit 0. |

### SPI Baud Rate Register (Address `0x2`)

This register controls the SCLK frequency. The reset value is `8'b0000 0000`.

| Bits | Name | Description |
| :--- | :--- | :--- |
| `SPPR2-0` | SPI Baud Rate Preselection | SPI Baud Rate Preselection Bits. |
| `SPR2-0` | SPI Baud Rate Selection | SPI Baud Rate Selection Bits. |

### SPI Status Register (Address `0x3`)

This read-only register provides the status of the SPI core. The reset value is `8'b0010 0000`.

| Bit | Name | Description |
| :--- | :--- | :--- |
| `SPIF` | SPI Transfer Complete Flag | Set after a received data byte has been transferred into the SPI Data Register. |
| `SPTEF` | SPI Transmit Empty Flag | If set, this bit indicates that the transmit data register is empty. |
| `MODF` | Mode Fault Flag | Set if the SS input becomes low while the SPI is configured as a master with mode fault detection enabled. |

### SPI Data Register (Address `0x5`)

This register is used to write data for transmission and read received data. The reset value is `8'b0000 0000`.

---

## Data Reception and Transmission

The SPI Core transmits data received from the APB Bus and receives data onto the bus. The transfer process follows this sequence:

1.  **Data Loading:** Data is written into the SPI data register via the APB Bus.
2.  **SS Activation:** The slave select (SS) signal is driven low to start communication.
3.  **Clock Generation:** The SPI Core generates the SCLK based on the CPHA and CPOL settings.
4.  **Data Transmission:** Data is shifted out through the MOSI line and received through the MISO line on the clock edges.
5.  **Transfer Completion:** The SS signal is driven high, and the clock generation stops, ending the transfer.

---

## Signal Descriptions

### Top Module Signals

These are the primary I/O signals for the integrated SPI core.

| Signal | Width | Direction | Signal Description |
| :--- | :--- | :--- | :--- |
| `PCLK` | 1 | Input | Clock signal. All signals are timed against the rising edge of PCLK. |
| `PRESET_n` | 1 | Input | Active Low Asynchronous Reset Signal. |
| `PADDR_i` | 3 | Input | Address bus for APB. |
| `PSEL_i` | 1 | Input | APB Slave Select Signal. |
| `PENABLE_i`| 1 | Input | Indicates the second and subsequent cycles of an APB transfer. |
| `PWRITE_i` | 1 | Input | Indicates an APB write (High) or read (Low) access. |
| `PWDATA_i` | 8 | Input | The APB write data bus. |
| `PRDATA_o` | 8 | Output | The APB read data bus. |
| `PREADY_o` | 1 | Output | Used to extend an APB Transfer. |
| `PSLVERR_o`| 1 | Output | Used to indicate a transfer error. |
| `mosi_o` | 1 | Output | Master Out Slave In data line. |
| `miso_i` | 1 | Input | Master In Slave Out data line. |
| `ss_o` | 1 | Output | Active-low Slave Select signal. |
| `sclk_o` | 1 | Output | Serial Clock output. |
| `spi_interrupt_request_o` | 1 | Output | SPI Interrupt Request. |

### Baud Rate Generator Signals

| Signal | Width | Direction | Signal Description |
| :--- | :--- | :--- | :--- |
| `PCLK` | 1 | Input | System Clock. |
| `PRESET_n` | 1 | Input | Active Low Asynchronous Reset Signal. |
| `cpol_i` | 1 | Input | Clock Polarity. |
| `spiswai_i`| 1 | Input | SPI Stop in Wait Mode. |
| `spi_mode_i`| 2 | Input | SPI Mode (Run, Wait, Stop). |
| `spr_i` | 3 | Input | SPI Baud Rate Selection Bits. |
| `sppr_i` | 3 | Input | SPI Baud Rate Preselection Bits. |
| `ss_i` | 1 | Input | Slave Select Active Low Signal. |
| `sclk_o` | 1 | Output | Serial Clock. |
| `BaudRateDivisor_o` | 12 | Output | Baud Rate Divisor value. |
| `cpha_i` | 1 | Input | Clock Phase. |
| `miso_receive_sclk_o` | 1 | Output | Flag to receive MISO data when CPOL and CPHA are the same. |
| `miso_receive_sclk0_o`| 1 | Output | Flag to receive MISO data when CPOL and CPHA are different. |
| `mosi_send_sclk_o` | 1 | Output | Flag to send MOSI data when CPOL and CPHA are the same. |
| `mosi_send_sclk0_o` | 1 | Output | Flag to send MOSI data when CPOL and CPHA are different. |

### SPI Slave Select Generator Signals

| Signal | Width | Direction | Signal Description |
| :--- | :--- | :--- | :--- |
| `PCLK` | 1 | Input | System Clock. |
| `PRESET_n` | 1 | Input | Active Low Asynchronous Reset Signal. |
| `mstr_i` | 1 | Input | SPI is in Master Mode. |
| `send_data_i` | 1 | Input | Send Data from Data Register. |
| `spiswai_i`| 1 | Input | SPI Stop in Wait Mode. |
| `spi_mode_i`| 2 | Input | SPI Mode (Run, Wait, Stop). |
| `ss_o` | 1 | Output | Slave Select Active Low Signal. |
| `BaudRateDivisor_i` | 12 | Input | Baud Rate Divisor value. |
| `tip_o` | 1 | Output | Transfer In Progress. |
| `receive_data_o`| 1 | Output | Receive Data to Data Register. |

### SPI APB Slave Interface Signals

| Signal | Width | Direction | Signal Description |
| :--- | :--- | :--- | :--- |
| `PCLK` | 1 | Input | System Clock. |
| `PRESET_n` | 1 | Input | Active Low Asynchronous Reset Signal. |
| `PADDR_i` | 3 | Input | APB Address bus. |
| `PSEL_i` | 1 | Input | APB Slave Select Signal. |
| `PENABLE_i`| 1 | Input | Indicates subsequent APB transfer cycles. |
| `PWRITE_i` | 1 | Input | Indicates Write (1) or Read (0). |
| `PWDATA_i` | 8 | Input | The write data bus. |
| `PRDATA_o` | 8 | Output | The read data bus. |
| `PREADY_o` | 1 | Output | Extends an APB Transfer. |
| `PSLVERR_o`| 1 | Output | Indicates Transfer Error. |
| `ss_i` | 1 | Input | Slave Select (Active Low Signal). |
| `spi_interrupt_request_o` | 1 | Output | SPI Interrupt Request. |
| `receive_data_i`| 1 | Input | Indicates MISO data transfer from Shifter to Data Register. |
| `miso_data_i` | 8 | Input | MISO Data from shift register. |
| `tip_i` | 1 | Input | Transfer In Progress. |
| `send_data_o` | 1 | Output | Indicates data transfer from Data Register to Shifter. |
| `mstr_o` | 1 | Output | Indicates Master (1) or Slave (0). |
| `cpol_o` | 1 | Output | Clock Polarity. |
| `cpha_o` | 1 | Output | Clock Phase. |
| `lsbfe_o` | 1 | Output | LSB First Enable. |
| `spiswai_o`| 1 | Output | SPI Stop in Wait Mode. |
| `mosi_data_o` | 8 | Output | MOSI Data from Data Register to Shift Register. |
| `spi_mode_o`| 2 | Output | SPI Mode (Run, Wait, Stop). |
| `spr_o` | 3 | Output | SPI Baud Rate Selection Bits. |
| `sppr_o` | 3 | Output | SPI Baud Rate Preselection Bits. |

### SPI Shifter Signals

| Signal | Width | Direction | Signal Description |
| :--- | :--- | :--- | :--- |
| `PCLK` | 1 | Input | APB Clock. |
| `PRESET_n` | 1 | Input | Active Low Asynchronous Reset Signal. |
| `ss_i` | 1 | Input | Slave Select (Active Low). |
| `send_data_i` | 1 | Input | Indicates data transfer from data register to shifter register. |
| `lsbfe_i` | 1 | Input | LSB First Enable. |
| `cpha_i` | 1 | Input | Clock Phase. |
| `cpol_i` | 1 | Input | Clock Polarity. |
| `miso_receive_sclk_i`| 1 | Input | Flag to receive MISO data when CPHA and CPOL are the same. |
| `miso_receive_sclk0_i`| 1 | Input | Flag to receive MISO data when CPHA and CPOL are different. |
| `mosi_send_sclk_i`| 1 | Input | Flag to send MOSI data when CPHA and CPOL are the same. |
| `mosi_send_sclk0_i`| 1 | Input | Flag to send MOSI data when CPHA and CPOL are different. |
| `data_mosi_i` | 8 | Input | MOSI data from Data Register to Shift Register. |
| `miso_i` | 1 | Input | Master In Slave Out data line. |
| `receive_data_i` | 1 | Input | Indicates data transfer from Shifter register to data register. |
| `mosi_o` | 1 | Output | Master Out Slave In data line. |
| `data_miso_o` | 8 | Output | MISO data from shift register. |

---

## Baud Rate Calculation

The baud rate of the SCLK is determined by the system clock (`PCLK`) and the Baud Rate Divisor.

The **Baud Rate Divisor** is calculated using the `SPPR` and `SPR` values from the SPI Baud Rate Register with the following equation:

$$\text{Baud Rate Divisor} = (SPPR + 1) \times 2^{(SPR + 1)}$$

The final **Baud Rate** is then calculated as:

$$\text{Baud Rate} = \frac{\text{PCLK}}{\text{Baud Rate Divisor}}$$

---

## Finite State Machines (FSM)

The core's operation is managed by two main FSMs.

### SPI Mode FSM

This FSM controls the operational mode of the SPI peripheral.
* **States:** `spi_run`, `spi_wait`, `spi_stop`.
* **Transitions:**
    * `spi_run` to `spi_wait` occurs when `spe` is low.
    * `spi_wait` to `spi_run` occurs when `spe` is high.
    * `spi_wait` to `spi_stop` occurs when `spiswai` is high.
    * `spi_stop` to `spi_wait` occurs when `spiswai` is low.

### APB Interface FSM

This FSM manages transactions on the APB slave interface.
* **States:** `IDLE`, `SETUP`, `ENABLE`.
* **Transitions:**
    * `IDLE` to `SETUP` when `PSEL` is high and `PENABLE` is low.
    * `SETUP` to `ENABLE` when `PSEL` and `PENABLE` are high.
    * `SETUP` to `IDLE` when `PSEL` is low.
    * `ENABLE` to `SETUP` when `PSEL` is high and `PENABLE` is low.
    * `ENABLE` to `IDLE` when `PSEL` is low.
