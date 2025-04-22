source "target_connect.tcl" 

## Check https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/RPU_GLBL_CNTL-RPU-Register 
## for more details
proc set_RPU_mode {} {
    set RPU_GLBL_CNTL 0xFF9A0000
    set rpu_mode_var 0x00000040

    ## Available RPU modes
    puts "\nAvailable RPU modes:"
    puts "1. Split mode: both cores are independent"
    puts "2. Lockstep mode: both cores are synchronized"
    puts "Select boot mode (1-2):"

    # Get user input
    flush stdout
    set mode [gets stdin]

    if {$mode == 1} {
        puts "\nRPU: Switching to Split Mode..."
        set rpu_mode_var 0x00000040
    } elseif {$mode == 2} {
        puts "\nRPU: Switching to Lockstep mode..."
        set rpu_mode_var 0x00000050
    } else {
        puts "\nInvalid mode. Use 1 for JTAG or 2 for JTAG."
        return
    }
    
    # update RPU mode
    # Read and print the current value of the register
    set current_value [mr $RPU_GLBL_CNTL]
    puts "\tCurrent RPU_GLBL_CNTL value: $current_value"

    # Update the RPU mode
    mwr $RPU_GLBL_CNTL $rpu_mode_var

    # Read and print the updated value of the register
    set updated_value [mr $RPU_GLBL_CNTL]
    puts "\tUpdated RPU_GLBL_CNTL value: $updated_value"

    # wait 1 sec
    after 1000
    con
}

