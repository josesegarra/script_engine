library subs;

uses  
      js_interface        in 'js_interface.pas',
      jsFiles             in 'jsfiles.pas',
      jsCompileContext    in 'jscompilecontext.pas',
      jsUtils             in 'jsutils.pas',
      jsSingletons        in 'jssingletons.pas';


function    JsNewCompileContext(name:pchar):TjsCompileContext;   cdecl;
var pp:string='ABC Σὲ EF';
begin
  aShow(pbyte(pp));
  result:=singletons.NewCompileContest(name);
end;

function    JsSetSource(context:TjsCompileContext;sourceName:pchar;source:pointer;size:longint):integer; cdecl;
begin
    result:=context.SetSource(sourceName,source,size);
end;


function   JsCompile(context:TjsCompileContext;sourceName:pchar):integer; cdecl;                               // Compiles a SOURCE FILE in a COMPILE CONTEXT
begin
  result:=context.Compile(sourceName);
end;


function JsSetSourceProvider(context:TjsCompileContext;provider:TJsOnSourceNeeded):integer; cdecl;              // Set SOURCE FILE PROVIDER in a COMPILE CONTEXT
begin
  result:=context.RegisterContentProvider(provider);
end;


exports
  JsNewCompileContext,JsSetSourceProvider,JsSetSource,JsCompile;

end.
