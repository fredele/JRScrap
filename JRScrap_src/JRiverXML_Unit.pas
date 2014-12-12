// This file is part of the JRScrap project.

// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit JRiverXML_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, VerySimple_Xml, Utils_Unit, debug_Unit,
  String_Unit;

type

  TJRiverXML = class
    XMLDoc: TXmlVerySimple;

  private
  var
    FChildNum: integer;
    FMediafile: string;
    FXMLfile: string;
    FNewFile: boolean;
    MPLNode, ItemNode: TXmlNode;
  public

    constructor Create(mediafile: string);
    Destructor Destroy; override;
    /// <summary>
    /// Set the field or create it if it does not exist
    /// </summary>
    procedure SetField(name, value: string);
    /// <summary>
    /// Test if the field exist
    /// </summary>
    function FieldExists(name: string): integer;
    /// <summary>
    /// returns the mediafile, cannot be changed at runtime
    /// </summary>

    procedure Save_Close;
    procedure Close;
    property mediafile: string read FMediafile;
    property newfile: boolean read FNewFile;

  end;

implementation

uses
  JRScrap_Unit;

procedure TJRiverXML.Save_Close;
begin
  if JRScrap_Frm.WriteXMLsideCar1.Checked = true then
  begin
    XMLDoc.SaveToFile(FXMLfile);
  end;
  XMLDoc := nil;
end;

procedure TJRiverXML.Close;
begin
  XMLDoc := nil;
end;

function TJRiverXML.FieldExists(name: string): integer;
var
  i: integer;
  getname: string;
  node: TXmlNode;
begin
  name := CapitalizeFirstLetter(name);
  result := -1;
  for i := 0 to ItemNode.ChildNodes.Count - 1 do
  begin
    node := ItemNode.ChildNodes[i];
    if node.name = 'Field' then
    begin
      if node.AttributeList[0].value = name then
      begin
        result := i;
        break;
      end;
    end;

  end;

end;

procedure TJRiverXML.SetField(name, value: string);
var
  i: integer;
  getname: string;
  fieldexists_bool: boolean;
  FieldNode: TXmlNode;
  nodenbr: integer;
begin

  if (trim(value) = emptystr) then
    exit;
  if JRScrap_Frm.WriteXMLsideCar1.Checked = false then
    exit;

  try

    name := CapitalizeFirstLetter(name);
    nodenbr := -1;
    nodenbr := FieldExists(name);
    if nodenbr <> -1 then
    begin
      getname := ItemNode.ChildNodes[nodenbr].AttributeList[0].value;
      debug(getname);
      if getname = name then
      begin
        ItemNode.ChildNodes[nodenbr].text := value;
      end;
    end
    else
    begin
      FieldNode := MPLNode.AddChild('Field');
      FieldNode.Attributes['name'] := name;
      FieldNode.text := value;
    end;
  except
    JRScrap_Frm.logger.error('Error XML: name :' + name + 'value: ' + value);
  end;

end;

constructor TJRiverXML.Create(mediafile: string);
var
  MediaFileExt: string;

begin

  FMediafile := mediafile;

  if not FileExists(mediafile) then
  begin
    raise Exception.Create('No such mediafile!');
    exit;
  end;

  MediaFileExt := ExtractFileExt(FMediafile);
  MediaFileExt := Copy(MediaFileExt, 2, length(MediaFileExt) - 1);
  FXMLfile := ExtractFilePath(FMediafile) + ExtractFileNameWithoutExt
    (FMediafile) + '_' + MediaFileExt;
  FXMLfile := FXMLfile + '_JRSidecar.xml';

  XMLDoc := TXmlVerySimple.Create;

  if not FileExists(FXMLfile) then
  begin

    MPLNode := XMLDoc.AddChild('MPL');
    MPLNode.Attributes['Version'] := '2.0';
    MPLNode.Attributes['Title'] := 'JRSidecar';
    ItemNode := MPLNode.AddChild('MPL');
    XMLDoc.SaveToFile(FXMLfile);
  end;

  XMLDoc.LoadFromFile(FXMLfile);
  MPLNode := XMLDoc.ChildNodes[1];
  if MPLNode.name = 'MPL' then
    ItemNode := MPLNode.ChildNodes[0];

end;

Destructor TJRiverXML.Destroy;
begin
  self.XMLDoc := nil;
  inherited;
end;

end.
