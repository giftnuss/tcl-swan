

package require Tcl 8.4
package require tcltest 2.2

proc testdir {} {
	set here [file dirname [file normalize [info script]]]
        return [file join $here swan tests]	
}

::tcltest::configure \
     -testdir [testdir] \
     -tmpdir [file join [testdir] tmp] \
     -singleproc 1 \
     -debug 1

eval ::tcltest::configure $::argv

::tcltest::runAllTests
