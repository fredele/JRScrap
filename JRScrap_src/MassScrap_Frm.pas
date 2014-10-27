unit MassScrap_Frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, myStringUtil, StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, uLkJSON,
  ThreadSearch, Utils_Unit, JRiverXML_Unit, MediaCenter_TLB,
  Vcl.ExtCtrls, Registry,TranslateJRStyle_Unit, Vcl.CheckLst ;

type
  TForm3 = class(TForm)
    ProgressBar1: TProgressBar;
    progresscount_Lbl: TLabel;
    Label2: TLabel;
    Film_Lbl: TLabel;
    Label1: TLabel;
    Button2: TButton;
    Timer1: TTimer;
    MassScrap_Field_list: TCheckListBox;
    Button1: TButton;
    CheckBox1 : TCheckBox;
    select_lbl: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure MassTag;
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure MassScrap_Field_listClick(Sender: TObject);

  public

  end;

var
  stop: boolean;
  Form3: TForm3;
  MyThreadSearch: TThreadsearch;
  loop: integer;
  check : boolean ; //KEEP IT !
  firstrun: boolean;
  FileinParamFound: boolean;

implementation

uses
  Themoviedb_Frm;

{$R *.dfm}



procedure TForm3.Button1Click(Sender: TObject);
begin
if self.Height = 270  then
begin
   self.Height := 440 ;
   self.Button1.Caption := '<<<' ;
end
   else
   begin
   self.Height := 270  ;

   self.Button1.Caption := '...' ;
   end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin

  check := self.CheckBox1.Checked;

  if self.Button2.Caption = 'STOP' then
  begin
    self.Button2.Caption := 'Go !';
    stop := true;
    Themoviedb.FMassScrap := False;
    self.MassScrap_Field_list.Enabled := true ;
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
    Themoviedb.FMassScrap := true;
    self.MassScrap_Field_list.Enabled := false ;
    loop := Themoviedb.Movie_Browser.row - 1;
    Application.ProcessMessages;
    MassTag;
  end;

end;

procedure TForm3.MassScrap_Field_listClick(Sender: TObject);
var
  I: Integer;
  RegNGFS: TRegistry;
begin

 for I := 1 to 12 do
begin
 if   MassScrap_Field_list.Checked[i-1] = true then
 begin

      Themoviedb.FMassScrapbooleans[i] := '1' ;
 end
 else
 begin
       Themoviedb.FMassScrapbooleans[i] := '0';
 end;
end;


  RegNGFS := TRegistry.Create;
  try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRMoviedB', true) then
    begin
      RegNGFS.WriteString('MassScrapbooleans', Themoviedb.FMassScrapbooleans);
    end;

  except
    RegNGFS.Free;
  end;

end;

procedure TForm3.MassTag;
begin
  try

    if ((firstrun = False) and (FileinParamFound = true)) then
    begin
      Themoviedb.FMassScrap := False;
       halt;
    end;



    firstrun := False;
    Inc(loop);

    if (loop = Themoviedb.FMoviesCount + 1) then
    begin
      Showmessage(FTranslateList[0]);
      self.Button2.Caption := 'Go !';
      stop := true;
      Themoviedb.FMassScrap := False;
      self.CheckBox1.Enabled := true;
      try
        MyThreadSearch.Terminate;
      except

      end;
      Exit;
    end;

    Application.ProcessMessages;
    if Themoviedb.FMassScrap = False then
    begin
      Button2Click(self);
      Exit;
    end;
    try
    Themoviedb.FCurrentJRiverId := StrToint(Themoviedb.Movie_Browser.Cells[0, loop]);
    except
     Themoviedb.logger.error('Error: 121');
    end;
    Themoviedb.FCurrentMovie := Themoviedb.FMoviesList.GetFile(Themoviedb.FCurrentJRiverId);


    Themoviedb.Select_MovieBrowserRow_by_JRiver_ID(Themoviedb.FCurrentJRiverId);

    if ((Themoviedb.FMassScrap = true) and (Themoviedb.FCurrentMovie.get('Lock External Tag Editor', true) <> 'YES')) then
    begin

      if ((Themoviedb.FCurrentMovie.get('IMDb ID', true) <> '' ) or (Themoviedb.FCurrentMovie.get('TheTVDB Series ID', true) <> '')) then
        Themoviedb.View_BtnClick(self)
      else if check = true then
        Themoviedb.Search_BtnClick(self)
      else
        MassTag;
    end

    else
    begin
      MassTag;
    end;
  except

  end;

end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  try
    self.Film_Lbl.Caption := Themoviedb.FCurrentMovie.get('name', true);
    self.ProgressBar1.Position := loop - 1;
    self.progresscount_Lbl.Caption := IntToStr(loop - 1) + ' / ' +
      IntToStr(Themoviedb.FMoviesCount);
  except

  end;

end;

procedure TForm3.CheckBox1Click(Sender: TObject);
var
  RegNGFS: TRegistry;
begin

  RegNGFS := TRegistry.Create;
  try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRMoviedB', true) then
    begin
      RegNGFS.Writebool('MassScrapWimdbID', self.CheckBox1.Checked);
    end;

  except
    RegNGFS.Free;
  end;

end;



procedure TForm3.FormActivate(Sender: TObject);
var
  RegNGFS: TRegistry;
  i: integer;
  s, s2: string;

begin

   RegNGFS := TRegistry.Create;
 try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRMoviedB', False) then
    begin
      Themoviedb.FMassScrapbooleans := RegNGFS.ReadString('MassScrapbooleans') ;
      for i := 1 to 12 do
       begin

        if   Themoviedb.FMassScrapbooleans[i] ='1' then
        self.MassScrap_Field_list.Checked[i-1]   := true
        else
        self.MassScrap_Field_list.Checked[i-1]   := false;
       end;

    end;
  except
    RegNGFS.Free;
  end;

  try
  for i  := 0 to 11 do
    begin
      if (s[i+1] = '1') then
        self.MassScrap_Field_list.Checked[i] := true
        else
         self.MassScrap_Field_list.Checked[i] := false;
    end;
  except

  end;


self.Height := 270 ;
  firstrun := true;

  if Themoviedb.FHideForm = true then
    ShowWindow(Application.Handle, SW_HIDE);


  RegNGFS := TRegistry.Create;
  try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRMoviedB', False) then
    begin
      self.CheckBox1.Checked := RegNGFS.Readbool('MassScrapWimdbID');

    end;
  except
    RegNGFS.Free;
  end;
  check :=  self.CheckBox1.Checked ;
  FileinParamFound := False;
  if Themoviedb.FHideForm = true then
  begin
    s := Themoviedb.FParameterStr;
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
      for i := 0 to Themoviedb.FMoviesCount - 1 do
      begin
        s2 := Themoviedb.FMoviesList.GetFile(i).filename;
        if s2 = s then
        begin
          FileinParamFound := true;
          Themoviedb.FCurrentMovie := Themoviedb.FMoviesList.GetFile(i);
          Themoviedb.FCurrentJRiverId := i;
          self.CheckBox1.Checked := False;
        end;
      end;

      if FileinParamFound = False then
      begin
        Showmessage(FTranslateList[12]);
        Application.Terminate;
      end;

      Themoviedb.Select_MovieBrowserRow_by_JRiver_ID(Themoviedb.FCurrentJRiverId);
      Themoviedb.ShowJRiverId(Themoviedb.FCurrentJRiverId);
      self.Button2Click(self);

    end
    else
    begin
      Themoviedb.Movie_Browser.row := 1;
      Themoviedb.Movie_Browser.Col := 1;
      loop := 1;
    end;

  end;

  stop := False;
  loop := Themoviedb.Movie_Browser.row;
  self.ProgressBar1.Max := Themoviedb.FMoviesCount;

  self.Film_Lbl.Caption := '-';
  TranslateJRStyle(Themoviedb.FCurrentLang, false);
  self.Label2.Caption := FTranslateList[16];
  self.Label1.Caption := FTranslateList[17];
  self.CheckBox1.Caption := FTranslateList[24];
  select_lbl.Caption := FTranslateList[39];
  for i:= 0 to  11  do
  begin
  self.MassScrap_Field_list.Items[i] :=  FTranslateList[i+27];
  end;


end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Themoviedb.FMassScrap := False;
  try
    MyThreadSearch.Terminate;
  except

  end;
  if Themoviedb.FHideForm = true then
  begin

    halt;
  end;

end;

procedure TForm3.FormShow(Sender: TObject);
begin
  if Themoviedb.FHideForm = true then
    ShowWindow(Application.Handle, SW_HIDE);
end;

end.
