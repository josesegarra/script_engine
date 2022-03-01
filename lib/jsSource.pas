unit jsSource;

{$interfaces corba}			// Not referenced counted

interface

uses 
		jsdefinitions  in 'jsdefinitions.pas',
		js_interface  in 'js_interface.pas';
	
type

	TjsSource=class
		private
			pName:string;
			pSource:unicodestring;
			pContext:IjsCompileContext;
			pCompiled:boolean;
			function FIsCompiled:boolean;
		public
			constructor Create(context:IjsCompileContext;fname:string;buffer:pbyte;size:longint);
			destructor  Destroy;	override;
			property	IsCompiled: boolean read FIsCompiled; 
		end;



implementation

uses SysUtils,fgl,typinfo,
		jsUtf8   	in 'jsutf8.pas',
		jsUtf16Le   in 'jsutf16le.pas',
		jsUtils  	in 'jsutils.pas';

var decoders: TFPGList<IjsDecoder>;


function SelectDecoder(p:pbyte):IjsDecoder;
var i:integer=0;
begin
	result:=nil;

	aShow(p);

	while (result=nil) and (i<decoders.Count) do begin
		if (decoders[i].canDecode(p)) then result:=decoders[i];
		i:=i+1;
	end;
end;


constructor TjsSource.Create(context:IjsCompileContext;fname:string;buffer:pbyte;size:longint);
var decoder:IjsDecoder;
begin
	pName:=fName;
	pCompiled:=false;
	pContext:=context;
	pSource:='';
	TLogger.TraceIn('TjsSource.Create ');
	if (size<10) then raise Exception.Create('File too small: '+fname);
	decoder:=SelectDecoder(buffer);
	if (decoder=nil) then raise Exception.Create('Encoding not supported: '+fname);
	TLogger.Trace('Using decoder '+decoder.Name);
	WriteLn('**************************************************');
	WriteLn(decoder.decode(buffer,size));
	WriteLn('**************************************************');

	


	{



	for i:=0 to 10 do begin
		WriteLn(IntToStr(buffer^)+'   '+BinStr(buffer^,8)+'  '+char(buffer^));
		
		inc(buffer);
	end;
	}
	TLogger.TraceOut('TjsSource.Create ');
end;

function TjsSource.FIsCompiled:boolean;
begin
	result:=pCompiled;
end;

destructor  TjsSource.Destroy;
begin
end;

initialization
	decoders:=TFPGList<IjsDecoder>.Create;
	decoders.add(TjsUtf8.Create);
	decoders.add(TjsUtf16le.Create);
finalization

end.