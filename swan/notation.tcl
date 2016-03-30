

snit::type ::swan::notation {
    # holds a melody
    variable melody
    # a scale to translate notenames
    variable scale

    constructor {} {
        set melody [::swan::melody %AUTO%]
	set scale [::swan::scale::circle %AUTO%]
    }

    set notes {1 2 4 8 16}

    foreach n $notes {
        set code "set duration [expr 1.0/$n]"
        append code {	        
	        set note [lindex $args 0]
		$melody append [eval [$scale getNote $note]]
	        set args [lreplace $args 0 0]
		if {[llength $args] > 0} {
			eval $self $args
	        }
        }
        method $n args $code
    }
    
    method getMelody {} { return $melody }
 
    method setScale {s} { set scale $s }
}

package provide ::swan::notation 0.2