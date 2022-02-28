unit js_interface;

interface

const
        JS_OK = 1;
        JS_FAIL = 0;

type
	    
        TJsNewCompileContext = function (name:pchar) :pointer;   cdecl;                                                 // Returns a COMPILE CONTEXT
        TJsSetSource = function (context:pointer;sourceName:pchar;source:pointer;size:longint):integer; cdecl;          // Sets a SOURCE FILE in a COMPILE CONTEXT
        TJsCompile = function (context:pointer;sourceName:pchar):integer; cdecl;                                     // Compiles a SOURCE FILE in a COMPILE CONTEXT

        TJsOnSourceNeeded = function(context:pointer;content:pchar):integer; cdecl;
        TJsSetSourceProvider = function (context:pointer;provider:TJsOnSourceNeeded):integer; cdecl;              // Set SOURCE FILE PROVIDER in a COMPILE CONTEXT


implementation

end.