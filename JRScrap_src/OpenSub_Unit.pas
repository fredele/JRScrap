unit OpenSub_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdHTTP, Vcl.StdCtrls, ComObj, MSXML,
  Vcl.Grids, AbBase, AbBrowse, AbZBrows, AbUnzper, Vcl.OleServer, Registry,
  ShellAPI,  String_Unit,
  MediaCenter_TLB, Vcl.Menus, TranslateJRStyle_Unit;

type
  TOpenSub_Form = class(TForm)
    StringGrid1: TStringGrid;
    Download: TButton;
    procedure LogIn_Proc;
    procedure FormActivate(Sender: TObject);

    procedure Search_imdbID_Proc;
    procedure DownloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OpenSub_Form1: TOpenSub_Form;


  // NOTE :
  // The functions  LogIn, LogOut, SearchSubtitles come from
  // http://www.yanniel.info/2012/01/open-subtitles-api-in-delphi.html
  // Thanks to him for sharing !!

function LogIn(aUsername, aPassword, aLanguage, aUserAgent: string): string;
function LogOut(aToken: string): string;
function SearchSubtitles(aToken, aSublanguageID, aMovieHash: string;
  aMovieByteSize: Cardinal): string; overload;
function SearchSubtitles(aToken, aSublanguageID: string; aImdbID: Cardinal)
  : string; overload;

procedure DownloadFile(fileaddr, filename: string);

implementation

{$R *.dfm}

uses
  JRScrap_Unit;

var

  Token: string;
  imdb : integer ;
  FCurrentMovieIMDBID, FCurrentMovieFolder: string;
  FNombresdeFilms: Integer;
  Flangshort: string;

procedure DownloadFile(fileaddr, filename: string);
var
  lHTTP: TIdHTTP;
  Fs: TFileStream;
begin
  Fs := TFileStream.Create(filename, fmCreate);
  lHTTP := TIdHTTP.Create(nil);
  lHTTP.get(fileaddr, Fs);
  lHTTP.Free;
  Fs.Free;
end;

function XML_RPC(aRPCRequest: string): string;
const
  cURL = 'http://api.opensubtitles.org/xml-rpc';
var
  lHTTP: TIdHTTP;
  Source, ResponseContent: TStringStream;
begin
  lHTTP := TIdHTTP.Create(nil);
  lHTTP.Request.ContentType := 'text/xml';
  lHTTP.Request.Accept := '*/*';
  lHTTP.Request.Connection := 'Keep-Alive';
  lHTTP.Request.Method := 'POST';
  lHTTP.Request.UserAgent := 'OS Test User Agent';
  Source := TStringStream.Create(aRPCRequest);
  ResponseContent := TStringStream.Create;
  try
    try
      lHTTP.Post(cURL, Source, ResponseContent);
      Result := ResponseContent.DataString;
    except
      Result := '';
    end;
  finally
    lHTTP.Free;
    Source.Free;
    ResponseContent.Free;
  end;
end;

function LogIn(aUsername, aPassword, aLanguage, aUserAgent: string): string;
const
  LOG_IN = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>LogIn</methodName>' + '  <params>' + '    <param>' +
    '      <value><string>%0:s</string></value>' + '    </param>' +
    '    <param>' + '      <value><string>%1:s</string></value>' +
    '    </param>' + '    <param>' +
    '      <value><string>%2:s</string></value>' + '    </param>' +
    '    <param>' + '      <value><string>%3:s</string></value>' +
    '    </param>' + '  </params>' + '</methodCall>';
var
  str: string;
begin
  str := Format(LOG_IN, [aUsername, aPassword, aLanguage, aUserAgent]);
  Result := XML_RPC(str);

end;

function LogOut(aToken: string): string;
const
  LOG_OUT = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>LogOut</methodName>' + '  <params>' + '    <param>' +
    '      <value><string>%0:s</string></value>' + '    </param>' +
    '  </params>' + '</methodCall>';
begin
  Result := XML_RPC(Format(LOG_OUT, [aToken]));
end;

function SearchSubtitles(aToken, aSublanguageID, aMovieHash: string;
  aMovieByteSize: Cardinal): string;
const
  SEARCH_SUBTITLES = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>SearchSubtitles</methodName>' + '  <params>' + '    <param>'
    + '      <value><string>%0:s</string></value>' + '    </param>' +
    '  <param>' + '   <value>' + '    <array>' + '     <data>' + '      <value>'
    + '       <struct>' + '        <member>' +
    '         <name>sublanguageid</name>' +
    '         <value><string>%1:s</string>' + '         </value>' +
    '        </member>' + '        <member>' + '         <name>moviehash</name>'
    + '         <value><string>%2:s</string></value>' + '        </member>' +
    '        <member>' + '         <name>moviebytesize</name>' +
    '         <value><double>%3:d</double></value>' + '        </member>' +
    '       </struct>' + '      </value>' + '     </data>' + '    </array>' +
    '   </value>' + '  </param>' + ' </params>' + '</methodCall>';

begin
  Result := XML_RPC(Format(SEARCH_SUBTITLES, [aToken, aSublanguageID,
    aMovieHash, aMovieByteSize]));
end;

function SearchSubtitles(aToken, aSublanguageID: string;
  aImdbID: Cardinal): string;
const
  SEARCH_SUBTITLES = '<?xml version="1.0"?>' + '<methodCall>' +
    '  <methodName>SearchSubtitles</methodName>' + '  <params>' + '    <param>'
    + '      <value><string>%0:s</string></value>' + '    </param>' +
    '  <param>' + '   <value>' + '    <array>' + '     <data>' + '      <value>'
    + '       <struct>' + '        <member>' +
    '         <name>sublanguageid</name>' +
    '         <value><string>%1:s</string>' + '         </value>' +
    '        </member>' + '        <member>' + '         <name>imdbid</name>' +
    '         <value><string>%2:d</string></value>' + '        </member>' +
    '       </struct>' + '      </value>' + '     </data>' + '    </array>' +
    '   </value>' + '  </param>' + ' </params>' + '</methodCall>';

begin
  Result := XML_RPC(Format(SEARCH_SUBTITLES, [aToken, aSublanguageID,
    aImdbID]));
end;

procedure TOpenSub_Form.Search_imdbID_Proc;
var
  id, i, j, k : Integer;
  str, currentmoviedata, currentmoviefield, lang, s: string;
  success: boolean;
  FXMLReader: IXMLDOMDocument;
  root, node, membernode, datanode, movienode: IXMLDOMNode;
begin
  try

    FXMLReader := CoDOMDocument.Create;
    success := false;
    self.StringGrid1.RowCount := 1;

    s := SearchSubtitles(Token, Flangshort, imdb);
    FXMLReader.loadXML(s);

    root := FXMLReader.DocumentElement;
    if root.childNodes[0].nodeName = 'params' then
    begin
      node := root.childNodes[i];
      if node.childNodes[0].nodeName = 'param' then
      begin
        node := node.childNodes[0];
        if node.childNodes[0].nodeName = 'value' then
        begin
          node := node.childNodes[0];
          if node.childNodes[0].nodeName = 'struct' then
          begin
            node := node.childNodes[0];

            for j := 0 to node.childNodes.length - 1 do
            begin
              membernode := node.childNodes[j];
              str := membernode.nodeName;
              if (membernode.childNodes[0].Text = 'data') then
              begin
                if membernode.childNodes[1].childNodes[0].childNodes[0]
                  .nodeName = 'data' then
                  datanode := membernode.childNodes[1].childNodes[0]
                    .childNodes[0];

                if datanode.childNodes.length >= 1 then
                  self.StringGrid1.RowCount := datanode.childNodes.length
                else
                  self.StringGrid1.RowCount := 2;

                for i := 0 to datanode.childNodes.length - 1 do
                begin
                  movienode := datanode.childNodes[i].childNodes[0];

                  if movienode.nodeName = 'struct' then
                  begin
                    for k := 0 to movienode.childNodes.length - 1 do
                    begin
                      if movienode.childNodes[k].nodeName = 'member' then
                      begin
                        if movienode.childNodes[k].childNodes[0].nodeName = 'name'
                        then
                        begin
                          success := true;
                          currentmoviefield := movienode.childNodes[k]
                            .childNodes[0].Text;
                          if currentmoviefield = 'SubFileName' then
                            self.StringGrid1.Cells[0, i + 1] :=
                              movienode.childNodes[k].childNodes[1]
                              .childNodes[0].Text;

                          if currentmoviefield = 'SubActualCD' then
                            self.StringGrid1.Cells[1, i + 1] :=
                              movienode.childNodes[k].childNodes[1]
                              .childNodes[0].Text;

                          if currentmoviefield = 'SubAddDate' then
                            self.StringGrid1.Cells[2, i + 1] :=
                              movienode.childNodes[k].childNodes[1]
                              .childNodes[0].Text;

                          if currentmoviefield = 'SubDownloadsCnt' then
                            self.StringGrid1.Cells[3, i + 1] :=
                              movienode.childNodes[k].childNodes[1]
                              .childNodes[0].Text;

                          if currentmoviefield = 'UserNickName' then
                            self.StringGrid1.Cells[4, i + 1] :=
                              movienode.childNodes[k].childNodes[1]
                              .childNodes[0].Text;

                          if currentmoviefield = 'ZipDownloadLink' then
                            self.StringGrid1.Cells[5, i + 1] :=
                              movienode.childNodes[k].childNodes[1]
                              .childNodes[0].Text;

                          if currentmoviefield = 'SubFormat' then
                            self.StringGrid1.Cells[6, i + 1] :=
                              movienode.childNodes[k].childNodes[1]
                              .childNodes[0].Text;

                        end;

                      end;

                    end;

                  end;

                end;

              end;
            end;
          end;
        end;
      end;
    end;

    self.StringGrid1.FixedRows := 1;
    if success = false then
    begin
      self.StringGrid1.RowCount := 1;
    end;
  except

    showmessage(Translate_String_JRStyle('No results for this search !',
      JRScrap_Frm.FCurrentLang));
    PostMessage(self.Handle, wm_close, 0, 0);

  end;
end;

procedure TOpenSub_Form.DownloadClick(Sender: TObject);
var
  AbUnZipper1: TAbUnZipper;
  zipfile: string;
begin
  if self.StringGrid1.RowCount <> 1 then
  begin
    zipfile := ExtractFilePath(FCurrentMovie.filename) +
      '\file.zip';
    DownloadFile(self.StringGrid1.Cells[5, self.StringGrid1.Row], zipfile);
    AbUnZipper1 := TAbUnZipper.Create(nil);
    AbUnZipper1.filename := zipfile;
    AbUnZipper1.BaseDirectory := ExtractFilePath(AbUnZipper1.filename);
    AbUnZipper1.ExtractFiles(self.StringGrid1.Cells[0, self.StringGrid1.Row]);
    AbUnZipper1.Free;
    deletefile(zipfile);
    showmessage(Translate_String_JRStyle('File Downloaded !',
      JRScrap_Frm.FCurrentLang));
  end;
end;

procedure TOpenSub_Form.FormActivate(Sender: TObject);
var
  i, j, k: Integer;
  str, currentmoviedata, currentmoviefield: string;

begin


   imdb := strtoint( replacestr(FCurrentMovie.Get('IMDb ID' ,true),'tt','') );

  Flangshort := JRScrap_Frm.FCurrentLangShort;

  if Flangshort = 'fr' then
    Flangshort := 'fre';
  if Flangshort = 'de' then
    Flangshort := 'ger';
  if Flangshort = 'it' then
    Flangshort := 'ita';
  if Flangshort = 'eng' then
    Flangshort := 'eng';

  self.StringGrid1.Cells[0, 0] := Translate_String_JRStyle('FileName',
    JRScrap_Frm.FCurrentLang);
  self.StringGrid1.Cells[1, 0] := Translate_String_JRStyle('CD',
    JRScrap_Frm.FCurrentLang);
  self.StringGrid1.Cells[2, 0] := Translate_String_JRStyle('Add Date',
    JRScrap_Frm.FCurrentLang);
  self.StringGrid1.Cells[3, 0] := Translate_String_JRStyle('Downld. Count',
    JRScrap_Frm.FCurrentLang);
  self.StringGrid1.Cells[4, 0] := Translate_String_JRStyle('UserNickName',
    JRScrap_Frm.FCurrentLang);
  self.StringGrid1.Cells[5, 0] := Translate_String_JRStyle('ZipDownloadLink',
    JRScrap_Frm.FCurrentLang);
  self.StringGrid1.Cells[6, 0] := Translate_String_JRStyle('SubFormat',
    JRScrap_Frm.FCurrentLang);
  self.Download.Caption := Translate_String_JRStyle('Download',
    JRScrap_Frm.FCurrentLang);
  self.StringGrid1.ColWidths[0] := 420;
  self.StringGrid1.ColWidths[1] := 70;
  self.StringGrid1.ColWidths[2] := 140;
  self.StringGrid1.ColWidths[3] := 140;
  self.StringGrid1.ColWidths[4] := 140;
  self.StringGrid1.ColWidths[5] := 0;
  self.StringGrid1.ColWidths[6] := 140;

  application.ProcessMessages;
  self.LogIn_Proc;

  Search_imdbID_Proc;
end;

procedure TOpenSub_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin

  try
    for i := 0 to StringGrid1.RowCount - 1 do
      StringGrid1.rows[i].clear;

  except
  end;
end;

procedure TOpenSub_Form.LogIn_Proc;
var
  i, j: Integer;
  FXMLReader: IXMLDOMDocument;
  root, node, membernode, datanode, movienode: IXMLDOMNode;
begin
  try
    FXMLReader := CoDOMDocument.Create;

    // Login for test purposes :    LogIn('', '', 'en', 'OS Test User Agent')   //
    FXMLReader.loadXML(LogIn('fredele', '', 'en', 'JROpenSub'));
    root := FXMLReader.DocumentElement;

    if root.childNodes[0].nodeName = 'params' then
    begin
      node := root.childNodes[i];
      if node.childNodes[0].nodeName = 'param' then
      begin
        node := node.childNodes[0];
        if node.childNodes[0].nodeName = 'value' then
        begin
          node := node.childNodes[0];
          if node.childNodes[0].nodeName = 'struct' then
          begin
            node := node.childNodes[0];

            for j := 0 to node.childNodes.length - 1 do
            begin
              if node.childNodes[j].nodeName = 'member' then
              begin
                membernode := node.childNodes[j];

                if ((membernode.childNodes[0].Text = 'token') and
                  (membernode.childNodes[0].nodeName = 'name')) then
                  if (membernode.childNodes[1].nodeName = 'value') then
                  begin
                    Token := membernode.childNodes[1].Text;

                  end;
              end;
            end;

          end;

        end;
      end;
    end;
  except

  end;
end;

end.
