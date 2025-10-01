##  Linting – APB-SPI Core

This folder contains the **linting setup** for the APB-SPI Core project. Linting is the **first verification step** in a professional hardware design flow. It checks the Verilog RTL for **coding errors, synthesis issues, and best practice violations** before simulation and synthesis.

---

##  What is Linting?

Linting is the *static analysis of HDL source code*. Unlike simulation, it does not run testbenches or apply vectors. Instead, it scans the code against a database of rules to find:

- **Errors** → critical problems that make the RTL unsynthesizable or functionally incorrect (e.g., multiple drivers, implicit latches, undeclared nets).  
- **Warnings** → suspicious constructs that may cause issues in certain conditions (e.g., unused signals, width mismatches, incomplete resets).  
- **Infos** → style recommendations or best practices that improve readability and maintainability.

Fixing lint issues early saves effort later in **simulation, synthesis, and timing closure**. Clean RTL improves project reliability and reduces risk.

---

##  Tool Used

- **Synopsys VC Static (SpyGlass Lint)**  
  Industry-standard static RTL analysis tool.  
  Provides checks for synthesis readiness, coding guidelines, and structural issues.

---

##  Flow Setup

This folder includes:
- **Makefile** → provides `lint` and `clean` targets.  
- **spi.tcl** → TCL script to configure and run lint analysis.  
- **spi_project_report.txt** → generated lint report after running the flow.  

---

###  Makefile

```makefile
clean:
	rm -rf novas* vcst* *.txt
	clear

lint: 
	$(VC_STATIC_HOME)/bin/vc_static_shell -f spi.tcl
````

* `clean` removes previous run results.
* `lint` launches VC Static shell with `spi.tcl`.
* **Note:** Set the environment variable before running (skip this step if already configured in your shell/profile):

  ```bash
  export VC_STATIC_HOME=/path/to/vc_static
  ```

---

###  Lint Script (`spi.tcl`)

```tcl
set search_path "./"
set library_path "./"

set_app_var enable_lint true

configure_lint -setup -goal lint_rtl

analyze -verbose -format verilog "../rtl/*.v"

elaborate top_mod

check_lint

report_lint -verbose -file spi_project_report.txt
```

**Explanation:**

* `search_path`, `library_path` → where to find RTL files.
* `set_app_var enable_lint true` → enable linting engine.
* `configure_lint -setup -goal lint_rtl` → use predefined lint goal for RTL.
* `analyze` → parse all Verilog files in `../rtl/`.
* `elaborate top_mod` → elaborate design starting at `top_mod` (change if your top-level is named differently).
* `check_lint` → run lint checks.
* `report_lint` → generate a detailed text report.

---

##  How to Run

1. **Set environment variable** (skip this step if already configured in your shell/profile):

   ```bash
   export VC_STATIC_HOME=/tools/synopsys/vc_static
   ```

2. **Run lint**:

   ```bash
   make lint
   ```

3. **View the report**:

   ```bash
   vim spi_project_report.txt
   ```

4. **Clean workspace**:

   ```bash
   make clean
   ```

---

##  Interpreting the Report

The file `spi_project_report.txt` will contain:

* **Errors (must fix):**

  * Multiple drivers on one net.
  * Implicit latches due to incomplete assignments.
  * Unconnected or undeclared ports.

* **Warnings (should fix):**

  * Unused signals or registers.
  * Width mismatches.
  * Signals without reset.

* **Infos ( optional):**

  * Style suggestions.
  * Best practice recommendations.

**Fix priority:**

1. Errors → always fix.
2. Warnings → fix unless intentional.
3. Infos → improve when possible.

---

##  Common Fixes

* **Implicit latches:** add default assignments or cover all `if`/`case` branches.
* **Unused signals:** remove them, or comment clearly if reserved.
* **Multiple drivers:** check for conflicting assignments.
* **Width mismatches:** align bus sizes or use casting.
* **Simulation-only code:** wrap with pragmas:

---

### How I Solved the Lint Violation (STARC05-1.3.1.3)
The STARC05-1.3.1.3 violation occurred because the asynchronous reset condition was incomplete. The fix involved ensuring the reset condition correctly sets the initial state for all driven variables.
Key Steps Taken to Resolve the Issue:
 * Identified Missing Assignments: Checked the always @(posedge clk or negedge rst_n) block and found that a sequential variable (reg type), while assigned in the synchronous path, was not explicitly assigned a reset value in the if (!rst_n) block.
 * Root Cause: The lint tool flagged this as improper use (AsyncResetOtherUse) because the reset path did not define the state of the unassigned register.
 * Mandatory Fix Applied: Every single sequential variable driven inside that procedural block was added to the asynchronous reset condition and explicitly assigned to a known value (e.g., 0 or 1).
This ensures the reset path is complete and exclusive, satisfying the STARC05-1.3.1.3 requirement and eliminating the critical lint violation.
---
##  Waivers

Some warnings may be intentional (e.g., reserved bits left unused). In such cases:

* Document the waiver directly in code comments.
* Optionally, maintain a `waivers.txt` file in this folder with:

  ```
  Rule ID: SGML002
  Signal: reserved[3:0]
  Reason: Reserved bits for future use
  ```

---

##  Role in the APB-SPI Project Flow

Linting is the **first step** of the complete flow:

1. **Linting (`lint/`)** → static checks, ensure clean RTL.
2. **Synthesis (`synth/`)** → convert RTL into gate-level netlist.
3. **Simulation (`sim/`)** → functional verification with testbenches.
4. **Coverage (`coverage/`)** → measure completeness of verification using VCS.


Skipping lint may lead to wasted time debugging trivial RTL mistakes during simulation or synthesis.

---

##  Summary

* Run `make lint` to check all RTL files.
* Report saved in `spi_project_report.txt`.
* Fix **Errors** and most **Warnings** before moving to simulation.
* Linting ensures the RTL is **synthesizable, maintainable, and reliable**.

This flow is beginner-friendly: just follow the steps, read the report, fix issues, and repeat until the RTL is clean.


