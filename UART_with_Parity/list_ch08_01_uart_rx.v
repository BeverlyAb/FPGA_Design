//Listing 8.1
module uart_rx
   #(
     parameter DBIT = 8,     // # DATA bits
               SB_TICK = 16  // # ticks for STOP bits
   )
   (
    input wire clk, reset,
    input wire rx, s_tick,
    output reg rx_done_tick,
	 output wire error,		// 0 - even # of 1's, 1 - odd #of 1's
    output wire [7:0] dout
   );

   // symbolic state declaration
   localparam [2:0]
      IDLE  = 3'b000,
      START = 3'b001,
      DATA  = 3'b010,
      PARITY = 3'b100;
		STOP  = 3'b011;
		
   // signal declaration
   reg [1:0] state_reg, state_next;
   reg [3:0] s_reg, s_next;
   reg [2:0] n_reg, n_next;
   reg [7:0] b_reg, b_next;
	reg p_reg, p_next;	//rolling values, between 0 and 1
	reg trans_parity;		// 0 - even # of 1's, 1 - odd # of 1's

   // body
   // FSMD state & DATA registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
				p_reg <= 0;
         end
      else
         begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
				p_reg <= p_next;
         end

   // FSMD next-state logic
   always @*
   begin
      state_next = state_reg;
      rx_done_tick = 1'b0;
      s_next = s_reg;
      n_next = n_reg;
      b_next = b_reg;
      case (state_reg)
         IDLE:
            if (~rx)
               begin
                  state_next = START;
                  s_next = 0;
               end
         START:
            if (s_tick)
               if (s_reg==7)
                  begin
                     state_next = DATA;
                     s_next = 0;
                     n_next = 0;
                  end
               else
                  s_next = s_reg + 1;
         DATA:
            if (s_tick)
               if (s_reg==15)
                  begin
                     s_next = 0;
                     b_next = {rx, b_reg[7:1]};
							if(rx)
								p_next = p_reg + 1;
                     if (n_reg==(DBIT-1))
                        state_next = PARITY ;
                      else
                        n_next = n_reg + 1;
                   end
               else
                  s_next = s_reg + 1;
			PARITY:
				if(s_tick)
					if(s_reg ==15)
						begin
							s_next = 0;
							trans_parity = rx;
							state_next = STOP;
						end
					else
						s_next = s_reg + 1;
         STOP:
            if (s_tick)
               if (s_reg==(SB_TICK-1))
                  begin
                     state_next = IDLE;
                     rx_done_tick =1'b1;
                  end
               else
                  s_next = s_reg + 1;
      endcase
   end
   // output
   assign dout = b_reg;
	assign error = (p_reg  == trans_parity) ? 0 : 1; //1 - parity mismatch, 0 parity match
endmodule