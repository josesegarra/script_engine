unit demo_utils;

interface 

uses Classes,Sysutils;

type
    TOnError = (doNothing,doThrow);

    function Exists(fname: string):boolean;													// Returns if file exists or not
    function ExistsInLocation(fname:string;OnError:TOnError):string;					    // Check if file exists, if not check in current path


implementation



function Exists(fname: string):boolean;														// Returns if file exists or not
begin
	WriteLn('***      Checking if file exists: '+fname);
	result:=FileExists(fname);
end;


function ExistsInLocation(fname:string;OnError:TOnError):string;												// Check if file exists, if not check in current path
var folder:string;
begin
	result:='';
	if Exists(fname) then result:=fname														// If file exists the return file name
	else begin 
		folder:=ExtractFilePath(paramstr(0));												// Get current folder
		if Exists(folder+fname) then result:=folder+fname;									// If file exists in current folder
	end;
    if ( (result<>'') or (OnError=TOnError.doNothing)) then exit;
    raise Exception.Create('File not found: '+fname);
end;



end.


