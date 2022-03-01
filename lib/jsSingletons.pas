unit jsSingletons;

interface

uses    classes,
        jsUtils  in 'jsutils.pas',
        jsCompileContext in 'jscompilecontext.pas';

type
	TjsSingletons=class
		private
            CompileContexts:TThreadlist;                                             // This holds applicatino singletons
		public
            function    NewCompileContest(cName:string):TjsCompileContext;
            procedure   FreeCompileContest(c:TjsCompileContext);

            constructor Create;
            destructor  Destroy; override;
		end;


var Singletons:TjsSingletons;

implementation

constructor TjsSingletons.Create;
begin
    TLogger.TraceIn('TjsSingletons.Create');
    CompileContexts:=TThreadlist.Create;                                             // This holds applicatino singletons
    TLogger.Trace('TjsSingletons Created CompileContext');
    TLogger.TraceOut('TjsSingletons.Create');
end;

destructor  TjsSingletons.Destroy; 
begin
    TLogger.TraceIn('TjsSingletons.Destroy');
    TLogger.Trace('***************************** PENDING');
    TLogger.TraceOut('TjsSingletons.Destroy');
end;


function TjsSingletons.NewCompileContest(cName:string):TjsCompileContext;
begin
    TLogger.TraceIn('TjsSingletons.NewCompileContest '+cName);
    result:=TjsCompileContext.Create(cName);
    CompileContexts.LockList.Add(result);
    TLogger.TraceOut('TjsSingletons.NewCompileContest '+cName);
end;

procedure TjsSingletons.FreeCompileContest(c:TjsCompileContext);
var s:string;
begin
    s:=c.Name;
    TLogger.TraceIn('TjsSingletons.FreeCompileContest '+s);
    if (c<>nil) then c.Free();
    CompileContexts.LockList.Remove(c);
    TLogger.TraceOut('TjsSingletons.FreeCompileContest'+s);
end;



initialization
    Singletons:=TjsSingletons.Create();
finalization

end.