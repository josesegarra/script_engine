unit jsDefinitions;

interface

{$interfaces corba}			// Not referenced counted


type
      IjsCompileContext = interface
      end;

      IjsDecoder = interface
          function Name:string;
          function canDecode(buffer:pbyte):boolean; 
          function decode(buffer:pbyte;size:integer):unicodestring;           // Decode without BOM
      end;


implementation

end.