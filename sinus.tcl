
package require Tk
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
proc func x { expr (sin($x*2) - sin($x*4)) * sin($x*16) / 1.8 }
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

set x 0.0
set lastx 0
set lasty $xaxis
while { $x <= 2*$pi + $step } {
    set xpos [expr $x * $xaxis / 2]
    set ypos [expr $xaxis - [func $x] * $xaxis]
    .c create line $lastx $lasty $xpos $ypos -fill blue
    set lastx $xpos
    set lasty $ypos    
    set x [expr $x + $step]
}
