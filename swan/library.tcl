

package require snit

# This helps loading "swan" files. I'm not familar enough with tcl
# autoloading, so this way is chosen currently.
namespace eval ::swan::library {

    variable libraryPath
    set libraryPath [file dirname [info script]]
    
    variable modules
    variable instruments
    
    set modules {
        duration
	log
	melody
	notation
	note
	pause
    }
    set instruments {
        generator
    }
}

foreach mod $::swan::library::modules {
    source [file join $::swan::library::libraryPath [format %s.tcl $mod]]
}

foreach inst $::swan::library::instruments {
    source [file join $::swan::library::libraryPath instrument [format %s.tcl $inst]]
}

package provide ::swan::library 0.2
