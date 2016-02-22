

snit::type ::swan::note {
	# the frequency of the note
	variable frequency
	# a component for a duration element
	component duration
	# the next note to play
	variable next
	# the play script
	variable playscript
	# the stop script
	variable stopscript
	
	constructor {{val 0.25} {freq 440.0}} {
		set duration [::swan::duration %AUTO% $val]
		set frequency $freq
	}
	
	destructor {
		catch {$duration destroy}
		catch {$next destroy}
	}
	
	typemethod setDuration {ms} {
		::swan::duration setDuration $ms
	}
	
	method getMiliseconds {} {
		return [$duration getMiliseconds]
	}
	
	method getFrequency {} {
		return $frequency
	}
	
	method setNext {note} {
	        set next $note
        }

	method getNext {} {
		return $next
	}
	
	method hasNext {} {
		return [info exists next]
	}
	
	method playNext {} {
	        $next play
	}
	
	method setPlay {play} {
		set playscript $play
		if {[$self hasNext]} { 
		        $next setPlay $play
                }
	}
	
	method setStop {stop} {
	        set stopscript $stop
		if {[$self hasNext]} { 
		        $next setStop $stop
                }
	}
	
	method play {} {
		if {[$self hasNext]} { 
		        after [$self getMiliseconds] [mymethod playNext]
                } else {
			after [$self getMiliseconds] [mymethod stop]
                }
		eval $playscript
	}
	
	method stop {} {
		eval $stopscript
	}
}

package provide ::swan::note 0.2