`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2019 13:59:38
// Design Name: 
// Module Name: ctl_tb
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

//Verilog HDL for "RAM_CTL", "mem_ctl_tb" "functional"


module ctl_tb (    
    input din_ack,
    input write,
    input read,
    input dout_valid,
    output reg rst,
    output reg din_valid,
    output reg mem_done,
    output reg dout_ack,
    output reg wen,
    output reg [3:0]test_state );

localparam 
    my_delay= 10,
    //writting states
    W_SET_DIN_VALID   = 4'b0000,
    W_SET_MEM_DONE     = 4'b0001,
    W_CLEAR_MEM_DONE   = 4'b0011,
    W_CLEAR_DIN_VALID  = 4'b0010,
    W_READIN_TRIG      = 4'b0110,
    //reading states
    R_SET_MEM_DONE    = 4'b0111,
    R_SET_DOUT_ACK    = 4'b0101,
    R_CLEAR_DOUT_ACK  = 4'b0100,
    R_CLEAR_MEM_DONE  = 4'b1100,
    R_CLEAR_VALID     = 4'b1101,
    R_FINISH_TESTS    = 4'b1001,
    INVALID_STATE      = 4'b1111;
     
    

//reg test_state;
    
initial
begin
    rst = 1'b1;
    #(2*my_delay);
    rst = 1'b0;
    #my_delay;
    
    $display( "INITIALIZE ALL OUTPUTS WITH 0" );   
    din_valid = 0;
    wen = 0;
    mem_done = 0;
    dout_ack = 0;
    test_state = W_SET_DIN_VALID;


end

always @*

    case(test_state)
    W_SET_DIN_VALID:
    begin
	#my_delay;
	$display( "SET wen 1" );
	din_valid = 0;
	wen = 1;
	mem_done = 0;
	dout_ack = 0;    
	#my_delay;
	$display( "SET din_valid 1" );
	din_valid = 1;
	wen = 1;
	mem_done = 0;
	dout_ack = 0;
	test_state = W_SET_MEM_DONE;
    end
    W_SET_MEM_DONE:
    begin
        if( write == 1'b1 ) begin
            #my_delay mem_done = 1'b1;
            test_state = W_CLEAR_MEM_DONE;
        end
     else 
        begin
            test_state = W_SET_MEM_DONE;
        end
    end
    W_CLEAR_MEM_DONE:
    begin
        if( write == 1'b0 ) begin
            #my_delay mem_done = 1'b0;
            test_state = W_CLEAR_DIN_VALID;
            end
        else 
        begin
            test_state = W_CLEAR_MEM_DONE;
        end
    end
    W_CLEAR_DIN_VALID:
    begin
        if( din_ack == 1'b1 ) begin
            #my_delay din_valid = 1'b0;
            test_state = W_READIN_TRIG;
        end
        else
        begin
            test_state = W_CLEAR_DIN_VALID;
        end
    end
    W_READIN_TRIG:
    begin
        if( din_ack == 1'b0 ) begin
            #my_delay wen = 1'b0;
             $display("WRITTING STOP");
            #my_delay din_valid = 1'b1;
            test_state = R_SET_MEM_DONE;       
        end
        else
        begin
            test_state = W_READIN_TRIG;
        end
    end
    
    R_SET_MEM_DONE:
    begin
        $display("START READING");
        if( read == 1'b1 ) begin
            #my_delay mem_done = 1'b1;
            test_state = R_SET_DOUT_ACK;
        end
        else
        begin
            test_state = R_SET_MEM_DONE;
        end
    end

    R_SET_DOUT_ACK:
    begin
        if( dout_valid == 1'b1 ) begin
            #my_delay dout_ack = 1'b1;
            test_state = R_CLEAR_DOUT_ACK;
        end
        else
        begin
            test_state = R_SET_DOUT_ACK;
        end
    end  

    R_CLEAR_DOUT_ACK:
    begin
        if( dout_valid == 1'b0 ) begin
            #my_delay dout_ack = 1'b0;
            test_state = R_CLEAR_MEM_DONE;
        end
        else
        begin
            test_state = R_CLEAR_DOUT_ACK;
        end
    end  

    R_CLEAR_MEM_DONE:
    begin
        if( read == 1'b0 ) begin
            #my_delay mem_done = 1'b0;
	    test_state =  R_CLEAR_VALID;          
        end
        else
        begin
            test_state =  R_CLEAR_MEM_DONE;
        end
    end

    R_CLEAR_VALID:
    begin
        if( din_ack == 1'b1 ) begin
            #my_delay din_valid = 1'b0;
	    test_state = R_FINISH_TESTS;
        end
        else
        begin
            test_state = R_CLEAR_VALID;
        end
    end
    
    R_FINISH_TESTS:
    begin
        if( din_ack == 1'b0 ) begin
            #my_delay din_valid = 1'b0;
            #my_delay $finish;
        end
        else
        begin
            test_state = R_FINISH_TESTS;
        end
    end

    default:
    begin
	test_state = INVALID_STATE;
    end
    endcase

endmodule
