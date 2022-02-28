unit jsUtils;

interface

uses classes,SysUtils;

type 
    TraceKind = (Enter,Exit,Default);
    TLogger = class
        incpad:string; static;
        pad:string; static; 
        class procedure Trace(s:string);                        static;
        class procedure TraceIn(s:string);                      static;
        class procedure TraceOut(s:string);                     static;
        class procedure Trace(kind:TraceKind;s:string);         static;
    end;



implementation

const   IncPadLength=6;                     // padding size for TRACE

class procedure TLogger.Trace(kind:TraceKind;s:string);
var r:string;
begin
    if (kind=TraceKind.Enter)       then r:='Enter ';
    if (kind=TraceKind.Exit)        then r:='Exit  ';
    if (kind=TraceKind.Default)     then r:='      ';
    if ( (kind=TraceKind.Exit) and (length(TLogger.pad)>IncPadLength)) then TLogger.pad:=leftStr(TLogger.pad,length(TLogger.pad)-IncPadLength);
    WriteLn('%trace '+r+TLogger.pad+s);
    if (kind=TraceKind.Enter)          then TLogger.pad:=TLogger.pad+TLogger.incPad;
end;

class procedure TLogger.Trace(s:string);
begin
    Trace(TraceKind.Default,s);
end;

class procedure TLogger.TraceIn(s:string);
begin
    Trace(TraceKind.Enter,s);
end;

class procedure TLogger.TraceOut(s:string);
begin
    Trace(TraceKind.Exit,s);
end;

initialization
    TLogger.incpad:=StringOfChar(' ',IncPadLength);
    TLogger.pad:='       ';

finalization

end.