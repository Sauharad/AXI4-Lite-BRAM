# AXI4-Lite-RAM

This is a design of a single port RAM module of width 32 bits and depth 2^16 with an AXI4-Lite based interface. 
AXI4-Lite is a bus protocol that uses five different channels with a valid-ready handshake based mechanism for data transfer transactions.

Write Address (AW) - The write address channel is used to communicate to the slave the address to which the master wishes to write data.
Write Data (W) - The write data channel carries the data which is to be written to the address provided in the AW channel.
Write Response (B) - The write response channel carries the response to the write operation given by the slave back to the master.
Read Address (AR) - The read address channel is used to communicate the address in the slave from which master wishes to read data..
Read Data (R) - The data read from the address in AR channel is sent by the slave to the master over the R channel.
