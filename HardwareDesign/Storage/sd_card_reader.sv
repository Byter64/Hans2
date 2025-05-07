module sd_card_reader (
  input logic clk,
  input logic rst,

  input logic read_data,
  input logic write_data,

  input logic [31:0] data_addr,
  input logic [31:0] data_in,
  input logic [3:0]  write_mask,

  output logic [31:0] data_out,
  output logic data_out_valid,
  output logic busy,
  

  //SD_controller
  input logic miso, // Connect to SD_DAT[0].
  output logic sclk, // Connect to SD_SCK.
  output logic cs, // Connect to SD_DAT[3].
  output logic mosi // Connect to SD_CMD.
              // For SPI mode, SD_DAT[2] and SD_DAT[1] should be held HIGH. 
              // SD_RESET should be held LOW.
);
///////////////////////////////////////////////////////////////////////

  typedef enum logic[3:0] {Initialize, Idle, WriteSDCard, ReadSDCard, PerformOperation} ControllerState;
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
      .clk(clk),
      .reset(rst)
  );

  logic old_sd_card_ready_for_next_byte;
  logic sd_card_ready_for_next_byte_strobe;

  always_ff @(posedge clk) begin
    old_sd_card_ready_for_next_byte <= sd_card_ready_for_next_byte;
    if(~old_sd_card_ready_for_next_byte && sd_card_ready_for_next_byte) begin
      sd_card_ready_for_next_byte_strobe <= 1;
    end else begin
      sd_card_ready_for_next_byte_strobe <= 0;
    end
  end

  logic old_sd_card_byte_available;
  logic sd_card_byte_available_strobe;

  always_ff @(posedge clk) begin
    old_sd_card_byte_available <= sd_card_byte_available;
    if(~old_sd_card_byte_available && sd_card_byte_available) begin
      sd_card_byte_available_strobe <= 1;
    end else begin
      sd_card_byte_available_strobe <= 0;
    end
  end

  always_ff @(posedge clk) begin  
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
        sd_card_sector_address <= {data_addr[31:9],9'b0}; 
        // Hit
        if(tag == data_addr[31:9]) begin
          // Read data from RAM
          if(read_data) begin
            // TODO Little endian or big endian
            data_out[31:24] <= ram[data_addr[8:0] + 3];
            data_out[23:16] <= ram[data_addr[8:0] + 2];
            data_out[15:8]  <= ram[data_addr[8:0] + 1];
            data_out[7:0]   <= ram[data_addr[8:0] + 0];
            data_out_valid <= 1;
          end
          //Write data to RAM, set dirty bit
          else if(write_data) begin
            // TODO Little endian or big endian
            ram_dirty <= 1;
            if(write_mask[3]) ram[data_addr[8:0] + 3] <= data_in[31:24];
            if(write_mask[2]) ram[data_addr[8:0] + 2] <= data_in[23:16];
            if(write_mask[1]) ram[data_addr[8:0] + 1] <= data_in[15:8];
            if(write_mask[0]) ram[data_addr[8:0] + 0] <= data_in[7:0];
          end
        end
        // No Hit
        else if(sd_card_ready && (read_data || write_data)) begin
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
          if(read_data) begin
            // TODO Little endian or big endian
            data_out[31:24] <= ram[data_addr[8:0] + 3];
            data_out[23:16] <= ram[data_addr[8:0] + 2];
            data_out[15:8]  <= ram[data_addr[8:0] + 1];
            data_out[7:0]   <= ram[data_addr[8:0] + 0];
            data_out_valid <= 1;
          end
          //Write data to RAM, set dirty bit
          else if(write_data) begin
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

