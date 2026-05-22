# Verilog-Coverage-Testbench

A comprehensive Verilog testbench framework for code coverage analysis using QuestaSim. Includes automated test execution, coverage report generation, and test result summarization. Designed as a reusable template for Verilog simulation projects.

---

## 🚀 Quick Start

### 1. Run Tests with Coverage

```bash
cd sim/
./run.csh              # Run all testcases with coverage
./report.csh           # Generate summary report
```

### 2. View Results

```bash
cat rep.log            # Quick summary
cat coverage/summary_report.txt    # Detailed coverage report
```

---

## 📁 Project Structure

```
.
├── rtl/                    # RTL design files
│   └── top.v             # XOR gate design
├── tb/                     # Testbench
│   └── testbench.v       # Main testbench module
├── testcases/            # Test stimuli
│   ├── onerun.v          # Test scenario 1
│   └── tworun.v          # Test scenario 2
├── sim/                   # Simulation environment
│   ├── Makefile          # Build automation
│   ├── compile.f         # Compilation file list
│   ├── pat.list          # Testcase list
│   ├── run.csh           # Test runner script
│   └── report.csh        # Coverage report generator
└── README.md
```

---

## 🔧 Tools Required

| Tool | Version | Purpose |
|------|---------|---------|
| QuestaSim | 10.7c | Verilog simulation & coverage |
| GNU Make | - | Build automation |
| Bash/C-shell | - | Scripting |

---

## 🎓 What You'll Learn

This project provides **foundational knowledge** in Verilog simulation and testing:

- **Verilog Testbench Basics**: Writing stimulus files, module instantiation, and test verification
- **QuestaSim Fundamentals**: Compilation, simulation, and waveform analysis workflows
- **Code Coverage Concepts**: Understanding coverage metrics (blocks, conditions, statements) and measurement techniques
- **Test Automation**: Automating multi-testcase execution using Make and shell scripts
- **Coverage Analysis**: Generating and interpreting coverage reports to identify untested code
- **Test Organization**: Structuring testcases, logs, and reports for systematic verification

*Note: This is a **basic, educational framework** designed to teach core simulation concepts. Production environments may require more advanced features (formal verification, protocol compliance, performance analysis, etc.).*

---

## 📊 Available Commands

### Makefile

```bash
make all           # Build + Run simulation
make all_cov       # Build + Run with coverage
make build         # Compile design
make build_cov     # Compile with coverage instrumentation
make run           # Run simulation
make run_cov       # Run with coverage tracking
make gen_cov       # Generate text coverage report
make clean         # Clean all generated files
```

### Scripts

```bash
./run.csh          # Run all testcases with coverage
./run.csh no-cov   # Run without coverage (faster)
./report.csh       # Generate test summary report
```

---

## 🎯 Coverage Results

Testbench achieves **100% code coverage** by testing all input combinations:

| Test | Inputs | Expected | Status |
|------|--------|----------|--------|
| Test 1 | a=0, b=0 | z=0 | PASS |
| Test 2 | a=0, b=1 | z=1 | PASS |
| Test 3 | a=1, b=0 | z=1 | PASS |
| Test 4 | a=1, b=1 | z=0 | PASS |

*(Example: XOR gate. Customize test scenarios for your design.)*

---

## 📈 Output Files

- `log/` - Simulation logs for each testcase
- `coverage/` - Coverage reports (text format)
- `rep.log` - Test summary report
- `covhtmlreport/` - HTML coverage visualization (optional)

---

## 🚀 Adding New Testcases

1. **Create test file** in `testcases/mytest.v`
2. **Add to `pat.list`**: echo "mytest" >> sim/pat.list  
3. **Run**: `./run.csh`

---

## 📚 For Detailed Setup Instructions

See [SETUP.md](SETUP.md)

---

**Last Updated:** May 2026
