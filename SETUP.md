# ⚙️ Setup Instructions

## Prerequisites

- Linux/WSL2
- QuestaSim 10.7c installed
- Verilator (for design rule checking)
- Bash/C-shell
- GUI support (X11/WSLg for waveform viewer)
- Basic Verilog knowledge

---

## 🔧 Initial Setup (One-time)

### 1. Create QuestaSim Tool Wrappers

```bash
# Create bin directory
mkdir -p ~/bin

# Create wrapper scripts for each tool
# Adjust QUESTASIM_PATH to your installation directory

cat > ~/bin/vlib << 'EOF'
#!/bin/bash
QUESTASIM_PATH="<path-to-questasim>/bin"
exec "$QUESTASIM_PATH/vlib.exe" "$@"
EOF

# Repeat for: vmap, vlog, vsim, vcover
for tool in vmap vlog vsim vcover; do
    cat > ~/bin/$tool << 'EOF'
#!/bin/bash
QUESTASIM_PATH="<path-to-questasim>/bin"
exec "$QUESTASIM_PATH/TOOL.exe" "$@"
EOF
    sed -i "s/TOOL/$tool/g" ~/bin/$tool
done

# Make executable
chmod +x ~/bin/{vlib,vmap,vlog,vsim,vcover}

# Add to PATH
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Verify:**
```bash
which vlib vmap vlog vsim vcover
# All should show /home/USER/bin/<tool>

vlib -version  # Should work
```

---

### 2. Setup Project

```bash
# Navigate to project directory
cd <project-dir>/sim

# Make scripts executable
chmod +x run.csh report.csh

# Verify tools are accessible
make help
```

---

## ▶️ Running Tests

### Single Test (No Coverage - Fast)

```bash
cd sim/
make clean
make TESTNAME=onerun all
cat log/onerun.log
```

**Expected:**
```
Test 1 PASS: a=0, b=0, z=0
Test 2 PASS: a=0, b=1, z=1
Test 3 PASS: a=1, b=0, z=1
Test 4 PASS: a=1, b=1, z=0
```

---

### All Tests with Coverage

```bash
cd sim/
./run.csh              # Runs all testcases from pat.list
./report.csh           # Generates summary
cat rep.log            # View summary
```

---

### Run Without Coverage (Faster)

```bash
./run.csh no-cov
```

---

## 📁 Configuration

### pat.list - Testcase List

```
onerun
tworun
# Comments ignored
```

Add testcase names, one per line.

### compile.f - File Compilation Order

```
../rtl/top.v
../tb/testbench.v
```

Order matters: RTL → TB → Tests

---

## 📊 Output Files

| File/Dir | Contents |
|----------|----------|
| `log/` | Simulation logs |
| `coverage/` | Coverage reports (text) |
| `rep.log` | Test summary report |
| `covhtmlreport/` | HTML coverage (if generated) |

---

## 🎯 Common Tasks

### Add New Testcase

1. Create `testcases/newtest.v`:
   ```verilog
   $monitor($time, " a=%b, b=%b, z=%b", a, b, z);
   a = 1; b = 0;  #10;
   if (z == 1) $display("Test PASS");
   else $display("Test FAIL");
   $finish;
   ```

2. Add to `pat.list`:
   ```bash
   echo "newtest" >> pat.list
   ```

3. Run:
   ```bash
   ./run.csh
   ./report.csh
   ```

---

### Modify Design

1. Edit `rtl/top.v`
2. Rebuild:
   ```bash
   make clean
   make build
   ```

---

### View Waveform

```bash
make wave    # Opens GUI if available
```

---

## 🐛 Debugging

### Check Tool Installation

```bash
for cmd in vlib vmap vlog vsim vcover; do
    command -v $cmd && echo "✓ $cmd" || echo "✗ $cmd missing"
done
```

### Compilation Errors

```bash
# Manually compile to see details
cd sim/
vlog -f compile.f
```

### Simulation Issues

```bash
# Check log file
grep -i "error" log/onerun.log
```

---

## 📋 Workflow Summary

```
1. Setup (one-time)
   └─ mkdir -p ~/bin
   └─ Create wrappers for vlib/vmap/vlog/vsim/vcover
   └─ Add to ~/.bashrc

2. Each Run
   ├─ cd sim/
   ├─ ./run.csh
   ├─ ./report.csh
   └─ cat rep.log

3. Cleanup
   └─ make clean
```

---

## ❓ FAQ

**Q: Do I need to setup every time?**  
A: No, wrappers are persistent. One-time setup only.

**Q: How fast is the test?**  
A: ~1s per testcase without coverage, ~5s with coverage.

**Q: Where are results?**  
A: Check `rep.log` for summary, `coverage/` for detailed reports.

**Q: Can I run single test?**  
A: Yes: `make TESTNAME=onerun all_cov`

---

**Setup complete! Ready to test.** ✅
