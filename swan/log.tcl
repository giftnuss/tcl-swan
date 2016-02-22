

package require logger
package require snit

snit::type ::swan::log {
        variable log
        
        constructor {{service ::swan::log}} {
	    set log [logger::init $service] 
	    ${log}::notice "Initialized logging for $service"
        }
	
        destructor {
            ${log}::delete
        }
        
	method debug    {msg} { ${log}::debug $msg }
	# info is a reserved name in snit
	method inform   {msg} { ${log}::info $msg }
	method notice   {msg} { ${log}::notice $msg }
	method warn     {msg} { ${log}::warn $msg }
	method error    {msg} { ${log}::error $msg }
	method critical {msg} { ${log}::critical $msg }
	
        method setlevel {lvl} {
	    ${log}::setlevel $lvl
        }
}

package provide ::swan::log 0.1