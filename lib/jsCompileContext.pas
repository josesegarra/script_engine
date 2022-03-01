unit jsCompileContext;

// To avoid circular references issues between TjsCompileContext and its child objects (ie: jsSource)
// children's references use the IjsCompileContext
// So, 	TjsCompileContext implements IjsCompileContext using interfaces of type Corba (not reference counted)								 
{$interfaces corba}				

interface

// https://wiki.freepascal.org/Data_Structures,_Containers,_Collections

uses 
        SysUtils,fgl,classes,
 		js_interface  	in 'js_interface.pas',
		jsDefinitions  	in 'jsdefinitions.pas',
		jsSource 		in 'jssource.pas';
	
type

	TjsCompileContext=class(TInterfacedObject,IjsCompileContext)								 
		private
			sourceFiles: TFPGMap<string, TjsSource>;
			cName: string;
			OnSource:TJsOnSourceNeeded;
			function GetContextName:string;
			function GetSource(sourceName:string):TjsSource;
		public
			property 	Name: String read GetContextName; 
			constructor Create(ContextName:string);
			destructor  Destroy;	override;
			function    SetSource(sourceName:string;buffer:pbyte;size:longint):integer;
			function    Compile(sourceName:string):integer;
			function	RegisterContentProvider(provider:TJsOnSourceNeeded):integer; 
		end;



implementation

uses jsUtils  in 'jsutils.pas';


function TjsCompileContext.GetContextName:string;
begin
	result:=cName;
end;

constructor TjsCompileContext.Create(ContextName:string);
begin
	cName:=ContextName;
	sourceFiles:=TFPGMap<string, TjsSource>.Create;
end;

destructor  TjsCompileContext.Destroy;
begin
	inherited Destroy;
end;

function    TjsCompileContext.SetSource(sourceName:string;buffer:pbyte;size:longint):integer;
begin
	TLogger.TraceIn('TjsCompileContext.SetSource');
	sourceFiles[sourceName]:=TjsSource.Create(self,sourceName,buffer,size);
	TLogger.TraceOut('TjsCompileContext.SetSource');
	result:=JS_FAIL;
end;

function TjsCompileContext.GetSource(sourceName:string):TjsSource;
var sourceFile:string;
begin
	sourceFile:=ExpandFileName(sourceName);
	TLogger.TraceIn('TjsCompileContext.GetSource: '+sourceFile);
	if ( (sourceFiles.IndexOf(sourceFile)=-1) and assigned(OnSource)) then OnSource(self,pchar(sourceFile)); 
	if not sourceFiles.TryGetData(sourceFile,result) then raise Exception.Create('TjsCompileContext.GetSource could not load: '+sourceFile);
	TLogger.Trace('TjsCompileContext.GetSource found: '+sourceFile);
	TLogger.TraceOut('TjsCompileContext.GetSource');
end;


function    TjsCompileContext.Compile(sourceName:string):integer;
var 	source:TjsSource;
begin
	TLogger.TraceIn('TjsCompileContext.Compile: '+sourceName);
	source:=GetSource(sourceName);
	TLogger.Trace('*************************** TjsCompileContext.Compile PENDING !!');
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