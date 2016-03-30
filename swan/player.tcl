

snit::type ::swan::player {

  # interval for asking source if there is something to play
  variable interval
  variable playScript
  variable stopScript
  
  component instrument
  component notation
  component source
  
  constructor {src} {
      set interval 1000
      set source $src
      set instrument [::swan::instrument::generator %AUTO%]
      set notation [::swan::notation %AUTO%]
      set playScript {play -frequency $frequency -amplitude 20000} 
      set stopScript stop

  }
  
  delegate method setScale to notation
  method setInstrument {i} { set instrument $i }
  method setPlayScript {play} { set playScript $play }
  method setStopScript {stop} { set stopScript $stop }
  
  method play {} {
      set line [$source fetch]
      if {[string length $line] > 0} {
          eval $notation $line
	  set melody [$notation getMelody]
	  $melody play [concat $instrument $playScript] [concat $instrument $stopScript]
	  after $interval [mymethod play]  
      }
  }
}

package provide ::swan::player 0.1