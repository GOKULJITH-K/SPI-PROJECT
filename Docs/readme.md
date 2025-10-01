
## APB-Based Serial Peripheral Interface (SPI) Core

This document provides a summary of the APB-Based SPI Core, including its register map, signal descriptions, and operational details.

---

## Register Address Map

[cite_start]The SPI Core registers are mapped to the following addresses[cite: 39, 40].

| Address | Register                | Access |
| :------ | :---------------------- | :----- |
| `0x0`   | SPI Control Register 1  | RW     |
| `0x1`   | SPI Control Register 2  | RW     |
| `0x2`   | SPI Baud Rate Register  | RW     |
| `0x3`   | SPI Status Register     | RO     |
| `0x5`   | SPI Data Register       | RW     |

---

## Register Descriptions

### SPI Control Register 1 (Address `0x0`)

[cite_start]This register is used to configure the main functionalities of the SPI core[cite: 45]. [cite_start]The reset value is `8'b0000 0100`[cite: 49].

| Bit     | Name    | Description                                                                          |
| :------ | :------ | :----------------------------------------------------------------------------------- |
| `SPIE`  | SPI Interrupt Enable | [cite_start]Enables SPI interrupt requests if the SPIF or MODF status flag is set[cite: 50]. |
| `SPE`   | SPI System Enable    | [cite_start]Enables the SPI system and its port pins[cite: 51].                                  |
| `SPTIE` | SPI Transmit Interrupt Enable | [cite_start]Enables SPI interrupt requests if the SPTEF flag is set[cite: 52].             |
| `MSTR`  | Master Mode Select   | [cite_start]Configures the SPI Core to work as a Master[cite: 53].                           |
| `CPOL`  | Clock Polarity       | [cite_start]Selects an inverted or non-inverted SPI clock[cite: 54].                           |
| `CPHA`  | Clock Phase          | [cite_start]Selects the SPI clock format[cite: 55].                                            |
| `SSOE`  | Slave Select Output Enable | [cite_start]Enables the SS output feature in master mode[cite: 56].                      |
| `LSBFE` | LSB First Enable     | [cite_start]When set, data is transferred least significant bit first[cite: 57].             |

### SPI Control Register 2 (Address `0x1`)

[cite_start]This register provides additional control options[cite: 58]. [cite_start]The reset value is `8'b0000 0000`[cite: 60].

| Bit       | Name               | Description                                                        |
| :-------- | :----------------- | :----------------------------------------------------------------- |
| `MODFEN`  | Mode Fault Enable  | [cite_start]Allows the Mode Fault (MODF) failure to be detected[cite: 61].       |
| `BIDIROE` | Bidirectional Mode Output Enable | [cite_start]Enables output in the Bidirectional mode of operation[cite: 62]. |
| `SPISWAI` | SPI Stop in Wait Mode | [cite_start]Used for power conservation while in wait mode[cite: 62].        |
| `SPC0`    | Serial Pin Control Bit 0 | [cite_start]Serial Pin Control Bit 0[cite: 63].                              |

### SPI Baud Rate Register (Address `0x2`)

[cite_start]This register controls the SCLK frequency[cite: 67]. [cite_start]The reset value is `8'b0000 0000`[cite: 71].

| Bits      | Name                     | Description                             |
| :-------- | :----------------------- | :-------------------------------------- |
| `SPPR2-0` | SPI Baud Rate Preselection | [cite_start]SPI Baud Rate Preselection Bits[cite: 72]. |
| `SPR2-0`  | SPI Baud Rate Selection    | [cite_start]SPI Baud Rate Selection Bits[cite: 73].    |

### SPI Status Register (Address `0x3`)

[cite_start]This read-only register provides the status of the SPI core[cite: 74]. [cite_start]The reset value is `8'b0010 0000`[cite: 75].

| Bit     | Name                     | Description                                                                                                    |
| :------ | :----------------------- | :------------------------------------------------------------------------------------------------------------- |
| `SPIF`  | SPI Transfer Complete Flag | [cite_start]Set after a received data byte has been transferred into the SPI Data Register[cite: 76].                        |
| `SPTEF` | SPI Transmit Empty Flag    | [cite_start]If set, this bit indicates that the transmit data register is empty[cite: 77].                                |
| `MODF`  | Mode Fault Flag            | [cite_start]Set if the SS input becomes low while the SPI is configured as a master with mode fault detection enabled[cite: 78]. |

### SPI Data Register (Address `0x5`)

[cite_start]This register is used to write data for transmission and read received data[cite: 79]. [cite_start]The reset value is `8'b0000 0000`[cite: 81].

---

## Data Reception and Transmission

[cite_start]The SPI Core transmits data received from the APB Bus and receives data onto the bus[cite: 92, 94]. [cite_start]The transfer process follows this sequence[cite: 95]:

1.  [cite_start]**Data Loading:** Data is written into the SPI data register via the APB Bus[cite: 96].
2.  [cite_start]**SS Activation:** The slave select (SS) signal is driven low to start communication[cite: 97].
3.  [cite_start]**Clock Generation:** The SPI Core generates the SCLK based on the CPHA and CPOL settings[cite: 98].
4.  [cite_start]**Data Transmission:** Data is shifted out through the MOSI line and received through the MISO line on the clock edges[cite: 99].
5.  [cite_start]**Transfer Completion:** The SS signal is driven high, and the clock generation stops, ending the transfer[cite: 100].

---

## Signal Descriptions

### Top Module Signals

[cite_start]These are the primary I/O signals for the integrated SPI core[cite: 136].

| Signal              | Width | Direction | Signal Description                                                                |
| :------------------ | :---- | :-------- | :-------------------------------------------------------------------------------- |
| `PCLK`              | 1     | Input     | Clock signal. [cite_start]All signals are timed against the rising edge of PCLK[cite: 136].       |
| `PRESET_n`          | 1     | Input     | [cite_start]Active Low Asynchronous Reset Signal[cite: 136].                                     |
| `PADDR_i`           | 3     | Input     | [cite_start]Address bus for APB[cite: 136].                                                     |
| `PSEL_i`            | 1     | Input     | [cite_start]APB Slave Select Signal[cite: 136].                                                 |
| `PENABLE_i`         | 1     | Input     | [cite_start]Indicates the second and subsequent cycles of an APB transfer[cite: 136].         |
| `PWRITE_i`          | 1     | Input     | [cite_start]Indicates an APB write (High) or read (Low) access[cite: 136].                   |
| `PWDATA_i`          | 8     | Input     | [cite_start]The APB write data bus[cite: 136].                                                  |
| `PRDATA_o`          | 8     | Output    | [cite_start]The APB read data bus[cite: 136].                                                   |
| `PREADY_o`          | 1     | Output    | [cite_start]Used to extend an APB Transfer[cite: 136].                                          |
| `PSLVERR_o`         | 1     | Output    | [cite_start]Used to indicate a transfer error[cite: 136].                                       |
| `mosi_o`            | 1     | Output    | [cite_start]Master Out Slave In data line[cite: 136].                                           |
| `miso_i`            | 1     | Input     | [cite_start]Master In Slave Out data line[cite: 136].                                           |
| `ss_o`              | 1     | Output    | [cite_start]Active-low Slave Select signal[cite: 136].                                          |
| `sclk_o`            | 1     | Output    | [cite_start]Serial Clock output[cite: 136].                                                     |
| `spi_interrupt_request_o` | 1     | Output    | [cite_start]SPI Interrupt Request[cite: 136].                                               |

### Baud Rate Generator Signals

| Signal                  | Width | Direction | Signal Description                                                                          |
| :---------------------- | :---- | :-------- | :------------------------------------------------------------------------------------------ |
| `PCLK`                  | 1     | Input     | [cite_start]System Clock[cite: 191].                                                                     |
| `PRESET_n`              | 1     | Input     | [cite_start]Active Low Asynchronous Reset Signal[cite: 191].                                             |
| `cpol_i`                | 1     | Input     | [cite_start]Clock Polarity[cite: 191].                                                                   |
| `spiswai_i`             | 1     | Input     | [cite_start]SPI Stop in Wait Mode[cite: 191].                                                            |
| `spi_mode_i`            | 2     | Input     | [cite_start]SPI Mode (Run, Wait, Stop)[cite: 191].                                                       |
| `spr_i`                 | 3     | Input     | [cite_start]SPI Baud Rate Selection Bits[cite: 191].                                                     |
| `sppr_i`                | 3     | Input     | [cite_start]SPI Baud Rate Preselection Bits[cite: 191].                                                  |
| `ss_i`                  | 1     | Input     | [cite_start]Slave Select Active Low Signal[cite: 191].                                                   |
| `sclk_o`                | 1     | Output    | [cite_start]Serial Clock[cite: 191].                                                                     |
| `BaudRateDivisor_o`     | 12    | Output    | [cite_start]Baud Rate Divisor value[cite: 191].                                                          |
| `cpha_i`                | 1     | Input     | [cite_start]Clock Phase[cite: 191].                                                                      |
| `miso_receive_sclk_o`   | 1     | Output    | [cite_start]Flag to receive MISO data when CPOL and CPHA are the same[cite: 191].                          |
| `miso_receive_sclk0_o`  | 1     | Output    | [cite_start]Flag to receive MISO data when CPOL and CPHA are different[cite: 191].                         |
| `mosi_send_sclk_o`      | 1     | Output    | [cite_start]Flag to send MOSI data when CPOL and CPHA are the same[cite: 191].                             |
| `mosi_send_sclk0_o`     | 1     | Output    | [cite_start]Flag to send MOSI data when CPOL and CPHA are different[cite: 191].                            |

### SPI Slave Select Generator Signals

| Signal              | Width | Direction | Signal Description                           |
| :------------------ | :---- | :-------- | :------------------------------------------- |
| `PCLK`              | 1     | Input     | [cite_start]System Clock[cite: 332].                        |
| `PRESET_n`          | 1     | Input     | [cite_start]Active Low Asynchronous Reset Signal[cite: 332].  |
| `mstr_i`            | 1     | Input     | [cite_start]SPI is in Master Mode[cite: 332].               |
| `send_data_i`       | 1     | Input     | [cite_start]Send Data from Data Register[cite: 332].        |
| `spiswai_i`         | 1     | Input     | [cite_start]SPI Stop in Wait Mode[cite: 332].               |
| `spi_mode_i`        | 2     | Input     | [cite_start]SPI Mode (Run, Wait, Stop)[cite: 332].          |
| `ss_o`              | 1     | Output    | [cite_start]Slave Select Active Low Signal[cite: 332].      |
| `BaudRateDivisor_i` | 12    | Input     | [cite_start]Baud Rate Divisor value[cite: 332].             |
| `tip_o`             | 1     | Output    | [cite_start]Transfer In Progress[cite: 332].                |
| `receive_data_o`    | 1     | Output    | [cite_start]Receive Data to Data Register[cite: 332].       |

### SPI APB Slave Interface Signals

| Signal                  | Width | Direction | Signal Description                                                  |
| :---------------------- | :---- | :-------- | :------------------------------------------------------------------ |
| `PCLK`                  | 1     | Input     | [cite_start]System Clock[cite: 417].                                             |
| `PRESET_n`              | 1     | Input     | [cite_start]Active Low Asynchronous Reset Signal[cite: 417].                       |
| `PADDR_i`               | 3     | Input     | [cite_start]APB Address bus[cite: 417].                                          |
| `PSEL_i`                | 1     | Input     | [cite_start]APB Slave Select Signal[cite: 417].                                  |
| `PENABLE_i`             | 1     | Input     | [cite_start]Indicates subsequent APB transfer cycles[cite: 417].                 |
| `PWRITE_i`              | 1     | Input     | [cite_start]Indicates Write (1) or Read (0)[cite: 417].                        |
| `PWDATA_i`              | 8     | Input     | [cite_start]The write data bus[cite: 417].                                       |
| `PRDATA_o`              | 8     | Output    | [cite_start]The read data bus[cite: 417].                                        |
| `PREADY_o`              | 1     | Output    | [cite_start]Extends an APB Transfer[cite: 417].                                  |
| `PSLVERR_o`             | 1     | Output    | [cite_start]Indicates Transfer Error[cite: 417].                                 |
| `ss_i`                  | 1     | Input     | [cite_start]Slave Select (Active Low Signal)[cite: 417].                         |
| `spi_interrupt_request_o` | 1     | Output    | [cite_start]SPI Interrupt Request[cite: 417].                                    |
| `receive_data_i`        | 1     | Input     | [cite_start]Indicates MISO data transfer from Shifter to Data Register[cite: 421]. |
| `miso_data_i`           | 8     | Input     | [cite_start]MISO Data from shift register[cite: 421].                            |
| `tip_i`                 | 1     | Input     | [cite_start]Transfer In Progress[cite: 421].                                     |
| `send_data_o`           | 1     | Output    | [cite_start]Indicates data transfer from Data Register to Shifter[cite: 421].      |
| `mstr_o`                | 1     | Output    | [cite_start]Indicates Master (1) or Slave (0)[cite: 421].                      |
| `cpol_o`                | 1     | Output    | [cite_start]Clock Polarity[cite: 421].                                           |
| `cpha_o`                | 1     | Output    | [cite_start]Clock Phase[cite: 421].                                              |
| `lsbfe_o`               | 1     | Output    | [cite_start]LSB First Enable[cite: 421].                                         |
| `spiswai_o`             | 1     | Output    | [cite_start]SPI Stop in Wait Mode[cite: 421].                                    |
| `mosi_data_o`           | 8     | Output    | [cite_start]MOSI Data from Data Register to Shift Register[cite: 421].           |
| `spi_mode_o`            | 2     | Output    | [cite_start]SPI Mode (Run, Wait, Stop)[cite: 421].                             |
| `spr_o`                 | 3     | Output    | [cite_start]SPI Baud Rate Selection Bits[cite: 421].                             |
| `sppr_o`                | 3     | Output    | [cite_start]SPI Baud Rate Preselection Bits[cite: 421].                          |

### SPI Shifter Signals

| Signal                 | Width | Direction | Signal Description                                                            |
| :--------------------- | :---- | :-------- | :---------------------------------------------------------------------------- |
| `PCLK`                 | 1     | Input     | [cite_start]APB Clock[cite: 605].                                                          |
| `PRESET_n`             | 1     | Input     | [cite_start]Active Low Asynchronous Reset Signal[cite: 605].                               |
| `ss_i`                 | 1     | Input     | [cite_start]Slave Select (Active Low)[cite: 605].                                          |
| `send_data_i`          | 1     | Input     | [cite_start]Indicates data transfer from data register to shifter register[cite: 605].     |
| `lsbfe_i`              | 1     | Input     | [cite_start]LSB First Enable[cite: 605].                                                   |
| `cpha_i`               | 1     | Input     | [cite_start]Clock Phase[cite: 605].                                                        |
| `cpol_i`               | 1     | Input     | [cite_start]Clock Polarity[cite: 605].                                                     |
| `miso_receive_sclk_i`  | 1     | Input     | [cite_start]Flag to receive MISO data when CPHA and CPOL are the same[cite: 605].            |
| `miso_receive_sclk0_i` | 1     | Input     | [cite_start]Flag to receive MISO data when CPHA and CPOL are different[cite: 605].         |
| `mosi_send_sclk_i`     | 1     | Input     | [cite_start]Flag to send MOSI data when CPHA and CPOL are the same[cite: 605].             |
| `mosi_send_sclk0_i`    | 1     | Input     | [cite_start]Flag to send MOSI data when CPHA and CPOL are different[cite: 605].            |
| `data_mosi_i`          | 8     | Input     | [cite_start]MOSI data from Data Register to Shift Register[cite: 605].                     |
| `miso_i`               | 1     | Input     | [cite_start]Master In Slave Out data line[cite: 605].                                      |
| `receive_data_i`       | 1     | Input     | [cite_start]Indicates data transfer from Shifter register to data register[cite: 605].     |
| `mosi_o`               | 1     | Output    | [cite_start]Master Out Slave In data line[cite: 605].                                      |
| `data_miso_o`          | 8     | Output    | [cite_start]MISO data from shift register[cite: 605].                                      |

---

## Baud Rate Calculation

The baud rate of the SCLK is determined by the system clock (`PCLK`) and the Baud Rate Divisor.

[cite_start]The **Baud Rate Divisor** is calculated using the `SPPR` and `SPR` values from the SPI Baud Rate Register with the following equation[cite: 161, 162]:

$$\text{Baud Rate Divisor} = (SPPR + 1) \times 2^{(SPR + 1)}$$

[cite_start]The final **Baud Rate** is then calculated as[cite: 163, 164]:

$$\text{Baud Rate} = \frac{\text{PCLK}}{\text{Baud Rate Divisor}}$$

---

## Finite State Machines (FSM)

The core's operation is managed by two main FSMs.


### SPI Mode FSM

This FSM controls the operational mode of the SPI peripheral.
* [cite_start]**States:** `spi_run`, `spi_wait`, `spi_stop`[cite: 441].
* **Transitions:**
    * [cite_start]`spi_run` to `spi_wait` occurs when `spe` is low[cite: 450].
    * [cite_start]`spi_wait` to `spi_run` occurs when `spe` is high[cite: 451, 454].
    * [cite_start]`spi_wait` to `spi_stop` occurs when `spiswai` is high[cite: 457].
    * [cite_start]`spi_stop` to `spi_wait` occurs when `spiswai` is low[cite: 459].

### APB Interface FSM

This FSM manages transactions on the APB slave interface.
* [cite_start]**States:** `IDLE`, `SETUP`, `ENABLE`[cite: 439].
* **Transitions:**
    * [cite_start]`IDLE` to `SETUP` when `PSEL` is high and `PENABLE` is low[cite: 452].
    * [cite_start]`SETUP` to `ENABLE` when `PSEL` and `PENABLE` are high[cite: 458].
    * [cite_start]`SETUP` to `IDLE` when `PSEL` is low[cite: 453].
    * [cite_start]`ENABLE` to `SETUP` when `PSEL` is high and `PENABLE` is low[cite: 460].
    * `ENABLE` to `IDLE` when `PSEL` is low.
