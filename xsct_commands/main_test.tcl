source target_connect.tcl
source set_RPU_mode.tcl
source set_boot_mode.tcl

proc load_pmufw {} {
    # show PMU MicroBlaze on JTAG chain 
    targets -set -nocase -filter {name =~ "*PSU*"}
    mwr 0xFFCA0038 0x1FF

    # Load PMUFW to PMU
    target -set -filter {name =~ "MicroBlaze PMU"}
    dow ../images/pmufw.elf
    after 2000
    con
}

proc load_fsbl_a53 {} {
    # Load and run FSBL
    target -set -filter {name =~ "Cortex-A53 #0"}
    rst -processor
    dow ../images/fsbl.elf
    after 2000
    con
    after 2000
    exec sleep 4
    stop
}

proc reset_processor_r5 {} {
    puts "Resetting the chosen processor..."
    target -set -filter {name =~ "Cortex-R5 #0"}  ;# Example: Resetting R5 #0
    rst -processor
    # target -set -filter {name =~ "Cortex-R5 #1"}  ;# Example: Resetting R5 #1
    # rst -processor
    puts "Processor reset complete."
}

proc main {} {
    # Connect to the target
    show_available_targets
    change_boot_mode
    show_available_targets
    load_pmufw
    load_fsbl_a53
    set_RPU_mode
    show_available_targets
    reset_processor_r5

    #load the image to chosen processor
    puts "Loading the image to the chosen processor..."
    target -set -filter {name =~ "Cortex-R5 #0"}  ;# Example: Loading to Cortex-R5 #1
    dow ../images/hello_world.elf
    # dow ../images/led_blink.elf
    con

    puts "Resetting the A53 processor..."
    target -set -filter {name =~ "Cortex-A53 #0"}  ;# Example: Resetting A53 #0
    rst -processor
}

#run main
main