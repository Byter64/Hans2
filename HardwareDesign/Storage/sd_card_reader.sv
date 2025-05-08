module sd_card_reader (
  input                               aclk,
  input                               aresetn,
  /*
    * AXI lite slave interfaces
    */
  input  logic [31:0] s_axil_awaddr,
  input  logic [2:0]  s_axil_awprot,
  input  logic        s_axil_awvalid,
  output logic        s_axil_awready,

  input  logic [31:0] s_axil_wdata,
  input  logic [3:0]  s_axil_wstrb,
  input  logic        s_axil_wvalid,
  output logic        s_axil_wready,

  output logic [1:0]  s_axil_bresp,
  output logic        s_axil_bvalid,
  input  logic        s_axil_bready,

  input  logic [31:0] s_axil_araddr,
  input  logic [2:0]  s_axil_arprot,
  input  logic        s_axil_arvalid,
  output logic        s_axil_arready,

  output logic [31:0] s_axil_rdata,
  output logic [1:0]  s_axil_rresp,
  output logic        s_axil_rvalid,
  input  logic        s_axil_rready,
  

  //SD_controller
  input logic miso, // Connect to SD_DAT[0].
  output logic sclk, // Connect to SD_SCK.
  output logic cs, // Connect to SD_DAT[3].
  output logic mosi // Connect to SD_CMD.
              // For SPI mode, SD_DAT[2] and SD_DAT[1] should be held HIGH. 
              // SD_RESET should be held LOW.
);
///////////////////////////////////////////////////////////////////////
  //In and outputs without axi
  //input logic clk;
  logic rst;
  assign rst = ~aresetn;
  //Data needed to be written to and from from axi
  logic read_data;
  logic write_data;

  logic [31:0] data_addr;
  logic [31:0] data_in;
  logic [3:0]  write_mask;

  logic [31:0] data_out;
  logic data_out_valid;
  logic busy;
  logic [31:0] data_addr_write;
  logic [31:0] data_addr_read;

  logic store_read_write_operation = 0; // Read = 1; Write = 0;

  typedef enum logic[31:0] {Initialize, Idle, WaitSDCard, WriteSDCard, ReadSDCard, PerformOperation} ControllerState;
  ControllerState state = Initialize;

  logic [7:0] ram [512];
  logic ram_dirty = '0;
  logic [22:0] tag; 

  assign busy = state != Idle;

  // SD CARD INPUTS/OUTPUTS
  logic sd_card_read = 0; // Read signal for SD card
  logic sd_card_write = 0;
  logic [7:0] sd_card_dout; // data output for read operation
  logic [7:0] sd_card_din; // data input for write operation
  logic sd_card_byte_available; // byte can be read
  logic sd_card_ready_for_next_byte; // byte can be written
  logic sd_card_ready;
  logic [31:0] sd_card_sector_address;
  

  // SD CARD LOGIC
  logic [8:0] byte_counter = 0;

  /////////////////////AXI-LITE/////////////////////
  ///////////////////   AW   /////////////////////
  always_ff @(posedge aclk) begin
      // Logic to determine S_AXIS_AWREADY
      // TODO logik einbauen die stalled wenn nicht in State idle
      s_axil_awready <= (state == Idle);
  end

  always_ff @(posedge aclk) begin
    if (s_axil_awvalid && s_axil_awready) begin //Never add any other conditions. This is likely to break axi
      data_addr_write <= s_axil_awaddr;
    end
  end
  ///////////////////   W    /////////////////////
  always_ff @(posedge aclk) begin
      // Logic to determine S_AXIS_WREADY
      s_axil_wready <= (state == Idle);
  end

  always_ff @(posedge aclk) begin
    write_data <= 0;
    if (s_axil_wvalid && s_axil_wready) begin //Never add any other conditions. This is likely to break axi
      data_in <= s_axil_wdata;
      write_data <= 1;
    end
  end
  ///////////////////  AR    /////////////////////
  always_ff @(posedge aclk) begin
      // Logic to determine S_AXIS_ARREADY
      s_axil_arready <= (state == Idle) && (s_axil_wvalid && s_axil_wready);
  end

  always_ff @(posedge aclk) begin
    read_data <= 0;
    if (s_axil_arvalid && s_axil_arready) begin //Never add any other conditions. This is likely to break axi
      data_addr_read <= s_axil_araddr;
      read_data <= 1;
    end
  end
  ///////////////////   B    /////////////////////
  // just always 00
  logic next_bvalid; //Assign your valid logic to this signal
  logic[1:0] next_bresp; //Assign the data here
  assign next_bvalid = 1;
  assign next_bresp = 0;
  always_ff @(posedge aclk) begin
    if (!aresetn)
      s_axil_bvalid <= 0;
    else if (!s_axil_bvalid || s_axil_bready) begin
      s_axil_bvalid <= next_bvalid;
      end
  end


  always_ff @(posedge aclk) begin
    if (!aresetn)
      s_axil_bresp <= 0;
    else if (!s_axil_bvalid || s_axil_bready)
    begin
      s_axil_bresp <= next_bresp;

      if (!next_bvalid)
        s_axil_bresp <= 0;
    end
  end

  ///////////////////   R    /////////////////////
  logic next_rvalid; //Assign your valid logic to this signal
  logic[31:0] next_rData; //Assign the data here
  assign next_rvalid = data_out_valid;
  assign next_rData = data_out;
  always_ff @(posedge aclk) begin
    if (!aresetn)
      s_axil_rvalid <= 0;
    else if (!s_axil_rvalid || s_axil_rready) begin
      s_axil_rvalid <= next_rvalid;
      end
  end

  always_ff @(posedge aclk) begin
    if (!aresetn)
      s_axil_rdata <= 0;
    else if (!s_axil_rvalid || s_axil_rready)
    begin
      s_axil_rdata <= next_rData;

      if (!next_rvalid)
        s_axil_rdata <= 0;
    end
  end

///////////////////AXI-LITE END///////////////////


  // Connections to sdcontroller
  sd_controller sd1 (
      .cs(cs),
      .mosi(mosi),
      .miso(miso),
      .sclk(sclk),
      .rd(sd_card_read),
      .dout(sd_card_dout),
      .byte_available(sd_card_byte_available),
      .wr(sd_card_write),
      .din(sd_card_din),
      .ready_for_next_byte(sd_card_ready_for_next_byte),
      .ready(sd_card_ready),
      .address(sd_card_sector_address),
      .clk(aclk),
      .reset(rst)
  );

  logic old_sd_card_ready_for_next_byte;
  logic sd_card_ready_for_next_byte_strobe;

  always_ff @(posedge aclk) begin
    old_sd_card_ready_for_next_byte <= sd_card_ready_for_next_byte;
    if(~old_sd_card_ready_for_next_byte && sd_card_ready_for_next_byte) begin
      sd_card_ready_for_next_byte_strobe <= 1;
    end else begin
      sd_card_ready_for_next_byte_strobe <= 0;
    end
  end

  logic old_sd_card_byte_available;
  logic sd_card_byte_available_strobe;

  always_ff @(posedge aclk) begin
    old_sd_card_byte_available <= sd_card_byte_available;
    if(~old_sd_card_byte_available && sd_card_byte_available) begin
      sd_card_byte_available_strobe <= 1;
    end else begin
      sd_card_byte_available_strobe <= 0;
    end
  end

  always_ff @(posedge aclk) begin  
    sd_card_write <= 0;
    sd_card_read <= 0;
    data_out_valid <= 0;
    case (state)
      Initialize: begin
        if(sd_card_ready) begin
          state <= ReadSDCard;
          sd_card_sector_address = '0;
          ram_dirty <= 0;
          sd_card_read <= 1;
          byte_counter <= '0;
        end
      end
      Idle: begin 
        // Hit
        if((tag == data_addr_read[31:9] && read_data) || (tag == data_addr_write[31:9] && write_data)) begin
          // Read data from RAM
          if(read_data) begin
            // TODO Little endian or big endian
            data_out[31:24] <= ram[data_addr_read[8:0] + 3];
            data_out[23:16] <= ram[data_addr_read[8:0] + 2];
            data_out[15:8]  <= ram[data_addr_read[8:0] + 1];
            data_out[7:0]   <= ram[data_addr_read[8:0] + 0];
            data_out_valid <= 1;
          end
          //Write data to RAM, set dirty bit
          else if(write_data) begin
            // TODO Little endian or big endian
            ram_dirty <= 1;
            if(write_mask[3]) ram[data_addr_write[8:0] + 3] <= data_in[31:24];
            if(write_mask[2]) ram[data_addr_write[8:0] + 2] <= data_in[23:16];
            if(write_mask[1]) ram[data_addr_write[8:0] + 1] <= data_in[15:8];
            if(write_mask[0]) ram[data_addr_write[8:0] + 0] <= data_in[7:0];
          end
        end
        // No Hit
        else if(read_data || write_data) begin
          state <= WaitSDCard;
          data_addr <= read_data ? data_addr_read : data_addr_write;
          store_read_write_operation <= read_data;
        end
      end
      WaitSDCard: begin
        sd_card_sector_address <= {data_addr[31:9],9'b0};
        if(sd_card_ready) begin
          // RAM dirty, Write into SD card, Read from SD Card
          if(ram_dirty) begin
            //0,1,2...512
            byte_counter <= '0; 
            state <= WriteSDCard;
            sd_card_write <= '1;
          end
          // RAM not dirty, Read from SD Card
          else begin
            //0,1,2...512
            byte_counter <= '0;
            state <= ReadSDCard;
            sd_card_read <= '1;
          end
        end
      end
      WriteSDCard: begin
        ram_dirty <= 0;
        if(sd_card_ready_for_next_byte_strobe) begin
          byte_counter <= byte_counter + 1;
          sd_card_din <= ram[byte_counter];
        end
        if(&byte_counter) begin
          byte_counter <= byte_counter;
          if(sd_card_ready) begin
            byte_counter <= '0;
            state <= ReadSDCard;
            sd_card_read <= '1;
          end
        end
      end
      ReadSDCard: begin
        tag <= sd_card_sector_address[31:9];
        if(sd_card_byte_available_strobe) begin
          byte_counter <= byte_counter + 1;
          ram[byte_counter] <= sd_card_dout;
        end
        if(&byte_counter) begin
          byte_counter <= byte_counter;
          if(sd_card_ready) begin
            state <= PerformOperation;
          end
        end
      end
      PerformOperation: begin
          if(store_read_write_operation) begin
            // TODO Little endian or big endian
            data_out[31:24] <= ram[data_addr[8:0] + 3];
            data_out[23:16] <= ram[data_addr[8:0] + 2];
            data_out[15:8]  <= ram[data_addr[8:0] + 1];
            data_out[7:0]   <= ram[data_addr[8:0] + 0];
            data_out_valid <= 1;
          end
          //Write data to RAM, set dirty bit
          else begin
            // TODO Little endian or big endian
            ram_dirty <= 1;
            if(write_mask[3]) ram[data_addr[8:0] + 3] <= data_in[31:24];
            if(write_mask[2]) ram[data_addr[8:0] + 2] <= data_in[23:16];
            if(write_mask[1]) ram[data_addr[8:0] + 1] <= data_in[15:8];
            if(write_mask[0]) ram[data_addr[8:0] + 0] <= data_in[7:0];
          end
          state <= Idle;
      end
    endcase
    if (rst) begin
      state <= Initialize;
      sd_card_read <= '0;
      sd_card_write <= '0;
      ram_dirty <= '0;
    end 
  end

endmodule

