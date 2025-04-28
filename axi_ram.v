`timescale 1ns / 1ps

module axi_bram(input wire s_aclk,
                input wire s_aresetn,
                input wire s_axi_awvalid,
                input wire [15:0] s_axi_awaddr,
                output reg s_axi_awready,
                input wire s_axi_wvalid,
                input wire [31:0] s_axi_wdata,
                output reg s_axi_wready,
                input wire [3:0] s_axi_wstrb,
                output reg [1:0] s_axi_bresp,
                input wire s_axi_bready,
                output reg s_axi_bvalid,
                input wire s_axi_arvalid,
                output reg s_axi_arready,
                input wire [15:0] s_axi_araddr,
                input wire s_axi_rvalid,
                output reg s_axi_rready,
                output reg [31:0] s_axi_rdata,
                output reg [1:0] s_axi_rresp);
                
localparam [1:0] addr_ready = 2'b00, write_ready = 2'b01, write = 2'b10, read = 2'b11;

reg [31:0] RAM [65535:0];
reg [2:0] ram_PS, ram_NS;
reg [15:0] awaddr, araddr,awaddr_next,araddr_next;
reg [31:0] wdata,wdata_next;

always @(posedge s_aclk or negedge s_aresetn)
begin
    if (!s_aresetn)
        begin
            ram_PS <= addr_ready;
            ram_NS <= addr_ready;
        end
    else
        ram_PS <= ram_NS;
        awaddr <= awaddr_next;
        araddr <= araddr_next;
        wdata <= wdata_next;
end

always @(*)
begin
    case (ram_PS)
        addr_ready: begin
                    s_axi_awready = 1;
                    s_axi_arready = 1;
                    s_axi_wready = 0;
                    s_axi_rready = 0;
                    s_axi_bvalid = 0;
                    s_axi_rdata = 0;
                    if (s_axi_awready && s_axi_awvalid)
                        begin
                            ram_NS = write_ready;
                            awaddr_next = s_axi_awaddr;
                          end
                    else if (s_axi_arready && s_axi_arvalid && !s_axi_awvalid)
                        begin
                            ram_NS = read;
                            araddr_next = s_axi_araddr;
                          end
                end
       write_ready: begin
                    s_axi_awready = 0;
                    s_axi_arready = 0;
                    s_axi_wready = 1;
                    if (s_axi_wready && s_axi_wvalid)
                        begin
                            ram_NS = write;
                            wdata_next = s_axi_wdata;
                          end
                end
        write: begin
                    s_axi_wready = 0;
                    RAM[awaddr] = wdata;
                    s_axi_bvalid = 1;
                    s_axi_bresp = 2'b00;
                    if (s_axi_bvalid && s_axi_bready)
                        begin
                            ram_NS = addr_ready;
                          end
                end
       read: begin
                    s_axi_arready = 0;
                    s_axi_awready = 0;
                    s_axi_rready = 1;
                    s_axi_rdata = RAM[araddr];
                    s_axi_rresp = 2'b00;
                    if (s_axi_rready && s_axi_rvalid)
                        begin
                            ram_NS = addr_ready;
                          end
                end
    endcase
end

endmodule
