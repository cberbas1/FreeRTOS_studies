source "target_connect.tcl" 

proc change_boot_mode {} {
    set boot_mode_var 0x0

    set CRL_APB_BASE 0x00FF5E0000
    set CRL_APB_BOOT_MODE_OFFSET 0x0200
    set CRL_APB_BOOT_MODE_ADDRESS [expr $CRL_APB_BASE + $CRL_APB_BOOT_MODE_OFFSET]

    puts "\nChanging boot mode1..."
    set CSU_BASE 0x00FFCA0000
    set CSU_MULTIBOOT_OFFSET 0x0010
    set CSU_MULTIBOOT_ADDRESS [expr $CSU_BASE + $CSU_MULTIBOOT_OFFSET]

    puts "\nChanging boot mode2..."

    ## Available boot modes
    puts "\nAvailable boot modes:"
    puts "1. JTAG"
    puts "2. SD"
    puts "3. QSPI"
    puts "4. eMMC"
    puts "5. USB"
    puts "Select boot mode (1-5):"

    # Get user input
    flush stdout
    set mode [gets stdin]

    if {$mode == 1} {
        puts "\nSwitching to JTAG boot mode..."
        set boot_mode_var 0x0100
    } elseif {$mode == 2} {
        puts "\nSwitching to SD boot mode..."
        set boot_mode_var 0xE100
    } elseif {$mode == 3} {
        puts "\nSwitching to QSPI boot mode..."
        set boot_mode_var 0x2100
    } elseif {$mode == 4} {
        puts "\nSwitching to eMMC boot mode..."
        set boot_mode_var 0x6100
    } elseif {$mode == 5} {
        puts "\nSwitching to USB boot mode..."
        set boot_mode_var 0x7100
    } else {
        puts "\nInvalid mode. Switching to default (JTAG) mode..."
        set boot_mode_var 0x0100
    }
    
    targets -set -filter {name =~ "PSU"}
    # update multiboot to ZERO
    mwr $CSU_MULTIBOOT_ADDRESS 0x0
    # change boot mode
    mwr $CRL_APB_BOOT_MODE_ADDRESS $boot_mode_var
    # reset
    rst -system
    after 2000
    con
}
