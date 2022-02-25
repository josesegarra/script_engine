library subs;

uses jsFiles;

function Compile(CString: PChar): PChar; cdecl;
var source:TjsSourceFile;
begin
  source:=TjsSourceFile.Create;
  WriteLn('**** THIS IS SHARED LIB: '+Cstring);
  result:='Done';
end;

exports
  Compile;

end.
