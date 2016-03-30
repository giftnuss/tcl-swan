
package require snit

snit::type ::swan::duration {
	# the time value of the note as a multiplier for
	# the duration
	variable value
	# the duration in miliseconds
	typevariable duration 1000
	# alternative duration not shared with every note
	variable tempo
	
	constructor {{val 0.25}} {
		set value $val
	}
	
	typemethod setDuration {ms} {
		set duration $ms
	}
	
	method setTempo {t} {
	       set tempo t
        }
	
	method getMiliseconds {} {
	        if {[info exists tempo]} {
		
	        } else {
		        return [expr int($duration * $value)]
		}
        }
}

package provide ::swan::duration 0.2