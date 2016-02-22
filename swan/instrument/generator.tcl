
package require snit
package require snack
 
snit::type ::swan::instrument::generator {
 
        option -frequency 440.0
	option -type sine
	option -amplitude 10000

        variable sound
	variable generator
	
	constructor {args} {
	        $self configurelist $args
		set sound [snack::sound]
		set generator [snack::filter generator [$self cget -frequency] [$self cget -amplitude]]
		$sound play -filter $generator
		$sound pause
        }
	
	method play {args} {
	        $self configurelist $args
	        $generator configure [$self cget -frequency] [$self cget -amplitude]
		$sound play
        }
	
	method stop {args} {
		$self configurelist $args
		$sound stop
	}
}

package provide ::swan::instrument::generator 0.1
