// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit XML_Export_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VerySimple_Xml,
  MediaCenter_TLB, debug_Unit, string_Unit, StrUtils,
  JvBaseDlg, JvBrowseFolder, TranslateJRStyle_Unit, Vcl.OleCtrls, SHDocVw,
  File_Unit,
  cyBaseWebBrowser, cyCustomWebBrowser, cyWebBrowser, JvComponentBase, ClipBrd,
  JvPrvwRender, Vcl.ExtCtrls, cyBasePanel, cyPanel;

type
  TXML_Export_Frm = class(TForm)
    CyPanel1: TCyPanel;
    Progress_Lbl: TLabel;
    cyWebBrowser1: TcyWebBrowser;
    Generate_Btn: TButton;
    Overview_Lbl: TLabel;
    Print_Btn: TButton;
    Proc_Lbl: TLabel;
    Save_HTML: TButton;
    Save_XML_Btn: TButton;
    SaveDialog1: TSaveDialog;
    XSL_File_List: TListBox;
    XSLSelect_Lbl: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Save_XML_BtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Generate_BtnClick(Sender: TObject);
    function CreateXML: boolean;
    procedure cyWebBrowser1DocumentComplete(ASender: TObject;

      const pDisp: IDispatch; const URL: OleVariant);
    procedure Print_BtnClick(Sender: TObject);
    procedure Save_HTMLClick(Sender: TObject);
  end;

var
  XML_Export_Frm: TXML_Export_Frm;
  FXMLfile, stylesheet_name, stylesheet_filename: string;
  Movies, Movie: TXmlNode;
  FField: IMJFieldsAutomation;
  list: TStringList;
  fieldname, fielddata, s: string;
  typ: Txmlnodetype;
  XMLExport: TXmlVerySimple;
procedure WBPrintPreview(WB: TcyWebBrowser);
function Transform(XMLContent: string; XSLContent: string): WideString;
function CorrectUTF8(str: string): string;

implementation

uses
  JRScrap_Unit, XMLDoc, XMLIntf;
{$R *.dfm}

function CorrectUTF8(str: string): string;
const
  MAX_CH = 37;
  tab1: array [1 .. MAX_CH] of string = ('%C3%A1', '%C3%81', '%C3%A4', '%C4%8D',
    '%C4%8C', '%C4%8E', '%C3%A9', '%C4%9B', '%C3%AD', '%C3%8D', '%C4%BE',
    '%C5%99', '%C5%88', '%C5%A1', '%C5%A5', '%C3%BA', '%C3%9A', '%C3%BD',
    '%C5%AF', '%C5%BE', '%C5%BD', '%C5%98', '%C5%A0', '%C3%B4', '%C5%A4',
    '%C4%8F', '%C3%9D', '%C3%89', '%C3%B3', '%C3%A0', '%C5%9A', '%C4%BD',
    '%C3%BC', '%C5%87', '%C5%8D', '%C3%96', '%C3%B6');

  tab2: array [1 .. MAX_CH] of string = ('á', 'Á', 'ä', 'è', 'È', 'Ï', 'é', 'ì',
    'í', 'Í', '¾', 'ø', 'ò', 'š', '', 'ú', 'Ú', 'ý', 'ù', 'ž', 'Ž', 'Ø', 'Š',
    'ô', '', 'ï', 'Ý', 'É', 'ó', 'a', 'Œ', '¼', 'ü', 'Ò', 'o', 'Ö', 'ö');
var
  i: integer;
begin
  result := str;

  for i := 1 to MAX_CH do
  begin
    str := stringreplace(str, tab1[i], tab2[i], [rfReplaceAll, rfIgnoreCase]);
  end;
  result := str;

end;

function Transform(XMLContent: string; XSLContent: string): WideString;
var
  XML: IXMLDocument;
  XSL: IXMLDocument;
begin

  XML := LoadXMLData(XMLContent);
  XSL := LoadXMLData(XSLContent);

  XML.DocumentElement.TransformNode(XSL.DocumentElement, result)

end;

// Print Preview
procedure WBPrintPreview(WB: TcyWebBrowser);
var
  vIn, vOut: OleVariant;
begin
  WB.ControlInterface.ExecWB(OLECMDID_PRINTPREVIEW,
    OLECMDEXECOPT_DONTPROMPTUSER, vIn, vOut);
end;

procedure TXML_Export_Frm.Generate_BtnClick(Sender: TObject);
var
  s2, s3, s1, fl: string;
begin

  FXMLfile := JRScrap_frm.FXSLFolder + 'export.xml';

  self.Save_XML_Btn.Enabled := false;
  self.Save_HTML.Enabled := false;
  self.Print_Btn.Enabled := false;

  if CreateXML = true then
  begin

    s2 := LoadFileToStr(stylesheet_filename);
    // XMLExport.SaveToFile(FXMLfile);
    // s1 :=  LoadFileToStr(FXMLfile) ;
    s3 := Transform(XMLExport.Text, s2);
    s3 := CorrectUTF8(s3);
    self.cyWebBrowser1.LoadFromString(s3);

    // .zoom:=0.25; //25%
    // .zoom:=0.5; //50%
    // .zoom:=1.5; //100%
    // .zoom:=2.0; //200%
    // .zoom:=5.0; //500%
    // .zoom:=10.0; //1000%
    cyWebBrowser1.OleObject.Document.Body.Style.Zoom := 0.5;

    self.Save_XML_Btn.Enabled := true;
    self.Save_HTML.Enabled := true;
    self.Print_Btn.Enabled := true;
  end;

end;

procedure TXML_Export_Frm.Print_BtnClick(Sender: TObject);
var
  Zoom: string;
begin
  Zoom := cyWebBrowser1.OleObject.Document.Body.Style.Zoom;
  cyWebBrowser1.OleObject.Document.Body.Style.Zoom := 1;
  WBPrintPreview(self.cyWebBrowser1);
  cyWebBrowser1.OleObject.Document.Body.Style.Zoom := Zoom;
end;

procedure TXML_Export_Frm.Save_HTMLClick(Sender: TObject);
begin
  SaveDialog1.DefaultExt := 'html';
  SaveDialog1.Filter := 'HTML file|*.html';
  if self.SaveDialog1.Execute = true then
  begin
    if fileexists(SaveDialog1.FileName) then
      deletefile(SaveDialog1.FileName);
    self.cyWebBrowser1.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TXML_Export_Frm.Save_XML_BtnClick(Sender: TObject);
var
  i, j, k: integer;
  ExpFolder: string;

begin
  SaveDialog1.DefaultExt := 'xml';
  SaveDialog1.Filter := 'XML file|*.xml';
  if self.SaveDialog1.Execute = true then
  begin
    ExpFolder := extractfilepath(SaveDialog1.FileName);
    CopyFile(PChar(stylesheet_filename),
      PChar(ExpFolder + stylesheet_name), true);
    if fileexists(SaveDialog1.FileName) then
      deletefile(SaveDialog1.FileName);
    XMLExport.SaveToFile(SaveDialog1.FileName);
  end;
end;

function TXML_Export_Frm.CreateXML: boolean;
var
  i, j, k, row: integer;

begin
  result := false;

  if fileexists(FXMLfile) then
    deletefile(FXMLfile);
  XMLExport := TXmlVerySimple.Create;
  FField := JRScrap_frm.MCAutomation.GetFields;
  stylesheet_name := emptystr;
  for i := self.XSL_File_List.items.count - 1 downto 0 do
    if self.XSL_File_List.selected[i] then
    begin
      stylesheet_name := self.XSL_File_List.items[i];
      stylesheet_filename := JRScrap_frm.FXSLFolder + stylesheet_name;
    end;

  if stylesheet_name = emptystr then
  begin
    Showmessage(Translate_String_JRStyle('No XSL selected !',
      JRScrap_frm.FCurrentLang));
    result := false;
    exit;
  end;

  XMLExport.AddChild('xml-stylesheet href="' + stylesheet_name +
    '" type="text/xsl"', ntXmlDecl);
  Movies := XMLExport.AddChild('Movies');
  try
    for i := 0 to JRScrap_frm.Movie_Browser.RowCount - 2 do
    begin
      application.processmessages;
      Movie := Movies.AddChild('Movie');
      self.Progress_Lbl.Caption := inttostr(i) + ' / ' +
        inttostr(FMoviesList.GetNumberFiles - 1);

      for j := 0 to FField.GetNumberFields - 1 do
      begin

        row := strtoint(JRScrap_frm.Movie_Browser.Cells[0, i + 1]);
        // Name in ENG
        if FMoviesList.GetFile(row).Get(FField.GetField(j).GetName(false), true)
          <> emptystr then
        begin

          if AnsiContainsStr(FMoviesList.GetFile(row)
            .Get(FField.GetField(j).GetName(false), true), ';') then
          begin
            fieldname := replaceStr(FField.GetField(j).GetName(false),
              ' ', '_');
            fieldname := replaceStr(fieldname, '(', '');
            fieldname := replaceStr(fieldname, ')', '');

            if assigned(list) then
              list.Free;
            list := TStringList.Create;
            fielddata := FMoviesList.GetFile(row)
              .Get(FField.GetField(j).GetName(false), true);
            fielddata := replaceStr(fielddata, '(', '');
            fielddata := replaceStr(fielddata, ')', '');
            fielddata := ansistring(fielddata);
            list := SplitStr(fielddata, ';');

            for k := 0 to list.count - 1 do
            begin
              if list[k] <> emptystr then
              begin
                try
                  Movie.AddChild(fieldname).Text := list[k];
                except
                end;
              end;
            end;

          end
          else
          begin
            fieldname := replaceStr(FField.GetField(j).GetName(false),
              ' ', '_');
            fieldname := replaceStr(fieldname, '(', '');
            fieldname := replaceStr(fieldname, ')', '');
            Movie.AddChild(fieldname).Text := FMoviesList.GetFile(row)
              .Get(FField.GetField(j).GetName(false), true);

            if fieldname = 'Image_File' then
            begin
              // Add image filepath in HTML formating ...
              // s := FMoviesList.GetFile(row).Get(FField.GetField(j).GetName(false),true) ;
              s := FMoviesList.GetFile(row).GetImageFile(IMAGEFILE_DISPLAY);
              // debug(s) ;
              s := replaceStr(s, ':\', '|/');
              s := replaceStr(s, '\', '/');
              s := 'file:///' + s;

              Movie.AddChild('Image_File_HTML').Text := s;
            end;

          end;
        end;
      end;

    end;
  except
    self.Progress_Lbl.Caption := 'ERROR !';
  end;

  result := true;
end;

procedure TXML_Export_Frm.cyWebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin

  // WBPrintPreview(self.cyWebBrowser1) ;
  self.Progress_Lbl.Caption := Translate_String_JRStyle('OK',
    JRScrap_frm.FCurrentLang);

end;

procedure TXML_Export_Frm.FormActivate(Sender: TObject);
var
  SR: TSearchRec;
begin
  self.Top := JRScrap_frm.Top + round((JRScrap_frm.Height - self.Height) / 2);
  self.Left := JRScrap_frm.Left + round((JRScrap_frm.Width - self.Width) / 2);

  self.XSLSelect_Lbl.Caption := Translate_String_JRStyle
    ('Select XSL rendering file :', JRScrap_frm.FCurrentLang);
  self.Proc_Lbl.Caption := Translate_String_JRStyle('Processing :',
    JRScrap_frm.FCurrentLang);
  self.Save_XML_Btn.Caption := Translate_String_JRStyle('Save XML/XSL',
    JRScrap_frm.FCurrentLang);
  self.Save_HTML.Caption := Translate_String_JRStyle('Save HTML',
    JRScrap_frm.FCurrentLang);
  self.Print_Btn.Caption := Translate_String_JRStyle('Print',
    JRScrap_frm.FCurrentLang);
  self.Overview_Lbl.Caption := Translate_String_JRStyle('Overview',
    JRScrap_frm.FCurrentLang);
  self.Generate_Btn.Caption := Translate_String_JRStyle('Generate',
    JRScrap_frm.FCurrentLang);
  try
    if FindFirst(JRScrap_frm.FXSLFolder + '*.xsl', faArchive, SR) = 0 then
    begin
      repeat
        XSL_File_List.items.Add(SR.Name);
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
  except

  end;

  try
    self.XSL_File_List.selected[0] := true;
  except
  end;
end;

procedure TXML_Export_Frm.FormShow(Sender: TObject);
begin
  self.Caption := Translate_String_JRStyle('Export', JRScrap_frm.FCurrentLang);
end;

end.
