// ------------------------------------------------------------------
// VectorPath port list for Ethernet 0
//   Include this file in a design top level module declaration
// ------------------------------------------------------------------


    // Ethernet ff divided clocks
    input  wire                         ethernet_0_m0_ff_clk_divby2,
    input  wire                         ethernet_0_m1_ff_clk_divby2,
    input  wire                         ethernet_0_ref_clk_divby2,

    // Quad MAC 0 flow control 
    input  wire  [3:0]                  ethernet_0_quad0_emac_enable,
    input  wire  [3:0]                  ethernet_0_quad0_emac_pause_en,
    input  wire  [31:0]                 ethernet_0_quad0_emac_pause_on,
    output wire  [31:0]                 ethernet_0_quad0_emac_xoff_gen,
    output wire  [3:0]                  ethernet_0_quad0_lpi_txhold,
    output wire  [3:0]                  ethernet_0_quad0_mac_stop_tx,
    output wire  [3:0]                  ethernet_0_quad0_tx_hold_req,

    // Quad MAC 0 Status 
    input  wire  [3:0]                  ethernet_0_m0_ffe_tx_ovr,
    input  wire  [3:0]                  ethernet_0_m0_ffp_tx_ovr,
    input  wire  [3:0]                  ethernet_0_m0_mac_tx_underflow,

    // Ethernet 0 TSN signals
    output wire  [64  -1:0]             ethernet_0_free_running_counter,
    input  wire  [ 16 -1:0]             ethernet_0_quad0_tx_ts_id,
    input  wire  [  4 -1:0]             ethernet_0_quad0_tx_ts_val,
    input  wire  [256 -1:0]             ethernet_0_quad0_tx_ts,
    output wire  [  4 -1:0]             ethernet_0_quad0_peer_delay_val,
    output wire  [120 -1:0]             ethernet_0_quad0_peer_delay

