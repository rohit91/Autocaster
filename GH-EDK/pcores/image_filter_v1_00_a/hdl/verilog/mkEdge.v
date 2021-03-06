//
// Generated by Bluespec Compiler, version 2012.01.A (build 26572, 2012-01-17)
//
// On Tue Aug 20 14:21:11 BST 2013
//
// Method conflict info:
// Method: filter
// Conflict-free: hsync, vde
// Sequenced before (restricted): bin_out
// Conflicts: filter
//
// Method: bin_out
// Conflict-free: bin_out, hsync
// Sequenced after (restricted): filter, vde
//
// Method: hsync
// Conflict-free: filter, bin_out, vde
// Conflicts: hsync
//
// Method: vde
// Conflict-free: filter, hsync
// Sequenced before (restricted): bin_out
// Conflicts: vde
//
//
// Ports:
// Name                         I/O  size props
// bin_out                        O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// bin_in                         I     1
// hsync                          I     1
// vde                            I     1
//
// Combinational paths from inputs to outputs:
//   (bin_in, vde) -> bin_out
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
`define BSV_ASSIGNMENT_DELAY
`endif

module mkEdge(CLK,
	      RST_N,

	      bin_in,

	      bin_out,

	      hsync,

	      vde);
  input  CLK;
  input  RST_N;

  // action method filter
  input  bin_in;

  // value method bin_out
  output bin_out;

  // action method hsync
  input  hsync;

  // action method vde
  input  vde;

  // signals for module outputs
  wire bin_out;

  // inlined wires
  wire filtered$wget, filtered$whas;

  // register lastRow
  reg [639 : 0] lastRow;
  wire [639 : 0] lastRow$D_IN;
  wire lastRow$EN;

  // register ready
  reg ready;
  wire ready$D_IN, ready$EN;

  // register working
  reg working;
  wire working$D_IN, working$EN;

  // register x
  reg [10 : 0] x;
  wire [10 : 0] x$D_IN;
  wire x$EN;

  // rule scheduling signals
  wire WILL_FIRE_RL_new_pixel, WILL_FIRE_RL_no_filter;

  // inputs to muxes for submodule ports
  wire [10 : 0] MUX_x$write_1__VAL_1;
  wire MUX_filtered$wset_1__SEL_2, MUX_filtered$wset_1__VAL_2;

  // remaining internal signals
  wire [639 : 0] x__h672, y__h720;
  wire [10 : 0] x__h648;
  wire x__h613, y__h614;

  // value method bin_out
  assign bin_out = filtered$whas && filtered$wget ;

  // rule RL_no_filter
  assign WILL_FIRE_RL_no_filter = ready && !working ;

  // rule RL_new_pixel
  assign WILL_FIRE_RL_new_pixel = vde && !hsync && ready ;

  // inputs to muxes for submodule ports
  assign MUX_filtered$wset_1__SEL_2 = vde && ready && working ;
  assign MUX_filtered$wset_1__VAL_2 = x__h613 & y__h614 ;
  assign MUX_x$write_1__VAL_1 = x + 11'd1 ;

  // inlined wires
  assign filtered$wget =
	     WILL_FIRE_RL_no_filter ? bin_in : MUX_filtered$wset_1__VAL_2 ;
  assign filtered$whas = WILL_FIRE_RL_no_filter || vde && ready && working ;

  // register lastRow
  assign lastRow$D_IN = bin_in ? lastRow | x__h672 : lastRow & y__h720 ;
  assign lastRow$EN = MUX_filtered$wset_1__SEL_2 ;

  // register ready
  assign ready$D_IN = 1'd1 ;
  assign ready$EN = hsync && !ready ;

  // register working
  assign working$D_IN = x != 11'd960 ;
  assign working$EN = x == 11'd960 || x == 11'd320 ;

  // register x
  assign x$D_IN = WILL_FIRE_RL_new_pixel ? MUX_x$write_1__VAL_1 : 11'd0 ;
  assign x$EN = WILL_FIRE_RL_new_pixel || hsync && x != 11'd0 && ready ;

  // remaining internal signals
  assign x__h613 = lastRow[x__h648[9:0]] ;
  assign x__h648 = x - 11'd320 ;
  assign x__h672 = 640'd1 << x__h648 ;
  assign y__h614 = ~bin_in ;
  assign y__h720 = ~x__h672 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (!RST_N)
      begin
        lastRow <= `BSV_ASSIGNMENT_DELAY 640'd0;
	ready <= `BSV_ASSIGNMENT_DELAY 1'd0;
	working <= `BSV_ASSIGNMENT_DELAY 1'd0;
	x <= `BSV_ASSIGNMENT_DELAY 11'd0;
      end
    else
      begin
        if (lastRow$EN) lastRow <= `BSV_ASSIGNMENT_DELAY lastRow$D_IN;
	if (ready$EN) ready <= `BSV_ASSIGNMENT_DELAY ready$D_IN;
	if (working$EN) working <= `BSV_ASSIGNMENT_DELAY working$D_IN;
	if (x$EN) x <= `BSV_ASSIGNMENT_DELAY x$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    lastRow =
	640'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    ready = 1'h0;
    working = 1'h0;
    x = 11'h2AA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkEdge

