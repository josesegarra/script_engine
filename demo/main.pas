
program JSHOST;

// ONLY WINDOWS function Compile(CString: PChar): PChar; cdecl; external 'js.so' name 'Compile';

uses 	SysUtils,			
			js_interface in '../lib/js_interface.pas',
			demo_shared in 'demo_shared.pas';


// UTF-8  	1 byte: 0xxxxxxx
//		  	2 byte: 110yyyyy 10xxxxxx
//		  	3 byte: 1110zzzz 10yyyyyy 10xxxxxx
//			4 byte: 11110uuu 10uuzzzz 10yyyyyy 10xxxxxx


var 
	dll:TShared_Lib;
    context:pointer;

function OnSourceNeeded(context:pointer;srcName:pchar):integer; cdecl;
begin
	WriteLn('*********** CONTEXT REQUEST '+srcName);
	result:=JS_OK;
end;




begin
	WriteLn('JavaScript compiler demo');																								// Log 	
	dll:=TShared_Lib.Create('js.so');																									// Load DLL
	context:=dll.NewCompileContext('main');																								// Create a context
	if (dll.SetSourceProvider(context,OnSourceNeeded)<>JS_OK) then raise Exception.Create('Could NOT set SetSourceProvider');			// Set SOURCE provider
	if (dll.Compile(context,'test.js')<>JS_OK) then raise Exception.Create('Could NOT compile test.js');								// Compile TEST.JS


	
	{*
 	AssignFile(datFile,'test.js');
  	Reset(datFile);
   	while not eof(datFile)           				// keep reading as long as there is data to read
     do begin
       read(datFile, chrContent);   				// reads a single character into chrContent variable
 		WriteLn(BinStr(chrContent,8));

     end;
	CloseFile(datFile);
	WriteLn('Done');
	*}
end.
