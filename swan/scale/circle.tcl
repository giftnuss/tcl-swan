

snit::type ::swan::scale::circle {
    # the scale
    variable scale
	
    constructor {} {
	foreach {x y} {
		F,     172.0
		G,     180.0
		G#,   200.0
		A      220.0
		H      240.0
		C      260.0
		E      320.0
		F      340.0
		G      360.0
		a      440.0
		a#    470.0
		h      500.0
		c      540.0
		c#    580.0
		d      620.0
		d#    660.0
		e      720.0
		f       780.0
		f#     820.0
		g      880.0
		g#    940.0
		a'  1000.0
	} {
		set scale($x) "::swan::note %AUTO% \$duration $y"
        }    
    }
    
    method getNote {key} { return $scale($key) }
	
}

package provide ::swan::scale::circle 0.1