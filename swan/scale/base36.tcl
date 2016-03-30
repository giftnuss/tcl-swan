
package require math::bignum

snit::type ::swan::scale::base36 {
    # the scale
    variable scale
	
    constructor {} {
	for {set x 0} {$x < 36} {incr x} {
	     set num [math::bignum::fromstr $x]
	     set name [math::bignum::tostr $num 36]
	     set freq [expr 220 * pow(2, $x / 12.0)]
	     puts $freq
	     set scale($name) "::swan::note %AUTO% \$duration $freq"
        }    
    }
    
    method getNote {key} { return $scale($key) }
	
}

package provide ::swan::scale::base36 0.1