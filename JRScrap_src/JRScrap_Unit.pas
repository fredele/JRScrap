﻿unit JRScrap_Unit;

interface

uses
  TLoggerUnit, TLevelUnit, TFileAppenderUnit, TranslateJRStyle_Unit,
  Vcl.Menus, Vcl.StdCtrls, TheMoviedB_Unit, String_Unit, debug_Unit,
  Vcl.Grids, mnEdit, Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Classes,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Graphics, Vcl.themes,
  Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL, mystringutil, File_Unit,
  IOUtils, JPEG,  VerySimple_Xml,
  MediaCenter_TLB,
  Vcl.Buttons, MassScrap_Unit, About_Frm,
  MC_Commands_Unit, iniFiles, JRiverXML_Unit, Utils_Unit, Math, ShellApi,
  Vcl.OleServer,
  Types_Unit, PngImage, ImageDropDown, StrUtils,
  SHFolder, Registry, Vcl.ImgList, WinShellFolder, Vcl.CheckLst,
  StarPanel_Unit, TVdB_Unit, JvSpeedbar, JvExExtCtrls, JvExtComponent,
  Vcl.Samples.Spin, OpenSub_Unit,  XML_Export_Unit,
  System.Actions, Vcl.ActnList, cyBasePanel, cyPanel, cyBaseLabel, cyLabel,
  cyDBLabel, cyEdit, cyCheckbox, Vcl.ToolWin, FredHostPanel, TransPanel_Unit,
  Image_Form_Unit,JvExStdCtrls, JvListBox, cyBaseButton, cyAdvButton, cyBaseLed,
  cyLed, cyStatusBar, Vcl.CategoryButtons, JvExComCtrls, JvToolBar, JvBaseDlg,
  JvBrowseFolder, Vcl.OleCtrls, SHDocVw, cyBaseWebBrowser, cyCustomWebBrowser,
  cyWebBrowser, JvComponentBase, JvPrint ;

type

  TJRScrap_Frm = class(TForm)
    MainMenu1: TMainMenu;
    Configure1: TMenuItem;
    EnterKeyforthemmoviedbAPI1: TMenuItem;
    Help: TMenuItem;
    Selectlanguage1: TMenuItem;
    WriteXMLsideCar1: TMenuItem;
    Close1: TMenuItem;
    SelectQuerylanguage: TMenuItem;
    Gotofolder: TMenuItem;
    ListBox_Pop: TPopupMenu;
    Delete: TMenuItem;
    Delete2: TMenuItem;
    Panel_Right: TPanel;
    About1: TMenuItem;
    Helppage1: TMenuItem;
    scrapall1: TMenuItem;
    Movie_Browser_Pop: TPopupMenu;
    Eraseallinfo1: TMenuItem;
    Dossiercourant1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Lock1: TMenuItem;
    All2: TMenuItem;
    None2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    SeeLogFile1: TMenuItem;
    Label2: TLabel;
    OpenFolder1: TMenuItem;
    EraseHistory1: TMenuItem;
    Panel_Left: TPanel;
    Update_Timer: TTimer;
    MCAutomation: TMCAutomation;
    ActionList1: TActionList;
    Search_Action: TAction;
    View_Action: TAction;
    Write_Action: TAction;
    cyDBLabel1: TcyDBLabel;
    ScrollBox1: TScrollBox;
    CyPanel5: TCyPanel;
    Name_Ed: TmnEdit;
    MemoOverview: TMemo;
    Release_date_Ed: TcyEdit;
    Star_Panel: TStar_Panel;
    Picture_Panel: TPanel;
    Picture_Img: TImage;
    Cast_Grid: TStringGrid;
    Serie_Pnl: TPanel;
    Serie_Title_Ed: TmnEdit;
    Season_Spin_Ed: TcyEdit;
    Label4: TLabel;
    Episode_Spin_Ed: TcyEdit;
    tvdb_id_Ed: TcyEdit;
    Movie_Pnl: TPanel;
    Original_title_Ed: TmnEdit;
    imdb_id_Ed: TcyEdit;
    Tmdb_id_Ed: TcyEdit;
    Keywords_ListBox: TJvListBox;
    Genre_ListBox: TJvListBox;
    Production_Company_ListBox: TJvListBox;
    Director_ListBox: TJvListBox;
    Executive_Producer_ListBox: TJvListBox;
    Screenwriter_ListBox: TJvListBox;
    Casting_ListBox: TJvListBox;
    Cinematographer_ListBox: TJvListBox;
    Music_by_ListBox: TJvListBox;
    Novel_ListBox: TJvListBox;
    Production_Design_ListBox: TJvListBox;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label12: TLabel;
    Label28: TLabel;
    cyStatusBar1: TcyStatusBar;
    StatusLed: TcyLed;
    Panel6: TPanel;
    Movie_Browser: TStringGrid;
    XML_Export: TMenuItem;
    ToolBar2: TToolBar;
    TheMoviedB_rd: TSpeedButton;
    TVdb_Rd: TSpeedButton;
    Subtitle_Btn: TButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Panel1: TPanel;
    Media_Sub_Combo: TComboBox;
    SpeedButton1: TSpeedButton;
    Filter_Combo: TComboBox;
    Filter_Ed: TEdit;
    Filter_Btn: TSpeedButton;
    Panel2: TPanel;
    Button2: TButton;
    Write_Btn: TButton;
    Writepicture1: TMenuItem;
    PlayinJRiverMC: TMenuItem;
    ToolButton3: TToolButton;
    PlayList_Combo: TComboBox;

    // Form Procedures

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Write_BtnClick(Sender: TObject);
    procedure LanguageClick(Sender: TObject);
    procedure LanguageQueryClick(Sender: TObject);
    procedure Genre_ListBoxClick(Sender: TObject);
    procedure WriteXMLsideCar1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Createthenewfields1Click(Sender: TObject);


    procedure Duration_EdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);



    procedure GotofolderClick(Sender: TObject);

    procedure Delete1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure Delete3Click(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure About1Click(Sender: TObject);
    procedure Helppage1Click(Sender: TObject);
    procedure Movie_Search_GridClick(Sender: TObject);
    procedure scrapall1Click(Sender: TObject);
    procedure Eraseallinfo1Click(Sender: TObject);
    procedure Movie_BrowserDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

    procedure Dossiercourant1Click(Sender: TObject);
    procedure All2Click(Sender: TObject);
    procedure None2Click(Sender: TObject);
    procedure Movie_BrowserFixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure FormShow(Sender: TObject);
    procedure SeeLogFile1Click(Sender: TObject);
    procedure OpenFolder1Click(Sender: TObject);
    procedure EraseHistory1Click(Sender: TObject);
    procedure Search_BtnClick(Sender: TObject);

    procedure Name_EdKeyPress(Sender: TObject; var Key: Char);

    procedure Media_Sub_ComboChange(Sender: TObject);
    procedure Season_Spin_WEnter(Sender: TObject);
    procedure Episode_Spin_WEnter(Sender: TObject);
    procedure Season_Spin_WExit(Sender: TObject);
    procedure Episode_Spin_WExit(Sender: TObject);
    procedure Episode_Spin_WChange(Sender: TObject);
    procedure Season_Spin_WChange(Sender: TObject);
    procedure Subtitle_BtnClick(Sender: TObject);
    procedure TheMoviedB_rdClick(Sender: TObject);
    procedure Update_TimerTimer(Sender: TObject);
    procedure Search_ActionExecute(Sender: TObject);
    procedure View_ActionExecute(Sender: TObject);
    procedure Write_ActionExecute(Sender: TObject);
    procedure Write_ItmClick(Sender: TObject);
    procedure Write_ImClick(Sender: TObject);
    procedure ScrollBox1Enter(Sender: TObject);
    procedure Movie_BrowserMouseEnter(Sender: TObject);
    procedure ScrollBox1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);

    procedure Panel2MouseLeave(Sender: TObject);
    procedure Movie_BrowserMouseLeave(Sender: TObject);
    procedure Movie_BrowserClick(Sender: TObject);
    procedure Movie_BrowserMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2Enter(Sender: TObject);
    procedure Cast_GridExit(Sender: TObject);
    procedure Cast_GridMouseEnter(Sender: TObject);
    procedure Picture_ImgMouseEnter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Picture_ImgDblClick(Sender: TObject);

    procedure Keywords_ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Button4Click(Sender: TObject);
    procedure Tmdb_id_EdEnter(Sender: TObject);
    procedure Tmdb_id_EdKeyPress(Sender: TObject; var Key: Char);
    procedure Movie_BrowserMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Season_Spin_EdKeyPress(Sender: TObject; var Key: Char);
    procedure Episode_Spin_EdKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Filter_EdKeyPress(Sender: TObject; var Key: Char);
    procedure Filter_BtnClick(Sender: TObject);
    procedure Cast_GridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EdKeyPress(Sender: TObject; var Key: Char);
    procedure Filter_ComboChange(Sender: TObject);
    procedure XML_ExportClick(Sender: TObject);
    procedure Writepicture1Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Cinematographer_ListBoxMouseLeave(Sender: TObject);
    procedure Cast_GridMouseLeave(Sender: TObject);
    procedure PlayinJRiverMCClick(Sender: TObject);
    procedure PlayList_ComboChange(Sender: TObject);

    // *************************************

  public

  var

    // My Variables
    FXSLFolder : string ;
    XMLExport: TXmlVerySimple;
    HPos : integer ;
    FfilterStr : string ;
    Fsearching: Boolean;
    FLangINV: Boolean;
    FJRVersionMajor: Integer;
    Fon_enter: Boolean;
    FAppPath: string;
    logger: TLogger;
    FLogFile: TextFile;
    FTempPath: string;
    FMovie_Browser_Width: Integer;
    FHideForm: Boolean;
    FMovieColumnsSortOrder: array [0 .. 20] of Boolean;
    idd: TImageDropDown<TJPEGImage>;
    FMassScrap: Boolean;
    lock_img: TPNGImage;
    FTheMoviedb_ID: string;
    idHTTP1: TIdHTTP;
    FCurrentMoviePicture: string;
    FStaron_Path: string;
    FStaroff_Path: string;
    FJRiverXml: TJRiverXml;
    Flang: string;
    FParseText: string;
    Fitem: TMenuItem;
    FMoviesCount: Integer;
    Flanguages: TStringList;
    FMesgCount: Integer;
    OldCursor: TCursor;
    FCurrentMoviePath: string;
    FCurrentJRiverId: Integer;
    FCurrentLang, FCurrentLangShort: string;
    FKeywords_List: Set of byte;
    FCurrentSort, FINIPath: string;
    FParameterStr: string;
    FSorttype: TSorttype;
    FlogFolder, FlogFilename: string;


    FBrowerMouseDownRow: Integer;
    // My Procedures
    procedure Filter_Search ;
    procedure SortStringGrid(var GenStrGrid: TStringGrid; ThatCol: Integer);
    procedure fillbrowser;
    Procedure Select_MovieBrowserRow_by_JRiver_ID(currentid: Integer);
    Procedure ShowJRiverId(currentid: Integer);
    procedure ClearAll();
    Procedure Update_Serie_ID;

  end;

var

  JRScrap_Frm: TJRScrap_Frm;
  TheMoviedB_Ins: TTheMoviedB_Cl;
  TTVdB_Ins: TTVdB_Cl;

    JRVersion: IMJVersionAutomation;
    pl: IMJPlaylistautomation;
    FMoviesList: IMJFilesAutomation;
    FCurrentMovie: IMJFileAutomation;
    FNewdBField: IMJFieldsAutomation;
    FPlay :  IMJPlaybackAutomation ;
    FCurrentPlaylist: IMJCurPlaylistAutomation ;
    FPlaylist : IMJPlaylistsAutomation ;
implementation

uses
  Search_Unit;
{$R *.dfm}

Procedure TJRScrap_Frm.Update_Serie_ID;
var
  i, j, curid, searchid, curtvbdid, searchtvbdid, searchjriverid,
    curjriverid: Integer;
begin
  if self.TVdb_Rd.down = true then
  begin
    for i := 1 to self.Movie_Browser.RowCount do
    begin
      try
        self.Movie_Browser.cells[10, i] :=
          FMoviesList.GetFile(strtoint(self.Movie_Browser.cells[0, i]))
          .Get('TheTVDB Series ID', true);
      except
        screen.cursor := crdefault;
        logger.error('Error: 358');
      end;
    end;
  end
  else
  begin
    for i := 1 to self.Movie_Browser.RowCount do
    begin
      try
        self.Movie_Browser.cells[10, i] :=
          FMoviesList.GetFile(strtoint(self.Movie_Browser.cells[0, i]))
          .Get('IMDb ID', true);
      except
        screen.cursor := crdefault;
        logger.error('Error: 358');
      end;
    end;
  end;

end;

procedure TJRScrap_Frm.Update_TimerTimer(Sender: TObject);
begin
  Update_Serie_ID;
end;

procedure TJRScrap_Frm.fillbrowser;
var
  i: Integer;
  s: string;
begin

  try
    for i := 1 to self.Movie_Browser.RowCount - 1 do
      self.Movie_Browser.Rows[i].Clear();
  except

  end;

  self.Movie_Browser.RowCount := 2;
  self.Movie_Browser.Fixedrows := 1;

  FMoviesCount := FMoviesList.GetNumberFiles();
  if FMoviesCount = 0 then
  begin
    ShowMessage(Translate_String_JRStyle('No Media Found !', FCurrentLang));
   // halt; // Terminates the program !!
   Exit ;
  end;

  try

    // Fill Movie Browser
    for i := 0 to FMoviesCount - 1 do
    begin
      application.ProcessMessages ;
      s := FMoviesList.GetFile(i).name;

      self.Movie_Browser.cells[0, i + 1] := IntToStr(i);
      self.Movie_Browser.cells[5, i + 1] := FMoviesList.GetFile(i).name;
      self.Movie_Browser.cells[2, i + 1] := FMoviesList.GetFile(i)
        .Get('Series', true);
      self.Movie_Browser.cells[3, i + 1] := FMoviesList.GetFile(i)
        .Get('Season', true);
      self.Movie_Browser.cells[4, i + 1] := FMoviesList.GetFile(i)
        .Get('Episode', true);
      self.Movie_Browser.cells[7, i + 1] := FMoviesList.GetFile(i)
        .Get('Lock External Tag Editor', true);
      self.Movie_Browser.cells[6, i + 1] :=
        Floattostr(StrToDateTime(FMoviesList.GetFile(i)
        .Get('Date Imported', true)));
      self.Movie_Browser.cells[12, i + 1] := FMoviesList.GetFile(i)
        .Get('Filename', true);
      self.Movie_Browser.cells[9, i + 1] := FMoviesList.GetFile(i)
        .Get('Date Imported', true);

      if TVdb_Rd.down = true then
        self.Movie_Browser.cells[10, i + 1] := FMoviesList.GetFile(i)
          .Get('TheTVDB Series ID', true);

      if self.TheMoviedB_rd.down = true then
        self.Movie_Browser.cells[10, i + 1] := FMoviesList.GetFile(i)
          .Get('IMDb ID', true);

      if length(DeleteAllSpaces(FMoviesList.GetFile(i).Get('Description', true))
        ) <> 0 then
        self.Movie_Browser.cells[11, i + 1] :=
          Leftstr(FMoviesList.GetFile(i).Get('Description', true), 40) + '...';

      self.Movie_Browser.RowCount := self.Movie_Browser.RowCount + 1;

    end;
    // delete last row
    if self.Movie_Browser.RowCount >= 1 then
      self.Movie_Browser.RowCount := self.Movie_Browser.RowCount - 1;

    for i := 0 to FMoviesCount - 1 do
    begin
      if FMoviesList.GetFile(i).filename = trim(s) then
      begin
        FileinParamFound := true;
        FCurrentMovie := FMoviesList.GetFile(i);
        FCurrentJRiverId := i;

      end;
    end;
  except

  end;
end;

procedure ShowFolder(strFolder: string);
begin
  ShellExecute(Application.Handle, PChar('explore'), PChar(strFolder), nil, nil,
    SW_SHOWNORMAL);
end;

function StringListBackwardSortCompare(List: TStringList;
  Index1, Index2: Integer): Integer;

begin
  Result := AnsiCompareStr(List[Index2], List[Index1]);
  // Will sort in reverse order
end;

procedure TJRScrap_Frm.SortStringGrid(var GenStrGrid: TStringGrid;
  ThatCol: Integer);
const
  // Define the Separator
  TheSeparator = '<sep>';
var
  CountItem, i, j, k, ThePosition: Integer;
  MyList: TStringList;
  MyString, TempString, currentid: string;
  s1, s2: string;
     d : integer ;
begin
  currentid := GenStrGrid.cells[0, GenStrGrid.row];

  // Give the number of rows in the StringGrid
  CountItem := GenStrGrid.RowCount;
  // Create the List
  MyList := TStringList.Create;
  MyList.Sorted := false;
  try
    begin
      for i := 1 to (CountItem - 1) do
      begin
        s1 := GenStrGrid.Rows[i].Strings[ThatCol];
        s2 := GenStrGrid.Rows[i].Text;
        s2 := GenStrGrid.Rows[i].Strings[3];
        MyList.Add(GenStrGrid.Rows[i].Strings[ThatCol] + GenStrGrid.Rows[i]
          .Strings[3] + GenStrGrid.Rows[i].Strings[4] + TheSeparator +
          GenStrGrid.Rows[i].Text);
      end;
      // Sort the List
      if FMovieColumnsSortOrder[ThatCol] = true then
      begin
        MyList.Sort;
      end
      else
      begin
        MyList.CustomSort(StringListBackwardSortCompare);
      end;

      for k := 0 to MyList.Count - 1 do
      begin
        // Take the String of the line (K – 1)
        MyString := MyList.Strings[(k)];
        // Find the position of the Separator in the String
        ThePosition := Pos(TheSeparator, MyString);
        TempString := '';
        { Eliminate the Text of the column on which we have sorted the StringGrid }
        TempString := Copy(MyString, (ThePosition), length(MyString));
        MyList.Strings[(k)] := '';
        MyList.Strings[(k)] := TempString;
      end;

      // Refill the StringGrid
      for j := 0 to (CountItem - 2) do

        GenStrGrid.Rows[j + 1].Text := StringReplace(MyList.Strings[j], '<sep>',
          '', [rfReplaceAll, rfIgnoreCase]);
    end;
  finally
    // Free the List
    MyList.Free;
  end;

    for i := 1 to GenStrGrid.RowCount do
      if currentid = GenStrGrid.cells[0, i] then
         GenStrGrid.row := i;

  end;

  procedure TJRScrap_Frm.SpeedButton1Click(Sender: TObject);
begin
  self.Filter_Combo.Enabled := not  self.Filter_Combo.Enabled ;
  self.filter_ed.Enabled := not self.filter_ed.Enabled ;

 if (self.filter_ed.Text <> emptystr) and (self.Filter_Combo.Enabled = true ) then
 Filter_Search ;

 if self.Filter_Combo.Enabled = false   then
 begin
 FfilterStr := '' ;
 Media_Sub_ComboChange(self);
 end;

end;

procedure  TJRScrap_Frm.Filter_Search ;
var
searchStr : string ;
begin
 if ((self.Filter_Combo.Enabled = True ))then
  begin
     if self.Filter_Ed.Text <> emptyStr then
     begin
     if self.Filter_Combo.Text = 'Filename' then
      FfilterStr := '[Filename]="'+ stringreplace(self.Filter_Ed.Text, '"','/"' ,[rfReplaceAll, rfIgnoreCase] ) +'"';

     if self.Filter_Combo.Text = 'Name' then
      FfilterStr := '[Name]="'+ stringreplace(self.Filter_Ed.Text, '"','/"' ,[rfReplaceAll, rfIgnoreCase] ) +'"';

      if self.Filter_Combo.Text = 'Series' then
      FfilterStr := '[Series]="'+ stringreplace(self.Filter_Ed.Text, '"','/"' ,[rfReplaceAll, rfIgnoreCase] ) +'"';

     end
     else
     begin
      FfilterStr := '';
     end;

       searchStr := ' [Media Type]=[Video]  [Media Sub Type]=[' + self.Media_Sub_Combo.Items[self.Media_Sub_Combo.ItemIndex] + ']' +' '+ FfilterStr ;
      FMoviesList := self.MCAutomation.Search(searchstr);
       fillbrowser ;
  end;
   if self.Filter_Combo.Enabled = False then
   begin
       FfilterStr := emptystr ;
   end;
end;

procedure TJRScrap_Frm.Season_Spin_EdKeyPress(Sender: TObject; var Key: Char);
begin
    self.Write_Btn.Enabled := true;
end;

procedure TJRScrap_Frm.Season_Spin_WChange(Sender: TObject);
  begin
    if Fon_enter = true then
      self.Write_Btn.Enabled := true;
  end;

  procedure TJRScrap_Frm.Season_Spin_WEnter(Sender: TObject);
  begin
    Fon_enter := true;
  end;

  procedure TJRScrap_Frm.Season_Spin_WExit(Sender: TObject);
  begin
    Fon_enter := false;
  end;

  procedure TJRScrap_Frm.SeeLogFile1Click(Sender: TObject);
  begin
    try
      ShellExecute(Handle, nil, PChar('notepad.exe'),
        PChar(ExtractFilePath(Application.ExeName) + FTempPath), nil,
        SW_SHOWNORMAL)
    except

    end;
  end;

  procedure TJRScrap_Frm.Cast_GridExit(Sender: TObject);
  begin
    self.SetFocus;
  end;

  procedure TJRScrap_Frm.Cast_GridMouseEnter(Sender: TObject);
  begin

    self.ScrollBox1.SetFocus;
  end;

 procedure TJRScrap_Frm.Cast_GridMouseLeave(Sender: TObject);
begin
Cast_Grid.Selection := TGridRect(Rect(-1, -1, -1, -1));
Cast_Grid.Repaint;
end;

procedure TJRScrap_Frm.Cast_GridSetEditText(Sender: TObject; ACol,
ARow: Integer; const Value: string);
begin
showmessage('coucou');
end;


  procedure TJRScrap_Frm.Cinematographer_ListBoxMouseLeave(Sender: TObject);
var
i : integer ;




for I := 0 to ((sender as TJvListbox).Items.Count - 1) do
     if (sender as TJvListbox).Selected[i] then
       (sender as TJvListbox).Selected[i]  :=  False;

end;

procedure TJRScrap_Frm.ShowJRiverId(currentid: Integer);
  var
    s: string;
    i: Integer;
    List: TStringList;
  begin
    try
      FCurrentMovie := FMoviesList.GetFile(FCurrentJRiverId);
      FCurrentMoviePath := ExtractFilePath(FCurrentMovie.filename);
      debug('Current Movie :' + FCurrentMovie.filename);
      List := TStringList.Create;

    except
      logger.error('Error: 609');
    end;

    s := FCurrentMovie.GetImageFile(IMAGEFILE_DISPLAY);

    if ((Fileexists(s)) and( FileSize(s)<>0 ))then
    begin
      try
        if Fileexists(s) then
        begin
        try
          self.Picture_Img.Picture.LoadFromFile(s);
        except

        end;
          FCurrentMoviePicture := s;

          if ExtractFileName(s) = 'Logo.png' then
          begin
            FCurrentMoviePicture := '';
            self.Picture_Img.Picture := nil;
          end;

        end;
      except
        screen.cursor := crdefault;
        logger.error('Error: loading Picture');
      end;
    end
    else
    begin
      self.Picture_Img.Picture := nil;
    end;

    try



      self.tvdb_id_Ed.Text := FMoviesList.GetFile(FCurrentJRiverId).Get('TheTVDB Series ID', true);
      self.imdb_id_Ed.Text := FCurrentMovie.Get('IMDb ID', true);
      self.Tmdb_id_Ed.Text := FCurrentMovie.Get('TMDb ID', true);






      self.Name_Ed.Text := FCurrentMovie.name;
      self.Serie_Title_Ed.Text := FCurrentMovie.Get('Series', true);
      self.Original_title_Ed.Text := FCurrentMovie.Get('Original title', true);
      self.Season_Spin_Ed.Text := FCurrentMovie.Get('Season', true);
      self.Episode_Spin_Ed.Text := FCurrentMovie.Get('Episode', true);
      self.MemoOverview.Text := FCurrentMovie.Get('Description', true);
      self.Release_date_Ed.Text := FCurrentMovie.Get('Date', true);




      self.Keywords_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Keywords', true), ';');
      self.Production_Company_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Production Company', true), ';');
      self.Genre_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Genre', true), ';');

      self.Casting_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Casting', true), ';');
      self.Executive_Producer_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Executive Producer', true), ';');
      self.Production_Design_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Production Design', true), ';');
      self.Screenwriter_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Screenwriter', true), ';');
      self.Music_by_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Music by', true), ';');
      self.Cinematographer_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('Cinematographer', true), ';');
      self.Director_ListBox.Items :=
        SplitStr(FCurrentMovie.Get('director', true), ';');

      self.Star_Panel.DrawStar(FCurrentMovie.Get('Critic Rating', true));
      self.Original_title_Ed.Text := FCurrentMovie.Get('original title', true);

    except
      screen.cursor := crdefault;
      logger.error('Error: FCurrentMovie');
    end;

    for i := 0 to self.Cast_Grid.RowCount - 1 do
      self.Cast_Grid.Rows[i].Clear;

    self.Cast_Grid.RowCount := 0;
    try
      List := SplitStr(FCurrentMovie.Get('Actors', true), ';');
      for i := 0 to List.Count - 1 do
      begin
        self.Cast_Grid.cells[0, i] := List[i];
        self.Cast_Grid.RowCount := self.Cast_Grid.RowCount + 1;
      end;
    except
      screen.cursor := crdefault;
      logger.error('Error: 685');
    end;
    try
      List := SplitStr(FCurrentMovie.Get('Character', true), ';');
      for i := 0 to List.Count - 1 do
      begin
        self.Cast_Grid.cells[1, i] := List[i];

      end;

      self.Cast_Grid.RowCount := self.Cast_Grid.RowCount - 1; // delete last
    except
      screen.cursor := crdefault;
      logger.error('Error: 697');
    end;
    
  end;

  Procedure TJRScrap_Frm.Select_MovieBrowserRow_by_JRiver_ID
    (currentid: Integer);
  var
    i: Integer;
  Begin

    for i := 1 to self.Movie_Browser.RowCount - 1 do
      try
        if currentid = strtoint(self.Movie_Browser.cells[0, i]) then
        begin
          self.Movie_Browser.row := i;
        end;
      except
        logger.error('Error : Select_MovieBrowserRow_by_JRiver_ID' +
          self.Movie_Browser.cells[0, i]);

      end;
  end;


  procedure TJRScrap_Frm.EdKeyPress(Sender: TObject; var Key: Char);
begin
    self.Write_Btn.Enabled := true ;
end;

procedure TJRScrap_Frm.View_ActionExecute(Sender: TObject);
  var
    rq: String;
  not_clear : boolean ;
  begin

    not_clear := false ;
    Fsearching := true;

    self.Write_Btn.Enabled := false;
    screen.cursor := crHourGlass;

    Application.ProcessMessages;

    if self.Movie_Browser.cells[7, self.Movie_Browser.row] = 'YES' then
    begin
      screen.cursor := crdefault;
      if self.FMassScrap = false then
      begin
        ShowMessage(Translate_String_JRStyle('File locked !', FCurrentLang));

        Exit;
      end
      else
      begin
        MassScrap_Frm.MassTag ;
        exit ;
      end;
    end;


   // TheMoviedB

    if self.TheMoviedB_rd.down = true then
    begin


    if assigned(TheMoviedB_Ins) then   TheMoviedB_Ins.Free ;

      TheMoviedB_Ins := TTheMoviedB_Cl.Create(FCurrentJRiverId,
        FCurrentLangShort);

      // 0 0 0
      if ((self.Tmdb_id_Ed.Text = emptystr) and
        (self.imdb_id_Ed.Text = emptystr) and (Name_Ed.Text = emptystr)) then
      begin
        if self.FMassScrap = false then
          begin
        ShowMessage(Translate_String_JRStyle('Nothing to search !', JRScrap_Frm.FCurrentLang));
         screen.Cursor := crdefault;
        Exit;
          end ;

      end;

      // 1 0 0
      if ((self.Tmdb_id_Ed.Text <> emptystr) and
        (self.imdb_id_Ed.Text = emptystr) and (Name_Ed.Text = emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.Tmdb_id_Ed.Text;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

      // 0 1 0
      if ((self.Tmdb_id_Ed.Text = emptystr) and
        (self.imdb_id_Ed.Text <> emptystr) and (Name_Ed.Text = emptystr)) then
      begin
        TheMoviedB_Ins.imdb_id := self.imdb_id_Ed.Text;
        TheMoviedB_Ins.TheMoviedB_IMDB_Search_Proc;
      end;

      ///*******

      // 1 1 0
      if ((self.Tmdb_id_Ed.Text <> emptystr) and
        (self.imdb_id_Ed.Text <> emptystr) and (Name_Ed.Text = emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.Tmdb_id_Ed.Text;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

      // 0 1 1
      if ((self.Tmdb_id_Ed.Text = emptystr) and
        (self.imdb_id_Ed.Text <> emptystr) and (Name_Ed.Text <> emptystr)) then
      begin
        TheMoviedB_Ins.imdb_id := self.imdb_id_Ed.Text;
        TheMoviedB_Ins.TheMoviedB_IMDB_Search_Proc;
      end;

      // 1 0 1
      if ((self.Tmdb_id_Ed.Text <> emptystr) and
        (self.imdb_id_Ed.Text = emptystr) and (Name_Ed.Text <> emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.Tmdb_id_Ed.Text;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

      // 1 1 1
      if ((self.Tmdb_id_Ed.Text <> emptystr) and
        (self.imdb_id_Ed.Text <> emptystr) and (Name_Ed.Text <> emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.Tmdb_id_Ed.Text;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

        // *********
       // 0 0 1
      if ((self.Tmdb_id_Ed.Text = emptystr) and
        (self.imdb_id_Ed.Text = emptystr) and (Name_Ed.Text <> emptystr)) then
      begin
        Search_Frm := TSearch_frm.Create(nil, TheMoviedB_Ins);
        Search_Frm.left := self.left + 250;
        Search_Frm.top := self.top + 20;
        not_clear := true ;
        Search_Frm.ShowModal;
      end;

  end;





    /// TVDB    !


  if self.TVdb_Rd.down = true then
   begin

       if ((self.Season_Spin_Ed.Text = emptystr) or( self.Episode_Spin_Ed.Text = emptystr)) then
       begin
        ShowMessage(Translate_String_JRStyle('No Serie / Episode to search !', JRScrap_Frm.FCurrentLang));
        screen.Cursor := crdefault;
        exit ;
       end;

       if assigned(TtvdB_Ins) then   TtvdB_Ins.Free ;

      TtvdB_Ins := TtvdB_Cl.Create(FCurrentJRiverId, FCurrentLangShort, strtoint( self.Episode_Spin_Ed.Text) , strtoint(self.Season_Spin_Ed.Text));

     if ((tvdb_id_Ed.Text = emptystr) and ( self.Serie_Title_Ed.Text= emptystr)) then
     begin
         if self.FMassScrap = false then
          begin
            ShowMessage(Translate_String_JRStyle('Nothing to search !', JRScrap_Frm.FCurrentLang));
           screen.Cursor := crdefault;
            Exit;
          end;

  end;

  if (tvdb_id_Ed.Text <> emptystr)  then
   begin
        TtvdB_Ins.tvdb_id :=  tvdb_id_Ed.Text ;
        TtvdB_Ins.TheTVDB_ID_Search_Proc;
    end;



    if ((tvdb_id_Ed.Text = emptystr) and ( self.Serie_Title_Ed.Text <> emptystr)) then
    begin
        Search_Frm := TSearch_frm.Create(nil, TTVdB_Ins);
        Search_Frm.left := self.left + 250;
        Search_Frm.top := self.top + 20;
        not_clear := true ;
        Search_Frm.ShowModal;
    end;





   end;


  if not_clear = false then
  begin
  ClearAll;
  end;

  end;

  procedure TJRScrap_Frm.Write_ActionExecute(Sender: TObject);
  var
    NpWnd: HWnd;
    FJRiverXml: TJRiverXml;
    day: TDateTime;
    s: string;
    i, j: Integer;
    crew_list: TStringList;

  begin

    screen.cursor := crHourGlass;
    Application.ProcessMessages;

    if not assigned(FCurrentMovie) then
    begin
      ShowMessage(Translate_String_JRStyle('No Movie selected !',
        FCurrentLang));
      screen.cursor := crdefault;
      Exit;
    end;

    if self.Movie_Browser.cells[7, self.Movie_Browser.row] = 'YES' then
    begin
      screen.cursor := crdefault;
      if self.FMassScrap = false then
      begin
        ShowMessage(Translate_String_JRStyle('File locked !', FCurrentLang));

        Exit;
      end;

    end;

    for i := 1 to self.Movie_Browser.RowCount - 1 do
    begin
      try
        if strtoint(self.Movie_Browser.cells[0, i]) = FCurrentJRiverId then
        begin

            self.Movie_Browser.cells[5, i] := self.Name_Ed.Text;

        end;
      except

        logger.error('self.Movie_Browser.Cells[0, i] = ' +
          self.Movie_Browser.cells[0, i]);
        logger.error('FCurrentJRiverId = ' + IntToStr(FCurrentJRiverId));
      end;
    end;

    try

      FJRiverXml := TJRiverXml.Create(self.Movie_Browser.cells[12,
        self.Movie_Browser.row]);
    except
      screen.cursor := crdefault;
      logger.error('Error: could not create XML file');
      debug('Error: could not create XML file');
      logger.error('FCurrentMovie.get(Filename.. =' +
        FCurrentMovie.Get('Filename', true));
    end;

      Select_MovieBrowserRow_by_JRiver_ID(FCurrentJRiverId);
      self.Movie_Browser.cells[3, self.Movie_Browser.row] :=self.Season_Spin_Ed.Text;
      self.Movie_Browser.cells[4, self.Movie_Browser.row] :=self.Episode_Spin_Ed.Text;
      self.Movie_Browser.cells[2, self.Movie_Browser.row] :=self.name_Ed.Text;
      self.Movie_Browser.cells[9, self.Movie_Browser.row] := FMoviesList.GetFile(FCurrentJRiverId).Get('Date Imported', true);
    if length(DeleteAllSpaces(self.MemoOverview.Text)) <> 0 then
     self.Movie_Browser.cells[11, self.Movie_Browser.row] :=Leftstr(self.MemoOverview.Text,40) + '...'
     else
     self.Movie_Browser.cells[11, self.Movie_Browser.row] := '';

    if self.TheMoviedB_rd.down = true then
      self.Movie_Browser.cells[10, self.Movie_Browser.row] := self.imdb_id_Ed.Text;

     if self.TvdB_rd.down = true then
      self.Movie_Browser.cells[10, self.Movie_Browser.row] := self.tvdb_id_Ed.Text;


    // Series
    if self.TVdb_Rd.down= true then
    begin
    self.Movie_Browser.cells[2, self.Movie_Browser.row] :=self.Serie_title_Ed.Text;

    FCurrentMovie.Set_('Season', self.Season_Spin_Ed.Text);
    FJRiverXml.SetField('Season', self.Season_Spin_Ed.Text);


    FCurrentMovie.Set_('Episode', self.Episode_Spin_Ed.Text);
    FJRiverXml.SetField('Episode', self.Episode_Spin_Ed.Text);


    FCurrentMovie.Set_('Series', self.Serie_Title_Ed.Text);
    FJRiverXml.SetField('Series',  self.Serie_Title_Ed.Text);


    end;
    // End Series



      FCurrentMovie.Set_('Name', self.Name_Ed.Text);
      FJRiverXml.SetField('Name', self.Name_Ed.Text);

      FCurrentMovie.Set_('original title', self.Original_title_Ed.Text);
      FJRiverXml.SetField('original title', self.Original_title_Ed.Text);

      try
        s := self.Release_date_Ed.Text;
        day := StrToDate(s);
        s := '';

        FCurrentMovie.Set_('Date', Floattostr(day));
      except
        screen.cursor := crdefault;
        logger.error('Error COM: Date');
      end;
      FJRiverXml.SetField('Date', Floattostr(day));



      for i := 0 to self.Cast_Grid.RowCount - 1 do
      begin
        s := s + ';' + self.Cast_Grid.cells[0, i];
      end;
      s := Copy(s, 2, length(s) - 1);
      FCurrentMovie.Set_('Actors', s);
      FJRiverXml.SetField('Actors', s);
      s := '';
      for i := 0 to self.Cast_Grid.RowCount - 1 do
      begin
        s := s + ';' + self.Cast_Grid.cells[1, i];
      end;
      s := Copy(s, 2, length(s) - 1);
      FCurrentMovie.Set_('Character', s);
      FJRiverXml.SetField('Character', s);
      s := '';
      for i := 0 to self.Cast_Grid.RowCount - 1 do
      begin
        if (self.Cast_Grid.cells[0, i] <> '') and
          (self.Cast_Grid.cells[1, i] <> '') then
        begin
          s := s + ';' + self.Cast_Grid.cells[0, i] + ', ' +
            self.Cast_Grid.cells[1, i];
        end;
      end;
      s := Copy(s, 2, length(s) - 1);
      FCurrentMovie.Set_('ActorAsCharacter', s);
      FJRiverXml.SetField('ActorAsCharacter', s);
      s := '';




      FCurrentMovie.Set_('IMDb ID', self.imdb_id_Ed.Text);
      FJRiverXml.SetField('IMDb ID', self.imdb_id_Ed.Text);

      FCurrentMovie.Set_('TMDB ID', self.Tmdb_id_Ed.Text);
      FJRiverXml.SetField('TMDB ID', self.Tmdb_id_Ed.Text);

      FCurrentMovie.Set_('TheTVDB Series ID', self.Tvdb_id_Ed.Text);
      FJRiverXml.SetField('TheTVDB Series ID', self.Tvdb_id_Ed.Text);

      FCurrentMovie.Set_('Critic Rating', Floattostr(self.Star_Panel.Value));
      FJRiverXml.SetField('Critic Rating', Floattostr(self.Star_Panel.Value));

      FCurrentMovie.Set_('Description', self.MemoOverview.Text);
      FJRiverXml.SetField('Description', self.MemoOverview.Text);

      s := serialize(self.Keywords_ListBox.Items);
      FCurrentMovie.Set_('Keywords', s);
      FJRiverXml.SetField('Keywords', s);
      s := emptystr;


      s := serialize(self.Genre_ListBox.Items);
      FCurrentMovie.Set_('Genre', s);
      FJRiverXml.SetField('Genre', s);
      s := emptystr;


      s := serialize(self.Production_Company_ListBox.Items);
      FCurrentMovie.Set_('Production Company', s);
      FJRiverXml.SetField('Production Company', s);
      s := emptystr;


    /// /////////


      s := serialize(self.Director_ListBox.Items);
      FCurrentMovie.Set_('Director', s);
      FJRiverXml.SetField('Director', s);
      s := emptystr;

      s := serialize(self.Executive_Producer_ListBox.Items);
      FCurrentMovie.Set_('Executive Producer', s);
      FJRiverXml.SetField('Executive Producer', s);
      s := emptystr;

      s := serialize(self.Cinematographer_ListBox.Items);
      FCurrentMovie.Set_('Cinematographer', s);
      FJRiverXml.SetField('Cinematographer', s);
      s := emptystr;

      s := serialize(self.Casting_ListBox.Items);
      FCurrentMovie.Set_('Casting', s);
      FJRiverXml.SetField('Casting', s);
      s := emptystr;


      s := serialize(self.Screenwriter_ListBox.Items);
      FCurrentMovie.Set_('Screenwriter', s);
      FJRiverXml.SetField('Screenwriter', s);
      s := emptystr;

      s := serialize(self.Music_by_ListBox.Items);
      FCurrentMovie.Set_('Music by', s);
      FJRiverXml.SetField('Music by', s);
      s := emptystr;

      s := serialize(self.Novel_ListBox.Items);
      FCurrentMovie.Set_('Novel', s);
      FJRiverXml.SetField('Novel', s);
      s := emptystr;

      s := serialize(self.Production_Design_ListBox.Items);
      FCurrentMovie.Set_('Production Design', s);
      FJRiverXml.SetField('Production Design', s);
      s := emptystr;

     // Picture_Rec_Chk

    s := '';
  if JRScrap_Frm.Writepicture1.Checked = true  then
 begin
      s := ExtractFilePath(self.Movie_Browser.cells[12, self.Movie_Browser.row])
        + ExtractFileNameWithoutExt(self.Movie_Browser.cells[12,
        self.Movie_Browser.row]) + '.jpg';


      // Save image in directory
      try
        self.Picture_Img.Picture.SaveToFile(s);
      except
        screen.cursor := crdefault;
        logger.error('Error: saving Picture');
      end;

      try
        FCurrentMovie.SetImageFile(s, IMAGEFILE_IN_DATABASE);
      except
        screen.cursor := crdefault;
      end;

      try
        FCurrentMovie.SetImageFile(s, IMAGEFILE_DISPLAY);
      except
        screen.cursor := crdefault;
      end;

      try
        FCurrentMovie.SetImageFile(s, IMAGEFILE_IN_FILE);
      except
        screen.cursor := crdefault;
      end;
 end;



    FJRiverXml.Save_Close;
    ShowJRiverId(FCurrentJRiverId);
    Update_Serie_ID;
    screen.cursor := crdefault;


  end;

  procedure TJRScrap_Frm.Write_BtnClick(Sender: TObject);
  var
    RowIndex: Integer;
  begin
    if self.Movie_Browser.Selection.top - self.Movie_Browser.Selection.Bottom  <>0 then
    begin
      for RowIndex := self.Movie_Browser.Selection.top to self.Movie_Browser.Selection.Bottom do
      begin


      if FMoviesList.GetFile(strtoint(self.Movie_Browser.Cells[ 0,Rowindex])).get('Lock External Tag Editor',true) <> 'YES' then
      begin

         if self.Serie_Title_Ed.text <> emptystr then
         begin
         FMoviesList.GetFile(strtoint(self.Movie_Browser.Cells[ 0,Rowindex])).Set_('Series' ,self.Serie_Title_Ed.text) ;
         self.Movie_Browser.Cells[2 ,RowIndex] := self.Serie_Title_Ed.text ;
         end;

         if self.Season_Spin_Ed.Text <> emptystr then
         begin
         FMoviesList.GetFile(strtoint(self.Movie_Browser.Cells[ 0,Rowindex])).Set_('Season' ,self.Season_Spin_Ed.Text ) ;
         self.Movie_Browser.Cells[3 ,RowIndex] := self.Season_Spin_Ed.Text ;
         end;

         if self.tvdb_id_Ed.text <> emptystr then
         begin
         FMoviesList.GetFile(strtoint(self.Movie_Browser.Cells[ 0,Rowindex])).Set_('TheTVDB Series ID' ,self.tvdb_id_Ed.text ) ;
         self.Movie_Browser.Cells[10 ,RowIndex] := self.tvdb_id_Ed.text ;
         end;

      end;


      end;
    end
    else
    begin
    Write_ActionExecute(self);
    end;
    //self.Write_Btn.Enabled := false ;
  end;

  procedure TJRScrap_Frm.Write_ImClick(Sender: TObject);
  begin
    Write_ActionExecute(self);
  end;

  procedure TJRScrap_Frm.Write_ItmClick(Sender: TObject);
  begin
    JRScrap_Frm.Search_ActionExecute(self);
  end;

  procedure TJRScrap_Frm.XML_ExportClick(Sender: TObject);
  var

     XML_Frm  : TXML_Export_Frm ;

begin
    XML_Frm  := TXML_Export_Frm.Create(self) ;
    XML_Frm.left := self.left + 250;
    XML_Frm.top := self.top + 20;
    XML_Frm.ShowModal ;
    XML_Frm.free ;
end;

procedure TJRScrap_Frm.About1Click(Sender: TObject);
  var
    f2: TForm;
  begin

    f2 := TForm2.Create(nil);
    f2.left := self.left + 250;
    f2.top := self.top + 20;
    f2.ShowModal;

  end;

  procedure TJRScrap_Frm.ScrollBox1Enter(Sender: TObject);
  begin

    debug('scrollbox1enter');
  end;

  procedure TJRScrap_Frm.ScrollBox1MouseWheel(Sender: TObject;
    Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
    var Handled: Boolean);
  begin
    debug('scroll box mouse wheel');
  end;

  procedure TJRScrap_Frm.Search1Click(Sender: TObject);
begin
self.Search_BtnClick(self);
end;

procedure TJRScrap_Frm.Search_ActionExecute(Sender: TObject);
  var

    rq: string;

  begin

    screen.cursor := crHourGlass;
    Application.ProcessMessages;

    self.Write_Btn.Enabled := false;

    // Delete all
    ClearAll();

    if self.Name_Ed.Text = '' then
    begin
      if self.FMassScrap = false then
      begin
        ShowMessage(Translate_String_JRStyle('Enter a Movie Name !',
          FCurrentLang));
        ShowJRiverId(FCurrentJRiverId);
        screen.cursor := crdefault;
        Exit;
      end
      else
      begin
        MassScrap_Frm.MassTag;
        screen.cursor := crdefault;
        Exit;
      end;
    end;

    if self.TVdb_Rd.down = true then
    begin
      TTVdB_Ins.SearchFiles(JRScrap_Frm.Name_Ed.Text);
    end
    else
    begin
      TheMoviedB_Ins.SearchFiles(JRScrap_Frm.Name_Ed.Text);
    end;

  end;

  procedure TJRScrap_Frm.Add1Click(Sender: TObject);
  var
    s: string;
  begin

    s := InputBox(Translate_String_JRStyle('Enter a value',
      FCurrentLang), ' ', '');
    if s <> '' then
    begin
      Keywords_ListBox.Items.Add(s);
      Keywords_ListBox.Sorted := false;
      Keywords_ListBox.Sorted := true;
      self.Write_Btn.Enabled := true;

    end;
  end;


  procedure TJRScrap_Frm.All2Click(Sender: TObject);
  var
    i: Integer;
  begin

    for i := 1 to self.FMoviesCount do
    begin
      try
        Movie_Browser.cells[7, i] := 'YES';
        FCurrentMovie := FMoviesList.GetFile
          (strtoint(JRScrap_Frm.Movie_Browser.cells[0, i]));
        FCurrentMovie.Set_('Lock External Tag Editor', 'YES');

      except
        logger.error('Error: 1729');
      end;
    end;

    Movie_Browser.Repaint;
  end;

  procedure TJRScrap_Frm.ClearAll();
  var
    i: Integer;
  begin
    try

      self.Star_Panel.Reset;
      self.Picture_Img.Picture := nil;

      for i := 0 to Cast_Grid.RowCount - 1 do
        Cast_Grid.Rows[i].Clear;

      for i := 0 to self.ComponentCount - 1 do
      begin
        if self.Components[i] is TJvListBox then
        begin
          (self.Components[i] as TJvListBox).Items.Clear;
        end;



        if self.Components[i] is TcyEdit then
        begin
          (self.Components[i] as TcyEdit).Text := emptystr;
        end;

        if self.Components[i] is TMemo then
        begin
          (self.Components[i] as TMemo).Text := emptystr;
        end;

      end;

    except
      screen.cursor := crdefault;
      logger.error('Error: ClearAll');
    end;

  end;

  procedure TJRScrap_Frm.Close1Click(Sender: TObject);
  begin
    Application.Terminate;
  end;

  procedure TJRScrap_Frm.Media_Sub_ComboChange(Sender: TObject);
  begin
     FfilterStr := '';
    self.Filter_Ed.Text := emptystr ;
    self.SpeedButton1.Down := false ;
    try
      FMoviesList := self.MCAutomation.Search
        (' [Media Type]=[Video]  [Media Sub Type]=[' + self.Media_Sub_Combo.Items
        [self.Media_Sub_Combo.ItemIndex] + ']' + FfilterStr);
      // Is the First a Movie or not ?
     { if FMoviesList.GetFile(0).Get('TheTVDB Series ID', true) = emptystr then
       self.TheMoviedB_rd.down := true
       else
        self.TVdb_Rd.down := true;}

       if    self.TheMoviedB_rd.down = true   then
      begin
        self.Filter_Combo.Items.Delete(2);  //Series

        self.Serie_Pnl.Visible := false;
        self.Movie_Pnl.Visible := true;
        self.Movie_Browser.ColWidths[2] := -1; // Serie Name
        self.Movie_Browser.ColWidths[3] := -1; // Season
        self.Movie_Browser.ColWidths[4] := -1; // Ep
        self.Movie_Browser.cells[10, 0] := 'Imdb ID';
      end
      else
      begin
        self.TVdb_Rd.down := true;

        self.Serie_Pnl.Visible := true;
        self.Movie_Pnl.Visible := false;
        self.Movie_Browser.ColWidths[2] := 120; // Serie Name
        self.Movie_Browser.ColWidths[3] := 20; // Season
        self.Movie_Browser.ColWidths[4] := 20; // Ep
        self.Movie_Browser.cells[10, 0] := 'Tvdb ID';
      end;

    except
    end;

    fillbrowser;

  end;

  procedure TJRScrap_Frm.Createthenewfields1Click(Sender: TObject);
  const
    tags: array [0 .. 8] of string = ('TMDB id', 'Production Company',
      'Casting', 'Executive Producer', 'Novel', 'Production Design',
      'Character', 'ActorAsCharacter', 'Lock External Tag Editor');
  var
    i, j, tagcreated: Integer;
    tagfound: Boolean;
    tagtext: string;
  begin
    tagcreated := 0;
    try
      FNewdBField := self.MCAutomation.GetFields;

      for j := 0 to length(tags) - 1 do
      begin
        tagfound := false;
        for i := 0 to FNewdBField.GetNumberFields - 1 do
        begin
          tagtext := FNewdBField.GetField(i).GetName(true);
          if tagtext = tags[j] then
          begin
            tagfound := true;
          end;

        end;
        if tagfound = false then
        begin
          FNewdBField.CreateFieldSimple(tags[j], tags[j], 1, 1);
          Inc(tagcreated);
        end;

      end;

    except
      logger.error('Error: New Fields created');
    end;
  end;

  procedure TJRScrap_Frm.Delete1Click(Sender: TObject);
  begin

    Keywords_ListBox.Items.Delete(Keywords_ListBox.ItemIndex);
    self.Write_Btn.Enabled := true;

  end;

  procedure TJRScrap_Frm.Delete2Click(Sender: TObject);
   var Caller: TObject;
   i : integer ;
  begin
    Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
    debug(Caller.ToString);

    for I:= (Caller as TJvListBox).items.count -1 downto  0 do
      if (Caller as TJvListBox).selected[i] then
        (Caller as TJvListBox).items.delete(i);

    self.Write_Btn.Enabled := true;

  end;

  procedure TJRScrap_Frm.Delete3Click(Sender: TObject);
  begin

    Genre_ListBox.Items.Delete(self.Genre_ListBox.ItemIndex);
    self.Write_Btn.Enabled := true;

  end;

  procedure TJRScrap_Frm.DeleteClick(Sender: TObject);
  var Caller: TObject;
  begin
    Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
    debug(Caller.ToString);
    ( Caller as TJvListBox).Items.Add(InputBox('Enter a value', ' ', ' '));
    ( Caller as TJvListBox).Sorted := false;
    ( Caller as TJvListBox).Sorted := true;
    self.Write_Btn.Enabled := true;
  end;

  procedure TJRScrap_Frm.Dossiercourant1Click(Sender: TObject);
  begin
    GotofolderClick(self);
  end;

  procedure TJRScrap_Frm.Duration_EdKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
  begin
    self.Write_Btn.Enabled := true;
  end;

  procedure TJRScrap_Frm.scrapall1Click(Sender: TObject);
  var
    MassScrap_Frm: TForm;
  begin

    MassScrap_Frm := TMassScrap_frm.Create(nil);
    MassScrap_Frm.left := self.left + 250;
    MassScrap_Frm.top := self.top + 20;
    MassScrap_Frm.ShowModal;

  end;

  procedure TJRScrap_Frm.Filter_BtnClick(Sender: TObject);
begin
Filter_Search ;
self.Filter_Btn.Down := false ;
end;

procedure TJRScrap_Frm.Filter_ComboChange(Sender: TObject);
begin
FfilterStr := emptystr ;
self.Filter_Ed.Text := emptystr ;
//self.SpeedButton1.Down := false ;
end;

procedure TJRScrap_Frm.Filter_EdKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
    begin
     Filter_Search ;

    end;

end;

procedure TJRScrap_Frm.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    logger.info('Closing app.');
    TLogger.freeInstances;
    idd.Free;
  end;

  procedure TJRScrap_Frm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  var
    RegNGFS: TRegistry;
  begin
    try

      RegNGFS := TRegistry.Create;
      try
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.WriteInteger('top', self.top);
          RegNGFS.WriteInteger('left', self.left);
          RegNGFS.WriteInteger('width', self.Width);

        end;
      except
        RegNGFS.Free;
      end;

    except
      screen.cursor := crdefault;
      logger.error('Error: could not write Top-Left-Width');
    end;
  end;

  procedure TJRScrap_Frm.FormCreate(Sender: TObject);
  var
    RegNGFS: TRegistry;
    i: Integer;
    lang, querylang: string;
    s: string;
    filelangname: string;
    languageitem: TMenuItem;
    FileinParamFound: Boolean;
    firstrun: Boolean;
    sub_type_stringlist: TStringList;
  begin
    FXSLFolder := GetFolderPath(CSIDL_COMMON_APPDATA) + '\JRScrap\';
    // Remove old .log files
     RemoveAllFilesFromFolder( FXSLFolder , '*.log') ;

    self.Hide;
    try
      MCAutomation := TMCAutomation.Create(self);
    except
      screen.cursor := crdefault;
      logger.error('Error : Could not initialize TMCAutomation');
    end;

    self.Movie_Pnl.Top := self.Serie_Pnl.Top ;
    self.Movie_Pnl.Left := self.Serie_Pnl.Left ;

    Fsearching := false;

    JRVersion := self.MCAutomation.GetVersion;
    debug('JRiver Version :');
    debug(JRVersion.Major);
    FJRVersionMajor := JRVersion.Major;




    sub_type_stringlist := TStringList.Create;

    logger := TLogger.getInstance;
    logger.setLevel(TLevelUnit.info);
    FlogFolder := GetFolderPath(CSIDL_COMMON_APPDATA) + '\JRScrap\Log\';

    FlogFilename := FlogFolder + FormatDateTime('dd_mm_yy__hh_mm_ss', Now) +
      '.log'; // Program Data
    logger.addAppender(TFileAppender.Create(FlogFilename));
    logger.info('Log File from JRScrap');
    logger.info('Date Generated :' + DateToStr(date) + ' at ' +
      TimeToStr(time));
    logger.info('Launching app.');
    FAppPath := ExtractFilePath(Application.ExeName);

    for i := 0 to length(FMovieColumnsSortOrder) - 1 do
      FMovieColumnsSortOrder[i] := false;

    if Fileexists(GetParentDirectory(FAppPath) + '\images\lock.png') = true then
      lock_img := TPNGImage.Create;
    lock_img.LoadFromFile(GetParentDirectory(FAppPath) + '\images\lock.png');

    try
      idHTTP1 := TIdHTTP.Create(self);
    except
      screen.cursor := crdefault;
      logger.error('Error : Could not create idHTTP');
    end;

    firstrun := true;

    idd := TImageDropDown<TJPEGImage>.Create(self.Picture_Img,
      self.Picture_Panel);


    FMesgCount := 0;

    for i := 1 to ParamCount do
      FParameterStr := FParameterStr + ' ' + ParamStr(i);
    FParameterStr := trim(FParameterStr);

    try

      RegNGFS := TRegistry.Create;
      try
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
        begin
          firstrun := RegNGFS.Readbool('Firstrun');
          RegNGFS.Free;
        end;

      except
        firstrun := true;
      end;

      if firstrun = true then
      begin

        try
          RegNGFS := TRegistry.Create;
          RegNGFS.RootKey := HKEY_CURRENT_USER;
          if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
          begin

            RegNGFS.Writebool('Firstrun', false);
            RegNGFS.WriteString('QueryLanguages', 'eng,fr,it,de,es,pt,nl,no');

            if not RegNGFS.ValueExists('Language') then
            begin
              RegNGFS.WriteString('Language', 'English');
            end;

            if not RegNGFS.ValueExists('QueryLanguage') then
            begin
              RegNGFS.WriteString('QueryLanguage', 'eng');
            end;

            RegNGFS.Writebool('WritePicture', true);
            RegNGFS.Writebool('WriteSideCar', true);
            RegNGFS.WriteInteger('top', 100);
            RegNGFS.WriteInteger('left', 100);
            RegNGFS.WriteInteger('width', 1200);
            WriteXMLsideCar1.Checked := true;
            RegNGFS.Free;
          end;

        except
          screen.cursor := crdefault;
          logger.error('Error: Could not write Keys in Register !');
        end;

        self.Createthenewfields1Click(Sender);

      end;

      RegNGFS := TRegistry.Create;
      try
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
        begin
          WriteXMLsideCar1.Checked := RegNGFS.Readbool('WriteSideCar');
          WritePicture1.Checked := RegNGFS.Readbool('WritePicture');
        end;
      finally
        RegNGFS.Free;
      end;

      Fitem := TMenuItem.Create(self);
      Fitem.name := 'English';
      Fitem.Caption := 'English';
      Fitem.RadioItem := true;
      Fitem.Checked := false;
      Fitem.GroupIndex := 1;
      Fitem.OnClick := LanguageClick;
      self.Selectlanguage1.Add(Fitem);

      try
        for filelangname in TDirectory.GetFiles(FAppPath + '\..\languages\') do
        begin
          if ExtractFileExt(filelangname) = '.txt' then
          begin
            lang := ExtractFileNameWithoutExt(filelangname);
            Fitem := TMenuItem.Create(self);
            Fitem.name := lang;
            Fitem.Caption := lang;
            Fitem.RadioItem := true;
            Fitem.Checked := false;
            Fitem.GroupIndex := 1;
            Fitem.OnClick := LanguageClick;
            self.Selectlanguage1.Add(Fitem);
          end;
        end;
      except
        screen.cursor := crdefault;
        logger.error('Error : Could not get language .txt files properly');
      end;

      Flanguages := TStringList.Create;
      try

        RegNGFS := TRegistry.Create;
        try
          RegNGFS.RootKey := HKEY_CURRENT_USER;
          if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
          begin
            Flanguages.CommaText := RegNGFS.Readstring('QueryLanguages');
            self.FCurrentLangShort := RegNGFS.Readstring('QueryLanguage');

          end;
        finally
          RegNGFS.Free;
        end;

        i := 0;
      except
        screen.cursor := crdefault;
        logger.error('Error: Could not read querylanguage');
      end;
      try
        for i := 0 to Flanguages.Count - 1 do
        begin

          languageitem := TMenuItem.Create(self);
          languageitem.name := Flanguages[i];
          languageitem.Caption := Flanguages[i];
          languageitem.Checked := false;
          if languageitem.Caption = self.FCurrentLangShort then

            languageitem.Checked := true;
          languageitem.RadioItem := true;
          languageitem.GroupIndex := 1;
          languageitem.OnClick := LanguageQueryClick;
          self.SelectQuerylanguage.Add(languageitem);
        end;
        i := 0;
      except
        screen.cursor := crdefault;
        logger.error('Error: Could not create languageitem');
      end;

      try

        if Fileexists(GetParentDirectory(FAppPath) + '\images\staron.png') = true
        then
          FStaron_Path := GetParentDirectory(FAppPath) + '\images\staron.png';
        if Fileexists(GetParentDirectory(FAppPath) + '\images\staroff.png') = true
        then
          FStaroff_Path := GetParentDirectory(FAppPath) + '\images\staroff.png';

        try

          RegNGFS := TRegistry.Create;
          try
            RegNGFS.RootKey := HKEY_CURRENT_USER;
            if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
            begin
              lang := RegNGFS.Readstring('Language');

            end;
          finally
            RegNGFS.Free;
          end;

          RegNGFS := TRegistry.Create;
          try
            RegNGFS.RootKey := HKEY_CURRENT_USER;
            if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
            begin

            end;
          finally
            RegNGFS.Free;
          end;

          FCurrentLang := lang;
        except
          screen.cursor := crdefault;
          logger.error('Error: Could not read English');
        end;

        if FindComponent(lang) <> nil then
        begin
          TMenuItem(FindComponent(lang)).Checked := true

        end
        else
        begin
          try
            TMenuItem(FindComponent('English')).Checked := true;
          except
            screen.cursor := crdefault;
            logger.error('Error: Could not find English item');
          end;
        end;
        if Fileexists(ExtractFileDir(Application.ExeName) + '\..\languages\' +
          lang + '.lng') then

          if FCurrentMovie <> nil then
          begin
            self.Name_Ed.Text := FCurrentMovie.name;
          end;

        RegNGFS := TRegistry.Create;
        try
          RegNGFS.RootKey := HKEY_CURRENT_USER;
          if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
          begin
            querylang := RegNGFS.Readstring('QueryLanguage');

          end;
        finally
          RegNGFS.Free;
        end;

        if FindComponent(querylang) <> nil then
        begin
          TMenuItem(FindComponent(querylang)).Checked := true

        end
        else
        begin
          try
            TMenuItem(FindComponent('eng')).Checked := true;
          except
            screen.cursor := crdefault;
            logger.error('Error: Could not find eng item');
          end;
        end;

        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
        begin

          try

            sub_type_stringlist.Sorted := true;
            sub_type_stringlist.Duplicates := dupIgnore;

            FMoviesList := self.MCAutomation.Search('[Media Type]=[Video]');
            FMoviesCount := FMoviesList.GetNumberFiles();

            for i := 0 to FMoviesCount - 1 do
            begin

              s := FMoviesList.GetFile(i).Get('Media Sub Type', true);

              sub_type_stringlist.Add(FMoviesList.GetFile(i)
                .Get('Media Sub Type', true));

            end;

          except
            screen.cursor := crdefault;
            logger.error('Error: Could not get Movies from JRiver');
          end;

          for i := sub_type_stringlist.Count - 1 downto 0 do
            if sub_type_stringlist[i] = '' then
              sub_type_stringlist.Delete(i);

          self.Media_Sub_Combo.Items.Clear;
          self.Media_Sub_Combo.Items := sub_type_stringlist;
          try

            self.Media_Sub_Combo.ItemIndex := 0;
            self.Media_Sub_Combo.ItemIndex := self.Media_Sub_Combo.Items.IndexOf('Movie');
            Media_Sub_ComboChange(self);
          except

          end;
          fillbrowser;
        end;

        /// ///////////////////////////////////////////////////////////////////////

        self.Cast_Grid.ColWidths[0] := 225;
        self.Cast_Grid.ColWidths[1] := 225;
        self.Cast_Grid.ColWidths[2] := 0;
        // BrowserCol
        self.Movie_Browser.ColWidths[0] := 0; // hide this Columns
        self.Movie_Browser.ColWidths[1] := 20; // Thumbnail

        self.Movie_Browser.ColWidths[2] := -1; // Serie Name
        self.Movie_Browser.ColWidths[3] := -1; // Season
        self.Movie_Browser.ColWidths[4] := -1; // Ep
        self.Movie_Browser.ColWidths[5] := 150; // Nom

        self.Movie_Browser.ColWidths[6] := -1; // Date Format Excel
        self.Movie_Browser.ColWidths[7] := -1; // YES/NO
        self.Movie_Browser.ColWidths[8] := 30; // Lock
        self.Movie_Browser.ColWidths[9] := 75; // Import Date
        self.Movie_Browser.ColWidths[10] := 70; // IMDb ID
        self.Movie_Browser.ColWidths[11] := 120; // Description
        self.Movie_Browser.ColWidths[12] := 1000; // FileName
        self.Movie_Browser.ColWidths[13] := 0; // contains 'P' if there's a picture ...
        self.Filter_Combo.ItemIndex := 0 ;

        self.Star_Panel.Reset;
        ShowJRiverId(FCurrentJRiverId);

       self.Filter_Combo.Items.Add('Filename') ;
       self.Filter_Combo.Items.Add('Name') ;
       self.Filter_Combo.ItemIndex := 0;


        FPlaylist := MCautomation.GetPlaylists;

        for i := 0 to FPlaylist.GetNumberPlaylists do
        begin
         self.PlayList_Combo.Items.Add(FPlaylist.GetPlaylist(i).Name) ;
        end;


      finally

      end;
    finally

    end;

  end;

  procedure TJRScrap_Frm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
    MousePos: TPoint; var Handled: Boolean);
  var
    n, i: Integer;

  begin

    ScrollBox1.Perform(WM_VSCROLL, SB_LINEDOWN, 0);

  end;

  procedure TJRScrap_Frm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
    MousePos: TPoint; var Handled: Boolean);
  var
    n, i: Integer;

  begin

    ScrollBox1.Perform(WM_VSCROLL, SB_LINEUP, 0);
  end;

  procedure TJRScrap_Frm.FormShow(Sender: TObject);
  var
    RegNGFS: TRegistry;
  begin

    self.Movie_Browser.cells[5, 0] := Translate_String_JRStyle('Name',
      FCurrentLang);
    self.Movie_Browser.cells[8, 0] := Translate_String_JRStyle('Lock',
      FCurrentLang);
    self.Movie_Browser.cells[9, 0] := Translate_String_JRStyle('Date Imported',
      FCurrentLang);
    self.Movie_Browser.cells[11, 0] := Translate_String_JRStyle('Overview',
      FCurrentLang);
    self.Movie_Browser.cells[12, 0] := Translate_String_JRStyle('Filename',
      FCurrentLang);
    self.Movie_Browser.cells[10, 0] := 'IMDb ID';
    self.Movie_Browser.cells[2, 0] := 'Series';
    self.Movie_Browser.cells[3, 0] := 'S';
    self.Movie_Browser.cells[4, 0] := 'E';

    RegNGFS := TRegistry.Create;
    try
      RegNGFS.RootKey := HKEY_CURRENT_USER;
      if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
      begin
        self.top := RegNGFS.ReadInteger('top');
        self.left := RegNGFS.ReadInteger('left');
        self.Width := RegNGFS.ReadInteger('width');

      end;
    except
      RegNGFS.Free;
    end;
    TranslateJRStyle(FCurrentLang, false); // translate to NextLang

    self.Button2.SetFocus ;
  end;

  procedure TJRScrap_Frm.Subtitle_BtnClick(Sender: TObject);
  begin
    OpenSub_Form1 := TOpenSub_Form.Create(nil);
    OpenSub_Form1.left := self.left + 250;
    OpenSub_Form1.top := self.top + 20;
    OpenSub_Form1.ShowModal;
    OpenSub_Form1.Free;
    OpenSub_Form1 := nil;

  end;

  procedure TJRScrap_Frm.TheMoviedB_rdClick(Sender: TObject);
  begin
   self.PlayList_Combo.ItemIndex := -1 ;
  self.SpeedButton1.Down := false ;
    ClearAll;
    self.Name_Ed.Text := emptystr ;
    debug((Sender as TSpeedButton).name);
    if (Sender as TSpeedButton).name = 'TheMoviedB_rd' then
    begin

      self.Movie_Pnl.Visible := true;
      self.Serie_Pnl.Visible := false;

    self.Movie_Browser.Options := self.Movie_Browser.Options -[goRangeSelect];


      self.Movie_Browser.ColWidths[2] := 0; // Serie Name
      self.Movie_Browser.ColWidths[3] := 0; // Season
      self.Movie_Browser.ColWidths[4] := 0; // Ep

      self.Movie_Browser.cells[5, 0] := Translate_String_JRStyle('Name',
        FCurrentLang);
      self.Movie_Browser.cells[2, 0] := 'Serie';
      self.Movie_Browser.cells[3, 0] := 'S';
      self.Movie_Browser.cells[4, 0] := 'E';
      self.Movie_Browser.cells[8, 0] := Translate_String_JRStyle('Lock',
        FCurrentLang);
      self.Movie_Browser.cells[9, 0] := Translate_String_JRStyle
        ('Date Imported', FCurrentLang);
      self.Movie_Browser.cells[10, 0] := 'Imdb ID';
      self.Movie_Browser.cells[11, 0] := Translate_String_JRStyle('Overview',
        FCurrentLang);
      self.Movie_Browser.cells[12, 0] := Translate_String_JRStyle('Filename',
        FCurrentLang);

      self.Season_Spin_Ed.Enabled := false;
      self.Episode_Spin_Ed.Enabled := false;

      self.Original_title_Ed.Enabled := true;


      self.Original_title_Ed.Text := '';

       self.Filter_Combo.Items.Clear ;
       self.Filter_Combo.Items.Add('Filename') ;
       self.Filter_Combo.Items.Add('Name') ;
       self.Filter_Combo.ItemIndex := 0;



      try
      self.Media_Sub_Combo.ItemIndex := StringListContainsstring(self.Media_Sub_Combo.Items, 'Movie') ;
      except

      end;

    end
    else
    begin

       self.Filter_Combo.Items.Clear ;
       self.Filter_Combo.Items.Add('Filename') ;
       self.Filter_Combo.Items.Add('Name') ;
       self.Filter_Combo.Items.Add('Series') ;
       self.Filter_Combo.ItemIndex := 0;

      self.Subtitle_Btn.Enabled := false ;
      self.Movie_Pnl.Visible := false;
      self.Serie_Pnl.Visible := true;

     self.Movie_Browser.Options := self.Movie_Browser.Options + [goRangeSelect];


      self.Movie_Browser.ColWidths[2] := 200; // Serie Name
      self.Movie_Browser.ColWidths[3] := 20; // Season
      self.Movie_Browser.ColWidths[4] := 20; // Ep

      self.Movie_Browser.cells[5, 0] := Translate_String_JRStyle('Name',
        FCurrentLang);

      self.Movie_Browser.cells[2, 0] := 'Serie';
      self.Movie_Browser.cells[3, 0] := 'S';
      self.Movie_Browser.cells[4, 0] := 'E';
      self.Movie_Browser.cells[8, 0] := Translate_String_JRStyle('Lock',
        FCurrentLang);
      self.Movie_Browser.cells[9, 0] := Translate_String_JRStyle
        ('Date Imported', FCurrentLang);
      self.Movie_Browser.cells[10, 0] := 'Tvdb ID';
      self.Movie_Browser.cells[11, 0] := Translate_String_JRStyle('Overview',
        FCurrentLang);
      self.Movie_Browser.cells[12, 0] := Translate_String_JRStyle('Filename',
        FCurrentLang);

      self.Season_Spin_Ed.Enabled := true;
      self.Episode_Spin_Ed.Enabled := true;

      self.Original_title_Ed.Text := '';


      try
      self.Media_Sub_Combo.ItemIndex := StringListContainsstring(self.Media_Sub_Combo.Items, 'TV Show') ;
      except

      end;
    end;

    clearall ;
    FCurrentLang := TranslateJRStyle(FCurrentLang, false);
    Media_Sub_ComboChange(self);
  end;



procedure TJRScrap_Frm.Name_EdKeyPress(Sender: TObject; var Key: Char);
  begin

    self.Write_Btn.Enabled := true;
  end;



procedure TJRScrap_Frm.Tmdb_id_EdEnter(Sender: TObject);
  begin
    debug('enter');
  end;

  procedure TJRScrap_Frm.Tmdb_id_EdKeyPress(Sender: TObject; var Key: Char);
  begin

    self.Write_Btn.Enabled := true;
  end;


  procedure TJRScrap_Frm.LanguageQueryClick(Sender: TObject);
  var
    RegNGFS: TRegistry;
  begin
    (Sender as TMenuItem).Checked := true;
    try
      self.FCurrentLangShort := trim((Sender as TMenuItem).Caption);
    except
      screen.cursor := crdefault;
      logger.error('Error: Could not set FCurrentLangShort ');
    end;
    self.FCurrentLangShort := StringReplace(self.FCurrentLangShort, '&', '',
      [rfReplaceAll, rfIgnoreCase]);
    try
      RegNGFS := TRegistry.Create;
      RegNGFS.RootKey := HKEY_CURRENT_USER;
      if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
      begin
        RegNGFS.WriteString('Querylanguage', self.FCurrentLangShort);
        RegNGFS.Free;
      end;

    except
      screen.cursor := crdefault;
      logger.error('Error: COuld not write Querylanguage');
    end;
  end;

  procedure TJRScrap_Frm.LanguageClick(Sender: TObject);
  var
    NextLang: string;
    RegNGFS: TRegistry;
  begin
    (Sender as TMenuItem).Checked := true;
    NextLang := (Sender as TMenuItem).name;
    if NextLang = FCurrentLang then
      Exit; // Exit if same ...

    if ((FCurrentLang = 'English') and (NextLang <> 'English')) then
    begin
      FLangINV := false;
      FCurrentLang := TranslateJRStyle(NextLang, false);
      // translate to NextLang
      FCurrentLang := NextLang;
      try

        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;

        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.WriteString('Language', self.FCurrentLangShort);
          RegNGFS.Free;
        end;
      except
        screen.cursor := crdefault;
        logger.error('Error: Could not write language');
      end;
    end;

    if ((FCurrentLang <> 'English') and (NextLang <> 'English')) then
    begin
      try
        TranslateJRStyle(FCurrentLang, true); // Untranslate current to english
        TranslateJRStyle(NextLang, false); // translate to NextLang
        FCurrentLang := NextLang;
        FLangINV := false;
        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.WriteString('Language', NextLang);
          RegNGFS.Free;
        end;

      except
        screen.cursor := crdefault;
        logger.error('Error: COuld not write language');
      end;
    end;

    if ((FCurrentLang <> 'English') and (NextLang = 'English')) then
    begin
      try

        TranslateJRStyle(FCurrentLang, true); // Untranslate current to english

        JRScrap_Frm.Movie_Browser.cells[1, 0] := 'Name';
        JRScrap_Frm.Movie_Browser.cells[8, 0] := 'Lock';
        JRScrap_Frm.Movie_Browser.cells[9, 0] := 'Date Imported';
        JRScrap_Frm.Movie_Browser.cells[11, 0] := 'Overview';
        JRScrap_Frm.Movie_Browser.cells[12, 0] := 'Filename';

        FCurrentLang := 'English';
        FLangINV := true;
        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.WriteString('Language', 'English');
          RegNGFS.Free;
        end;

      except
        screen.cursor := crdefault;
        logger.error('Error: COuld not write language');
      end;
    end;

  end;

  procedure TJRScrap_Frm.Genre_ListBoxClick(Sender: TObject);
  begin
    self.Genre_ListBox.Selected[self.Genre_ListBox.ItemIndex] := false;
  end;

  procedure TJRScrap_Frm.GotofolderClick(Sender: TObject);
  begin
    if FCurrentMoviePath <> '' then
      ShowFolder(FCurrentMoviePath);
  end;

  procedure TJRScrap_Frm.Helppage1Click(Sender: TObject);
  var
    MyLink: string;
  begin
    MyLink := 'https://github.com/fredele/JRScrap/blob/master/help.md';
    ShellExecute(Application.Handle, PChar('open'), PChar(MyLink), nil,
      nil, SW_SHOW);

  end;



  procedure TJRScrap_Frm.Keywords_ListBoxDrawItem(Control: TWinControl;
    Index: Integer; Rect: TRect; State: TOwnerDrawState);
  begin
    ShowMessage('coucou');
  end;



  procedure TJRScrap_Frm.Button1Click(Sender: TObject);
  begin
    FCurrentJRiverId := strtoint(self.Movie_Browser.cells[0,
      self.Movie_Browser.row]);
    FCurrentMovie := FMoviesList.GetFile(FCurrentJRiverId);

    ClearAll;
    ShowJRiverId(FCurrentJRiverId);
    Application.ProcessMessages;

  end;

  procedure TJRScrap_Frm.Button2Click(Sender: TObject);
  begin
    View_ActionExecute(self);
  end;

  procedure TJRScrap_Frm.Button4Click(Sender: TObject);
  begin
    self.Movie_Browser.Perform(WM_HSCROLL, SB_LINEDOWN, 0);

  end;


  procedure TJRScrap_Frm.Writepicture1Click(Sender: TObject);
 var
    RegNGFS: TRegistry;
  begin
     Writepicture1.Checked := not Writepicture1.Checked;
    if Writepicture1.Checked = true then
    begin
        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.Writebool('WritePicture', WriteXMLsideCar1.Checked);
          RegNGFS.Free;
        end;
    end
    else
    begin
        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.Writebool('WritePicture', WriteXMLsideCar1.Checked);
          RegNGFS.Free;
        end;
    end;

end;

procedure TJRScrap_Frm.WriteXMLsideCar1Click(Sender: TObject);
  var
    RegNGFS: TRegistry;
  begin
    WriteXMLsideCar1.Checked := not WriteXMLsideCar1.Checked;
    if WriteXMLsideCar1.Checked = true then
    begin
      try

        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.Writebool('WriteSideCar', WriteXMLsideCar1.Checked);
          RegNGFS.Free;
        end;

      except
        
        screen.cursor := crdefault;
      end;
    end
    else
    begin
      try

        RegNGFS := TRegistry.Create;
        RegNGFS.RootKey := HKEY_CURRENT_USER;
        if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
        begin
          RegNGFS.Writebool('WriteSideCar', WriteXMLsideCar1.Checked);
          RegNGFS.Free;
        end;

      except
        logger.error('Error: could not write WriteSideCar');
        screen.cursor := crdefault;
      end;
    end;
  end;

  procedure TJRScrap_Frm.Search_BtnClick(Sender: TObject);
  begin
    JRScrap_Frm.Search_ActionExecute(self);
  end;


  procedure TJRScrap_Frm.Episode_Spin_EdKeyPress(Sender: TObject; var Key: Char);
begin
self.Write_Btn.Enabled := true;
end;

procedure TJRScrap_Frm.Episode_Spin_WChange(Sender: TObject);
  begin

    if Fon_enter = true then
      self.Write_Btn.Enabled := true;
  end;

  procedure TJRScrap_Frm.Episode_Spin_WEnter(Sender: TObject);
  begin
    Fon_enter := true;
  end;

  procedure TJRScrap_Frm.Episode_Spin_WExit(Sender: TObject);
  begin
    Fon_enter := false;
  end;

  procedure TJRScrap_Frm.Eraseallinfo1Click(Sender: TObject);
  var
    crew_list: TStringList;
    i, j: Integer;
  begin

    if self.Movie_Browser.cells[7, self.Movie_Browser.row] = 'YES' then
    begin
      ShowMessage(Translate_String_JRStyle('File locked !', FCurrentLang));

      Exit;
    end;
    try
      FCurrentJRiverId := strtoint(self.Movie_Browser.cells[0,
        self.Movie_Browser.row]);
    except
      logger.error('Error: 2912' + self.Movie_Browser.cells[0,
        self.Movie_Browser.row]);
    end;
    FCurrentMovie := FMoviesList.GetFile(FCurrentJRiverId);
    try
      FCurrentMovie.Set_('original title', '');
      FCurrentMovie.Set_('Date', '');
      FCurrentMovie.Set_('Actors', '');
      FCurrentMovie.Set_('Character', '');
      FCurrentMovie.Set_('ActorAsCharacter', '');
      FCurrentMovie.Set_('Genre', '');
      FCurrentMovie.Set_('Production Company', '');
      FCurrentMovie.Set_('Keywords', '');
      FCurrentMovie.Set_('IMDb ID', '');
      FCurrentMovie.Set_('TMDb ID', '');
      FCurrentMovie.Set_('TheTVDB Series ID', '');
      FCurrentMovie.Set_('Series', '');
      FCurrentMovie.Set_('Season', '');
      FCurrentMovie.Set_('Episode', '');
      FCurrentMovie.Set_('Description', '');
      FCurrentMovie.Set_('Lock External Tag Editor', 'NO');
      FCurrentMovie.Set_('Director', '');
      FCurrentMovie.Set_('Executive Producer', '');
      FCurrentMovie.Set_('Screenwriter', '');
      FCurrentMovie.Set_('Casting', '');
      FCurrentMovie.Set_('Cinematographer', '');
      FCurrentMovie.Set_('Music by', '');
      FCurrentMovie.Set_('Novel', '');
      FCurrentMovie.Set_('Production Design', '');
      FCurrentMovie.Set_('Critic Rating', '');
      FCurrentMovie.Set_('Lock External Tag Editor', '');

    except
      logger.error('Error: 2965');
    end;

    try
      FCurrentMovie.SetImageFile('', IMAGEFILE_DISPLAY);
    except
      screen.cursor := crdefault;
    end;

    try
      FCurrentMovie.SetImageFile('', IMAGEFILE_In_DATABASE);  // NECESSARY !
    except
      screen.cursor := crdefault;
    end;

    ClearAll;

    try
      self.Movie_Browser.cells[10, self.Movie_Browser.row] := emptystr;
      self.Movie_Browser.cells[11, self.Movie_Browser.row] := emptystr;
      self.Movie_Browser.cells[7, self.Movie_Browser.row] := 'NO';

      if self.TVdb_Rd.down = true then
      begin
      self.Movie_Browser.cells[5, self.Movie_Browser.row] := emptystr;
      self.Movie_Browser.cells[3, self.Movie_Browser.row] := emptystr;
      self.Movie_Browser.cells[4, self.Movie_Browser.row] := emptystr;
      end;

    except
      logger.error('Error: 3016');
    end;

    ShowJRiverId(FCurrentJRiverId);

  end;

  procedure TJRScrap_Frm.EraseHistory1Click(Sender: TObject);
  begin
    RemoveAllFilesFromFolder(self.FlogFolder, '*.*');
  end;



procedure TJRScrap_Frm.Movie_BrowserClick(Sender: TObject);
  begin

    FCurrentJRiverId := strtoint(self.Movie_Browser.cells[0,
      self.Movie_Browser.row]);
    FCurrentMovie := FMoviesList.GetFile(FCurrentJRiverId);

    ClearAll;
    ShowJRiverId(FCurrentJRiverId);
    if self.imdb_id_Ed.Text<>emptystr then
       self.Subtitle_Btn.Enabled := true
       else
        self.Subtitle_Btn.Enabled := false ;
    self.Write_Btn.Enabled := false;
    Application.ProcessMessages;

  end;

  procedure TJRScrap_Frm.Movie_BrowserDrawCell(Sender: TObject;
    ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  var
    s: string;
    aCanvas: TCanvas;
    pic: TImage;
    dest: TBitmap;
  begin

    if ARow = 0 then
      Exit;
    aCanvas := (Sender as TStringGrid).Canvas;

    if ACol = 1 then
    begin

      try

        pic := TImage.Create(self);

        s := FMoviesList.GetFile(strtoint(Movie_Browser.cells[0, ARow]))
          .GetImageFile(IMAGEFILE_THUMBNAIL_SMALL);
        if  ( FileSize(s)<>0 )
        then
        begin
        pic.Picture.LoadFromFile(s);
        end;

        if Fileexists(s) then
        begin
          aCanvas.FillRect(Rect);
          try
          s := FMoviesList.GetFile(strtoint(Movie_Browser.cells[0, ARow])).GetImageFile(IMAGEFILE_DISPLAY);
           except

          end;
          if not AnsiContainsStr(s, 'Logo.png') then
          begin
             Movie_Browser.cells[13, ARow] := 'P' ;
             try
            aCanvas.stretchDraw(Rect, pic.Picture.Graphic) ;
             except

             end;

          end
          else
          begin
            aCanvas.FillRect(Rect);
          end;


        end
        else
        begin
          aCanvas.FillRect(Rect);
        end;
      except

      end;


    end;

    s := emptystr;
    if ACol = 8 then
    begin
      s := (Sender as TStringGrid).cells[7, ARow];
      if (s <> 'YES') then
      begin
        aCanvas.FillRect(Rect);
      end
      else
      begin
        aCanvas.FillRect(Rect);
        aCanvas.stretchDraw(Rect, self.lock_img);
      end;
    end;

  end;

  procedure TJRScrap_Frm.Movie_BrowserFixedCellClick(Sender: TObject;
    ACol, ARow: Integer);
    var
    i : integer ;
  begin


 for I := 0 to self.Movie_Browser.ColCount -1 do
 begin
 self.Movie_Browser.cells[I, 0] := StringReplace(self.Movie_Browser.cells[I, 0] ,'˄ ',  '', [rfReplaceAll, rfIgnoreCase]);
 self.Movie_Browser.cells[I, 0] := StringReplace(self.Movie_Browser.cells[I, 0] ,'˅ ',  '', [rfReplaceAll, rfIgnoreCase]);

 end;



    if ((ACol = 1) or(ACol = 9) or (ACol = 10) or (ACol = 8) or (ACol = 5) or (ACol = 12) or
      (ACol = 2)) then
    begin

      if FMovieColumnsSortOrder[ACol] = true then
    self.Movie_Browser.cells[ACol, 0] :=  '˄ ' +self.Movie_Browser.cells[ACol, 0]
    else
    self.Movie_Browser.cells[ACol, 0] :=  '˅ ' +  self.Movie_Browser.cells[ACol, 0]   ;

       FMovieColumnsSortOrder[ACol] := not FMovieColumnsSortOrder[ACol];

      if ACol = 9 then
      begin
        ACol := 2;
      FMovieColumnsSortOrder[2] := not FMovieColumnsSortOrder[2];
      end;

      if ACol = 8 then
      begin
       FMovieColumnsSortOrder[7] := not FMovieColumnsSortOrder[7];
        ACol := 7;
      end;

      if ACol = 1 then
      begin
       FMovieColumnsSortOrder[13] := not FMovieColumnsSortOrder[13];
        ACol := 13;
      end;


      SortStringGrid(self.Movie_Browser, ACol);







    end;

  end;

  procedure TJRScrap_Frm.Movie_BrowserMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    ACol, ARow: Integer;
  begin

    Movie_Browser.MouseToCell(X, Y, ACol, ARow);

    if ACol <> 8 then
      Exit;
    FCurrentJRiverId := strtoint(Movie_Browser.cells[0, ARow]);
    FCurrentMovie := FMoviesList.GetFile(FCurrentJRiverId);

    if (Movie_Browser.cells[7, ARow] = 'YES') then
    begin
      Movie_Browser.cells[7, ARow] := 'NO';
      FCurrentMovie.Set_('Lock External Tag Editor', 'NO');

    end
    else
    begin
      Movie_Browser.cells[7, ARow] := 'YES';
      FCurrentMovie.Set_('Lock External Tag Editor', 'YES');
    end;

    self.Movie_Browser.Repaint;

  end;

  procedure TJRScrap_Frm.Movie_BrowserMouseEnter(Sender: TObject);
  begin
 //   self.Movie_Browser.SetFocus;


  end;

  procedure TJRScrap_Frm.Movie_BrowserMouseLeave(Sender: TObject);
  begin
    self.ScrollBox1.SetFocus;
  end;

  procedure TJRScrap_Frm.Movie_BrowserMouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    RowIndex: Integer;
    i: Integer;
  begin
    if (self.Movie_Browser.Selection.Bottom - self.Movie_Browser.Selection.top) <> 0 then
    begin

      for RowIndex := self.Movie_Browser.Selection.top to self.Movie_Browser.
        Selection.Bottom do
      begin
        ClearAll;
        for i := 0 to self.ComponentCount - 1 do
        begin
          if self.Components[i] is TJvListBox then
          begin
            (self.Components[i] as TJvListBox).Items.Clear;
          end;

          if self.Components[i] is TCheckBox then
          begin
            (self.Components[i] as TCheckBox).Checked := false;
            (self.Components[i] as TCheckBox).Enabled := false;
          end;

          if self.Components[i] is TcyEdit then
          begin
            (self.Components[i] as TcyEdit).Text := emptystr;
            (self.Components[i] as TcyEdit).Enabled := false;
          end;

          if self.Components[i] is TMemo then
          begin
            (self.Components[i] as TMemo).Text := emptystr;
            (self.Components[i] as TMemo).Enabled := false;
          end;

          if self.Components[i] is TMnEdit then
          begin
            (self.Components[i] as TMnEdit).Text := emptystr;
            (self.Components[i] as TMnEdit).Enabled := false;
          end;

        end;

        self.tvdb_id_Ed.Enabled :=  true ;
        self.Season_Spin_Ed.Enabled := true ;
        if self.TVdb_Rd.down = true then

        self.Name_Ed.Enabled := true
        else
        self.Name_Ed.Enabled := false ;

      end;

    end
    else
    begin
     for i := 0 to self.ComponentCount - 1 do
        begin
           if self.Components[i] is TCheckBox then
          begin
            (self.Components[i] as TCheckBox).Enabled := true;
          end;
           if self.Components[i] is TMemo then
          begin
            (self.Components[i] as TMemo).Enabled := true;
          end;
           if self.Components[i] is TcyEdit then
          begin
            (self.Components[i] as TcyEdit).Enabled := true;
          end;

            if self.Components[i] is  TMnEdit then
          begin
            (self.Components[i] as  TMnEdit).Enabled := true;
          end;
        end;

    end;

  end;

  procedure TJRScrap_Frm.Movie_Search_GridClick(Sender: TObject);
  begin

    if self.TVdb_Rd.down = true then
    begin
      self.tvdb_id_Ed.Text := Search_Frm.Movie_Search_Grid.cells
        [2, Search_Frm.Movie_Search_Grid.row];
    end;

    if self.themoviedb_rd.down = true then
    begin
    FTheMoviedb_ID := Search_Frm.Movie_Search_Grid.cells
      [2, Search_Frm.Movie_Search_Grid.row];
    end;
  end;



  procedure TJRScrap_Frm.None2Click(Sender: TObject);
  var
    i: Integer;
  begin
    try
      for i := 1 to self.FMoviesCount do
      begin
        Movie_Browser.cells[7, i] := 'NO';
        try
         FCurrentMovie :=FMoviesList.GetFile
            (strtoint(JRScrap_Frm.Movie_Browser.cells[0, i]));
        except
          logger.error('Error: 3191' + JRScrap_Frm.Movie_Browser.cells[0, i]);
        end;
        FCurrentMovie.Set_('Lock External Tag Editor', 'NO');
      end;
    except

    end;

    Movie_Browser.Repaint;

  end;

  procedure TJRScrap_Frm.OpenFolder1Click(Sender: TObject);
  begin
    ShellExecute(Application.Handle, PChar('explore'), PChar(FlogFolder), nil,
      nil, SW_SHOWNORMAL);
  end;



  procedure TJRScrap_Frm.Panel2Enter(Sender: TObject);
  begin
    self.SetFocus;
  end;

  procedure TJRScrap_Frm.Panel2MouseLeave(Sender: TObject);
  begin
    self.Movie_Browser.SetFocus;
  end;

  procedure TJRScrap_Frm.Picture_ImgDblClick(Sender: TObject);
  var
    Img_Form1: TImage_Form;

  begin
    Img_Form1 := TImage_Form.Create(self);
    Img_Form1.Image1.Picture.Assign(self.Picture_Img.Picture);
    Img_Form1.Image1.Height := self.Picture_Img.Picture.Height;
    Img_Form1.Image1.Width := self.Picture_Img.Picture.Width;
    Img_Form1.Caption := IntToStr(self.Picture_Img.Picture.Height) + ' X ' +
      IntToStr(self.Picture_Img.Picture.Width) + ' px';
    Img_Form1.ShowModal;
  end;

  procedure TJRScrap_Frm.Picture_ImgMouseEnter(Sender: TObject);
  begin

    self.ScrollBox1.SetFocus;
  end;


procedure TJRScrap_Frm.PlayinJRiverMCClick(Sender: TObject);



 FPlay :=  MCAutomation.GetPlayback ;
 FCurrentPlaylist :=  MCAutomation.GetCurPlaylist ;
 FCurrentPlaylist.RemoveAllFiles ;
 filetoplay :=  FCurrentMovie.Filename ;
 FCurrentPlaylist.AddFile( filetoplay ,0) ;
 debug(FCurrentPlaylist.GetNumberFiles) ;
 Send_MC_COMMAND( MCC_PLAY_FIRST_FILE);
 MCAutomation.ShowProgram(1);
end;


procedure TJRScrap_Frm.PlayList_ComboChange(Sender: TObject);

FMoviesList := FPLaylist.GetPlaylist(self.PlayList_Combo.ItemIndex).GetFiles ;
fillbrowser ;
end;

procedure TJRScrap_Frm.Save1Click(Sender: TObject);

self.Save1Click(self);
end;

end.
