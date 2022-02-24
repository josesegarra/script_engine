library subs;

function Compile(CString: PChar): PChar; cdecl;
begin
  WriteLn('Compiling ');
  WriteLn(Cstring);
  result:='Done';
end;

exports
  Compile;

end.
