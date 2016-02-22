

package require snit

snit::type ::swan::pause {
	# a component for a duration element
	component duration
	# the next note to play
	variable next
	
	constructor {{val 0.25}} {
		set duration [::swan::duration %AUTO% $val]
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
}

package provide ::swan::pause 0.1