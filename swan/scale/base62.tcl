

snit::type ::swan::scale::base62 {
    # the scale
    variable scale
	
    constructor {} {
        set sym {0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
	for {set x 0} {$x < 62} {incr x} {
	     set name [lindex $sym $x]
	     set freq [expr 110 * pow(2, $x / 19.0)]
	     puts $freq
	     set scale($name) "::swan::note %AUTO% \$duration $freq"
        }    
    }
    
    method getNote {key} { return $scale($key) }
	
}

package provide ::swan::scale::base36 0.1