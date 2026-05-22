
module testbench;
	reg a, b;
	wire z;
	
	top dut(.a(a), .b(b), .z(z));
	
	`include "run_test.v"
	initial begin
		runtest();
	end
endmodule
