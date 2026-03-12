`include "quadra.vh"

module square
(
    input  x2_t x2,
    output sq_t sq
);
	// TODO: change it to arthmitic shift
    // Compute x2^2:
	logic [33:0] tmp;

	assign tmp = x2 * x2;
    always_comb sq = {12'b0, tmp[33:22]};

endmodule    
