
package require math::constants

::math::constants::print-constants

::math::constants::constants radtodeg degtorad pi tiny eps

puts $pi

if { [catch { puts [expr 1.0 + $tiny] } error ] } {
    puts $error
}

if { 1.0 + $eps == 1.0 } {
   puts "$eps is still to small"
} else {
   puts "\[expr 1.0 + \$eps\] = [expr 1.0 + $eps] != 1.0, but not visible ;)"
}
