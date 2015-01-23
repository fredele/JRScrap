// This file is part of the JRScrap project.

// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit MassScrap_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, myStringUtil, StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, uLkJSON,
  Threadsearch_Unit, Utils_Unit, JRiverXML_Unit, MediaCenter_TLB,
  Vcl.ExtCtrls, Registry, TranslateJRStyle_Unit, Vcl.CheckLst, debug_Unit,
  TheMoviedB_Unit, TVdb_Unit, Freebase_Unit, Traileraddict_Unit, cyBasePanel,
  cyPanel;

type
  TMassScrap_Frm = class(TForm)
    CyPanel1: TCyPanel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Film_Lbl: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Picture_Rec_Chk: TCheckBox;
    ProgressBar1: TProgressBar;
    progresscount_Lbl: TLabel;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure MassTag;
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Picture_Rec_ChkClick(Sender: TObject);
  public

  end;

var
  stop: boolean;
  MyThreadSearch: TThreadsearch;
  loop: integer;
  check: boolean; // KEEP IT !
  firstrun: boolean;
  FileinParamFound: boolean;

implementation

uses
  JRScrap_Unit;

{$R *.dfm}

procedure TMassScrap_Frm.Button2Click(Sender: TObject);
begin

  check := self.CheckBox1.Checked;

  if self.Button2.Caption = 'STOP' then
  begin
    self.Button2.Caption := 'Go !';
    stop := true;
    JRScrap_Frm.FMassScrap := False;

    try
      MyThreadSearch.Terminate;

    except

    end;

    self.CheckBox1.Enabled := true;
  end
  else
  begin

    self.Button2.Caption := 'STOP';
    self.CheckBox1.Enabled := False;
    JRScrap_Frm.FMassScrap := true;
    loop := JRScrap_Frm.Movie_Browser.row - 1;
    Application.ProcessMessages;
    MassTag;
  end;

end;

procedure TMassScrap_Frm.MassTag;
begin
  debug('MassScrap');
  try

    firstrun := False;
    Inc(loop);

    if (loop = JRScrap_Frm.FMoviesCount + 1) then
    begin
      Showmessage(Translate_String_JRStyle('Done !', JRScrap_Frm.FCurrentLang));
      self.Button2.Caption := 'Go !';
      stop := true;
      JRScrap_Frm.FMassScrap := False;
      self.CheckBox1.Enabled := true;
      try
        MyThreadSearch.Terminate;
      except

      end;
      Exit;
    end;

    if JRScrap_Frm.FMassScrap = False then
    begin
      Button2Click(self);
      Exit;
    end;
    try
      JRScrap_Frm.FCurrentJRiverId :=
        StrToint(JRScrap_Frm.Movie_Browser.Cells[0, loop]);
    except
      JRScrap_Frm.logger.error('Error: 121');
    end;
    FCurrentMovie := FMoviesList.GetFile(JRScrap_Frm.FCurrentJRiverId);
    debug('FCurrentMovie' + FCurrentMovie.Name);

    JRScrap_Frm.Select_MovieBrowserRow_by_JRiver_ID
      (JRScrap_Frm.FCurrentJRiverId);

    if (JRScrap_Frm.TheMoviedB_Btn.down = False) then
    begin
      try
        if JRScrap_Frm.Traileraddict_Search_Btn.down = true then
        begin
          debug('Traileraddict');
          TTrailerAddict_Ins := TTrailerAddict_Cl.Create;
          TTrailerAddict_Ins.Search_Name;
        end;
      except

      end;

      try
        if (JRScrap_Frm.freebase_Btn.down = true) then
        begin
          debug('freebase');
          TFreebase_Ins := TFreebase_Cl.Create;
          TFreebase_Ins.Freebase_getID();
        end;
      except

      end;
    end;

    try
      if (JRScrap_Frm.TheMoviedB_Btn.down = true) then
      begin
        // if assigned(TheMoviedB_Ins) then   TheMoviedB_Ins.Free ;
        TheMoviedB_Ins := TTheMoviedB_Cl.Create(JRScrap_Frm.FCurrentJRiverId,
          JRScrap_Frm.FCurrentLangShort);
        TheMoviedB_Ins.Auto_search;
      end;
    except

    end;

    try
      if JRScrap_Frm.TVdb_Btn.down = true then
      begin
        // if assigned(TTvdB_Ins) then  TTvdB_Ins.Free ;

        TTvdB_Ins := TTVdB_Cl.Create(JRScrap_Frm.FCurrentJRiverId,
          JRScrap_Frm.FCurrentLangShort,
          StrToint(JRScrap_Frm.Episode_Ed.Text),
          StrToint(JRScrap_Frm.Season_Ed.Text));
        TTvdB_Ins.Auto_search;
      end;
    except

    end;

  except
    debug('except');
    if loop <= JRScrap_Frm.Movie_Browser.RowCount then
    begin
      // MassTag ;
    end
    else
      Exit;
  end;
end;

procedure TMassScrap_Frm.Picture_Rec_ChkClick(Sender: TObject);
var
  RegNGFS: TRegistry;
begin
 JRScrap_Frm.Writepicture1.Checked :=  not self.Picture_Rec_Chk .checked;
 JRScrap_Frm.Writepicture1Click(nil);
end;

procedure TMassScrap_Frm.Timer1Timer(Sender: TObject);
begin
  try
    self.Film_Lbl.Caption := FCurrentMovie.get('name', true);
    self.ProgressBar1.Position := loop - 1;
    self.progresscount_Lbl.Caption := IntToStr(loop - 1) + ' / ' +
      IntToStr(JRScrap_Frm.FMoviesCount);

    if loop > JRScrap_Frm.FMoviesCount then
    begin
      stop := true;
      JRScrap_Frm.FMassScrap := False;
      try
        MyThreadSearch.Terminate;

      except

      end;

    end;

  except

  end;

end;

procedure TMassScrap_Frm.CheckBox1Click(Sender: TObject);
var
  RegNGFS: TRegistry;
begin

  RegNGFS := TRegistry.Create;
  try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
    begin
      RegNGFS.Writebool('MassScrapWimdbID', self.CheckBox1.Checked);
    end;

  except
    RegNGFS.Free;
  end;

end;

procedure TMassScrap_Frm.FormActivate(Sender: TObject);
var
  RegNGFS: TRegistry;
  I: integer;
  s, s2: string;

begin

  self.Top := JRScrap_frm.Top + round((JRScrap_frm.Height - self.Height) / 2);
  self.Left := JRScrap_frm.Left + round((JRScrap_frm.Width - self.Width) / 2);

  RegNGFS := TRegistry.Create;

  self.Height := 270;
  firstrun := true;

  if JRScrap_Frm.FHideForm = true then
    ShowWindow(Application.Handle, SW_HIDE);

  RegNGFS := TRegistry.Create;
  try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRScrap', False) then
    begin
      try
        self.CheckBox1.Checked := RegNGFS.Readbool('MassScrapWimdbID');
        self.Picture_Rec_Chk.Checked := RegNGFS.Readbool('WritePicture');
      except

      end;

    end;
  except
    RegNGFS.Free;
  end;
  check := self.CheckBox1.Checked;
  FileinParamFound := False;
  if JRScrap_Frm.FHideForm = true then
  begin
    s := JRScrap_Frm.FParameterStr;
    s := trim(s);
    if (AnsiLeftStr(s, 5) = '-hide') then
    begin
      self.Button2.Hide;
      self.CheckBox1.Hide;
      self.ProgressBar1.Hide;
      self.Label2.Top := 10;
      self.Label1.Hide;
      self.Film_Lbl.Top := 10;
      self.Height := 80;
      Delete(s, 1, 6);
      for I := 0 to JRScrap_Frm.FMoviesCount - 1 do
      begin
        s2 := FMoviesList.GetFile(I).Filename;
        if s2 = s then
        begin
          FileinParamFound := true;
          FCurrentMovie := FMoviesList.GetFile(I);
          JRScrap_Frm.FCurrentJRiverId := I;
          self.CheckBox1.Checked := False;
        end;
      end;

      if FileinParamFound = False then
      begin
        Showmessage(Translate_String_JRStyle('This is not a Movie !',
          JRScrap_Frm.FCurrentLang));
        Application.Terminate;
      end;

      JRScrap_Frm.Select_MovieBrowserRow_by_JRiver_ID
        (JRScrap_Frm.FCurrentJRiverId);
      JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);
      self.Button2Click(self);

    end
    else
    begin
      JRScrap_Frm.Movie_Browser.row := 1;
      JRScrap_Frm.Movie_Browser.Col := 1;
      loop := 1;
    end;

  end;

  stop := False;
  loop := JRScrap_Frm.Movie_Browser.row;
  self.ProgressBar1.Max := JRScrap_Frm.FMoviesCount;

  self.Film_Lbl.Caption := '-';
  TranslateJRStyle(JRScrap_Frm.FCurrentLang, False);
  self.Label2.Caption := Translate_String_JRStyle('Media :',
    JRScrap_Frm.FCurrentLang);
  self.Label1.Caption := Translate_String_JRStyle('Progress :',
    JRScrap_Frm.FCurrentLang);
  self.CheckBox1.Caption := Translate_String_JRStyle
    ('Scrap first Media found if API ID is missing', JRScrap_Frm.FCurrentLang);
  self.Picture_Rec_Chk.Caption := Translate_String_JRStyle('Record the picture',
    JRScrap_Frm.FCurrentLang);
end;

procedure TMassScrap_Frm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  JRScrap_Frm.FMassScrap := False;
  try
    MyThreadSearch.Terminate;
  except

  end;
  if JRScrap_Frm.FHideForm = true then
  begin

    halt;
  end;

end;

procedure TMassScrap_Frm.FormShow(Sender: TObject);
begin
  if JRScrap_Frm.FHideForm = true then
    ShowWindow(Application.Handle, SW_HIDE);

  self.Caption := Translate_String_JRStyle('Scrap Medias from this line',
    JRScrap_Frm.FCurrentLang);

end;

end.
