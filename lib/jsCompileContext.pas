unit jsCompileContext;

{$interfaces corba}				// Not reference counted !!!

interface

uses 
		 SysUtils,

 		js_interface  	in 'js_interface.pas',
		jsDefinitions  	in 'jsDefinitions.pas',
		jsSource 		in 'jsSource.pas';
	
type

	TjsCompileContext=class(TInterfacedObject,IjsCompileContext)
		private
			sourceFiles:Dictionary<string,TjsSource>;
			cName: string;
			OnSource:TJsOnSourceNeeded;
			function GetContextName:string;
		public
			property 	Name: String read GetContextName; 
			constructor Create(ContextName:string);
			destructor  Destroy;	override;
			function    SetSource(sourceName:string;buffer:pbyte;size:longint):integer;
			function    Compile(sourceName:string):integer;
			function	RegisterContentProvider(provider:TJsOnSourceNeeded):integer; 
		end;



implementation

uses classes,jsUtils  in 'jsUtils.pas';


function TjsCompileContext.GetContextName:string;
begin
	result:=cName;
end;

constructor TjsCompileContext.Create(ContextName:string);
begin
	cName:=ContextName;
end;

destructor  TjsCompileContext.Destroy;
begin
	inherited Destroy;
end;

function    TjsCompileContext.SetSource(sourceName:string;buffer:pbyte;size:longint):integer;
begin
	TLogger.TraceIn('TjsCompileContext.SetSource');
	TLogger.Trace('*************************** TjsCompileContext.SetSource	NOT IMPLEMENTED');
	TLogger.TraceOut('TjsCompileContext.SetSource');
	result:=JS_FAIL;
end;

function    TjsCompileContext.Compile(sourceName:string):integer;
begin
	TLogger.TraceIn('TjsCompileContext.Compile');
	TLogger.Trace('*************************** TjsCompileContext.Compile	NOT IMPLEMENTED');
	TLogger.TraceOut('TjsCompileContext.Compile');
	result:=JS_OK;
end;

function TjsCompileContext.RegisterContentProvider(provider:TJsOnSourceNeeded):integer; 
begin
  	OnSource:=provider;
	result:=JS_OK;
end;



initialization

finalization

end.