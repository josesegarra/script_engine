unit jsUtf8;

{$interfaces corba}			// Not referenced counted

interface

uses 
	jsdefinitions  in 'jsdefinitions.pas';
	
type

	TjsUtf8=class(IjsDecoder)
		private
		public
		  function Name:string;
          function canDecode(buffer:pbyte):boolean; 
          function decode(buffer:pbyte;size:integer):unicodestring;           // Decode without BOM
		end;



implementation


uses SysUtils,jsUtils  in 'jsUtils.pas';


const 	
		// 110x xxxx
		b2_val	:byte=$C0;	// 110 00000
		b2_mask :byte=$E0;	// 111 00000

		// 1110 xxxx
		b3_val	:byte=$E0;	// 1110 0000
		b3_mask :byte=$F0;	// 1111 0000

		// 1111 0xxx
		b4_val	:byte=$F0;	// 11110 000
		b4_mask :byte=$F8;	// 11111 000

		// 10xx xxxx
		bX_val	:byte=$F0;	// 10 00 0000
		bX_mask	:byte=$C0;	// 11 00 0000


// https://wiki.freepascal.org/UTF8_strings_and_characters
// https://en.wikipedia.org/wiki/Byte_order_mark

function IsUnicodeChar(p:pByte):boolean;
begin
	result:=true;
	//1 byte : 0xxxxxxx
	if  (p^<>$0) and (p^<$80) then exit;
	//2 bytes : p and 111xxxxx =  110xxxxx C0 10xxxxxx 80
	if ( (p^ and b2_mask) = b2_val) and ( ((p+1)^ and bX_mask)=bX_val) then exit;

	//3 bytes : 1110xxxx E0 10xxxxxx 80 10xxxxxx 80
	if ( (p^ and b3_mask) = b3_val) 
		and ( ((p+1)^ and bX_mask)=bX_val)
		and ( ((p+2)^ and bX_mask)=bX_val)
	then exit;


	//4 bytes : 1111 0xxx F0 10xxxxxx 10xxxxxx 10xxxxxx
	if ( (p^ and b4_mask) = b4_val) 
		and ( ((p+1)^ and bX_mask)=bX_val)
		and ( ((p+2)^ and bX_mask)=bX_val)
		and ( ((p+3)^ and bX_mask)=bX_val)
	then exit;

	result:=false;
end;



function canDecodeImpl(buffer:pbyte):integer;
begin 
	if (buffer^=$EF) and ((buffer+1)^=$BB) and ((buffer+2)^=$BF) then result:=3			// If UTF8 BOM then we can decode 
	else if IsUnicodeChar(buffer) then result:=0										// If No BOM but a valid UTF8 then we can decode
	else result:=-1;  																		// Otherwise we can´t decode
	WriteLn('Result iid CANDECODE IMPLE IS '+IntToStr(result));
end;          

function TjsUtf8.decode(buffer:pbyte;size:integer):unicodestring;           // Decode without BOM
var kind:integer;
begin
	kind:=canDecodeImpl(buffer);
	if (kind<>-1)  then SetString(result,pchar(buffer+kind),size-kind) else result:=''; 
end;

function TjsUtf8.canDecode(buffer:pbyte):boolean;
begin
	result:=canDecodeImpl(buffer)<>-1;
end;

function TjsUtf8.Name:string;
begin
	result:='UTF-8 decoder';
end;



initialization

finalization

end.