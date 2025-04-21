source "target_connect.tcl" 

proc change_boot_mode {mode} {
    set boot_mode_var 0x0

    if {$mode == 0} {
        puts "\nSwitching to JTAG boot mode..."
        set boot_mode_var 0x0100
    } elseif {$mode == 1} {
        puts "\nSwitching to SD boot mode..."
        set boot_mode_var 0xE100
    } elseif {$mode == 2} {
        puts "\nSwitching to QSPI boot mode..."
        set boot_mode_var 0x2100
    } elseif {$mode == 3} {
        puts "\nSwitching to eMMC boot mode..."
        set boot_mode_var 0x6100
    } elseif {$mode == 4} {
        puts "\nSwitching to USB boot mode..."
        set boot_mode_var 0x7100
    } else {
        puts "\nInvalid mode. Use 1 for JTAG or 2 for JTAG."
        return
    }
    
    targets -set -filter {name =~ "PSU"}
    # update multiboot to ZERO
    mwr 0xffca0010 0x0
    # change boot mode to JTAG
    mwr 0xff5e0200 $boot_mode_var
    # reset
    rst -system
    after 2000
    con
}

show_available_targets
change_boot_mode 0
show_available_targets
