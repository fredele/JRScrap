// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit String_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, myDebug, StrUtils, Vcl.ExtCtrls, TypInfo, IOUtils;

type
  TArrayOfString = array of String;

function SplitStr(chaine: String; delimiteur: string): TStringList;
procedure RemoveDuplicates(const stringList: TStringList);
procedure MergeStrinList(L1: TStringList; L2: TStringList);
function StringListContainsstring(L1: TStringList; str: string): boolean;
function ReadFileToString_UTF8(filename: string): string;
function ReadFileToString_ANSI(filename: string): string;
function IsNumeric(str: string): boolean;
function Deletelastchar(str: string): string;
function Deletefirstchar(str: string): string;
function DeletefirstandLastchar(str: string): string;
function DeleteAccents(AText: String): string;
function DeleteAllSpaces(AText: String): string;
function SplitString(const aSeparator, aString: String; aMax: Integer = 0)
  : TArrayOfString;
procedure deleteAllIdentical(strlist: TStringList);
function CapitalizeFirstLetter(str: string): string;
function serialize(List: TStringList): string; overload;
function serialize(List: TStrings): string; overload;
function serialize(List: TArrayOfString): string; overload;
function ArrayofStringToStringList(ar: TArrayOfString): TStringList;
function replaceStr(str, org, repl: string): string;
function ExtractText(const str: string; const Delim1, Delim2: string)
  : TStringList;
Function StringToStream(const aString: string): TStream;
procedure StringToFile(const filename, SourceString: string);
function SplitString2(sep: char; str: string): TStrings;

implementation

procedure StringToFile(const filename, SourceString: string);

begin
  with TStringList.Create do
    try
      Add(SourceString);
      SaveToFile(filename);
    finally
      Free;
    end;

end;

function SplitString2(sep: char; str: string): TStrings;
var
  List: TStrings;
begin

  List := TStringList.Create;
  try
    List.Clear;
    List.Delimiter := sep;
    List.DelimitedText := str;
    result := List;
  finally
    debug(List.count);
  end;
end;

Function StringToStream(const aString: string): TStream;
begin
  result := TStringStream.Create(aString);
end;

function ExtractText(const str: string; const Delim1, Delim2: string)
  : TStringList;
var
  c, pos1, pos2: Integer;
begin
  result := TStringList.Create;
  c := 1;
  pos1 := 1;

  while pos1 > 0 do
  begin
    pos1 := PosEx(Delim1, str, c);
    if pos1 > 0 then
    begin
      pos2 := PosEx(Delim2, str, pos1 + 1);
      if pos2 > 0 then
        result.Add(Copy(str, pos1 + length(Delim1),
          pos2 - (length(Delim1) + pos1)));
      c := pos1 + 1;
    end;

  end;
end;

function replaceStr(str, org, repl: string): string;
begin
  result := stringreplace(str, org, repl, [rfReplaceAll, rfIgnoreCase]);
end;

function ArrayofStringToStringList(ar: TArrayOfString): TStringList;
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  for i := 0 to length(ar) - 1 do
  begin
    if ar[i] <> emptystr then
      sl.Add(ar[i]);
  end;
  result := sl;
end;

function serialize(List: TArrayOfString): string;
var
  i: Integer;
  s: string;
begin
  for i := 0 to length(List) - 1 do
  begin
    s := List[i] + ';';
  end;
  s := Deletelastchar(s);
  result := s;
end;

function serialize(List: TStringList): string;
var
  s: string;
  i: Integer;
begin
  for i := 0 to List.count - 1 do
  begin
    s := s + ';' + List[i];
  end;
  result := Copy(s, 2, length(s) - 1);
end;

function serialize(List: TStrings): string;
var
  s: string;
  i: Integer;
begin
  for i := 0 to List.count - 1 do
  begin
    s := s + ';' + List[i];
  end;
  result := Copy(s, 2, length(s) - 1);
end;

function CapitalizeFirstLetter(str: string): string;
begin
  Deletefirstchar(str);
  str := uppercase(str[1]) + Deletefirstchar(str);
  result := str;
end;

function DeletefirstandLastchar(str: string): string;
begin
  Deletefirstchar(str);
  Deletelastchar(str);
  result := str;
end;

function SplitString(const aSeparator, aString: String; aMax: Integer = 0)
  : TArrayOfString;
var
  i, strt, cnt: Integer;
  sepLen: Integer;

  procedure AddString(aEnd: Integer = -1);
  var
    endPos: Integer;
  begin
    if (aEnd = -1) then
      endPos := i
    else
      endPos := aEnd + 1;

    if (strt < endPos) then
      result[cnt] := Copy(aString, strt, endPos - strt)
    else
      result[cnt] := '';

    Inc(cnt);
  end;

begin
  if (aString = '') or (aMax < 0) then
  begin
    SetLength(result, 0);
    EXIT;
  end;

  if (aSeparator = '') then
  begin
    SetLength(result, 1);
    result[0] := aString;
    EXIT;
  end;

  sepLen := length(aSeparator);
  SetLength(result, (length(aString) div sepLen) + 1);

  i := 1;
  strt := i;
  cnt := 0;
  while (i <= (length(aString) - sepLen + 1)) do
  begin
    if (aString[i] = aSeparator[1]) then
      if (Copy(aString, i, sepLen) = aSeparator) then
      begin
        AddString;

        if (cnt = aMax) then
        begin
          SetLength(result, cnt);
          EXIT;
        end;

        Inc(i, sepLen - 1);
        strt := i + 1;
      end;

    Inc(i);
  end;

  AddString(length(aString));

  SetLength(result, cnt);
end;

function DeleteAllSpaces(AText: String): string;
begin
  result := stringreplace(AText, ' ', '', [rfReplaceAll]);
end;

function DeleteAccents(AText: String): string;
const
  Char_Accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ';
  Char_Sans_Accents = 'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn';
var
  i: Integer;
  sTemp: String;
begin
  sTemp := AText;
  For i := 1 to length(Char_Accents) do
    // sTemp := FastReplace(sTemp, Char_Accents[i], Char_Sans_Accents[i]);
    sTemp := stringreplace(sTemp, Char_Accents[i], Char_Sans_Accents[i],
      [rfReplaceAll]);
  result := sTemp;
end;

function Deletefirstchar(str: string): string;
begin
  delete(str, 1, 1);
  result := str;
end;

function Deletelastchar(str: string): string;
begin
  delete(str, length(str), 1);
  result := str;
end;

function StringListContainsstring(L1: TStringList; str: string): boolean;
var
  i: Integer;
begin
  result := false;
  for i := 0 to L1.count - 1 do
    if L1[i] = str then
      result := true;

end;

procedure MergeStrinList(L1: TStringList; L2: TStringList);
var
  i: Integer;
begin
  for i := 0 to L2.count - 1 do
    L1.Add(L2[i]);
end;

function SplitStr(chaine: String; delimiteur: string): TStringList;
var
  L: TStringList;
begin
  L := TStringList.Create;
  L.text := stringreplace(chaine, delimiteur, #13#10, [rfReplaceAll]);

  SplitStr := L;
end;

procedure RemoveDuplicates(const stringList: TStringList);
var
  buffer: TStringList;
  cnt: Integer;
begin
  stringList.Sort;
  buffer := TStringList.Create;
  try
    buffer.Sorted := true;
    buffer.Duplicates := dupIgnore;
    buffer.BeginUpdate;
    for cnt := 0 to stringList.count - 1 do
      buffer.Add(stringList[cnt]);
    buffer.EndUpdate;
    stringList.Assign(buffer);
  finally
    FreeandNil(buffer);
  end;
end;

function ReadFileToString_UTF8(filename: string): string;
begin
  result := TFile.ReadAllText(filename, TEncoding.UTF8);
end;

function ReadFileToString_ANSI(filename: string): string;
begin
  result := TFile.ReadAllText(filename, TEncoding.ANSI);
end;

function IsNumeric(str: string): boolean;
var
  s: String;
  iValue, iCode: Integer;
begin

  val(str, iValue, iCode);
  if iCode = 0 then
    result := true
  else
    result := false;
end;

procedure deleteAllIdentical(strlist: TStringList);
begin

end;

end.
