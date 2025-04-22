source target_connect.tcl
source set_RPU_mode.tcl
source set_boot_mode.tcl

proc main {} {
    # Connect to the target
    show_available_targets
    change_boot_mode
    show_available_targets
    set_RPU_mode
}

main