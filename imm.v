module ImmGen (output [31:0] gen_out, input [31:0] inst);
reg[11:0] x;

always@(*) begin
if(inst[6] == 0) begin
    if(inst[5] == 0) begin
        x = inst[31:20];
    end
    else begin
        x = {inst[31:25], inst[11:7]};
    end
end
else begin
    x = {inst[31], inst[7], inst[30:25], inst[11:8]};
end
end

assign gen_out = { {20{x[11]}}, x[11:0]};

endmodule 