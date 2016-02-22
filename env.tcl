
puts [info library]

foreach lib {Tcl Tclx Tk snit} {
	package require $lib
	puts -nonewline "$lib:\t\t"
	puts [package provide $lib]
}

if {[info exists .]} { puts ". is defined" } else { puts "no .?" }

parray env

if {[info exists tcl_pkgPath]} {
	puts -nonewline "tcl_pkgPath: "
	puts $tcl_pkgPath
}
puts $auto_path

puts [info global]

parray auto_index
exit
