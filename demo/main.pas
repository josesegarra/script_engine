
program JSHOST;

// ONLY WINDOWS function Compile(CString: PChar): PChar; cdecl; external 'js.so' name 'Compile';

uses SysUtils,DynLibs;

type
  		TMyEnum = (mb0, mb1, mb2, mb3, mb4, mb5, mb6, mb7);
  		TMyBits = set of TMyEnum; // = Byte in size

var 	
		shared_lib:string;
		mylib_handle :TLibHandle=dynlibs.NilHandle;
		compile: function(CString:Pchar):Pchar ; cdecl;
  		s:string;
		tfIn: TextFile;
  		i:integer;
		datFile : File of Byte;    
		chrContent : Byte;
		mbs: TMyBits;

// UTF-8  	1 byte: 0xxxxxxx
//		  	2 byte: 110yyyyy 10xxxxxx
//		  	3 byte: 1110zzzz 10yyyyyy 10xxxxxx
//			4 byte: 11110uuu 10uuzzzz 10yyyyyy 10xxxxxx
begin
	WriteLn('JavaScript compiler demo');
	shared_lib:=ExtractFilePath(paramstr(0))+'libjs.so';

	if FileExists(shared_lib) then begin
		mylib_handle := LoadLibrary(shared_lib);
		Pointer(Compile):=DynLibs.GetProcedureAddress(mylib_handle,PChar('Compile'));
		Compile('Hello');
	end else WriteLn('Shared LIB not found: '+shared_lib);

	{*
 	AssignFile(tfIn,'test.js');
    reset(tfIn);
    while not eof(tfIn) do
    begin
      readln(tfIn, s);
      writeln(s);
	  for i:=1 to length(s) do 
	  begin
		  write(s[i]+' '+IntToStr(ord(s[i]))+' ');
	  end;
	  writeln(' [CR]');
    end;
    CloseFile(tfIn);
	*}
 	AssignFile(datFile,'test.js');
  	Reset(datFile);
   	while not eof(datFile)           				// keep reading as long as there is data to read
     do begin
       read(datFile, chrContent);   				// reads a single character into chrContent variable
 		WriteLn(BinStr(chrContent,8));

     end;
	CloseFile(datFile);
	WriteLn('Done');
end.
