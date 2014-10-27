unit Utils_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Vcl.StdCtrls;

function ExtractFileNameWithoutExt(const FileName: string): string;
function MinuteToHourMinute(minute: integer): string;
function formatdateEngToFrench(date: string): string;
procedure RemoveDuplicates(const stringList: TStringList);
function GetParentDirectory(path: string): string;
function HourToSec(hour: string): integer;
function IsNumeric(str: string): boolean;

implementation

function ExtractFileNameWithoutExt(const FileName: string): string;
begin
  Result := ChangeFileExt(ExtractFileName(FileName), '');
end;

function MinuteToHourMinute(minute: integer): string;
var
  H, M: integer;
  Hs, Ms: string;
begin
  H := minute div 60;
  M := minute mod 60;

  Hs := IntToStr(H);
  Ms := IntToStr(M);
  if Length(Hs) = 1 then
    Hs := '0' + Hs;
  if Length(Ms) = 1 then
    Hs := '0' + Ms;
  Result := Hs + ':' + Ms;

end;

function formatdateEngToFrench(date: string): string;
var
  y, M, d: string;
begin
  // xxxx/xx/xx
  y := Copy(date, 0, 4);
  M := Copy(date, 6, 2);
  d := Copy(date, 9, 2);
  Result := d + '/' + M + '/' + y;
end;

function HourToSec(hour: string): integer;
var
  Hs, Ms, s: string;
  i, j: integer;
  numlist: array [0 .. 2] of string;
  b: boolean;
begin
  try
    j := 0;
    for i := 1 to hour.Length do

      if IsNumeric(hour[i]) = true then
        numlist[j] := numlist[j] + hour[i]
      else
        j := j + 1;

    if j > 2 then
      Result := 0;
    if numlist[2] <> '' then
      Result := ((StrToInt(numlist[0]) * 60) + StrToInt(numlist[1])) * 60 +
        StrToInt(numlist[2])
    else
      Result := ((StrToInt(numlist[0]) * 60) + StrToInt(numlist[1])) * 60;
  except
    Result := 0;
  end;

end;

function IsNumeric(str: string): boolean;
var
  s: String;
  iValue, iCode: integer;
begin

  val(str, iValue, iCode);
  if iCode = 0 then
    Result := true
  else
    Result := false;
end;

procedure RemoveDuplicates(const stringList: TStringList);
var
  buffer: TStringList;
  cnt: integer;
begin
  stringList.Sort;
  buffer := TStringList.Create;
  try
    buffer.Sorted := true;
    buffer.Duplicates := dupIgnore;
    buffer.BeginUpdate;
    for cnt := 0 to stringList.Count - 1 do
      buffer.Add(stringList[cnt]);
    buffer.EndUpdate;
    stringList.Assign(buffer);
  finally
    FreeandNil(buffer);
  end;
end;

function GetParentDirectory(path: string): string;
begin
  Result := ExpandFileName(path + '\..')
end;

end.
