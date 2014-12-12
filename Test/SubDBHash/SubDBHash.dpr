program SubDBHash;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  SubDB_Unit in '..\..\JRScrap_src\SubDB_Unit.pas';
var
filename : string ;
begin
filename := 'justified.mp4' ;

CalcSubDBHash(filename);  // must be edc1981d6459c6111fe36205b4aff6c2


end.
