`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2019 14:10:52
// Design Name: 
// Module Name: mem_ctl_next_state
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_ctl_next_state(
    input din_valid,
    input wen,
    input dout_ack,
    input mem_done,
    
    input din_ack,
    input dout_valid,
    input mem_write,
    input mem_read,
    input anti_glitch,
    
    output reg din_ack_nxt,
    output reg dout_valid_nxt,
    output reg mem_write_nxt,
    output reg mem_read_nxt,
    output reg anti_glitch_nxt
    );
    
    always @*
    begin
        case({wen, din_valid, dout_ack, mem_done, mem_write, mem_read, din_ack, dout_valid, anti_glitch})
        /*IDLE*/
	9'b0000_0000_0: 
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end   
	9'b1000_0000_0: 
	/*W0*/
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end   
	/*W1*/
        9'b1100_0000_0: 
        begin
            mem_write_nxt = 1;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end   
	/*W2*/
        9'b1100_1000_0: 
        begin
            mem_write_nxt = 1;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end   
        /* TRANSIENT */
        9'b1101_1000_0:
        begin
            mem_write_nxt = 1;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end    
        /*W3*/    
        9'b1101_1000_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end    
        /*W4*/    
        9'b1101_0000_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end 
        /*W5*/    
        9'b1100_0000_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 1;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end
        /*W6*/    
        9'b1100_0010_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 1;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end
        /*TRANSIENT*/    
        9'b1000_0010_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 1;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end
        /*W7*/    
        9'b1000_0010_0:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end                                              
        
        /*R0*/    
        9'b0100_0000_0:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 1;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end  
        /*R1*/    
        9'b0100_0100_0:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 1;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end  
        /*R2*/    
        9'b0101_0100_0:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 1;
            din_ack_nxt = 0;
            dout_valid_nxt = 1;
            anti_glitch_nxt = 0;
        end
        /*R3*/    
        9'b0101_0101_0:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 1;
            din_ack_nxt = 0;
            dout_valid_nxt = 1;
            anti_glitch_nxt = 0;
        end
        /*TRANSIENT*/
        9'b0111_0101_0:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 1;
            din_ack_nxt = 0;
            dout_valid_nxt = 1;
            anti_glitch_nxt = 1;
        end   
        /*R4*/    
        9'b0111_0101_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 1;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end
        /*R5*/    
        9'b0111_0100_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 1;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end        
        /*R6*/    
        9'b0101_0100_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end  
        /*R7*/    
        9'b0101_0000_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end        
        /*R8*/    
        9'b0100_0000_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 1;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end       
        /*R9*/    
        9'b0100_0010_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 1;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 1;
        end     
	/*TRANSIENT*/    
        9'b0000_0010_1:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 1;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end
        /*R10*/    
        9'b0000_0010_0:
        begin
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;
        end        


     default
        begin       
            mem_write_nxt = 0;
            mem_read_nxt = 0;
            din_ack_nxt = 0;
            dout_valid_nxt = 0;
            anti_glitch_nxt = 0;        
        end
                                                               
        endcase
    
    end
    
endmodule
