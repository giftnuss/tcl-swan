
puts $argv0
puts [llength $argv]
puts $argv

set dir [file dirname [info script]]
puts "Current dir: $dir"

parray tcl_platform

