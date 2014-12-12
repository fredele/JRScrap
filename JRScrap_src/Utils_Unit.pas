// This file is part of the JRScrap project.

// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit Utils_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, StrUtils,
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Vcl.StdCtrls;

function ExtractFileNameWithoutExt(const FileName: string): string;
function MinuteToHourMinute(minute: integer): string;
function formatdateEngToFrench(date: string): string;
procedure RemoveDuplicates(const stringList: TStringList);
function GetParentDirectory(path: string): string;
function HourToSec(hour: string): integer;
function IsNumeric(str: string): boolean;
function CleanFileName(const InputString: string): string;
function MemoryStreamToString1(M: TMemoryStream): AnsiString;
function MemoryStreamToString2(M: TMemoryStream): AnsiString;

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

function CleanFileName(const InputString: string): string;
var
  i: integer;
  ResultWithSpaces: string;
begin

  ResultWithSpaces := InputString;

  for i := 1 to Length(ResultWithSpaces) do
  begin
    // These chars are invalid in file names.
    case ResultWithSpaces[i] of
      '/', '\', ':', '*', '?', '"', '|', ' ', #$D, #$A, #9:
        // Use a * to indicate a duplicate space so we can remove
        // them at the end.
{$WARNINGS OFF} // W1047 Unsafe code 'String index to var param'
        if (i > 1) and ((ResultWithSpaces[i - 1] = ' ') or
          (ResultWithSpaces[i - 1] = '*')) then
          ResultWithSpaces[i] := '*'
        else
          ResultWithSpaces[i] := ' ';

{$WARNINGS ON}
    end;
  end;

  // A * indicates duplicate spaces.  Remove them.
  Result := ReplaceStr(ResultWithSpaces, '*', '');

  // Also trim any leading or trailing spaces
  Result := Trim(Result);

  if Result = '' then
  begin
    raise (Exception.Create('Resulting FileName was empty Input string was: ' +
      InputString));
  end;
end;

function MemoryStreamToString1(M: TMemoryStream): AnsiString;
var
  SS: TStringStream;
begin
  if M <> nil then
  begin
    SS := TStringStream.Create('', CP_UTF8);
    // here did not suffice in the second parameter CP_UTF8
    try
      SS.CopyFrom(M, 0);
      Result := SS.DataString;
    finally
      SS.Free;
    end;
  end
  else
  begin
    Result := '';
  end;
end;

function MemoryStreamToString2(M: TMemoryStream): AnsiString;
begin
  SetString(Result, PAnsiChar(M.Memory), M.Size);
end;

end.
