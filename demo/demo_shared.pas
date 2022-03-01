unit demo_shared;

interface 

uses SysUtils,DynLibs,
			js_interface in '../lib/js_interface.pas',
			demo_utils in 'demo_utils.pas';

type

	TShared_Lib=class
		private	
			handle:TLibHandle;																// Lib Handle
			path:string;
			function Load(fname:string):pointer;
		public 
			NewCompileContext:TJsNewCompileContext;
			SetSourceProvider:TJsSetSourceProvider;
			Compile:TJsCompile;
			SetSource:TJsSetSource;
			constructor Create(fileName:string);
			destructor  Destroy;	override;
		end;

implementation


function TShared_Lib.Load(fname:string):pointer;
begin
	result:=DynLibs.GetProcedureAddress(handle,PChar(fname));
	if result=nil then raise Exception.Create('Could not find '+fname+' in '+path)
	else WriteLn('***      Imported function '+fname);
end;

constructor TShared_Lib.Create(fileName:string);											// Load shared library
begin
	WriteLn('***  Loading shared library: '+fileName);									
	path:=ExistsInLocation(fileName,TOnError.doThrow);									
	handle := LoadLibrary(path);
	NewCompileContext:=Load('JsNewCompileContext');
	SetSourceProvider:=Load('JsSetSourceProvider');
	Compile:=Load('JsCompile');
	SetSource:=Load('JsSetSource');
end;

destructor   TShared_Lib.Destroy;	
begin

end;

	{*
	shared_lib:=ExtractFilePath(paramstr(0))+'libjs.so';

	if FileExists(shared_lib) then begin
		mylib_handle := LoadLibrary(shared_lib);
		compile:=nil;
		c:=DynLibs.GetProcedureAddress(mylib_handle,PChar('Compile'));
		Compile:=c;
		Compile('------- Hello');
	end else WriteLn('Shared LIB not found: '+shared_lib);
	*}

end.