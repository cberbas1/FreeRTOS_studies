## @author: Berk Erbas
## @date: 2023-10-04
## @description: This script connects to a target.

#procedure to connect to the target

#procedure to list the available targets
proc list_targets {} {
    #get the target list
    set target_list [targets]

    # Split into lines and parse target info
    set lines [split $target_list "\n"]
    set target_list [list]

    foreach line $lines {
        # Extract index, name, and state using regex
        if {[regexp {^\s*(\d+)\s+(Cortex\S*)\s+(.*)} $line -> index name state]} {
            lappend parsed_targets [dict create index $index name $name state $state]
        }
    }
    
    return $parsed_targets
}

proc print_avilable {available_targets} {
    puts "\nAvailable processor targets:"
    puts [format "%-10s %-20s %-15s" "Index" "Name" "State"]  ;# Header with fixed widths
    puts "----------------------------------------------------------"

    foreach target $available_targets {
        set index [dict get $target index]
        set name [dict get $target name]
        set state [dict get $target state]
        puts [format "%-10s %-20s %-15s" $index $name $state]
    }
}

proc show_available_targets {} {
    # connect to the target
    connect
    
    # list the available targets 
    set available_targets [list_targets]

    # Print targets
    print_avilable $available_targets
}


