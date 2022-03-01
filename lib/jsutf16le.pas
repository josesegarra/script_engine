unit jsUtf16Le;

// https://wiki.freepascal.org/UTF8_strings_and_characters

{$interfaces corba}			// Not referenced counted


interface

uses 
		jsdefinitions  in 'jsdefinitions.pas',
		js_interface  in 'js_interface.pas';
	
type

	TjsUtf16Le=class(IjsDecoder)
		private
		public
		  function Name:string;
          function canDecode(buffer:pbyte):boolean; 
          function decode(buffer:pbyte;size:integer):unicodestring;           // Decode without BOM
		end;



implementation

uses SysUtils,jsUtils  in 'jsUtils.pas';


function canDecodeImpl(buffer:pbyte):boolean; 
begin
	result:=(buffer^=$FF) and ((buffer+1)^=$FE);
end;

function TjsUtf16Le.canDecode(buffer:pbyte):boolean; 
begin
	result:=canDecodeImpl(buffer);
end;


function TjsUtf16Le.decode(buffer:pbyte;size:integer):unicodestring;
begin
	if (canDecodeImpl(buffer)) then begin
		SetString(result,pUnicodeChar(buffer+2),(size div 2) -1);
		end else result:=''; 
end;

function TjsUtf16Le.Name:string;
begin
	result:='UTF-16LE decoder';
end;


initialization

finalization

end.