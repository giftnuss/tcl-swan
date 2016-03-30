

package require snit

# This helps loading "swan" files. I'm not familar enough with tcl
# autoloading, so this way is chosen currently.
namespace eval ::swan::library {

    variable libraryPath
    set libraryPath [file dirname [info script]]
    
    variable modules
    variable instruments
    variable scales
    
    set modules {
        duration
	log
	melody
	notation
	note
	pause
	player
    }
    set instruments {
        generator
    }
    set scales {
        base36
	base62
        circle
    }
}

foreach mod $::swan::library::modules {
    source [file join $::swan::library::libraryPath [format %s.tcl $mod]]
}

foreach inst $::swan::library::instruments {
    source [file join $::swan::library::libraryPath instrument [format %s.tcl $inst]]
}
foreach inst $::swan::library::scales {
    source [file join $::swan::library::libraryPath scale [format %s.tcl $inst]]
}

package provide ::swan::library 0.2
