# How to use load.tcl
# source settings.sh of Vivado, SDK or PetaLinux in Bash
# xsct
# XSCT% source load.tcl
# XSCT% disconnect # when rerun needed or complete

connect
# connect -host <IP> if using SmartLync or remote debug

after 2000

# show PMU MicroBlaze on JTAG chain 
targets -set -nocase -filter {name =~ "*PSU*"}
mwr 0xFFCA0038 0x1FF

# Load PMUFW to PMU
target -set -filter {name =~ "MicroBlaze PMU"}
dow pmufw.elf
after 2000
con

# Load and run FSBL
target -set -filter {name =~ "Cortex-A53 #0"}
rst -processor
dow fsbl.elf
after 2000
con
after 2000
exec sleep 2
stop

# # Run U-boot
# targets -set -nocase -filter {name =~ "*A53*#0"}
# dow u-boot.elf
# dow bl31.elf
con