unit jsFiles;


interface

{*
uses classes;

type
	// the type TRandomNumber gets globally known
	// since it is included somewhere (uses-statement)
	TjsSourceFile=class
		private
			items: TList;
		public
			constructor Create;
			destructor  Destroy;	override;
		end;

*}  
implementation
{*
constructor TjsSourceFile.Create;
begin
	items:=TList.Create;
	WriteLn('***************** CREATE TjsSourceFile');
end;

destructor  TjsSourceFile.Destroy;
begin
	inherited Destroy;
end;

*}

initialization

finalization

end.