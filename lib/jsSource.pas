unit jsSource;

{$interfaces corba}			// Not referenced counted

interface

uses 
		jsdefinitions  in 'jsdefinitions.pas',
		js_interface  in 'js_interface.pas';
	
type

	TjsSource=class
		private
			cName: string;
		public
			constructor Create(context:IjsCompileContext;cName:string;buffer:pbyte;size:longint);
			destructor  Destroy;	override;
		end;



implementation

constructor TjsSource.Create(context:IjsCompileContext;cName:string;buffer:pbyte;size:longint);
begin
end;

destructor  TjsSource.Destroy;
begin
end;



initialization

finalization

end.