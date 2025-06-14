module GPU_Pip1 (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[15:0] re_start_x,
    input  logic[15:0] re_start_y,
    input  logic[15:0] re_width,
    input  logic[15:0] re_height,
    
    output logic[15:0] se_x,
    output logic[15:0] se_y,
    output logic se_valid,
    input  logic se_ready
)

enum logic {
    IDLE,
    GENERATING
} State;

State state = IDLE;
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

logic[15:0] x;
logic[15:0] y;
logic[15:0] max_x; //inclusive
logic[15:0] max_y; //incusisve


always_ff @(posedge clk) begin
    case(state)
    IDLE: begin
        re_ready <= 1;
        if (re_handshake) begin
            if (re_width != 0 && re_height != 0) begin
                state <= GENERATING;
                re_ready <= 0;
                se_valid <= 1;
                x <= re_start_x;
                y <= re_start_y;
                max_x <= re_start_x + re_width - 1;
                max_y <= re_start_y + re_height - 1;
            end
        end
    end
    GENERATING: begin
        x <= x + 1;
        
        if(x == max_x)
        begin
            y <= y + 1;
            if(y == max_y) begin
                re_ready <= 1;
                se_valid <= 0;
                state <= IDLE;
            end
        end
    end
    
    if (rst) begin
        state <= IDLE;
        se_valid <= 0;
        re_ready <= 0;
    end
    endcase
end
endmodule

module GPU_Pip2 (
    input logic clk,
    input logic rst,

    input  logic re_valid,
    output logic re_ready,
    input  logic[31:0] re_base_address,
    input  logic[15:0] re_x,
    input  logic[15:0] re_y,
    input  logic[15:0] re_image_width,
    input  logic[15:0] re_height,
    
    output logic[15:0] se_memory_address,
    output logic se_valid,
    input  logic se_ready
);
wire re_handshake = re_valid && re_ready;
wire se_handshake = se_valid && se_ready;

enum logic {
    EMPTY,
    FULL
} State;

State state = EMPTY;

always_ff @(posedge clk) begin
    case (state)
    EMPTY: begin
        if(re_handshake) begin
            se_memory_address <= re_base_address + ((re_x) << 1) + ((re_image_width * re_y) << 1);
            se_valid <= 1;
            re_ready <= 0;
            state <= FULL;
        end
    end
    FULL: begin
        if(se_handshake) begin
            se_valid <= 0;
            re_ready <= 1;
            state <= IDLE;
        end
    end
    endcase

    else if(se_handshake) begin
        se_valid <= 0;
    end

    if(se_handshake || se_valid == 0)
end

endmodule


/*
1. Position generieren
2. Speicheradresse berechnen
3. Pixel lesen
4. (Optional) Color table auflösen
4. Screenpos berechnen
5. Pixelschreiben
*/

/*
Skalieren
Spiegeln
color table

Rechteck zeichnen
Linie zeichnen
*/