unit SubDB_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cyBasePanel,
  IdHashMessageDigest, idHash, IdGlobal, Threadsearch_unit, types_unit,
  string_unit, debug_Unit, Utils_unit, TranslateJRStyle_Unit,
  cyPanel, Vcl.Imaging.pngimage;

type
  TSubDB_Frm = class(TForm)
    CyPanel1: TCyPanel;
    Download_Btn: TButton;
    ListBox1: TListBox;
    Status_Lbl: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure After_Get_Laguages(str: string);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Download_BtnClick(Sender: TObject);
    procedure After_Get_srt(str: string);
  private

  public

  end;

var
  SubDB_Frm: TSubDB_Frm;

function CalcSubDBHash(const FileName: TFileName): string;

implementation

uses
  JRScrap_unit;
{$R *.dfm}

function CalcSubDBHash(const FileName: TFileName): string;
const
  b = 65536;
var
  stream: TFileStream;
  i: Integer;
  eightbyte_begin: array [0 .. b] of byte;
  eightbyte_end: array [0 .. b] of byte;
  idmd5: TIdHashMessageDigest5;
  extract: TIdBytes;
begin

  for i := 0 to 65536 do
  begin
    eightbyte_begin[i] := 0;
    eightbyte_end[i] := 0;
  end;
  Setlength(extract, b * 2);
  stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try

    stream.Seek(0, soBeginning);
    stream.Read(eightbyte_begin, b);
    stream.Seek(-b, soEnd);
    stream.Read(eightbyte_end, b);

    for i := 0 to b do
    begin
      extract[i] := eightbyte_begin[i];
    end;
    for i := 0 to b do
    begin
      extract[i + b] := eightbyte_end[i];
    end;

    idmd5 := TIdHashMessageDigest5.Create;
    result := idmd5.Hashbytesashex(extract);

  finally
    stream.Free;
    idmd5.Free;
  end;
end;

procedure TSubDB_Frm.After_Get_srt(str: string);
var
  FileName: string;
begin

  if str <> emptystr then
  begin
    FileName := JRScrap_frm.FCurrentMoviePath +
      CalcSubDBHash(FCurrentMovie.FileName) + '.srt';
    StringToFile(FileName, str);

    showmessage(Translate_String_JRStyle('File Downloaded !',
      JRScrap_frm.FCurrentLang));
  end
  else
  begin

  end;
  screen.Cursor := crdefault;
end;

procedure TSubDB_Frm.Download_BtnClick(Sender: TObject);
var
  rq, ua: string;
  Thrd_Search: TThreadsearch;
begin

  screen.Cursor := crHourglass;
  rq := 'http://api.thesubdb.com/?action=download&hash=' +
    CalcSubDBHash(FCurrentMovie.FileName) + '&language=' + self.ListBox1.Items
    [self.ListBox1.itemindex];

  try
    ua := 'SubDB/1.0 (JRScrap/0.2; https://github.com/fredele/JRScrap)';
    Thrd_Search := TThreadsearch.Create(nil, ua, Tcod.utf8, rq, After_Get_srt);
  except
    screen.Cursor := crdefault;
    JRScrap_frm.logger.error('Error: Error for this request');
  end;

end;

procedure TSubDB_Frm.FormActivate(Sender: TObject);
var
  rq, ua: string;
  Thrd_Search: TThreadsearch;
begin

  self.Top := JRScrap_frm.Top + round((JRScrap_frm.Height - self.Height) / 2);
  self.Left := JRScrap_frm.Left + round((JRScrap_frm.Width - self.Width) / 2);

  rq := 'http://api.thesubdb.com/?action=search&hash=' +
    CalcSubDBHash(FCurrentMovie.FileName);
  screen.Cursor := crHourglass;

  try
    ua := 'SubDB/1.0 (JRScrap/0.2; https://github.com/fredele/JRScrap)';
    Thrd_Search := TThreadsearch.Create(nil, ua, Tcod.utf8, rq,
      After_Get_Laguages);
  except
    screen.Cursor := crdefault;
    JRScrap_frm.logger.error('Error: Error for this request');
  end;
  application.ProcessMessages;

  self.Download_Btn.Caption := Translate_String_JRStyle('Download',
    JRScrap_frm.FCurrentLang);
  self.Status_Lbl.Caption := Translate_String_JRStyle('Searching ...',
    JRScrap_frm.FCurrentLang);

end;

procedure TSubDB_Frm.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  s: string;
  png: TPNGImage;
  bmp: TBitmap;
begin
  debug(ListBox1.Items[Index]);
  with ListBox1.Canvas do
  begin

    TextOut(Rect.Left + 22, Rect.Top, AnsiUpperCase(ListBox1.Items[Index]));

    s := GetParentDirectory(JRScrap_frm.FAppPath) + '\images\flags\' +
      ListBox1.Items[Index] + '.png';
    if Fileexists(s) = true then
    begin

      png := TPNGImage.Create;
      png.LoadFromFile(s);

      bmp := TBitmap.Create;
      bmp.assign(png);

      Draw(Rect.Left, Rect.Top + 3, bmp);

      bmp.Free;
      png.Free;
    end;

  end;
end;

procedure TSubDB_Frm.After_Get_Laguages(str: string);
var
  FileName: string;
  List: TStrings;
  i: Integer;
begin
  if str = emptystr then
  begin
    showmessage(Translate_String_JRStyle('No results for this search !',
      JRScrap_frm.FCurrentLang));
    PostMessage(self.Handle, wm_close, 0, 0);
  end;

  self.ListBox1.Items := SplitString2(',', str);
  self.Download_Btn.Enabled := true;
  screen.Cursor := crdefault;
  self.Status_Lbl.Caption := Translate_String_JRStyle('OK',
    JRScrap_frm.FCurrentLang);
  self.ListBox1.itemindex := 0;
end;

end.
