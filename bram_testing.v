`timescale 1ns / 1ps

module bram_testing;

reg aclk, aresetn;
reg awvalid; 
reg [15:0] awaddr;
wire awready;
reg wvalid;
reg [31:0] wdata;
wire wready;
wire bvalid;
reg bready;
wire [1:0] bresp;
reg arvalid;
wire arready;
reg [15:0] araddr;
reg rvalid;
wire rready;
wire [31:0] rdata;
wire [1:0] rresp;

wire [31:0] loc = myram.RAM[awaddr];
wire [2:0] state = myram.ram_PS;
wire [15:0] int_awaddr = myram.awaddr, int_araddr = myram.araddr;
wire [31:0] int_wdata = myram.wdata;

axi_bram myram(.s_aresetn(aresetn),
               .s_aclk(aclk),
               .s_axi_awvalid(awvalid),
               .s_axi_awready(awready),
               .s_axi_awaddr(awaddr),
               .s_axi_wvalid(wvalid),
               .s_axi_wready(wready),
               .s_axi_wdata(wdata),
               .s_axi_bready(bready),
               .s_axi_bvalid(bvalid),
               .s_axi_bresp(bresp),
               .s_axi_arready(arready),
               .s_axi_arvalid(arvalid),
               .s_axi_araddr(araddr),
               .s_axi_rvalid(rvalid),
               .s_axi_rready(rready),
               .s_axi_rresp(rresp),
               .s_axi_rdata(rdata));

initial
begin
    aclk = 0;
    forever #1 aclk = ~aclk;
end

initial
begin
    #2.5 aresetn = 0;
    #2 aresetn = 1; awvalid  = 0;

    //Performing Two Write Operations to memory
    #10 awvalid = 1; awaddr = 16'h0001;
    #4 wvalid = 1; wdata = 32'h0000000A; awvalid = 0;
    #6 bready = 1; wvalid = 0;
    #4 bready = 0;
    #2 awvalid = 1; awaddr = 16'hAA0F; 
    #2 wvalid = 1; wdata = 32'h110A0FB9; awvalid = 0;
    #2 bready = 1; wvalid = 0;
    #2 bready = 0;
    //Reading back the data written in the previous write operations
    #4 arvalid = 1; araddr = 16'hAA0F;
    #20 rvalid = 1;
    #10 $finish;
end
endmodule
