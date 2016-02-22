
package require snit

# melody is a single chained list of note elements
snit::type ::swan::melody {
	# the first note to play
	variable first
	
	# the last element in the list
	variable last
	
	destructor {
		catch {$first destroy}
	}
	
	# set first note
	method begin {note} {
		set first $note
		set last $note
        }
	
	# append a note
	method append {note} {
	        if {! [info exists first]} {
		       $self begin $note
	        } else {
	               set temp $last
		       set last $note
		       $temp setNext $note
	        }
	}
	
	method play {play stop} {
		if {! [info exists first]} {
			return -code error "first note is undefined"
		}
		if {! [info complete $play]} {
			return -code error "invalid script parameter: play"
		}
		if {! [info complete $stop]} {
			return -code error "invalid script parameter: stop"
		}
		$first setPlay $play
		$first setStop $stop
		$first play
	}
}

package provide ::swan::melody 0.2
