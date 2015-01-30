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

function StringListContainsstring(L1: TStringList; str: string)
  : integer; overload;
function StringListContainsstring(L1: TStrings; str: string): integer; overload;

function ReadFileToString_UTF8(filename: string): string;
function ReadFileToString_ANSI(filename: string): string;
function IsNumeric(str: string): boolean;
function Deletelastchar(str: string): string;
function Deletefirstchar(str: string): string;
function DeletefirstandLastchar(str: string): string;
function DeleteAccents(AText: String): string;
function DeleteAllSpaces(AText: String): string;
function SplitString(const aSeparator, aString: String; aMax: integer = 0)
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
function DecodeUTF8(const Source: string): WideString;
function Unescape(const s: AnsiString): string;
function UnescapeAndNormalize(const s: AnsiString): string;

implementation

const
  NormalizationC = 1;

function NormalizeString(NormForm: integer; lpSrcString: LPCWSTR;
  cwSrcLength: integer; lpDstString: LPWSTR; cwDstLength: integer): integer;
  stdcall; external 'Normaliz.dll';

function Normalize(const s: string): string;
var
  newLength: integer;
begin
  // in NormalizationC mode the result string won't grow longer than the input string
  SetLength(Result, Length(s));
  newLength := NormalizeString(NormalizationC, PChar(s), Length(s),
    PChar(Result), Length(Result));
  SetLength(Result, newLength);
end;

// Converts /UXXX unicode encoding to the real character in UTF
function UnescapeAndNormalize(const s: AnsiString): string;
begin
  Result := Normalize(Unescape(s));
end;

function Unescape(const s: AnsiString): string;
var
  i: integer;
  j: integer;
  c: integer;
begin
  // Make result at least large enough. This prevents too many reallocs
  SetLength(Result, Length(s));
  i := 1;
  j := 1;
  while i <= Length(s) do
  begin
    if s[i] = '\' then
    begin
      if i < Length(s) then
      begin
        // escaped backslash?
        if s[i + 1] = '\' then
        begin
          Result[j] := '\';
          inc(i, 2);
        end
        // convert hex number to WideChar
        else if (s[i + 1] = 'u') and (i + 1 + 4 <= Length(s)) and
          TryStrToInt('$' + string(Copy(s, i + 2, 4)), c) then
        begin
          inc(i, 6);
          Result[j] := WideChar(c);
        end
        else
        begin
          raise Exception.CreateFmt('Invalid code at position %d', [i]);
        end;
      end
      else
      begin
        raise Exception.Create('Unexpected end of string');
      end;
    end
    else
    begin
      Result[j] := WideChar(s[i]);
      inc(i);
    end;
    inc(j);
  end;

  // Trim result in case we reserved too much space
  SetLength(Result, j - 1);
end;

// --------

function DecodeUTF8(const Source: string): WideString;
var
  Index, SourceLength, FChar, NChar: Cardinal;
begin
  { Convert UTF-8 to unicode }
  Result := '';
  Index := 0;
  SourceLength := Length(Source);
  while Index < SourceLength do
  begin
    inc(Index);
    FChar := Ord(Source[Index]);
    if FChar >= $80 then
    begin
      inc(Index);
      if Index > SourceLength then
        exit;
      FChar := FChar and $3F;
      if (FChar and $20) <> 0 then
      begin
        FChar := FChar and $1F;
        NChar := Ord(Source[Index]);
        if (NChar and $C0) <> $80 then
          exit;
        FChar := (FChar shl 6) or (NChar and $3F);
        inc(Index);
        if Index > SourceLength then
          exit;
      end;
      NChar := Ord(Source[Index]);
      if (NChar and $C0) <> $80 then
        exit;
      Result := Result + WideChar((FChar shl 6) or (NChar and $3F));
    end
    else
      Result := Result + WideChar(FChar);
  end;
end;

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
    Result := List;
  finally
    debug(List.count);
  end;
end;

Function StringToStream(const aString: string): TStream;
begin
  Result := TStringStream.Create(aString);
end;

function ExtractText(const str: string; const Delim1, Delim2: string)
  : TStringList;
var
  c, pos1, pos2: integer;
begin
  Result := TStringList.Create;
  c := 1;
  pos1 := 1;

  while pos1 > 0 do
  begin
    pos1 := PosEx(Delim1, str, c);
    if pos1 > 0 then
    begin
      pos2 := PosEx(Delim2, str, pos1 + 1);
      if pos2 > 0 then
        Result.Add(Copy(str, pos1 + Length(Delim1),
          pos2 - (Length(Delim1) + pos1)));
      c := pos1 + 1;
    end;

  end;
end;

function replaceStr(str, org, repl: string): string;
begin
  Result := stringreplace(str, org, repl, [rfReplaceAll, rfIgnoreCase]);
end;

function ArrayofStringToStringList(ar: TArrayOfString): TStringList;
var
  i: integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  for i := 0 to Length(ar) - 1 do
  begin
    if ar[i] <> emptystr then
      sl.Add(ar[i]);
  end;
  Result := sl;
end;

function serialize(List: TArrayOfString): string;
var
  i: integer;
  s: string;
begin
  for i := 0 to Length(List) - 1 do
  begin
    s := List[i] + ';';
  end;
  s := Deletelastchar(s);
  Result := s;
end;

function serialize(List: TStringList): string;
var
  s: string;
  i: integer;
begin
  for i := 0 to List.count - 1 do
  begin
    s := s + ';' + List[i];
  end;
  Result := Copy(s, 2, Length(s) - 1);
end;

function serialize(List: TStrings): string;
var
  s: string;
  i: integer;
begin
  for i := 0 to List.count - 1 do
  begin
    s := s + ';' + List[i];
  end;
  Result := Copy(s, 2, Length(s) - 1);
end;

function CapitalizeFirstLetter(str: string): string;
begin
  Deletefirstchar(str);
  str := uppercase(str[1]) + Deletefirstchar(str);
  Result := str;
end;

function DeletefirstandLastchar(str: string): string;
begin
  Deletefirstchar(str);
  Deletelastchar(str);
  Result := str;
end;

function SplitString(const aSeparator, aString: String; aMax: integer = 0)
  : TArrayOfString;
var
  i, strt, cnt: integer;
  sepLen: integer;

  procedure AddString(aEnd: integer = -1);
  var
    endPos: integer;
  begin
    if (aEnd = -1) then
      endPos := i
    else
      endPos := aEnd + 1;

    if (strt < endPos) then
      Result[cnt] := Copy(aString, strt, endPos - strt)
    else
      Result[cnt] := '';

    inc(cnt);
  end;

begin
  if (aString = '') or (aMax < 0) then
  begin
    SetLength(Result, 0);
    exit;
  end;

  if (aSeparator = '') then
  begin
    SetLength(Result, 1);
    Result[0] := aString;
    exit;
  end;

  sepLen := Length(aSeparator);
  SetLength(Result, (Length(aString) div sepLen) + 1);

  i := 1;
  strt := i;
  cnt := 0;
  while (i <= (Length(aString) - sepLen + 1)) do
  begin
    if (aString[i] = aSeparator[1]) then
      if (Copy(aString, i, sepLen) = aSeparator) then
      begin
        AddString;

        if (cnt = aMax) then
        begin
          SetLength(Result, cnt);
          exit;
        end;

        inc(i, sepLen - 1);
        strt := i + 1;
      end;

    inc(i);
  end;

  AddString(Length(aString));

  SetLength(Result, cnt);
end;

function DeleteAllSpaces(AText: String): string;
begin
  Result := stringreplace(AText, ' ', '', [rfReplaceAll]);
end;

function DeleteAccents(AText: String): string;
const
  Char_Accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ';
  Char_Sans_Accents = 'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn';
var
  i: integer;
  sTemp: String;
begin
  sTemp := AText;
  For i := 1 to Length(Char_Accents) do
    // sTemp := FastReplace(sTemp, Char_Accents[i], Char_Sans_Accents[i]);
    sTemp := stringreplace(sTemp, Char_Accents[i], Char_Sans_Accents[i],
      [rfReplaceAll]);
  Result := sTemp;
end;

function Deletefirstchar(str: string): string;
begin
  delete(str, 1, 1);
  Result := str;
end;

function Deletelastchar(str: string): string;
begin
  delete(str, Length(str), 1);
  Result := str;
end;

function StringListContainsstring(L1: TStringList; str: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to L1.count - 1 do
    if L1[i] = str then
      Result := i;

end;

function StringListContainsstring(L1: TStrings; str: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to L1.count - 1 do
    if L1[i] = str then
      Result := i;

end;

procedure MergeStrinList(L1: TStringList; L2: TStringList);
var
  i: integer;
begin
  for i := 0 to L2.count - 1 do
    L1.Add(L2[i]);
end;

function SplitStr(chaine: String; delimiteur: string): TStringList;
var
  L: TStringList;
  i: integer;
  s: string;
begin
  L := TStringList.Create;
  L.text := stringreplace(chaine, delimiteur, #13#10, [rfReplaceAll]);

  for i := 0 to L.count - 1 do
  begin
    s := L[i];
    if s[1] = ' ' then
    begin
      s := Deletefirstchar(s);
      L[i] := s;
    end;
  end;

  SplitStr := L;
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
  Result := TFile.ReadAllText(filename, TEncoding.UTF8);
end;

function ReadFileToString_ANSI(filename: string): string;
begin
  Result := TFile.ReadAllText(filename, TEncoding.ANSI);
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

procedure deleteAllIdentical(strlist: TStringList);
begin

end;

end.
