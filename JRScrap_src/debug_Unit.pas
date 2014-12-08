// This file is part of th JRScrap project.
// Licence : GPL v 3
// Website : https://github.com/fredele/JRScrap/
// Year : 2014
// Author : frederic klieber

unit Debug_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, MMSystem,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, StrUtils;

const
  Inistring: string =
    '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- line ';
  EndString: string =
    '                                                                                                                                                                                                                                                           ';

var
  incr: integer;
procedure Debug(s: string); overload;
procedure Debug(i: integer); overload;
procedure Debug(i: extended); overload;
procedure Debug(i: Boolean); overload;

implementation

procedure Debug(s: string);
begin
  OutputDebugString(PChar(Inistring + s + EndString));

end;

procedure Debug(i: integer);
begin
  OutputDebugString(PChar(Inistring + IntToStr(i) + EndString));
end;

procedure Debug(i: Boolean);
begin
  if i = true then
    OutputDebugString(PChar(Inistring + 'YES' + EndString));
  if i = false then
    OutputDebugString(PChar(Inistring + 'NO' + EndString));
end;

procedure Debug(i: extended);
begin
  OutputDebugString(PChar(Inistring + FloatToStr(i) + EndString));
end;

end.
