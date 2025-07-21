module top_ulx3s_sd_mem (
    input  logic        clk_25mhz,
    output logic        sd_clk,
    output logic        sd_cmd,
    inout  logic [3:0]  sd_d,
    output logic [7:0] led
);
  // Clock and reset
  logic rst_n = 0; // Active-low reset
  logic clk;
  logic pll_locked;

  ecp5pll #(
    .in_hz       (25000000),
    .out0_hz     (50000000)
  ) uut_pll (
    .clk_i(clk_25mhz),
    .clk_o(clk),
    .locked(pll_locked)
  );

  // Use the PLL lock signal for a robust reset
  always_ff @(posedge clk) begin
    rst_n <= pll_locked;
  end

  // Tie SD lines for SPI mode
  assign sd_d[1] = 1'b1; // DAT1 must be held HIGH
  assign sd_d[2] = 1'b1; // DAT2 must be held HIGH

  // SD SPI connections
  logic sd_cs, sd_mosi, sd_miso;
  assign sd_miso = sd_d[0];
  assign sd_d[3] = sd_cs;  // DAT3 = Chip Select (CS) in SPI mode
  assign sd_cmd = sd_mosi; // CMD = MOSI in SPI mode

  // AXI-Lite Master signals for controlling the SD card slave
  logic [31:0] awaddr, wdata, araddr;
  logic [3:0]  wstrb;
  logic        awvalid, wvalid, bready, arvalid, rready;
  logic        awready, wready, bvalid, arready, rvalid;
  logic [31:0] rdata;
  
  // Test Sequencer FSM
  // This FSM will write 100 sectors, then read and verify them.
  typedef enum logic [3:0] {
    S_INIT,
    // Write Phase
    S_SETUP_WRITE,
    S_WAIT_WRITE_HANDSHAKE,
    S_WAIT_WRITE_DONE,
    // Read & Verify Phase
    S_SETUP_READ,
    S_WAIT_READ_HANDSHAKE,
    S_WAIT_READ_DATA,
    // Final States
    S_SUCCESS,
    S_ERROR
  } state_t;

  state_t state = S_INIT;
  
  // Use 'integer' for counters that can go > 255. More flexible.
  integer sector_count = 0;
  integer word_count = 0; // Each sector has 128 words (512 bytes / 4 bytes/word)

  // Data pattern to write and verify
  logic [31:0] expected_data;
  assign expected_data = { 8'hA5, sector_count[7:0], word_count[7:0], 8'h5A };


  logic [24:0] slow_clk_counter = 0;
  logic slow_tick;

  always_ff @(posedge clk) begin
      if (slow_clk_counter == 25'd33_554_431) begin
          slow_clk_counter <= 0;
          slow_tick <= 1;
      end else begin
          slow_clk_counter <= slow_clk_counter + 1;
          slow_tick <= 0;
      end
  end

  always_ff @(posedge clk) begin
    if (!rst_n) begin
      state         <= S_INIT;
      awvalid       <= 0;
      wvalid        <= 0;
      bready        <= 0;
      arvalid       <= 0;
      rready        <= 0;
      awaddr        <= 0;
      araddr        <= 0;
      wdata         <= 0;
      wstrb         <= 4'b1111;
      sector_count  <= 0;
      word_count    <= 0;
      led           <= 1; // Turn on one LED to show power
    end else begin
      // Default assignments (to prevent latches)
      awvalid <= 0;
      wvalid  <= 0;
      arvalid <= 0;
      rready  <= 0;
      bready  <= 0;

      case (state)
        S_INIT: begin
          // Wait for sd_card_reader to become ready after reset.
          // A simple delay is sufficient, or wait for a ready signal from the slave.
          // Let's start the write sequence.
          state <= S_SETUP_WRITE;
        end

        // --- WRITE PHASE ---
        S_SETUP_WRITE: begin
          // Show progress: MSB=0 for write phase, lower bits show sector
          led     <= {1'b1, sector_count[6:0]}; 
          
          awvalid <= 1;
          wvalid  <= 1;
          bready  <= 1; // Always be ready to accept the write response
          awaddr  <= sector_count * 512 + word_count * 4;
          wdata   <= expected_data; // Write our known pattern
          
          state   <= S_WAIT_WRITE_HANDSHAKE;
        end

        S_WAIT_WRITE_HANDSHAKE: begin
          led     <= {1'b1, sector_count[6:0]}; 
          awvalid <= 1; // Keep valid high until ready is asserted
          wvalid  <= 1;
          bready  <= 1;

          if (awready && wready) begin
            state   <= S_WAIT_WRITE_DONE;
            awvalid <= 0;
            wvalid  <= 0;
          end
        end
        
        S_WAIT_WRITE_DONE: begin
          led     <= {1'b1, sector_count[6:0]}; 
          bready  <= 1;
          
          if (bvalid) begin
            // Write transaction is complete. Move to the next word/sector.
            if (word_count < 127) begin
              word_count <= word_count + 1;
              state      <= S_SETUP_WRITE; // Next word in same sector
            end else begin
              word_count <= 0; // Reset word count for next sector
              if (sector_count < 99) begin
                sector_count <= sector_count + 1;
                state        <= S_SETUP_WRITE; // Next sector
              end else begin
                // All 100 sectors written. Reset counters and start reading.
                sector_count <= 0;
                word_count   <= 0;
                state        <= S_SETUP_READ;
              end
            end
          end
        end

        // --- READ & VERIFY PHASE ---
        S_SETUP_READ: begin
          // Show progress: MSB=1 for read phase
          led <= {1'b1, sector_count[6:0]};
          
          arvalid <= 1;
          rready  <= 1; // Always be ready to accept read data
          araddr  <= sector_count * 512 + word_count * 4;
          
          state <= S_WAIT_READ_HANDSHAKE;
        end
        
        S_WAIT_READ_HANDSHAKE: begin
          led <= {1'b1, sector_count[6:0]};
          arvalid <= 1;
          rready  <= 1;
          
          if(arready) begin
            arvalid <= 0;
            state <= S_WAIT_READ_DATA;
          end
        end

        S_WAIT_READ_DATA: begin
          led <= {1'b1, sector_count[6:0]};
          rready <= 1;

          if (rvalid) begin
            // Data is ready! Verify it now.
            if (rdata != expected_data) begin
              // MISMATCH! Go to error state.
              state <= S_ERROR;
            end else begin
              // Data matches. Move to the next word/sector.
              if (word_count < 127) begin
                word_count <= word_count + 1;
                state      <= S_SETUP_READ; // Next word
              end else begin
                word_count <= 0;
                if (sector_count < 99) begin
                  sector_count <= sector_count + 1;
                  state        <= S_SETUP_READ; // Next sector
                end else begin
                  // All 100 sectors read and verified successfully!
                  state <= S_SUCCESS;
                end
              end
            end
          end
        end

        S_SUCCESS: begin
          // Light a "good" pattern (e.g., a rotating light)
          if (slow_tick) begin
            led <= {led[6:0], led[7]}; // Rotate the bit
          end
        end

        S_ERROR: begin
          // Light a "bad" pattern (e.g., flashing all LEDs)
          if (slow_tick) begin
            led <= ~led; // Flash all LEDs
          end
        end
      endcase
    end
  end

  // Instantiate your AXI-Lite SD card controller
  // The module name "sd_card_reader" is assumed from your example.
  sd_card_reader sd_inst (
    .aclk             (clk),
    .aresetn          (rst_n),
    // Write Address Channel
    .s_axil_awaddr    (awaddr),
    .s_axil_awprot    (3'b000),
    .s_axil_awvalid   (awvalid),
    .s_axil_awready   (awready),
    // Write Data Channel
    .s_axil_wdata     (wdata),
    .s_axil_wstrb     (wstrb),
    .s_axil_wvalid    (wvalid),
    .s_axil_wready    (wready),
    // Write Response Channel
    .s_axil_bresp     (),
    .s_axil_bvalid    (bvalid),
    .s_axil_bready    (bready),
    // Read Address Channel
    .s_axil_araddr    (araddr),
    .s_axil_arprot    (3'b000),
    .s_axil_arvalid   (arvalid),
    .s_axil_arready   (arready),
    // Read Data Channel
    .s_axil_rdata     (rdata),
    .s_axil_rresp     (),
    .s_axil_rvalid    (rvalid),
    .s_axil_rready    (rready),
    // SD Card Physical Pins
    .miso             (sd_miso),
    .sclk             (sd_clk),
    .cs               (sd_cs),
    .mosi             (sd_mosi)
  );

endmodule