
program JSHOST;

// ONLY WINDOWS function Compile(CString: PChar): PChar; cdecl; external 'js.so' name 'Compile';

uses SysUtils,DynLibs;

type
  		TMyEnum = (mb0, mb1, mb2, mb3, mb4, mb5, mb6, mb7);
  		TMyBits = set of TMyEnum; // = Byte in size

var 	
		shared_lib:string;													// Name of shared LIB
		mylib_handle :TLibHandle=dynlibs.NilHandle;							// Lib Handle




		compile: function(CString:Pchar):Pchar ; cdecl;
  		s:string;
		tfIn: TextFile;
  		i:integer;
		datFile : File of Byte;    
		chrContent : Byte;
		mbs: TMyBits;
		c:pointer;

// UTF-8  	1 byte: 0xxxxxxx
//		  	2 byte: 110yyyyy 10xxxxxx
//		  	3 byte: 1110zzzz 10yyyyyy 10xxxxxx
//			4 byte: 11110uuu 10uuzzzz 10yyyyyy 10xxxxxx
begin
	WriteLn('JavaScript compiler demo');
	shared_lib:=ExtractFilePath(paramstr(0))+'libjs.so';

	if FileExists(shared_lib) then begin
		mylib_handle := LoadLibrary(shared_lib);
		compile:=nil;
		c:=DynLibs.GetProcedureAddress(mylib_handle,PChar('Compile'));
		Compile:=c;
		Compile('------- Hello');
	end else WriteLn('Shared LIB not found: '+shared_lib);

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
