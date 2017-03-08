//Listing 8.5
module uart_test
   (
    input wire clk, reset,
    input wire rx,
    input wire [0:0] btn,
    output wire tx, //error,
    output wire [3:0] an,
    output wire [7:0] sseg, led
   );

   // signal declaration
   wire tx_full, rx_empty, err, btn_tick, rx_partiy, tx_parity;
   wire [7:0] rec_data, rec_data1;

   // body
   // instantiate uart
   uart uart_unit
      (.clk(clk), .reset(reset), .rd_uart(btn_tick),
       .wr_uart(btn_tick), .rx(rx), .w_data(rec_data1),
       .tx_full(tx_full), .rx_empty(rx_empty),.tx_parity(tx_parity),.rx_parity(rx_parity),
       .r_data(rec_data),.error(err), .tx(tx));
   // instantiate debounce circuit
   debounce btn_db_unit
      (.clk(clk), .reset(reset), .sw(btn),
       .db_level(), .db_tick(btn_tick));
   // incremented data loops back
   assign rec_data1 = rec_data + 1;
   // LED display
   assign led = rec_data;
   assign an = 4'b1110;
   assign sseg = {~err, ~tx_full, rx_parity , 1'b1, ~rx_empty, 1'b1, tx_parity,1'b1};

endmodule