#!/bin/sh
# the next line restarts using wish \
exec wish8.4 "$0" "$@"

package require -exact snack 2.2

set f(generator) [snack::filter generator 440.0]
set f(map) [snack::filter map 1 0 0 1]
set f(echo) [snack::filter echo 0.6 0.6 30 0.4 50 0.3]
set f(active) $f(generator)
set f(components) [list generator]
snack::sound sound

namespace eval ::instrument::generator {

    variable v
    set v(type) sine

    proc Config {args} {
        global f
	variable v
        set type $v(type)
        switch $type {
            sawtooth {
                set v(shape) 0
                set type triangle
            }
        }
	set shape [expr $v(shape) / 1000.0] ; # note that using 1000.0 as float is important !!!
	#puts "$v(shape) $shape"
        $f(generator) configure $v(freq) $v(ampl) $shape $type -1
    }

    proc build {root} {
        buildWaveForm $root

        set scales [frame ${root}.f]
	pack $scales -expand yes -fill both -side top
        buildFrequency $scales
	buildAmplitude $scales
	buildShape $scales
    }
    
    proc buildWaveForm {root} {
        variable v
        tk_optionMenu ${root}.m [namespace current]::v(type) sine rectangle triangle sawtooth noise
        foreach i [list 0 1 2 3 4] {
            ${root}.m.menu entryconfigure $i -command [namespace code Config]
        }
        pack ${root}.m -side bottom
    }
        
    proc buildFrequency {root} {
        variable v
        set v(freq) 440.0
        pack [scale ${root}.s1 -label Frequency -from 4000 -to 20 -length 200\
            -variable [namespace current]::v(freq) -command [namespace code Config]] \
	    -side left -expand yes -fill both
    }
    
    proc buildAmplitude {root} {
        variable v
	set v(ampl) 20000
        pack [scale ${root}.s2 -label Amplitude -from 32767 -to 0 -length 200\
            -variable [namespace current]::v(ampl) -command [namespace code Config]] \
	    -side left -expand yes -fill both
    }
    
    proc buildShape {root} {
        variable v
	set v(shape) 0.0
        pack [scale ${root}.s3 -label Shape -from 1000 -to 0 -length 200\
            -variable [namespace current]::v(shape) -command [namespace code Config]] \
	    -side left -expand yes -fill both
    }
}

namespace eval ::instrument::mapper {
	variable v
	
        set v(0) 1
        set v(1) 0
        set v(2) 0
        set v(3) 1
	
	proc build {root} {
	    variable v
            pack [label ${root}.l -text "In (L,R)"] -anchor e
            pack [frame ${root}.f]
            pack [label ${root}.f.l -text Out] -side left
            pack [frame ${root}.f.f] -side left
            pack [frame ${root}.f.f.t]
            pack [frame ${root}.f.f.b]
            pack [label ${root}.f.f.t.l -text L] -side left
            pack [checkbutton ${root}.f.f.t.a \
	    -var [namespace current]::v(0) \
	    -command [namespace code Config]] -side left
            pack [checkbutton ${root}.f.f.t.b \
	    -var [namespace current]::v(1) \
	    -command [namespace code Config]] -side left
            pack [label ${root}.f.f.b.l -text R] -side left
            pack [checkbutton ${root}.f.f.b.a \
	    -var [namespace current]::v(2) \
	    -command [namespace code Config]] -side left
            pack [checkbutton ${root}.f.f.b.b \
	    -var [namespace current]::v(3) \
	    -command [namespace code Config]] -side left
        }

        proc Config {} {
            global f 
	    variable v
            $f(map) configure $v(0) $v(1) $v(2) $v(3)
        }

}

namespace eval ::instrument::echo {

        variable v
        set v(iGain) 0.6
        set v(oGain) 0.6
        
	set v(delay1) 30.0
        set v(decay1) 0.4
        
	set v(delay2) 50.0
        set v(decay2) 0.3
	
	proc build root {
                pack [scale ${root}.s1 -label InGain -from 1.0 -to 0.0 -resolution .01 \
                	-variable [namespace current]::v(iGain) \
			-command [namespace code Config]] -side left

                pack [scale ${root}.s2 -label OutGain -from 1.0 -to 0.0 -resolution .01 \
	               -variable [namespace current]::v(oGain) \
		       -command [namespace code Config]] -side left

                pack [scale ${root}.s3 -label Delay1 -from 250.0 -to 10.0 \
		       -variable [namespace current]::v(delay1) \
		       -command [namespace code Config]] -side left 

                pack [scale ${root}.s4 -label Decay1 -from 1.0 -to 0.0 -resolution .01 \
	               -variable [namespace current]::v(decay1) \
		       -command [namespace code Config]] -side left 

                pack [scale ${root}.s5 -label Delay2 -from 250.0 -to 10.0 \
		       -variable [namespace current]::v(delay2) \
		       -command [namespace code Config]] -side left 

                pack [scale ${root}.s6 -label Decay2 -from 1.0 -to 0.0 -resolution .01 \
		       -variable [namespace current]::v(decay2) \
		       -command [namespace code Config]] -side left 
	}
	
        proc Config {args} {
                global f 
		variable v
                $f(echo) configure $v(iGain) $v(oGain) $v(delay1) $v(decay1) $v(delay2) $v(decay2)
        }
}

namespace eval ::instrument::compose {
    variable v
    set v(map) 0
    set v(echo) 0
    set v(status) stop

    proc build {root} {
	buildControls $root
	buildComponents $root
    }
    
    proc buildControls {root} {
        pack [frame ${root}.fb] -side bottom
        pack [button ${root}.fb.a -bitmap snackPlay \
	-command [namespace code Play]] -side left
        pack [button ${root}.fb.b -bitmap snackStop \
	-command [namespace code Stop]] -side left
    }

    proc buildComponents {root} {
        buildMap $root
	buildEcho $root
    }
    
    proc buildMap root {
	pack [frame ${root}.map] -side left
	pack [label ${root}.map.l -text map] -side left
	pack [checkbutton ${root}.map.c \
	-var [namespace current]::v(map) \
	-command [namespace code Config]] -side left
    }
    
    proc buildEcho root {
	pack [frame ${root}.echo] -side left
	pack [label ${root}.echo.l -text echo] -side left
	pack [checkbutton ${root}.echo.c \
	-var [namespace current]::v(echo) \
	-command [namespace code Config]] -side left
    }
    
    proc Config {} {
        global f
	variable v
        sound stop
	if {[llength $f(components)] > 1} {
	    $f(active) destroy
        }
	
	set f(components) [list generator]
	if {$v(map) == 1} {
	    lappend f(components) map
       }
	if {$v(echo) == 1} {
	    lappend f(components) echo
       }
       
       if {[llength $f(components)] == 1} {
           set f(active) $f(generator)
       } else {
           set components ""
           foreach c $f(components) {
	      append components " " $f($c)
          }
          set f(active) [eval snack::filter compose $components]
       }
       if {$v(status) eq "play"} {
           Play 
       }
    }

    proc Play {} {
        global f
	variable v
        sound stop
	set v(status) play
        sound play -devicechannels 2 -filter $f(active)
    }
    
    proc Stop {} {
        variable v
	set v(status) stop
        sound stop
    }
}

namespace eval ::instrument::main {
    proc build {root} {
        set compose [frame ${root}.c]
        set generator [frame ${root}.g]
	set mapper [frame ${root}.m]
	set echo [frame ${root}.e]
	pack $compose -side top
        pack $generator -side bottom
	pack $mapper -side bottom
	pack $echo -side left
	::instrument::compose::build $compose
        ::instrument::generator::build $generator
	::instrument::mapper::build $mapper
	::instrument::echo::build $echo
    }
}

::instrument::main::build ""
