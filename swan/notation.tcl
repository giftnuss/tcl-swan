

snit::type ::swan::notation {
    # holds a melody
    variable melody
    # a scale to translate notenames
    variable scale

    constructor {} {
        set melody [::swan::melody %AUTO%]
	
	  
array set scale {
    a     {::swan::note %AUTO% $duration 440.0}
    c#   {::swan::note %AUTO% $duration 600.0}
    f     {::swan::note %AUTO% $duration 800.0}
    h    {::swan::note %AUTO% $duration 520.0}
    c    {::swan::note %AUTO% $duration 560.0}
    d    {::swan::note %AUTO% $duration 630.0}
}
    }

    set notes {1 2 4 8 16}

    foreach n $notes {
        set code "set duration [expr 1.0/$n]"
        append code {	        
	        set note [lindex $args 0]
		$melody append [eval $scale($note)]
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