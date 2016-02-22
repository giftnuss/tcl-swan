
package require -exact snack 2.2
package require math::constants

::math::constants::constants pi

set height 400
set width 900
set lmargin 0
set xaxis [expr $height / 2]
set step [expr $pi / 180]

proc func x { expr sin($x) }
proc func x { expr sin($x*2) }
proc func x { expr (sin($x*2) - sin($x)) / 2 }
#proc func x { expr (sin($x*2) - sin($x*4)) * sin($x*16) / 1.8 }
proc func x { expr (sin($x*2*cos($x * sin($x +16))) - sin($x * 8 * sin($x))) / 2 }

# Where to draw the canvas.
canvas .c \
    -relief sunken \
    -bd 2 \
    -height [expr $height+32] \
    -width [expr $width-($lmargin-2)] \
    -scrollregion [list $lmargin 0 $width $height]
pack .c

# Put the decorations:
.c create line 0 0 0 $height -fill black
.c create line 0 $xaxis $width $xaxis -fill black

# the Sound
set sec 0
set ampl 10000
set freq 440.0
set f [snack::filter generator $freq $ampl]
snack::sound s

proc playsound {lastx lasty x y} {
    global f xaxis ampl sec
    
    set e [expr ($y / $xaxis -1) * -1]
    
    set freq [expr 440.0 + $e * 320]
    set sampl [expr int(abs($lastx -$x)) * 100]
    set sec [expr int($x * 50)]
    puts "$sec $freq $sampl"
    
    after $sec "$f configure $freq $ampl 0.0 sine -1"
}

proc bgerror {msg} { puts $msg }

proc looper {body starty} {
    global pi xaxis step
    set f func
    set x 0.0
    set lastx 0
    set lasty $starty
    while { $x <= 2*$pi + $step } {
        set xpos [expr $x * $xaxis / 2]
        set ypos [expr $xaxis - [$f $x] * $xaxis]
	# #0 - im global scope
        uplevel #0 $body $lastx $lasty $xpos $ypos
        set lastx $xpos
        set lasty $ypos    
        set x [expr $x + $step]
    }
}

proc show {lastx lasty x y} { puts "$x:\t$y" }
proc draw {lastx lasty x y} { .c create line $lastx $lasty $x $y -fill blue }

looper show $xaxis
looper draw $xaxis

s play -filter $f
looper playsound $xaxis
after $sec "s stop"
