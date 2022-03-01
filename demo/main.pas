
program JSHOST;

// ONLY WINDOWS function Compile(CString: PChar): PChar; cdecl; external 'js.so' name 'Compile';

uses 	SysUtils,classes,			
			js_interface in '../lib/js_interface.pas',
			demo_utils in 'demo_utils.pas',
			demo_shared in 'demo_shared.pas';


// UTF-8  	1 byte: 0xxxxxxx
//		  	2 byte: 110yyyyy 10xxxxxx
//		  	3 byte: 1110zzzz 10yyyyyy 10xxxxxx
//			4 byte: 11110uuu 10uuzzzz 10yyyyyy 10xxxxxx


var input_file:string;
	dll:TShared_Lib;
    context:pointer;

function OnSourceNeeded(context:pointer;srcName:pchar):integer; cdecl;
var ms:TMemoryStream;
begin
	result:=JS_FAIL;
	WriteLn('*********** Loading from file system '+srcName);
	if (not FileExists(srcName)) then exit;
    ms:=TMemoryStream.Create;
    ms.LoadFromFile(ExistsInLocation(srcName,TOnError.doThrow));
	ms.position:=0;
	dll.SetSource(context,srcName,ms.memory,ms.size);
	ms.Destroy;
	WriteLn('*********** Loaded from file system '+srcName);
	result:=JS_OK;
end;

begin
	

	input_file:='init.js'; 
	if (ParamCount>0) then input_file:=ParamStr(1); 
	WriteLn('JavaScript compiler demo');																								// Log 	
	dll:=TShared_Lib.Create('js.so');																									// Load DLL
	context:=dll.NewCompileContext('main');																								// Create a context named 'main'
	if (dll.SetSourceProvider(context,OnSourceNeeded)<>JS_OK) then raise Exception.Create('Could NOT set SetSourceProvider');			// Set SOURCE provider
	if (dll.Compile(context,Pchar(input_file))<>JS_OK) then raise Exception.Create('Could NOT compile: '+input_file);					// Compile TEST.JS


	
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
