unit About_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.GIFImg,
  ShellAPI, TranslateJRStyle_Unit,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Label4: TLabel;
    Label_Version: TLabel;
    Image2: TImage;
    Image3: TImage;
    JRiverVersion: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure gt(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  JRScrap_Unit;
{$R *.dfm}

function GetFileVersion(exeName: string): string;
const
  c_StringInfo = 'StringFileInfo\040904E4\FileVersion';
var
  n, Len: cardinal;
  Buf, Value: PChar;
begin
  Result := '';
  n := GetFileVersionInfoSize(PChar(exeName), n);
  if n > 0 then
  begin
    Buf := AllocMem(n);
    try
      GetFileVersionInfo(PChar(exeName), 0, n, Buf);
      if VerQueryValue(Buf, PChar(c_StringInfo), Pointer(Value), Len) then
      begin
        Result := Trim(Value);
      end;
    finally
      FreeMem(Buf, n);
    end;
  end;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  self.Label_Version.Caption := 'Version : ' + GetFileVersion(ParamStr(0));
  JRiverVersion.Caption := 'JRiver Version :' + JRVersion.Version;

  self.Caption := Translate_String_JRStyle('About' ,JRScrap_Frm.FCurrentLang) ;
  self.Label1.Caption :=   Translate_String_JRStyle('This app. is powered by :' ,JRScrap_Frm.FCurrentLang) ;
  self.Label2.Caption :=   Translate_String_JRStyle('Please, consider helping them by providing your data' ,JRScrap_Frm.FCurrentLang) ;
  self.Label4.Caption :=   Translate_String_JRStyle('Click me to see my page on Github !!' ,JRScrap_Frm.FCurrentLang) ;

end;

procedure TForm2.Image1Click(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'https://www.themoviedb.org/';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink), nil,
    nil, SW_SHOW);
end;

procedure TForm2.Image1MouseEnter(Sender: TObject);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TForm2.Image1MouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TForm2.Image2Click(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'http://thetvdb.com/';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink), nil,
    nil, SW_SHOW);

end;

procedure TForm2.Label3Click(Sender: TObject);
var em_subject, em_body, em_mail : string;
 begin
   em_subject := 'JRScrap user feedback';
   em_body := 'Hello,';

   em_mail := 'mailto:frederic.klieber@gmail.com?subject=' +
     em_subject + '&body=' + em_body ;

   ShellExecute(Handle,'open',
     PChar(em_mail), nil, nil, SW_SHOWNORMAL) ;

end;

procedure TForm2.Label3MouseEnter(Sender: TObject);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TForm2.Label3MouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TForm2.Label4Click(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'https://github.com/fredele/JRScrap';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink), nil,
    nil, SW_SHOW);

end;

procedure TForm2.Label4MouseEnter(Sender: TObject);
begin
  Screen.Cursor := crHandPoint;
end;

procedure TForm2.gt(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TForm2.Image3Click(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'http://www.opensubtitles.org';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink), nil,
    nil, SW_SHOW);

end;

end.
