unit Languagues_Unit;

interface

uses
  VerySimple_Xml, Utils_Unit, SysUtils, Debug_Unit, Classes;

type
  Language = record
    name: string;
    internal: string;
    tmdb: string;
    tvdb: string;
    opensub: string;
    iso: string;

  end;

var
  Languages: array of Language;

procedure addLanguage(lg: Language); overload;
procedure addLanguage(name, internal, tmdb, opensub: string); overload;
procedure FillLanguages;
procedure DisplayLanguages;

function IsoToInternal(str: string): string;
function InternalToISO(str: string): string;
function InternalToName(str: string): string;
function InternalToOpensub(str: string): string;
function InternalToTMDB(str: string): string;
function InternalToTVDB(str: string): string;
function NameToInternal(str: string): string;
function NameToTMDB(str: string): string;
function TMDBToInternal(str: string): string;
function TMDBToOpensub(str: string): string;

implementation

uses
  JRScrap_Unit;

function IsoToInternal(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].iso = str then
      if Languages[i].internal <> '' then
        result := Languages[i].internal;
  end;
end;

function InternalToISO(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].internal = str then
      if Languages[i].iso <> '' then
        result := Languages[i].iso;
  end;
end;

function TMDBToOpensub(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].tmdb = str then
      if Languages[i].internal <> '' then
        result := Languages[i].opensub;
  end;
end;

function InternalToOpensub(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].internal = str then
      result := Languages[i].opensub;
  end;
end;

function InternalToName(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].internal = str then
      result := Languages[i].name;
  end;
end;

function NameToInternal(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].name = str then
      result := Languages[i].internal;
  end;
end;

function NameToTMDB(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].name = str then
      result := Languages[i].tmdb;
  end;
end;

function InternalToTMDB(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].internal = str then
      result := Languages[i].tmdb;
  end;
end;

function InternalToTVDB(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].internal = str then
      if Languages[i].tvdb <> '' then
        result := Languages[i].tvdb;
  end;
end;

function TMDBToInternal(str: string): string;
var
  i: integer;
begin
  result := str;
  for i := 0 to length(Languages) - 1 do
  begin
    if Languages[i].tmdb = str then
      result := Languages[i].internal;
  end;
end;

procedure DisplayLanguages;
var
  i: integer;

begin
  for i := 0 to length(Languages) - 1 do
  begin
    debug(Languages[i].name);
    debug(Languages[i].internal);
    debug(Languages[i].tmdb);
    debug(Languages[i].opensub);
  end;

end;

procedure addLanguage(lg: Language);
begin
  setlength(Languages, length(Languages) + 1);
  Languages[length(Languages) - 1] := lg;
end;

procedure addLanguage(name, internal, tmdb, opensub: string);
var
  lg: Language;
begin
  lg.name := name;
  lg.internal := internal;
  lg.tmdb := tmdb;
  lg.opensub := opensub;
  addLanguage(lg);
end;

// Fill  Languages array with all Languages available in the XML file
procedure FillLanguages;
var
  i, j: integer;
  Languages_file: string;
  XML_Languages: TXmlVerySimple;
  RootNode, Child: TXmlNode;
  lg: Language;
begin

  Languages_file := GetParentDirectory(JRScrap_Frm.FAppPath) +
    '\languages\languages.xml';
  XML_Languages := TXmlVerySimple.Create;
  if Fileexists(Languages_file) then
  begin
    XML_Languages.LoadFromFile(Languages_file);
    RootNode := XML_Languages.Root.ChildNodes[1];
    debug(XML_Languages.Root.ChildNodes[1].name);

    for i := 0 to RootNode.ChildNodes.Count - 1 do
    begin

      Child := RootNode.ChildNodes[i];

      FillChar(lg, SizeOf(lg), 0);

      for j := 0 to Child.ChildNodes.Count - 1 do
      begin

        if Child.ChildNodes[j].name = 'name' then
          lg.name := Child.ChildNodes[j].Text;

        if Child.ChildNodes[j].name = 'internal' then
          lg.internal := Child.ChildNodes[j].Text;

        if Child.ChildNodes[j].name = 'tmdb' then
          lg.tmdb := Child.ChildNodes[j].Text;

        if Child.ChildNodes[j].name = 'opensub' then
          lg.opensub := Child.ChildNodes[j].Text;

        if Child.ChildNodes[j].name = 'tvdb' then
          lg.tvdb := Child.ChildNodes[j].Text;

        if Child.ChildNodes[j].name = 'iso' then
          lg.iso := Child.ChildNodes[j].Text;


        // add other values here ...

      end;

      addLanguage(lg);
    end;

    // DisplayLanguages ;

  end;

end;

end.
