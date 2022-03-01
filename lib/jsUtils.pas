unit jsUtils;

interface

uses classes,SysUtils;



type 
    
    TLogger = class
        incpad:string; static;
        pad:string; static; 
        class procedure Trace(s:string);                        static;
        class procedure TraceIn(s:string);                      static;
        class procedure TraceOut(s:string);                     static;
    end;

procedure aShow(p:pbyte);
function  isLittleEndian:boolean;



implementation


type    TraceKind = (trEnter,trExit,trDefault);
const   IncPadLength=6;                     // padding size for TRACE


procedure TraceImpl(kind:TraceKind;s:string);
var r:string;
begin
    if (kind=TraceKind.trEnter)       then r:='Enter ';
    if (kind=TraceKind.trExit)        then r:='Exit  ';
    if (kind=TraceKind.trDefault)     then r:='      ';
    if ( (kind=TraceKind.trExit) and (length(TLogger.pad)>IncPadLength)) then TLogger.pad:=leftStr(TLogger.pad,length(TLogger.pad)-IncPadLength);
    WriteLn('%trace '+r+TLogger.pad+s);
    if (kind=TraceKind.trEnter)          then TLogger.pad:=TLogger.pad+TLogger.incPad;
end;

class procedure TLogger.Trace(s:string);
begin
    TraceImpl(TraceKind.trDefault,s);
end;

class procedure TLogger.TraceIn(s:string);
begin
    TraceImpl(TraceKind.trEnter,s);
end;

class procedure TLogger.TraceOut(s:string);
begin
    TraceImpl(TraceKind.trExit,s);
end;

function gByte(var p:pbyte):byte;
begin
    result:=p^;
    inc(p);
end;



procedure aShow(p:pbyte);
var i:integer;
begin
    i:=10;
    while (i>0) do begin
        Write(IntToStr(ord(p^)));
        Write(' ');
        inc(p);
        dec(i);
    end;
    WriteLn(' ');

end;

function isLittleEndian:boolean;
var p:word;
    q:pbyte;
begin
    p:=5;
    q:=@p;
    result:=(q^=5) and ((q+1)^=0);
end;


initialization
    TLogger.incpad:=StringOfChar(' ',IncPadLength);
    TLogger.pad:='       ';

finalization

end.