// Testcase for 100% coverage with verification
// Tests all input combinations and checks outputs
task runtest();
    begin
    $monitor("%0t a=%b, b=%b, z=%b", $time, a, b, z);

    // Test case 1: a=0, b=0, expected z=0
    a = 0; b = 0;  #10;
    if (z == 0) 
        $display("Test 1 PASS: a=0, b=0, z=%b", z);
    else
        $display("Test 1 FAIL: a=0, b=0, z=%b (expected 0)", z);

    // Test case 2: a=0, b=1, expected z=1
    a = 0; b = 1;  #10;
    if (z == 1) 
        $display("Test 2 PASS: a=0, b=1, z=%b", z);
    else
        $display("Test 2 FAIL: a=0, b=1, z=%b (expected 1)", z);

    // Test case 3: a=1, b=0, expected z=1
    a = 1; b = 0;  #10;
    if (z == 1) 
        $display("Test 3 PASS: a=1, b=0, z=%b", z);
    else
        $display("Test 3 FAIL: a=1, b=0, z=%b (expected 1)", z);

    // Test case 4: a=1, b=1, expected z=0
    a = 1; b = 1;  #10;
    if (z == 0) 
        $display("Test 4 PASS: a=1, b=1, z=%b", z);
    else
        $display("Test 4 FAIL: a=1, b=1, z=%b (expected 0)", z);

    // All tests completed
    $finish;
    end
endtask