//UART_tx
module uart_tx
   #(
     parameter DBIT = 8,     // # DATA bits
               SB_TICK = 16  // # ticks for STOP bits
   )
   (
    input wire clk, reset,
    input wire tx_START, s_tick, 
    input wire [7:0] din,
    output reg tx_done_tick,
	 //output reg tx_parity,
    output wire tx
   );

   // symbolic state declaration
   localparam [2:0]
      IDLE  = 3'b000,
      START = 3'b001,
      DATA  = 3'b010,
      PARITY = 3'b100,
		STOP  = 3'b011;

   // signal declaration
   reg [1:0] state_reg, state_next;
   reg [3:0] s_reg, s_next;
   reg [2:0] n_reg, n_next;
   reg [7:0] b_reg, b_next;
   reg tx_reg, tx_next;
	reg p_reg, p_next;

   // body
   // FSMD state & DATA registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
            tx_reg <= 1'b1;
				p_reg <= 0;
         end
      else
         begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
            tx_reg <= tx_next;
				p_reg <= p_next;
         end

   // FSMD next-state logic & functional units
   always @*
   begin
      state_next = state_reg;
      tx_done_tick = 1'b0;
      s_next = s_reg;
      n_next = n_reg;
      b_next = b_reg;
      tx_next = tx_reg;
	 p_next = p_reg;
	//	tx_parity = 0; // instantiate output
      case (state_reg)
         IDLE:
            begin
               tx_next = 1'b1;
               if (tx_START)
                  begin
                     state_next = START;
                     s_next = 0;
                     b_next = din;
                  end
            end
         START:
            begin
               tx_next = 1'b0;
               if (s_tick)
                  if (s_reg==15)
                     begin
                        state_next = PARITY;
                        s_next = 0;
                        n_next = 0;
				   p_next = 0;
                     end
                  else
                     s_next = s_reg + 1;
            end
         DATA:
            begin
               tx_next = b_reg[0];
					if(tx_reg)
						p_next = p_reg + 1; //update parity bit
               if (s_tick)
                  if (s_reg==15)
                     begin
                        s_next = 0;
                        b_next = b_reg >> 1;
                        if (n_reg==(DBIT-1))
                           state_next = STOP ;
                        else
                           n_next = n_reg + 1;
                     end
                  else
                     s_next = s_reg + 1;
            end
			PARITY:
				begin 
					tx_next = p_reg;
			//		tx_parity = p_reg;
					if(s_tick)
						begin 
							if (s_reg == 15)
								begin
									s_next = 0;
									state_next = STOP;
								end
							else
								s_next = s_reg + 1;
						end
				end
         STOP:
            begin
               tx_next = 1'b1;
               if (s_tick)
                  if (s_reg==(SB_TICK-1))
                     begin
                        state_next = IDLE;
                        tx_done_tick = 1'b1;
                     end
                  else
                     s_next = s_reg + 1;
            end
			default: state_next = IDLE;
      endcase
   end
   // output
	
   assign tx = tx_reg;

endmodule