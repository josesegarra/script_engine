unit demo_shared;

interface 

uses SysUtils,DynLibs;

type
		TShared_Lib:class
		private	
			function Location(name:string):string;
			mylib_handle :TLibHandle=dynlibs.NilHandle;							// Lib Handle
		public 
			constructor Create(name:string);
			destructor  Destroy;	override;
		end;

implementation

function OsExt:string
begin
 	{$IFDEF WINDOWS}return '.dll';{$ELSE}return '.so';{$ENDIFDEF}
 nd;

function TShared_Lib.Location(name:string):string;
var folder:string;
begin
	
	if FileExists(name) return name;
	if FileExists('lib'+name) return name+'lib';
	folder:=ExtractFilePath(paramstr(0));
	if FileExists(folder+name) return folder+name;
	
	
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
end.