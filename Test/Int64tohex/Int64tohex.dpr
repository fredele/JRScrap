program Int64tohex;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Math_Unit in '..\..\JRScrap_src\Math_Unit.pas';

var
res : string ;
begin

res := Int64ToHex(10) ;
res := Int64ToHex(-10) ;
res := Int64ToHex(-4039812719335662738) ;   //C7EFB3BC50E49B6E

end.
