unit JRiverXML_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Vcl.StdCtrls,
  Utils_Unit;

type

  /// <summary>
  /// Class by wich to access the additionnal XML file created by JRiver
  /// holding the Field values
  /// </summary>
  TJRiverXML = class
    XMLDoc: TXMLDocument;

  private
  var
    FChildNum: integer;
    FMediafile: string;
    FXMLfile: string;
    FNewFile: boolean;
  public
    /// <remarks>
    /// constructor : DO NOT nil the Sender !
    /// </remarks>
    constructor Create(mediafile: string; Sender: TObject);
    Destructor Destroy; override;
    /// <summary>
    /// Set the field or create it if it does not exist
    /// </summary>
    procedure SetField(name, value: string);
    /// <summary>
    /// Test if the field exist
    /// </summary>
    function FieldExists(name: string): boolean;
    /// <summary>
    /// returns the mediafile, cannot be changed at runtime
    /// </summary>
    procedure Close ;
    property mediafile: string read FMediafile;
    property newfile: boolean read FNewFile;

  end;

implementation

function TJRiverXML.FieldExists(name: string): boolean;
var
  i: integer;
  getname: string;

begin
  Result := false;

  with XMLDoc.ChildNodes do
  begin
    if Assigned(FindNode('MPL')) then
    begin
      with Nodes['MPL'].ChildNodes do
      begin
        if Assigned(FindNode('Item')) then
        begin

          for i := 0 to Nodes['Item'].ChildNodes.count - 1 do
          begin
            if Nodes['Item'].ChildNodes[i].NodeName = 'Field' then
            begin
              getname :=
                VarToStr(Nodes['Item'].ChildNodes[i].GetAttributeNS
                ('Name', ''));
              if getname = name then
              begin
                FChildNum := i;
                Result := true;
              end;

            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TJRiverXML.SetField(name, value: string);
var
  i: integer;
  getname: string;
  fieldexists_bool: boolean;
begin

  if FieldExists(name) then
  begin
    XMLDoc.ChildNodes.Nodes['MPL'].ChildNodes.Nodes['Item'].ChildNodes
      [FChildNum].Text := value;
  end
  else
  begin
    with XMLDoc.ChildNodes.Nodes['MPL'].ChildNodes.Nodes['Item']
      .AddChild('Field') do
    begin
      Text := value;
      setattribute('Name', name);
    end;
  end;
  XMLDoc.SaveToFile(FXMLfile);
end;

constructor TJRiverXML.Create(mediafile: string; Sender: TObject);
var
  MediaFileExt: string;
begin
  FMediafile := mediafile;

  if not FileExists(mediafile) then
  begin
    raise Exception.Create('No such mediafile!');
    Exit;
  end;

  if Sender = nil then
  begin
    raise Exception.Create('Set the Sender to a TObject, not nil !');
    // In fact, the TSMLDocument dynamically created here
    // will not function corrrectly if he has no Owner.

    Exit;
  end;

  MediaFileExt := ExtractFileExt(FMediafile);
  MediaFileExt := Copy(MediaFileExt, 2, length(MediaFileExt) - 1);
  FXMLfile := ExtractFilePath(FMediafile) + ExtractFileNameWithoutExt
    (FMediafile) + '_' + MediaFileExt;


  FXMLfile := FXMLfile + '_JRSidecar.xml';

  XMLDoc := TXMLDocument.Create(Sender as TComponent);
  if FileExists(FXMLfile) then
  begin
    FNewFile := false;
    XMLDoc.Active := true;
    XMLDoc.LoadFromFile(FXMLfile);

  end
  else
  begin
    FNewFile := true;
    XMLDoc.Active := true;
    XMLDoc.Version := '1.0';
    XMLDoc.Encoding := 'UTF-8';
    XMLDoc.StandAlone := 'yes';

    XMLDoc.AddChild('MPL');

    With XMLDoc.ChildNodes.Nodes['MPL'] do
    begin
      SetAttributeNS('Version', ' ', '2.0');
      SetAttributeNS('Title', ' ', 'JRSidecar');
      AddChild('Item');
    end;

    XMLDoc.SaveToFile(FXMLfile);
    XMLDoc.LoadFromFile(FXMLfile);

    SetField('Filename', mediafile);
    SetField('Media Sub Type', 'Movie');

  end;

end;

Destructor TJRiverXML.Destroy;
begin
  XMLDoc.Active := false;
  self.XMLDoc := nil;
  inherited;
end;

procedure TJRiverXML.Close ;
begin
 XMLDoc.Active := false;
  self.XMLDoc := nil;
  inherited;
end;

end.
