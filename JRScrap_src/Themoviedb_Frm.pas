unit Themoviedb_Frm;

interface

uses
  TLoggerUnit, TLevelUnit, TFileAppenderUnit,TranslateJRStyle_Unit,
  Vcl.Menus, Vcl.StdCtrls,
  Vcl.Grids, mnEdit, Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Classes,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   Vcl.Graphics, Vcl.themes,
   Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL,
  uLkJSON, mystringutil,myFileUnit, IOUtils, JPEG,
     MediaCenter_TLB,
  Vcl.Buttons, MassScrap_Frm, About_Frm,
  MC_Commands_Unit, iniFiles, JRiverXML_Unit, Utils_Unit, Math, ShellApi,
  Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Vcl.OleServer,
  Types_Unit, PngImage, ImageDropDown, StrUtils,
   SHFolder, Registry, Vcl.ImgList, WinShellFolder,
  Threadsearch , Threadsearch_Image ,Functions_Unit, Vcl.CheckLst,
  StarPanel_Unit, JvSpeedbar, JvExExtCtrls, JvExtComponent, Vcl.Samples.Spin ,MSXML ,OpenSub_Unit
    ;
type

  TThemoviedb = class(TForm)
    MainMenu1: TMainMenu;
    Configure1: TMenuItem;
    EnterKeyforthemmoviedbAPI1: TMenuItem;
    Select1: TMenuItem;
    All1: TMenuItem;
    None1: TMenuItem;
    Help: TMenuItem;
    Selectlanguage1: TMenuItem;
    WriteXMLsideCar1: TMenuItem;
    SelectStyle: TMenuItem;
    Close1: TMenuItem;
    SelectQuerylanguage: TMenuItem;
    Gotofolder: TMenuItem;
    Keyword_Pop: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    Production_Pop: TPopupMenu;
    Genres_Pop: TPopupMenu;
    Delete: TMenuItem;
    Delete2: TMenuItem;
    Add2: TMenuItem;
    Delete3: TMenuItem;
    Panel1: TPanel;
    Panel5: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Movie_Search_Grid: TStringGrid;
    Search_Btn, View_Btn: TButton;
    SearchEdit: TmnEdit;
    search_byimdb: TRadioButton;
    search_byname: TRadioButton;
    Imdb_search: TEdit;
    About1: TMenuItem;
    Helppage1: TMenuItem;
    scrapall1: TMenuItem;
    N1: TMenuItem;
    Movie_Browser_Pop: TPopupMenu;
    Eraseallinfo1: TMenuItem;
    Dossiercourant1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Lock1: TMenuItem;
    All2: TMenuItem;
    None2: TMenuItem;
    Write_Btn: TButton;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    SeeLogFile1: TMenuItem;
    Label2: TLabel;
    MCAutomation: TMCAutomation;
    OpenFolder1: TMenuItem;
    EraseHistory1: TMenuItem;
    Panel3: TPanel;
    Movie_Browser: TStringGrid;
    Panel4: TPanel;
    ComboBox1: TComboBox;
    StatusBar1: TStatusBar;
    Panel6: TPanel;
    ScrollBox1: TScrollBox;
    PageControl1: TPageControl;
    TabSheet_Single_Movie: TTabSheet;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Title_Chk: TCheckBox;
    Picture_Chk: TCheckBox;
    Original_Title_Chk: TCheckBox;
    Overview_Chk: TCheckBox;
    release_date_Chk: TCheckBox;
    API_id_chk: TCheckBox;
    API_id_Ed: TEdit;
    Release_date_Ed: TEdit;
    MemoOverview: TMemo;
    Vote_Average_Chk: TCheckBox;
    Keywords_Chk: TCheckBox;
    Production_Comp_Chk: TCheckBox;
    Genres_Chk: TCheckBox;
    Genre_ListBox: TListBox;
    Production_Company_ListBox: TListBox;
    Keywords_List: TListBox;
    Picture_Panel: TPanel;
    Picture_Img: TImage;
    Original_title_Ed: TmnEdit;
    Title_Ed: TmnEdit;
    Star_Panel: TStar_Panel;
    Season_Spin_W: TSpinEdit;
    Episode_Spin_W: TSpinEdit;
    Subtitle_Btn: TButton;
    TabSheet_Single_Movie_Add: TTabSheet;
    Panel7: TPanel;
    Cast_Chk: TCheckBox;
    Cast_Grid: TStringGrid;
    Crew_Chk: TCheckBox;
    Crew_Grid: TStringGrid;
    TheMoviedB_rd: TRadioButton;
    TVdb_Rd: TRadioButton;
    Label5: TLabel;


    // Form Procedures

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Write_BtnClick(Sender: TObject);
    procedure Enterakey1Click(Sender: TObject);
    procedure All1Click(Sender: TObject);
    procedure None1Click(Sender: TObject);
    procedure LanguageClick(Sender: TObject);
    procedure LanguageQueryClick(Sender: TObject);
    procedure StyleClick(Sender: TObject);
    procedure Genre_ListBoxClick(Sender: TObject);
    procedure WriteXMLsideCar1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Movie_BrowserClick(Sender: TObject);
    procedure Createthenewfields1Click(Sender: TObject);
    procedure Original_title_EdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Release_date_EdKeyPress(Sender: TObject; var Key: Char);
    procedure Duration_EdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Vote_Average_EdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoOverviewKeyPress(Sender: TObject; var Key: Char);
    procedure API_id_EdKeyPress(Sender: TObject; var Key: Char);

    procedure GotofolderClick(Sender: TObject);

    procedure Delete1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure Add2Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure Delete3Click(Sender: TObject);

    procedure Imdb_searchEnter(Sender: TObject);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Movie_BrowserKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure About1Click(Sender: TObject);
    procedure Helppage1Click(Sender: TObject);
    procedure search_bynameClick(Sender: TObject);
    procedure search_byimdbClick(Sender: TObject);
    procedure Movie_Search_GridClick(Sender: TObject);
    procedure scrapall1Click(Sender: TObject);
    procedure Eraseallinfo1Click(Sender: TObject);
    procedure Movie_BrowserDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Movie_BrowserMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Dossiercourant1Click(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure All2Click(Sender: TObject);
    procedure None2Click(Sender: TObject);
    procedure Movie_BrowserFixedCellClick(Sender: TObject; ACol, ARow: Integer);
    procedure FormShow(Sender: TObject);
    procedure SendUpdateDBfromTags1Click(Sender: TObject);
    procedure SeeLogFile1Click(Sender: TObject);
    procedure OpenFolder1Click(Sender: TObject);
    procedure EraseHistory1Click(Sender: TObject);
    procedure View_BtnClick(Sender: TObject);
    procedure Search_BtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Movie_BrowserMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Title_EdKeyPress(Sender: TObject; var Key: Char);
    procedure Original_title_EdKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure Season_Spin_WEnter(Sender: TObject);
    procedure Episode_Spin_WEnter(Sender: TObject);
    procedure Season_Spin_WExit(Sender: TObject);
    procedure Episode_Spin_WExit(Sender: TObject);
    procedure Episode_Spin_WChange(Sender: TObject);
    procedure Season_Spin_WChange(Sender: TObject);
    procedure Serie_EdKeyPress(Sender: TObject; var Key: Char);
    procedure Subtitle_BtnClick(Sender: TObject);
    procedure API_id_EdChange(Sender: TObject);
    procedure TheMoviedB_rdClick(Sender: TObject);


    //*************************************



  public

  var

    // My Variables
    FXMLReader: IXMLDOMDocument;
    Fon_enter : boolean ;
    FAppPath : string ;
    logger : TLogger;
    FLogFile: TextFile;
    FTempPath: string;
    FMovie_Browser_Width: Integer;
    FHideForm: Boolean;
    FMovieColumnsSortOrder: array [0 .. 20] of Boolean;
    idd: TImageDropDown<TJPEGImage>;
    FMassScrap: Boolean;
    lock_img: TPNGImage;
    FTheMoviedb_ID: string;
    MovieThreadSearch1 , MovieThreadSearch2: TThreadsearch;
    MovieThreadSearch_Image : TThreadsearch_Image;
    idHTTP1: TIdHTTP;
    FCurrentMoviePicture: string;
    FStaron_Path: string;
    FStaroff_Path: string;
    FMovieAPIkey , FAPIkey : string;
    FJRiverXml: TJRiverXml;
    Flang: string;
    FJSonReader: TlkJSONobject;
    FParseText: string;
    Fitem: TMenuItem;
    Fstyleitem: TMenuItem;
    pl: IMJPlaylistautomation;
    FMoviesList: IMJFilesAutomation;
    FMoviesCount: Integer;
    FCurrentMovie: IMJFileAutomation;
    FNewdBField: IMJFieldsAutomation;
    FdefaultStyleName: string;
    Flanguages: TStringList;
    FMesgCount: Integer;
    OldCursor: TCursor;
    FCurrentMoviePath,FCurrentMovieFilename: string;
    FCurrentJRiverId: Integer;
    FCurrentLang, FCurrentLangShort: string;
    FKeywords_List: Set of byte;
    FCurrentSort, FINIPath: string;
    FParameterStr : string ;
    Fstyle: string;
    FMassScrapbooleans : string ;
    FSorttype: TSorttype;
    FlogFolder , FlogFilename : string ;
    After_Thread_Search_Basic_Info_Bool,
    After_Thread_Search_Keywords_Bool,
    After_Thread_Search_Image_Bool,
    After_Thread_Search_Credits_Bool : boolean ;

    // My Procedures

    procedure SortStringGrid(var GenStrGrid: TStringGrid; ThatCol: Integer);
    procedure After_Thread_Search_Search_imdb;
    procedure After_Thread_Search_Search_tvdb;
    procedure After_Thread_Search_IMDB_ID;
    procedure fillbrowser ;

    procedure After_Thread_SearchSerieEpisode ;
    procedure After_Thread_Search_Basic_Info;
    procedure After_Thread_Search_Credits;
    procedure After_Thread_Search_Keywords;
    procedure After_Thread_Image;
    procedure looping;
    Procedure NewIMGLoaded(Sender: TObject);
    Procedure Select_MovieBrowserRow_by_JRiver_ID(currentid: Integer);
    Procedure ShowJRiverId(currentid: Integer);
    procedure ClearAll();
    Procedure Check_Fields_from_FMassScrapbooleans ;
    Procedure Update_TVBD_ID;

  end;



var

  Themoviedb: TThemoviedb;



implementation

{$R *.dfm}

Procedure TThemoviedb.Update_TVBD_ID;
var
i ,j, curid,searchid,curtvbdid,searchtvbdid ,searchjriverid ,curjriverid  : integer ;
begin
if self.TVdb_Rd.Checked = true then
 begin
 for i := 1 to self.Movie_Browser.RowCount do
   begin
   try
    self.Movie_Browser.cells[10,i] :=  FMoviesList.GetFile(strtoint(self.Movie_Browser.cells[0,i]  )).Get('TheTVDB Series ID', true);
   except
    screen.cursor := crdefault;
      logger.error('Error: 358');
   end;
   end;
 end;
end;

procedure TThemoviedb.After_Thread_Search_Search_tvdb;
var
  i, j: Integer;
  rq, id: string;
  root, node: IXMLDOMNode;
begin

  if MovieThreadSearch1.TextToParse <> '' then
  begin

    try
      FXMLReader := CoDOMDocument.Create;
      FXMLReader.loadXML(MovieThreadSearch1.TextToParse);
    except
      screen.cursor := crdefault;
      logger.error('Error: Parsing');
    end;

    root := FXMLReader.DocumentElement;

    self.Movie_Search_Grid.rowcount := root.childNodes.length;

    if ((self.Movie_Search_Grid.rowcount = 1 )and (FMassScrap = False)) then
    begin
    ShowMessage(FTranslateList[10]);
    ShowJRiverId(FCurrentJRiverId);
     Screen.Cursor := crDefault;
      exit;
    end;


    for i := 0 to root.childNodes.length - 1 do
    begin
      node := root.childNodes[i];

      for j := 0 to node.childNodes.length - 1 do
      begin
        if node.childNodes[j].nodeName = 'seriesid' then
          self.Movie_Search_Grid.cells[2, i] := node.childNodes[j].Text;

        if node.childNodes[j].nodeName = 'SeriesName' then
          self.Movie_Search_Grid.cells[0, i] := node.childNodes[j].Text;

      end;
    end;


    if self.Imdb_search.Text <> emptystr then
    begin
      Form3.MassTag;
    end;

    if self.FMassScrap = true then
       begin
        self.Movie_Search_Grid.Row := 0;
        self.Movie_Search_Grid.col := 1;
        self.Movie_Search_Grid.SetFocus;
        self.View_BtnClick(self);
       end;

  end;

  screen.cursor := crdefault;
  Application.ProcessMessages;

end;

procedure TThemoviedb.fillbrowser ;
var
i : integer ;
s : string ;
begin
 try
 for I := 1 to self.Movie_Browser.RowCount - 1 do
    self.Movie_Browser.Rows[I].Clear();

  self.Movie_Browser.RowCount := 2;
 self.Movie_Browser.Fixedrows := 1;

  self.Movie_Browser.row := 1 ;
  self.Movie_Browser.col := 1 ;

   FMoviesCount := FMoviesList.GetNumberFiles();
        if FMoviesCount = 0 then
        begin
        ShowMessage(FTranslateList[26]);
        halt ;
        end;
 except

 end;

   try

      // Fill Movie Browser
      for i := 0 to FMoviesCount - 1 do
      begin

         s := FMoviesList.GetFile(i).name ;
        self.Movie_Browser.Cells[1, i + 1] := FMoviesList.GetFile(i).name;
        self.Movie_Browser.Cells[0, i + 1] := IntToStr(i);
        self.Movie_Browser.Cells[2, i + 1] := FMoviesList.GetFile(i).Get('Series', true);
        self.Movie_Browser.Cells[3, i + 1] := FMoviesList.GetFile(i).get('Season', true) ;
        self.Movie_Browser.Cells[4, i + 1] := FMoviesList.GetFile(i).get('Episode', true);


        self.Movie_Browser.Cells[9, i + 1] :=
          Floattostr(StrToDateTime(FMoviesList.GetFile(i)
          .get('Date Imported', true)));

        self.Movie_Browser.Cells[12, i + 1] := FMoviesList.GetFile(i)
          .get('Filename', true);

        self.Movie_Browser.Cells[7, i + 1] := FMoviesList.GetFile(i)
          .get('Lock External Tag Editor', true);

        self.Movie_Browser.Cells[9, i + 1] := FMoviesList.GetFile(i)
          .get('Date Imported', true);



    if  TVdb_Rd.Checked = true then
    self.Movie_Browser.Cells[10, i + 1] := FMoviesList.GetFile(i).get('TheTVDB Series ID', true) ;

    if self.TheMoviedB_rd.Checked = true then
    self.Movie_Browser.Cells[10, i + 1] := FMoviesList.GetFile(i).get('IMDb ID', true);


        if length(DeleteAllSpaces(FMoviesList.GetFile(i).get('Description',
          true))) <> 0 then
          self.Movie_Browser.Cells[11, i + 1] :=
            Leftstr(FMoviesList.GetFile(i).get('Description', true),
            40) + '...';

        self.Movie_Browser.RowCount := self.Movie_Browser.RowCount + 1;

      end;
      // delete last row
     if self.Movie_Browser.RowCount >= 1 then
        self.Movie_Browser.RowCount := self.Movie_Browser.RowCount - 1;




   except
   end;
   try
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
      try
      FCurrentMovieFilename := s;
      self.FHideForm := false;

      if not assigned(FCurrentMovie) then
        Exit;

      except

      end;


end;


procedure TThemoviedb.looping;
var
s : string ;
begin


 s :=FCurrentMovie.get('Media Sub Type', true) ;
 if ( ( self.TheMoviedB_rd.Checked )and( After_Thread_Search_Basic_Info_Bool = true)and(After_Thread_Search_Keywords_Bool  = true)and(After_Thread_Search_Credits_Bool  = true)and(After_Thread_Search_Image_Bool = true))then
 begin

 After_Thread_Search_Basic_Info_Bool := false;
After_Thread_Search_Keywords_Bool :=  false;
After_Thread_Search_Credits_Bool :=  false;
After_Thread_Search_Image_Bool :=  false;

  self.Write_Btn.Enabled := true;
  if self.FMassScrap = true then
  begin
    self.Write_BtnClick(self);
  end;
   end;

 if ( (  self.TVdb_Rd.Checked = true )and( After_Thread_Search_Basic_Info_Bool = true)and(After_Thread_Search_Image_Bool = true))then
 begin

After_Thread_Search_Basic_Info_Bool := false;
After_Thread_Search_Keywords_Bool :=  false;
After_Thread_Search_Credits_Bool :=  false;
After_Thread_Search_Image_Bool :=  false;

  self.Write_Btn.Enabled := true;
  if self.FMassScrap = true then
  begin
    self.Write_BtnClick(self);
  end;
  end;

  Screen.Cursor := crDefault;



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

procedure TThemoviedb.SortStringGrid(var GenStrGrid: TStringGrid;
  ThatCol: Integer);
const
  // Define the Separator
  TheSeparator = '<sep>';
var
  CountItem, i, j, k, ThePosition: Integer;
  MyList: TStringList;
  MyString, TempString, currentid: string;
begin
  currentid := GenStrGrid.Cells[0, GenStrGrid.Row];

  // Give the number of rows in the StringGrid
  CountItem := GenStrGrid.RowCount;
  // Create the List
  MyList := TStringList.Create;
  MyList.Sorted := false;
  try
    begin
      for i := 1 to (CountItem - 1) do
        MyList.Add(GenStrGrid.Rows[i].Strings[ThatCol] + TheSeparator +
          GenStrGrid.Rows[i].Text);
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

        GenStrGrid.Rows[j + 1].Text := StringReplace(MyList.Strings[j], '<sep>', '',
          [rfReplaceAll, rfIgnoreCase]);
    end;
  finally
    // Free the List
    MyList.Free;
  end;

  try
    for i := 1 to GenStrGrid.RowCount do
      if currentid = GenStrGrid.Cells[0, i] then
        GenStrGrid.Row := i;
    GenStrGrid.Col := 1;
  except

  end;

  FMovieColumnsSortOrder[ThatCol] := not FMovieColumnsSortOrder[ThatCol];
end;


procedure TThemoviedb.Season_Spin_WChange(Sender: TObject);
begin
self.View_Btn.Enabled := true ;
if  Fon_enter = true then
self.Write_Btn.Enabled := true ;
end;

procedure TThemoviedb.Season_Spin_WEnter(Sender: TObject);
begin
 Fon_enter := true ;
end;

procedure TThemoviedb.Season_Spin_WExit(Sender: TObject);
begin
  Fon_enter := false ;
end;

procedure TThemoviedb.SeeLogFile1Click(Sender: TObject);
begin
  try
    ShellExecute(Handle, nil, PChar('notepad.exe'),
      PChar(ExtractFilePath(Application.ExeName) + FTempPath), nil,
      SW_SHOWNORMAL)
  except

  end;
end;

Procedure TThemoviedb.Check_Fields_from_FMassScrapbooleans ;
begin



  //Picture
  if FMassScrapbooleans[0+1] = '1'  then
  self.Picture_Chk.Checked := true
  else
  self.Picture_Chk.Checked := false;
  //Title
    if FMassScrapbooleans[1+1] = '1'  then
  self.Title_Chk.Checked := true
  else
  self.Title_Chk.Checked := false;
  // Original title
    if FMassScrapbooleans[2+1] = '1'  then
  self.Original_Title_Chk.Checked := true
  else
  self.Original_Title_Chk.Checked:= false;
  //release_date
    if FMassScrapbooleans[3+1] = '1'  then
  self.release_date_Chk.Checked := true
  else
  self.release_date_Chk.Checked := false ;
  //imdb_id
    if FMassScrapbooleans[4+1] = '1'  then
  self.API_id_chk.Checked := true
  else
  self.API_id_chk.Checked := false;
  //Overview
    if FMassScrapbooleans[5+1] = '1'  then
  self.Overview_Chk.Checked := true
  else
  self.Overview_Chk.Checked := false;
  //Vote_Average
    if FMassScrapbooleans[6+1] = '1'  then
  self.Vote_Average_Chk.Checked := true
  else
  self.Vote_Average_Chk.Checked := false;
  //Production_Comp
    if FMassScrapbooleans[7+1] = '1'  then
  self.Production_Comp_Chk.Checked := true
  else
  self.Production_Comp_Chk.Checked  := false;
  //Genres
    if FMassScrapbooleans[8+1] = '1'  then
  self.Genres_Chk.Checked := true
  else
    self.Genres_Chk.Checked := false;
  //Keywords
    if FMassScrapbooleans[9+1] = '1'  then
  self.Keywords_Chk.Checked := true
  else
    self.Keywords_Chk.Checked := false;
  //Cast
    if FMassScrapbooleans[10+1] = '1'  then
  self.Cast_Chk.Checked := true
  else
  self.Cast_Chk.Checked := false;
  //Crew
  if FMassScrapbooleans[11+1] = '1'  then
  self.Crew_Chk.Checked := true
  else
  self.Crew_Chk.Checked := false  ;

  if self.Title_Ed.Text = emptystr then   self.Title_Chk.Checked := false ;
  if self.Original_title_Ed.Text = emptystr  then    self.Original_Title_Chk.Checked := false ;

  if self.Release_date_Ed.Text = emptystr then self.release_date_Chk.Checked := false ;
  if self.API_id_Ed.Text = emptystr then self.API_id_chk.Checked := false ;



end;


procedure TThemoviedb.SendUpdateDBfromTags1Click(Sender: TObject);
begin
  // self.SendUpdateDBfromTags1.Checked := not self.SendUpdateDBfromTags1.Checked ;
end;



procedure TThemoviedb.Serie_EdKeyPress(Sender: TObject; var Key: Char);
begin

  self.Write_Btn.Enabled := true;
end;

procedure TThemoviedb.ShowJRiverId(currentid: Integer);
var
  s: string;
  i: Integer;
  List: TStringList;
begin
try
  FCurrentMovie := FMoviesList.GetFile(FCurrentJRiverId);
  FCurrentMoviePath := ExtractFilePath(FCurrentMovie.filename);
  FCurrentMovieFilename := FCurrentMovie.filename;
  List := TStringList.Create;

  self.Title_Ed.Text := FCurrentMovie.name;

  if self.TVdb_Rd.Checked then
  begin
  self.SearchEdit.Text := FCurrentMovie.Get('Series', true);
  end ;

  if self.TheMoviedB_rd.Checked = true then
  begin
  self.SearchEdit.Text := FCurrentMovie.name;
  end;


except
 logger.error('Error: 609');
end;

  s := FCurrentMovie.GetImageFile(IMAGEFILE_DISPLAY);
  if Fileexists(s) then
  begin
    try
      if Fileexists(s) then
      begin
        self.Picture_Img.Picture.LoadFromFile(s);
        FCurrentMoviePicture := s;

        if ExtractFileName(s) = 'Logo.png' then
        begin
          FCurrentMoviePicture := '';
          self.Picture_Img.Picture := nil;
        end;

      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: loading Picture');
    end;
  end
  else
  begin
    self.Picture_Img.Picture := nil;
  end;

  try
    self.Original_title_Ed.Text := FCurrentMovie.Get('Series', true);
    try
    self.Season_Spin_W.Value :=  strtoint( FCurrentMovie.Get('Season', true));
    self.Episode_Spin_W.Value :=  strtoint( FCurrentMovie.Get('Episode', true));
    except

    end;

    self.MemoOverview.Text := FCurrentMovie.get('Description', true);
    self.Release_date_Ed.Text := FCurrentMovie.get('Date', true);

     if  self.TVdb_Rd.Checked = true then
    self.API_id_Ed.Text := FCurrentMovie.Get('TheTVDB Series ID', true);
    if self.TheMoviedB_rd.Checked = true then
    self.API_id_Ed.Text := FCurrentMovie.get('IMDb ID', true);


    if self.API_id_Ed.Text <> '' then
    begin
      self.search_byimdb.Checked := true;
      self.View_Btn.Enabled := true;
      self.Search_Btn.Enabled := false;
    end
    else
    begin
      self.search_byname.Checked := true;
      self.View_Btn.Enabled := false;
      self.Search_Btn.Enabled := true;
    end;

     if  self.TVdb_Rd.Checked = true then
    begin
    self.Imdb_search.Text := FCurrentMovie.get('TheTVDB Series ID', true);
    end;
    if self.TheMoviedB_rd.Checked = true then
    begin
    self.Imdb_search.Text := FCurrentMovie.get('IMDb ID', true);
    end;


    self.Keywords_List.Items :=
      SplitStr(FCurrentMovie.get('Keywords', true), '; ');
    self.Production_Company_ListBox.Items :=
      SplitStr(FCurrentMovie.get('Production Company', true), '; ');
    self.Genre_ListBox.Items :=
      SplitStr(FCurrentMovie.get('Genre', true), '; ');
    self.Star_Panel.DrawStar(FCurrentMovie.get('Critic Rating', true));

    if self.TheMoviedB_rd.Checked = true then
    self.Original_title_Ed.Text := FCurrentMovie.get('original title', true);
    if self.TVdb_Rd.Checked = true then
    self.Original_title_Ed.Text := FCurrentMovie.get('Series', true);
  except
    Screen.Cursor := crDefault;
    logger.error('Error: FCurrentMovie');
  end;

  for i := 0 to self.Cast_Grid.RowCount - 1 do
    self.Cast_Grid.Rows[i].Clear;

  self.Cast_Grid.RowCount := 0;
  try
  List := SplitStr(FCurrentMovie.get('Actors', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Cast_Grid.Cells[0, i] := List[i];
    self.Cast_Grid.RowCount := self.Cast_Grid.RowCount + 1;
  end;
  except
    Screen.Cursor := crDefault;
    logger.error('Error: 685');
  end;
  try
  List := SplitStr(FCurrentMovie.get('Character', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Cast_Grid.Cells[1, i] := List[i];

  end;

  self.Cast_Grid.RowCount := self.Cast_Grid.RowCount - 1; // delete last
   except
    Screen.Cursor := crDefault;
    logger.error('Error: 697');
  end;
  try
  for i := 0 to self.Crew_Grid.RowCount - 1 do
    self.Crew_Grid.Rows[i].Clear;

  self.Crew_Grid.RowCount := 0;

  List := SplitStr(FCurrentMovie.get('Director', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Director';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Producer', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Producer';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Executive Producer', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] :=
      'Executive Producer';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Screenwriter', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Screenwriter';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Production Company', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] :=
      'Production Company';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Casting', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Casting';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Cinematographer', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Cinematographer';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Music by', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Music by';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Novel', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Novel';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  List := SplitStr(FCurrentMovie.get('Production Design', true), ';');
  for i := 0 to List.Count - 1 do
  begin
    self.Crew_Grid.Cells[0, self.Crew_Grid.RowCount - 1] := 'Production Design';
    self.Crew_Grid.Cells[1, self.Crew_Grid.RowCount - 1] := List[i];
    self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
  end;

  self.Crew_Grid.RowCount := self.Crew_Grid.RowCount - 1; // Delete last

   except
    Screen.Cursor := crDefault;
    logger.error('Error: 791');
  end;
end;

Procedure TThemoviedb.Select_MovieBrowserRow_by_JRiver_ID(currentid: Integer);
var
  i: Integer;
Begin

    for i := 1 to self.Movie_Browser.RowCount - 1 do
    try
      if currentid = StrToint(self.Movie_Browser.Cells[0, i]) then
      begin
        self.Movie_Browser.Row := i;
        self.Movie_Browser.Col := 1;
      end;
     except
    logger.error('Error : Select_MovieBrowserRow_by_JRiver_ID' + self.Movie_Browser.Cells[0, i]);

  end;

end;

Procedure TThemoviedb.NewIMGLoaded(Sender: TObject);
Begin
  self.Picture_Chk.Checked := true;
  self.Write_Btn.Enabled := true;

End;


procedure TThemoviedb.After_Thread_SearchSerieEpisode ;
var
  rq, posterpath, s, s2,actorliststr, Directorliststr, Writerliststr: string;
  i, j,k: Integer;
  actorlist , Directorlist , Writerlist : TArrayOfString;

  root, node: IXMLDOMNode;
  epnum, senum: Integer;
  current_ep, current_se: Integer;
begin

  screen.cursor := crhourglass;
  current_se := self.Season_Spin_W.Value; // strtoint( FCurrentMovie.Get('Season', true));
  current_ep := self.Episode_Spin_W.Value; // strtoint( FCurrentMovie.Get('Episode', true));
 posterpath := emptystr ;

   if (MovieThreadSearch1.TextToParse = '' ) then
   begin
   if self.FMassScrap  = false then
     begin
     ShowMessage(FTranslateList[10]);
     ShowJRiverId(FCurrentJRiverId);
     Screen.Cursor := crDefault;
     exit ;
     end
     else
     begin
       Form3.masstag;
     end;
   end;

  if MovieThreadSearch1.TextToParse <> '' then

  begin

    try
      FXMLReader := CoDOMDocument.Create;
      FXMLReader.loadXML(MovieThreadSearch1.TextToParse);

    except
      screen.cursor := crdefault;
      logger.error('Error: Parsing');
    end;
    try
    root := FXMLReader.DocumentElement;

    epnum := 0;
    senum := 0;
    for i := 0 to root.childNodes.length - 1 do
    begin
      node := root.childNodes[i];
      if node.nodeName = 'Series' then
      begin
        for j := 0 to node.childNodes.length - 1 do
        begin
          if node.childNodes[j].nodeName = 'id' then
          begin
            self.API_id_Ed.Text := node.childNodes[j].Text;
            if   API_id_Ed.Text <> '' then API_id_chk.Checked:= true ;
          end;

          if node.childNodes[j].nodeName = 'Actors' then
          begin
            actorliststr := node.childNodes[j].Text;
            actorlist := mystringutil.SplitString('|',actorliststr) ;

             for k := 0 to Length(actorlist) - 1 do
            begin
            DeletefirstandLastchar (actorlist[k]);
             end;

            for k := 1 to Length(actorlist) - 2 do
            begin
              self.Cast_Grid.Cells[0,k-1]:=  actorlist[k];
              self.Cast_Grid.RowCount := self.Cast_Grid.RowCount + 1;
            end;
              self.Cast_Grid.RowCount := self.Cast_Grid.RowCount - 1;
            if   actorliststr <> '' then self.Cast_Chk.Checked:= true ;
          end;

          if node.childNodes[j].nodeName = 'SeriesName' then
          begin
            self.Original_title_Ed.Text  := node.childNodes[j].Text;
             if self.Original_title_Ed.Text <> '' then self.Original_title_Chk.checked := true ;
          end;
        end;
      end;
      if node.nodeName = 'Episode' then
      begin
        for j := 0 to node.childNodes.length - 1 do
        begin
          if node.childNodes[j].nodeName = 'EpisodeNumber' then
          begin
            epnum := StrToInt(node.childNodes[j].Text);
          end;
          if node.childNodes[j].nodeName = 'SeasonNumber' then
          begin
            senum := StrToInt(node.childNodes[j].Text);
          end;
        end;
        if ((epnum = current_ep) and (senum = current_se)) then
        begin
          for j := 0 to node.childNodes.length - 1 do
          begin
            if node.childNodes[j].nodeName = 'Overview' then
            begin
              self.MemoOverview.Text := ansistring(node.childNodes[j].Text);
              if self.MemoOverview.Text <> '' then
                self.Overview_Chk.Checked := true;
            end;
            if node.childNodes[j].nodeName = 'EpisodeName' then
            begin
              self.Title_Ed.Text := ansistring(node.childNodes[j].Text);
              if self.Title_Ed.Text <> '' then
                self.Title_Chk.Checked := true;
            end;


             if node.childNodes[j].nodeName = 'Director' then
            begin

            Directorliststr := node.childNodes[j].Text;
            Directorlist := mystringutil.SplitString('|',Directorliststr) ;

             for k := 0 to Length(Directorlist) - 1 do
            begin
            DeletefirstandLastchar (Directorlist[k]);
             end;

            for k := 1 to Length(Directorlist) - 2 do
            begin

              self.Crew_Grid.cells[0,  self.Crew_Grid.RowCount -1 ] := 'Director';
              self.Crew_Grid.cells[1, self.Crew_Grid.RowCount -1 ] :=  Directorlist[k];
              self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
            end;

               if Directorliststr <> '' then
              self.Crew_Chk.Checked := true;
            end;




            if node.childNodes[j].nodeName = 'Writer' then
            begin

            Writerliststr := node.childNodes[j].Text;
            Writerlist := mystringutil.SplitString('|',Writerliststr) ;

             for k := 0 to Length(Writerlist) - 1 do
            begin
            DeletefirstandLastchar (Writerlist[k]);
             end;

            for k := 1 to Length(Writerlist) - 2 do
            begin

              self.Crew_Grid.cells[0,  self.Crew_Grid.RowCount -1 ] := 'ScreenWriter';
              self.Crew_Grid.cells[1, self.Crew_Grid.RowCount -1 ] :=  Writerlist[k];
              self.Crew_Grid.RowCount := self.Crew_Grid.RowCount + 1;
            end;
              self.Crew_Grid.RowCount := self.Crew_Grid.RowCount - 1;
               if Writerliststr <> '' then
              self.Crew_Chk.Checked := true;
            end;

            if node.childNodes[j].nodeName = 'filename' then
            begin
              posterpath := 'http://thetvdb.com/banners/' +
                node.childNodes[j].Text;


             // GetPoster(posterpath);
              MovieThreadSearch_Image := TThreadsearch_Image.Create(posterpath , After_Thread_Image);

              self.Picture_Chk.Checked := true;
            end;
            if node.childNodes[j].nodeName = 'FirstAired' then
            begin
              s := node.childNodes[j].Text;
              s2 := s[9] + s[10] + '/' + s[6] + s[7] + '/' + s[1] + s[2] +
                s[3] + s[4];
              self.Release_date_Ed.Text := s2;
              if self.Release_date_Ed.Text <> '' then
                self.release_date_Chk.Checked := true;
            end;
            if node.childNodes[j].nodeName = 'Rating' then
            begin


              self.Star_Panel.DrawStar(node.childNodes[j].Text);

                self.Vote_Average_Chk.Checked := true;
            end;
          end;
        end;
      end;

    end;

    except


    end;

   self.Write_Btn.Enabled := true ;
  end;
if posterpath = emptystr then
  begin
After_Thread_Search_Image_Bool :=  true;
  end;

After_Thread_Search_Basic_Info_Bool := true ;
 looping ;
screen.cursor := crdefault;

end;

procedure TThemoviedb.After_Thread_Search_Basic_Info;
var
  rq, posterpath, s: string;
  i: Integer;
begin
  screen.cursor := crhourglass;
  try
    FJSonReader := TlkJSON.ParseText(MovieThreadSearch1.TextToParse)
      as TlkJSONobject;
  except
    Screen.Cursor := crDefault;
    logger.error('Error: Parsing');
  end;

  try

    if FJSonReader.getString('poster_path') <> '' then
    begin
      self.Picture_Chk.Checked := true;

      posterpath := 'http://image.tmdb.org/t/p/w500' + FJSonReader.getString('poster_path');
      if FJSonReader.getString('poster_path') <> emptystr then
      MovieThreadSearch_Image := TThreadsearch_Image.Create(posterpath , After_Thread_Image)
      else
      After_Thread_Search_Image_Bool := true ;

    end;
  except
    Screen.Cursor := crDefault;
    self.Picture_Chk.Checked := false;
  end;

  try
    if FJSonReader.getString('imdb_id') <> '' then
    begin
      self.API_id_chk.Checked := true;
      self.API_id_Ed.Text := (FJSonReader.getString('imdb_id'));
    end;
  except
    Screen.Cursor := crDefault;
    self.API_id_chk.Checked := false;
    self.API_id_Ed.Text := '';
  end;

  try
    if FJSonReader.getString('original_title') <> '' then
    begin
      self.Original_Title_Chk.Checked := true;
      self.Original_title_Ed.Text := (FJSonReader.getString('original_title'));
    end;
  except
    Screen.Cursor := crDefault;
    self.Original_Title_Chk.Checked := false;
    self.Original_title_Ed.Text := '';
  end;

  try
    if FJSonReader.getString('title') <> '' then
    begin
      self.Title_Chk.Checked := true;
      self.Title_Ed.Text := (FJSonReader.getString('title'));
    end;
  except
    Screen.Cursor := crDefault;
    self.Title_Chk.Checked := false;
    self.Title_Ed.Text := '';
  end;

  try
    if FJSonReader.getDouble('vote_average') <> 0 then
    begin
      self.Vote_Average_Chk.Checked := true;
      self.Star_Panel.DrawStar(round(FJSonReader.getDouble('vote_average')));
    end;
  except
    Screen.Cursor := crDefault;
    self.Vote_Average_Chk.Checked := false;
    self.Star_Panel.Reset ;
  end;

  try
    if FJSonReader.getString('release_date') <> '' then
    begin
      self.release_date_Chk.Checked := true;
      s := FJSonReader.getString(('release_date'));
      s := formatdateEngToFrench(s);
      self.Release_date_Ed.Text := s;
    end;
  except
    Screen.Cursor := crDefault;
    self.Release_date_Ed.Text := '';
    self.release_date_Chk.Checked := false;
  end;

  try
    if FJSonReader.getString('overview') <> '' then
    begin
      self.Overview_Chk.Checked := true;
      if FJSonReader.getString('overview') <> '' then

        self.MemoOverview.Lines.Text := (FJSonReader.getString('overview'));
    end;
  except
    Screen.Cursor := crDefault;
    self.MemoOverview.Lines.Text := '';
    self.Overview_Chk.Checked := false;
  end;

  try
    if (FJSonReader.Field['genres'] as TlkJSONList).Count <> 0 then
    begin


      self.Genres_Chk.Checked := true;
      for i := 0 to (FJSonReader.Field['genres'] as TlkJSONList).Count - 1 do
      begin
        self.Genre_ListBox.Items.Add
          (trim((((FJSonReader.Field['genres'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['name'].value)));
      end;
    end;
  except
    Screen.Cursor := crDefault;
    self.Genre_ListBox.Items.Clear;
    self.Genres_Chk.Checked := false;
  end;

  try
    if (FJSonReader.Field['production_companies'] as TlkJSONList).Count <> 0
    then
    begin
      
      self.Production_Comp_Chk.Checked := true;
      for i := 0 to (FJSonReader.Field['production_companies'] as TlkJSONList)
        .Count - 1 do
      begin
        self.Production_Company_ListBox.Items.Add
          (trim((((FJSonReader.Field['production_companies'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['name'].value)));
      end;
    end;
  except
    Screen.Cursor := crDefault;
    self.Production_Company_ListBox.Items.Clear;
    self.Production_Comp_Chk.Checked := false;
  end;

  rq := ('https://api.themoviedb.org/3/movie/' + FTheMoviedb_ID + '/credits?api_key=' +
    FMovieAPIkey + '&language=' + self.FCurrentLangShort);

  MovieThreadSearch1 := TThreadsearch.Create(Tcod.ansi ,rq, After_Thread_Search_Credits);


  rq := ('https://api.themoviedb.org/3/movie/' + FTheMoviedb_ID + '/keywords?api_key=' +
    FMovieAPIkey + '&language=' + self.FCurrentLangShort);

  MovieThreadSearch2 := TThreadsearch.Create(Tcod.ansi, rq, After_Thread_Search_Keywords);
 application.ProcessMessages ;
 After_Thread_Search_Basic_Info_Bool := true ;
 looping ;

 screen.cursor := crdefault;
end;

procedure TThemoviedb.After_Thread_Search_Credits;
var
  rq : string;
  i: Integer;
begin
  screen.cursor := crhourglass;
  try
    FJSonReader := TlkJSON.ParseText(MovieThreadSearch1.TextToParse)
      as TlkJSONobject;
  except
    Screen.Cursor := crDefault;
    logger.error('Error: Parsing');
  end;

  try
    if (FJSonReader.Field['cast'] as TlkJSONList).Count <> 0 then
    begin
      self.Cast_Chk.Checked := true;
      self.Cast_Grid.RowCount :=
        (FJSonReader.Field['cast'] as TlkJSONList).Count;

      for i := 0 to (FJSonReader.Field['cast'] as TlkJSONList).Count - 1 do
      begin
        self.Cast_Grid.Cells[0, i] :=
          (((FJSonReader.Field['cast'] as TlkJSONList).child[i]
          as TlkJSONobject).Field['name'].value);
        self.Cast_Grid.Cells[1, i] :=
          (((FJSonReader.Field['cast'] as TlkJSONList).child[i]
          as TlkJSONobject).Field['character'].value);
        self.Cast_Grid.Cells[2, i] :=
          (((FJSonReader.Field['cast'] as TlkJSONList).child[i]
          as TlkJSONobject).Field['id'].value);
      end;
    end;
  except
    Screen.Cursor := crDefault;
    self.Cast_Chk.Checked := false;
  end;

  try
    if (FJSonReader.Field['crew'] as TlkJSONList).Count <> 0 then
    begin

      self.Crew_Chk.Checked := true;
      self.Crew_Grid.RowCount :=
        (FJSonReader.Field['crew'] as TlkJSONList).Count;

      for i := 0 to (FJSonReader.Field['crew'] as TlkJSONList).Count - 1 do
      begin
        self.Crew_Grid.Cells[0, i] :=
          (((FJSonReader.Field['crew'] as TlkJSONList).child[i]
          as TlkJSONobject).Field['job'].value);
        self.Crew_Grid.Cells[1, i] :=
          (((FJSonReader.Field['crew'] as TlkJSONList).child[i]
          as TlkJSONobject).Field['name'].value);
        self.Crew_Grid.Cells[2, i] :=
          (((FJSonReader.Field['crew'] as TlkJSONList).child[i]
          as TlkJSONobject).Field['department'].value);
        self.Crew_Grid.Cells[3, i] :=
          (((FJSonReader.Field['crew'] as TlkJSONList).child[i]
          as TlkJSONobject).Field['id'].value);
      end;
    end;
  except
    Screen.Cursor := crDefault;
    self.Crew_Chk.Checked := false;
  end;

  for i := 0 to self.Crew_Grid.RowCount do
  begin
    if self.Crew_Grid.Cells[0, i] = 'Original Music Composer' then
      self.Crew_Grid.Cells[0, i] := 'Music by';
    if self.Crew_Grid.Cells[0, i] = 'Screenplay' then
      self.Crew_Grid.Cells[0, i] := 'Screenwriter';
    if self.Crew_Grid.Cells[0, i] = 'Director of Photography' then
      self.Crew_Grid.Cells[0, i] := 'Cinematographer';
  end;

application.ProcessMessages ;
After_Thread_Search_Credits_Bool := true ;
screen.cursor := crdefault;
 looping ;


end;

procedure TThemoviedb.After_Thread_Image;
begin
screen.cursor := crhourglass;
application.ProcessMessages ;

After_Thread_Search_Image_Bool := true ;
looping ;
screen.cursor := crdefault;
end;

procedure TThemoviedb.After_Thread_Search_Keywords;
var
  i: Integer;
begin
screen.cursor := crhourglass;
  try
    try
      FJSonReader := TlkJSON.ParseText(MovieThreadSearch2.TextToParse)
        as TlkJSONobject;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: Parsing');
    end;

    if (FJSonReader.Field['keywords'] as TlkJSONList).Count <> 0 then
    begin
      self.Keywords_Chk.Checked := true;
      for i := 0 to self.Keywords_List.Items.Count - 1 do
        self.Keywords_List.Items.Delete(i);
      for i := 0 to (FJSonReader.Field['keywords'] as TlkJSONList).Count - 1 do
      begin
        self.Keywords_List.Items.Add
          (trim((((FJSonReader.Field['keywords'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['name'].value)));
      end;
    end;

  except
    Screen.Cursor := crDefault;
    self.Keywords_List.Items.Clear;
    self.Keywords_Chk.Checked := false;
  end;
application.ProcessMessages ;
After_Thread_Search_Keywords_Bool := true ;
 looping ;
 screen.cursor := crdefault;

end;



procedure TThemoviedb.Release_date_EdKeyPress(Sender: TObject; var Key: Char);
begin
  self.release_date_Chk.Checked := true;
  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.Imdb_searchEnter(Sender: TObject);
begin
  self.search_byimdb.Checked := true;
end;




procedure TThemoviedb.Write_BtnClick(Sender: TObject);
var
  NpWnd: HWnd;
  FJRiverXml: TJRiverXml;
  day: TDateTime;
  s: string;
  i, j: Integer;
  crew_list: TStringList;

begin
self.View_Btn.Enabled := true ;
  if self.FMassScrap = true then
  begin
  try
    Check_Fields_from_FMassScrapbooleans ;
  except

  end;
  end;

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  if not assigned(FCurrentMovie) then
  begin
    ShowMessage(FTranslateList[11]);
    Screen.Cursor := crDefault;
    Exit;
  end;

  if self.Movie_Browser.Cells[7, self.Movie_Browser.Row] = 'YES' then
  begin
    Screen.Cursor := crDefault;
    if self.FMassScrap = false then
    begin
      ShowMessage(FTranslateList[18]);
      ShowJRiverId(FCurrentJRiverId);
      Exit;
    end;

  end;


    for i := 1 to self.Movie_Browser.RowCount - 1 do
    begin
     try
      if StrToint(self.Movie_Browser.Cells[0, i]) = FCurrentJRiverId then
      begin
      if self.Title_Chk.Checked = true  then
         begin
        self.Movie_Browser.Cells[1, i] := self.Title_Ed.Text;
         end;
      end;
      except

    logger.error('self.Movie_Browser.Cells[0, i] = ' + self.Movie_Browser.Cells[0, i]);
    logger.error('FCurrentJRiverId = ' + IntToStr(FCurrentJRiverId));
  end;
    end;
    self.SearchEdit.Text := self.Title_Ed.Text;



  try

    FJRiverXml := TJRiverXml.Create(self.Movie_Browser.Cells[12,   self.Movie_Browser.Row], Sender);
  except
    Screen.Cursor := crDefault;
    logger.error('Error: could not create XML file');
    logger.error('FCurrentMovie.get(Filename.. =' + FCurrentMovie.get('Filename', true));
  end;

  if self.TVdb_Rd.Checked = true then
  begin
  self.Movie_Browser.cells[3, self.Movie_Browser.row] :=IntToStr(self.Season_Spin_W.Value);
  FCurrentMovie.Set_('Season', IntToStr(self.Season_Spin_W.Value));

   try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Season', IntToStr(self.Season_Spin_W.Value));
    except
      logger.error('Error XML: Season');
    end;

  self.Movie_Browser.cells[4, self.Movie_Browser.row] :=IntToStr(self.Episode_Spin_W.Value);
  FCurrentMovie.Set_('Episode', IntToStr(self.Episode_Spin_W.Value));

   try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Episode', IntToStr(self.Episode_Spin_W.Value));
    except
      logger.error('Error XML: Episode');
    end;

  self.Movie_Browser.cells[2, self.Movie_Browser.row] := self.Original_title_Ed.Text
  end;

 

  if self.Title_Chk.Checked = true then
  begin

    try
      FCurrentMovie.Set_('Name', self.Title_Ed.Text);
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Change CurrentMovie name');
      // 'Error: filling Movie_Browser'
    end;
    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Name', self.Title_Ed.Text);
    except
      logger.error('Error XML: Change CurrentMovie name');
    end;

  end;

  if ((self.Original_Title_Chk.Checked = true)and (self.TheMoviedB_rd.Checked = true)) then
  begin
    try
      FCurrentMovie.Set_('original title', self.Original_title_Ed.Text);

    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Original_Title');
    end;
    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('original title', self.Original_title_Ed.Text);
    except
      logger.error('Error XML: Original_Title');
    end;
  end;

   if ((self.Original_title_Chk.Checked = true )and (self.TVdb_Rd.Checked = true))then
  begin

    try
      FCurrentMovie.Set_('Series', self.Original_title_Ed.Text);
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Change CurrentMovie name');
      // 'Error: filling Movie_Browser'
    end;
    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Series', self.Original_title_Ed.Text);
    except
      logger.error('Error XML: Change CurrentMovie name');
    end;

  end;

  if self.release_date_Chk.Checked = true then
  begin
    try
      s := self.Release_date_Ed.Text;
      day := StrToDate(s);
      s := '';


      FCurrentMovie.Set_('Date', Floattostr(day));
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Date');
    end;
    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Date', Floattostr(day));
    except
      logger.error('Error XML: Date');
    end;
  end;

  if self.Cast_Chk.Checked = true then
  begin
    try
      for i := 0 to self.Cast_Grid.RowCount - 1 do
      begin
        s := s + ';' + self.Cast_Grid.Cells[0, i];
      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: self.Cast_Grid.Cells');
    end;

    s := Copy(s, 2, length(s) - 1);
    try

      FCurrentMovie.Set_('Actors', s);

    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Actors');
    end;
    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Actors', s);
    except
      logger.error('Error XML: Actors');
    end;

    s := '';
    try
      for i := 0 to self.Cast_Grid.RowCount - 1 do
      begin
        s := s + ';' + self.Cast_Grid.Cells[1, i];
      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: Cast_Grid');
    end;

    s := Copy(s, 2, length(s) - 1);
    try
      FCurrentMovie.Set_('Character', s);
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Character');
    end;

    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Character', s);
    except
      logger.error('Error XML: Character');
    end;
    s := '';

    try
      for i := 0 to self.Cast_Grid.RowCount - 1 do
      begin
        if (self.Cast_Grid.Cells[0, i] <> '') and
          (self.Cast_Grid.Cells[1, i] <> '') then
        begin
          s := s + ';' + self.Cast_Grid.Cells[0, i] + ', ' +
            self.Cast_Grid.Cells[1, i];
        end;
      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: Cast_Grid.RowCount');
    end;

    s := Copy(s, 2, length(s) - 1);
    try
      FCurrentMovie.Set_('ActorAsCharacter', s);

    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: ActorAsCharacter');
    end;
    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('ActorAsCharacter', s);
    except
      logger.error('Error XML: ActorAsCharacter');
    end;
    s := '';

  end;

  if self.Genres_Chk.Checked = true then
  begin
    try
      for i := 0 to self.Genre_ListBox.Count - 1 do
      begin
        s := s + ';' + self.Genre_ListBox.Items[i];
      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: Genre_ListBox');
    end;

    s := Copy(s, 2, length(s) - 1);
    try
      FCurrentMovie.Set_('Genre', s);
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Genre');
    end;
    try
      if WriteXMLsideCar1.Checked = true then
        FJRiverXml.SetField('Genre', s);
    except
      logger.error('Error XML: Genre');
    end;
    s := '';

  end;

  if self.Production_Comp_Chk.Checked = true then
  begin
    try
      for i := 0 to self.Production_Company_ListBox.Count - 1 do
      begin
        s := s + ';' + self.Production_Company_ListBox.Items[i];
      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: Production_Company_ListBox');
    end;

    s := Copy(s, 2, length(s) - 1);
    try
      FCurrentMovie.Set_('Production Company', s);
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Production Company');
    end;
    try
      if WriteXMLsideCar1.Checked then
        FJRiverXml.SetField('Production Company', s);
    except
      Screen.Cursor := crDefault;
      logger.error('Error XML: Production Company');
    end;
    s := '';

  end;

  if self.Keywords_Chk.Checked = true then
  begin
    try
      for i := 0 to self.Keywords_List.Count - 1 do
      begin
        s := s + ';' + self.Keywords_List.Items[i];
      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: Keywords_List');
    end;

    s := Copy(s, 2, length(s) - 1);
    try

      FCurrentMovie.Set_('Keywords', s);
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Keywords');
    end;

    try
      if WriteXMLsideCar1.Checked then
        FJRiverXml.SetField('Keywords', s);
    except
      Screen.Cursor := crDefault;
      logger.error('Error XML: Keywords');
    end;
  end;
  s := '';

  if self.API_id_chk.Checked = true then
  begin
    try
      self.Movie_Browser.cells[10, self.Movie_Browser.row] := self.API_Id_Ed.Text;
       if  self.TVdb_Rd.Checked = true then
      begin
      FCurrentMovie.Set_('TheTVDB Series ID', self.API_id_Ed.Text) ;

      end;
      if self.TheMoviedB_rd.Checked = true then
      begin
      FCurrentMovie.Set_('IMDb ID', self.API_id_Ed.Text);
      end;

    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: IMDb ID');
    end;
    try
      if WriteXMLsideCar1.Checked then

         if  self.TVdb_Rd.Checked = true then
        FJRiverXml.SetField('TheTVDB Series ID', self.API_id_Ed.Text);
        if self.TheMoviedB_rd.Checked = true then
        FJRiverXml.SetField('IMDb ID', self.API_id_Ed.Text);

    except
      Screen.Cursor := crDefault;
      logger.error('Error XML: IMDb ID');
    end;
  end;

  if self.Vote_Average_Chk.Checked = true then
  begin
    try
      FCurrentMovie.Set_('Critic Rating', Floattostr(self.Star_Panel.value));
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Critic Rating');
    end;
    try
      if WriteXMLsideCar1.Checked then
        FJRiverXml.SetField('Critic Rating', Floattostr(self.Star_Panel.value));
    except
      Screen.Cursor := crDefault;
      logger.error('Error XML: Critic Rating');
    end;
  end;

  if self.Overview_Chk.Checked = true then
  begin
    try

      FCurrentMovie.Set_('Description', self.MemoOverview.Text);
    except
      Screen.Cursor := crDefault;
      logger.error('Error COM: Description');
    end;
    try
      if WriteXMLsideCar1.Checked then
        FJRiverXml.SetField('Description', self.MemoOverview.Text);
    except
      Screen.Cursor := crDefault;
      logger.error('Error XML: Description');
    end;;
  end;

  if self.Crew_Chk.Checked then
  begin
    crew_list := TStringList.Create;
    s := '';

    for i := 0 to self.Crew_Grid.RowCount - 1 do
    begin
      crew_list.Add(self.Crew_Grid.Cells[0, i]);
    end;
    RemoveDuplicates(crew_list);
    try
      for i := 0 to crew_list.Count - 1 do
      begin
        for j := 0 to self.Crew_Grid.RowCount - 1 do
        begin

          if self.Crew_Grid.Cells[0, j] = crew_list[i] then
            s := s + ';' + self.Crew_Grid.Cells[1, j];
        end;
        s := Copy(s, 2, length(s) - 1);
        try
          if WriteXMLsideCar1.Checked then
            FJRiverXml.SetField(crew_list[i], s);

        except
          Screen.Cursor := crDefault;
          logger.error('Error COM: Crew');
        end;
        try
          FCurrentMovie.Set_(crew_list[i], s);
        except
          Screen.Cursor := crDefault;
          logger.error('Error XML: Crew');
        end;
        s := '';
      end;

      crew_list := nil;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: crew_list');
    end;
  end;

  s := '';

  if self.Picture_Chk.Checked = true then
  begin
    s := ExtractFilePath(self.Movie_Browser.Cells[12, self.Movie_Browser.Row]) +
      ExtractFileNameWithoutExt(self.Movie_Browser.Cells[12,
      self.Movie_Browser.Row]) + '.jpg';

    // Save image in directory
    try
      self.Picture_Img.Picture.SaveToFile(s);
    except
      Screen.Cursor := crDefault;
      logger.error('Error: saving Picture');
    end;

    try
      FCurrentMovie.SetImageFile(s, IMAGEFILE_IN_DATABASE);

    except
      Screen.Cursor := crDefault;
    end;

    try
      FCurrentMovie.SetImageFile(s, IMAGEFILE_DISPLAY);
    except
      Screen.Cursor := crDefault;

    end;

    try
      FCurrentMovie.SetImageFile(s, IMAGEFILE_IN_FILE);
    except
      Screen.Cursor := crDefault;
    end;
  end;

  Select_MovieBrowserRow_by_JRiver_ID(FCurrentJRiverId);

  Screen.Cursor := crDefault;
  try
    self.Movie_Browser.Cells[9, self.Movie_Browser.Row] :=
      FMoviesList.GetFile(FCurrentJRiverId).get('Date Imported', true);

  except

  end;

  if length(DeleteAllSpaces(FMoviesList.GetFile(FCurrentJRiverId).get('Description',
    true))) <> 0 then
    self.Movie_Browser.Cells[11, self.Movie_Browser.Row] :=
      Leftstr(FMoviesList.GetFile(FCurrentJRiverId).get('Description', true),
      40) + '...'

  else
    self.Movie_Browser.Cells[11, self.Movie_Browser.Row] := '';



  if self.FMassScrap = true then
  begin
    self.Movie_Browser.Cells[7, self.Movie_Browser.Row] := 'YES';
    self.Movie_Browser.Repaint;
    FCurrentMovie.Set_('Lock External Tag Editor', 'YES');
    Form3.MassTag;

  end;
  FJRiverXml.close ;
  ShowJRiverId(FCurrentJRiverId);
  Update_TVBD_ID;
end;



procedure TThemoviedb.About1Click(Sender: TObject);
var
  f2: TForm;
begin

  f2 := TForm2.Create(nil);
  f2.left := self.left + 250;
  f2.top := self.top + 20;
  f2.ShowModal;

end;

procedure TThemoviedb.Add1Click(Sender: TObject);
var
  s: string;
begin
  self.Keywords_Chk.Checked := true;
  s := InputBox(FTranslateList[6], ' ', '');
  if s <> '' then
  begin
    Keywords_List.Items.Add(s);
    Keywords_List.Sorted := false;
    Keywords_List.Sorted := true;
    self.Write_Btn.Enabled := true;

  end;
end;

procedure TThemoviedb.Add2Click(Sender: TObject);
var
  s: string;
begin
  self.Genres_Chk.Checked := true;
  s := InputBox(FTranslateList[6], ' ', '');
  if s <> '' then
  begin
    Genre_ListBox.Items.Add(s);
    Genre_ListBox.Sorted := false;
    Genre_ListBox.Sorted := true;
    self.Write_Btn.Enabled := true;

  end;
end;

procedure TThemoviedb.All1Click(Sender: TObject);
begin
  if self.Title_Ed.Text <> '' then
    self.Title_Chk.Checked := true;
  if self.Original_title_Ed.Text <> '' then
    self.Original_Title_Chk.Checked := true;
  if self.Release_date_Ed.Text <> '' then
    self.release_date_Chk.Checked := true;
  if self.API_id_Ed.Text <> '' then
    self.API_id_chk.Checked := true;
  if self.MemoOverview.Text <> '' then
    self.Overview_Chk.Checked := true;

  if self.Star_Panel.value <> 0 then
    self.Vote_Average_Chk.Checked := true;

  if self.Genre_ListBox.Items.Count > 0 then
    self.Genres_Chk.Checked := true;
  if self.Production_Company_ListBox.Items.Count <> 0 then
    self.Production_Comp_Chk.Checked := true;
  if self.Keywords_List.Items.Count > 0 then
    self.Keywords_Chk.Checked := true;

  if self.Cast_Grid.Cells[0, 0] <> '' then
    self.Cast_Chk.Checked := true;
  if self.Crew_Grid.Cells[0, 0] <> '' then
    self.Crew_Chk.Checked := true;

  if FCurrentMoviePicture <> '' then
    self.Picture_Chk.Checked := true;

end;

procedure TThemoviedb.All2Click(Sender: TObject);
var
  i: Integer;
begin

    for i := 1 to self.FMoviesCount do
    begin
    try
      Movie_Browser.Cells[7, i] := 'YES';
      Themoviedb.FCurrentMovie := Themoviedb.FMoviesList.GetFile
        (StrToint(Themoviedb.Movie_Browser.Cells[0, i]));
      FCurrentMovie.Set_('Lock External Tag Editor', 'YES');

  except
   logger.error('Error: 1729');
  end;
    end;

  Movie_Browser.Repaint;
end;




procedure TThemoviedb.ClearAll();
var
  i: Integer;
begin
  try
    self.Star_Panel.Reset;
    self.Picture_Img.Picture := nil ;
    self.Picture_Chk.Checked := false;
    self.Title_Chk.Checked := false;
    self.Original_Title_Chk.Checked := false;
    self.release_date_Chk.Checked := false;
    self.API_id_chk.Checked := false;
    self.Overview_Chk.Checked := false;
      if  self.TVdb_Rd.Checked = false then
      begin
   // self.Season_Spin_W.Value := 0;
   // self.Episode_Spin_W.Value := 0;
      end;


    self.Vote_Average_Chk.Checked := false;
    self.Genres_Chk.Checked := false;
    self.Production_Comp_Chk.Checked := false;
    self.Keywords_Chk.Checked := false;
    self.Cast_Chk.Checked := false;
    self.Crew_Chk.Checked := false;
    self.API_id_Ed.Text := '';
    self.Title_Ed.Text := '';
    self.Original_title_Ed.Text := '';
    self.Release_date_Ed.Text := '';
    self.Genre_ListBox.Items.Clear;
    self.Production_Company_ListBox.Items.Clear;
    self.Keywords_List.Items.Clear;
    self.MemoOverview.Lines.Clear;
    self.Cast_Grid.RowCount := 1;
    self.Crew_Grid.RowCount := 1;

    for i := 0 to self.Cast_Grid.RowCount do
      self.Cast_Grid.Rows[i].Clear;

    self.Cast_Grid.Rows[1].Clear;

    for i := 0 to self.Crew_Grid.RowCount do
      self.Crew_Grid.Rows[i].Clear;
  except
    Screen.Cursor := crDefault;
    logger.error('Error: ClearAll');
  end;

  self.Genre_ListBox.Items.Clear;
  self.Production_Company_ListBox.Items.Clear;
  self.Keywords_List.Items.Clear;

end;

procedure TThemoviedb.Close1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TThemoviedb.ComboBox1Change(Sender: TObject);
begin

if  self.ComboBox1.Items[self.ComboBox1.ItemIndex] <> 'TV Show' then
begin
 self.TheMoviedB_rd.Checked := true;
   self.Movie_Browser.ColWidths[2] := 0;  // Serie Name
  self.Movie_Browser.ColWidths[3] := 0;  //Season
  self.Movie_Browser.ColWidths[4] := 0;  //Ep
  self.Movie_Browser.Cells[10, 0] := 'Imdb ID' ;
end
else
begin
 self.TVdb_Rd.Checked := true;
self.Movie_Browser.ColWidths[2] := 200;  // Serie Name
  self.Movie_Browser.ColWidths[3] := 20;  //Season
  self.Movie_Browser.ColWidths[4] := 20;  //Ep
  self.Movie_Browser.Cells[10, 0] := 'Tvdb ID' ;
end;

self.Movie_Browser.col := 0;
FMoviesList := self.MCAutomation.Search(' [Media Type]=[Video]  [Media Sub Type]=['+ self.ComboBox1.Items[self.ComboBox1.ItemIndex]+']');
fillbrowser ;
end;

procedure TThemoviedb.Createthenewfields1Click(Sender: TObject);
const
  tags: array [0 .. 7] of string = ('Production Company', 'Casting',
    'Executive Producer', 'Novel', 'Production Design', 'Character',
    'ActorAsCharacter', 'Lock External Tag Editor');
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

procedure TThemoviedb.Delete1Click(Sender: TObject);
begin
  self.Keywords_Chk.Checked := true;
  Keywords_List.Items.Delete(Keywords_List.itemindex);
  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.Delete2Click(Sender: TObject);
begin
  self.Production_Comp_Chk.Checked := true;
  Production_Company_ListBox.Items.Delete
    (self.Production_Company_ListBox.itemindex);
  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.Delete3Click(Sender: TObject);
begin
  self.Genres_Chk.Checked := true;
  Genre_ListBox.Items.Delete(self.Genre_ListBox.itemindex);
  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.DeleteClick(Sender: TObject);
begin
  self.Production_Comp_Chk.Checked := true;
  Production_Company_ListBox.Items.Add(InputBox('Enter a value', ' ', ' '));
  Production_Company_ListBox.Sorted := false;
  Production_Company_ListBox.Sorted := true;
  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.Dossiercourant1Click(Sender: TObject);
begin
  GotofolderClick(self);
end;

procedure TThemoviedb.Duration_EdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.scrapall1Click(Sender: TObject);
var
  f3: TForm;
begin

  f3 := TForm3.Create(nil);
  f3.left := self.left + 250;
  f3.top := self.top + 20;
  f3.ShowModal;

end;

procedure TThemoviedb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  logger.info('Closing app.' );
  Tlogger.freeInstances;
  idd.Free;
  FJSonReader.Free;

end;

procedure TThemoviedb.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
    Screen.Cursor := crDefault;
    logger.error('Error: could not write Top-Left-Width');
  end;
end;

procedure TThemoviedb.FormCreate(Sender: TObject);
var
  RegNGFS: TRegistry;
  i: Integer;
  lang, querylang: string;
  s: string;
  filelangname,stylename: string;
  languageitem: TMenuItem;
  FileinParamFound: Boolean;
  firstrun: Boolean;
  sub_type_stringlist : TStringList;
begin

   FMovieAPIkey := '3b608fc11821e92cd2459320206a9d9b';
   FAPIkey := '1A501B293D1EF0C7';

   sub_type_stringlist := Tstringlist.Create ;

   logger := Tlogger.getInstance;
   logger.setLevel(TLevelUnit.INFO);
   FlogFolder   := GetFolderPath(CSIDL_COMMON_APPDATA)+ '\JRScrap\' ;
   Flogfilename := FlogFolder + FormatDateTime('dd_mm_yy__hh_mm_ss',Now)+ '.log';     // Program Data
   logger.addAppender(TFileAppender.Create(Flogfilename));
   logger.info('Log File from JRScrap');
   logger.info('Date Generated :' + DateToStr(date) + ' at ' + TimeToStr(time));
   logger.info('Launching app.');
   FAppPath := ExtractFilePath(Application.ExeName);

  for i := 0 to length(FMovieColumnsSortOrder) - 1 do
    FMovieColumnsSortOrder[i] := false;

  if Fileexists(GetParentDirectory(FAppPath) + '\images\lock.png') = true then
    lock_img := TPNGImage.Create;
  lock_img.LoadFromFile(GetParentDirectory(FAppPath) + '\images\lock.png');

  try
    MCAutomation := TMCAutomation.Create(self);
  except
    Screen.Cursor := crDefault;
    logger.error('Error : Could not initialize TMCAutomation');
  end;

  try
    idHTTP1 := TIdHTTP.Create(self);
  except
    Screen.Cursor := crDefault;
    logger.error('Error : Could not create idHTTP');
  end;

  firstrun := true;
  SetTranslateList ;
  idd := TImageDropDown<TJPEGImage>.Create(self.Picture_Img,
    self.Picture_Panel);
  idd.OnAfterLoadImg := NewIMGLoaded;

  FMesgCount := 0;

  for i := 1 to ParamCount do
    FParameterStr := FParameterStr + ' ' + ParamStr(i);
  FParameterStr := trim(FParameterStr);

  if assigned(TStyleManager.ActiveStyle) then
    FdefaultStyleName := TStyleManager.ActiveStyle.name;

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
        FMassScrapbooleans := '111111111111' ;
        RegNGFS.WriteString('MassScrapbooleans', Themoviedb.FMassScrapbooleans);

      

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

          RegNGFS.Writebool('WriteSideCar', true);
          RegNGFS.WriteString('style', 'Windows');
          RegNGFS.WriteInteger('top', 100);
          RegNGFS.WriteInteger('left', 100);
          RegNGFS.WriteInteger('width', 1200);
          WriteXMLsideCar1.Checked := true;
          RegNGFS.Free;
        end;

      except
        Screen.Cursor := crDefault;
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
      Screen.Cursor := crDefault;
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
      Screen.Cursor := crDefault;
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
      Screen.Cursor := crDefault;
      logger.error('Error: Could not create languageitem');
    end;

    try
      for stylename in TStyleManager.StyleNames do
      begin
        Inc(i);
        Fstyleitem := TMenuItem.Create(self);
        Fstyleitem.name := 'Style' + IntToStr(i);
        Fstyleitem.Caption := stylename;
        Fstyleitem.Checked := false;
        Fstyleitem.RadioItem := true;
        Fstyleitem.GroupIndex := 1;
        Fstyleitem.OnClick := StyleClick;
        self.SelectStyle.Add(Fstyleitem);
      end;
    except
      Screen.Cursor := crDefault;
      logger.error('Error: Could not set Window style');
    end;

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
      Screen.Cursor := crDefault;
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
        Screen.Cursor := crDefault;
        logger.error('Error: Could not find English item');
      end;
    end;
    if Fileexists(ExtractFileDir(Application.ExeName) + '\..\languages\' + lang
      + '.lng') then

      if FCurrentMovie <> nil then
      begin
        self.SearchEdit.Text := self.FCurrentMovie.name;
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
        Screen.Cursor := crDefault;
        logger.error('Error: Could not find eng item');
      end;
    end;

    RegNGFS := TRegistry.Create;
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
    begin
      try
        Fstyle := RegNGFS.Readstring('style');
      except

      end;

      RegNGFS.Free;
      if Fstyle = '' then
        Fstyle := 'Windows';
      TStyleManager.SetStyle(trim(StringReplace(Fstyle, '&', '',
        [rfReplaceAll, rfIgnoreCase])));

      try

      sub_type_stringlist.Sorted := True;
      sub_type_stringlist.Duplicates := dupIgnore;

      FMoviesList := self.MCAutomation.Search('[Media Type]=[Video]');
      FMoviesCount := FMoviesList.GetNumberFiles();

      for i := 0 to FMoviesCount - 1 do
      begin
       s :=  FMoviesList.GetFile(i).get('Media Sub Type', true) ;
      sub_type_stringlist.add(  FMoviesList.GetFile(i).get('Media Sub Type', true));

      end;

       except
        Screen.Cursor := crDefault;
        logger.error('Error: Could not get Movies from JRiver');
      end;



    for i := sub_type_stringlist.Count - 1 downto 0 do
    if sub_type_stringlist[i] = '' then
    sub_type_stringlist.Delete(i);


    self.ComboBox1.Items.Clear ;
    self.ComboBox1.Items := sub_type_stringlist ;
    try

    self.ComboBox1.ItemIndex := 0 ;
    self.ComboBox1.ItemIndex := self.ComboBox1.items.IndexOf('Movie');
    ComboBox1Change(Self);
    except

    end;


         fillbrowser ;

    end;

  finally

  end;

end;

procedure TThemoviedb.FormShow(Sender: TObject);
var
  RegNGFS: TRegistry;
begin
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

  if self.FHideForm = true then
    ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TThemoviedb.StyleClick(Sender: TObject);
var
  name: string;
  RegNGFS: TRegistry;
begin

  (Sender as TMenuItem).Checked := true;
  name := (Sender as TMenuItem).Caption;
  TStyleManager.SetStyle(trim(StringReplace(name, '&', '', [rfReplaceAll,
    rfIgnoreCase])));

  try
    RegNGFS := TRegistry.Create;
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
    begin

      RegNGFS.WriteString('style', name);
      WriteXMLsideCar1.Checked := true;
      RegNGFS.Free;
    end;

  except
    Screen.Cursor := crDefault;
    logger.error('Error: could not set style');
  end;
end;





procedure TThemoviedb.Subtitle_BtnClick(Sender: TObject);
var
  frm_openSub: TForm;
begin

  frm_openSub := TOpenSub_Form.Create(nil);
  frm_openSub.left := self.left + 250;
  frm_openSub.top := self.top + 20;
  frm_openSub.ShowModal;

end;

procedure TThemoviedb.TheMoviedB_rdClick(Sender: TObject);
begin
  if search_byname.Checked = true then  search_bynameClick(self);
  if search_byimdb.Checked = true then search_byimdbClick(self);
  self.Movie_Search_Grid.RowCount := 0;

  if  self.TheMoviedB_rd.Checked = true then
begin

  self.Original_Title_Chk.Caption := 'Original Title :'   ;
  search_byimdb.Caption := 'IMDB ID :'   ;

  self.Movie_Browser.ColWidths[2] := 0;  // Serie Name
  self.Movie_Browser.ColWidths[3] := 0;  //Season
  self.Movie_Browser.ColWidths[4] := 0;  //Ep
  self.Movie_Browser.Cells[10, 0] := 'Imdb ID' ;




  self.Season_Spin_W.Enabled  := false ;
  self.Episode_Spin_W.Enabled  := false ;

  self.Original_title_Ed.Enabled := true ;
  self.Original_Title_Chk.Enabled := true ;

   self.Original_title_Ed.Text := '';

end ;

if  self.TVdb_Rd.Checked = true then
begin
  self.Original_Title_Chk.Caption := 'Serie Title :'   ;
  search_byimdb.Caption := 'TVDB ID :'   ;

  self.Movie_Browser.ColWidths[2] := 200;  // Serie Name
  self.Movie_Browser.ColWidths[3] := 20;  //Season
  self.Movie_Browser.ColWidths[4] := 20;  //Ep
  self.Movie_Browser.Cells[10, 0] := 'Tvdb ID' ;


  self.Season_Spin_W.Enabled  := true ;
  self.Episode_Spin_W.Enabled  := true ;

  self.Original_title_Ed.Text := '';
end;
   fillbrowser ;
   ShowJRiverId(FCurrentJRiverId);
  API_id_chk.Caption := search_byimdb.Caption ;
  FCurrentLang := TranslateJRStyle(FCurrentLang, false);
end;

procedure TThemoviedb.Title_EdKeyPress(Sender: TObject; var Key: Char);
begin
 self.Title_Chk.Checked := true;
  self.Write_Btn.Enabled := true;
end;

procedure TThemoviedb.LanguageQueryClick(Sender: TObject);
var
  RegNGFS: TRegistry;
begin
  (Sender as TMenuItem).Checked := true;
  try
    self.FCurrentLangShort := trim((Sender as TMenuItem).Caption);
  except
    Screen.Cursor := crDefault;
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
    Screen.Cursor := crDefault;
    logger.error('Error: COuld not write Querylanguage');
  end;
end;

procedure TThemoviedb.LanguageClick(Sender: TObject);
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
   FCurrentLang :=  TranslateJRStyle(NextLang, false);
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
      Screen.Cursor := crDefault;
      logger.error('Error: Could not write language');
    end;
  end;

  if ((FCurrentLang <> 'English') and (NextLang <> 'English')) then
  begin
    try
      TranslateJRStyle(FCurrentLang, true); // Untranslate current to english
      TranslateJRStyle(NextLang, false); // translate to NextLang
      FCurrentLang := NextLang;

      RegNGFS := TRegistry.Create;
      RegNGFS.RootKey := HKEY_CURRENT_USER;
      if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
      begin
        RegNGFS.WriteString('Language', NextLang);
        RegNGFS.Free;
      end;

    except
      Screen.Cursor := crDefault;
      logger.error('Error: COuld not write language');
    end;
  end;

  if ((FCurrentLang <> 'English') and (NextLang = 'English')) then
  begin
    try
      TranslateJRStyle(FCurrentLang, true); // Untranslate current to english
      FCurrentLang := 'English';

      RegNGFS := TRegistry.Create;
      RegNGFS.RootKey := HKEY_CURRENT_USER;
      if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
      begin
        RegNGFS.WriteString('Language', 'English');
        RegNGFS.Free;
      end;

    except
      Screen.Cursor := crDefault;
      logger.error('Error: COuld not write language');
    end;
  end;

end;

procedure TThemoviedb.Genre_ListBoxClick(Sender: TObject);
begin
  self.Genre_ListBox.Selected[self.Genre_ListBox.itemindex] := false;
end;



procedure TThemoviedb.GotofolderClick(Sender: TObject);
begin
  if FCurrentMoviePath <> '' then
    ShowFolder(FCurrentMoviePath);
end;

procedure TThemoviedb.Helppage1Click(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'https://github.com/fredele/JRScrap/blob/master/help.md';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink), nil,
    nil, SW_SHOW);

end;

procedure TThemoviedb.API_id_EdChange(Sender: TObject);
begin
    if AnsiContainsStr(self.API_id_Ed.Text, 'tt') then
    self.Subtitle_Btn.Enabled := true
    else
    self.Subtitle_Btn.Enabled := false ;

end;

procedure TThemoviedb.API_id_EdKeyPress(Sender: TObject; var Key: Char);
begin
  self.API_id_chk.Checked := true;
  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.View_BtnClick(Sender: TObject);
var
  rq: String;

begin
ClearAll();
self.Write_Btn.Enabled := false ;
Screen.Cursor := crHourGlass;



  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

 if self.TheMoviedB_rd.Checked = true then
    begin
//// IMDB

  // IMdb search
  if self.search_byimdb.Checked = true then
  begin
    self.Imdb_search.Text := StringReplace(self.Imdb_search.Text, 'TT', 'tt',
      [rfReplaceAll, rfIgnoreCase]);
    if ((self.Imdb_search.Text[1] <> 't') or (self.Imdb_search.Text[2] <> 't'))
    then
    begin
      ShowMessage(FTranslateList[14]);
      ShowJRiverId(FCurrentJRiverId);
      Screen.Cursor := crDefault;
      Exit;
    end;

    rq := 'http://api.themoviedb.org/3/find/' + self.Imdb_search.Text +
      '?api_key=' + FMovieAPIkey + '&external_source=imdb_id' + '&language=' +
      self.FCurrentLangShort;


  try

    MovieThreadSearch1 := TThreadsearch.Create(Tcod.ansi , rq, After_Thread_Search_IMDB_ID);
    // Le thread est désormais créé, et actif.

  except
    Screen.Cursor := crDefault;
    logger.error('Error: Error for this request');
  end;
   end;


  // TheMoviedb_ID search
  if self.search_byimdb.Checked = false then
  begin
    None1Click(Sender);

    if FTheMoviedb_ID = '' then
    begin
      ShowMessage(FTranslateList[10]);
      ShowJRiverId(FCurrentJRiverId);
      Screen.Cursor := crDefault;
      exit ;
    end;
    rq := 'https://api.themoviedb.org/3/movie/' + FTheMoviedb_ID + '?api_key=' + FMovieAPIkey +
      '&language=' + self.FCurrentLangShort;

    MovieThreadSearch1 := TThreadsearch.Create(Tcod.ansi ,rq, After_Thread_Search_Basic_Info);
  end;


end;

 if  self.TVdb_Rd.Checked = true then
begin
//// THEMOVIEDB

try

    rq := 'http://thetvdb.com/api/' + FAPIkey + '/series/' +
      self.imdb_search.Text + '/all/' + FCurrentLangShort + '.xml';

    MovieThreadSearch1 := TThreadsearch.Create(Tcod.utf8,rq, After_Thread_SearchSerieEpisode);
    // Le thread est désormais créé, et actif.

  except
    screen.cursor := crdefault;
  end;








end;

  Application.ProcessMessages;

end;

procedure TThemoviedb.Vote_Average_EdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  self.Vote_Average_Chk.Checked := true;
  self.Write_Btn.Enabled := true;
end;

procedure TThemoviedb.WriteXMLsideCar1Click(Sender: TObject);
var
  RegNGFS: TRegistry;
begin
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
      ShowMessage(FTranslateList[8]);
      Screen.Cursor := crDefault;
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
      Screen.Cursor := crDefault;
    end;
  end;
end;



procedure TThemoviedb.SearchEditChange(Sender: TObject);
begin
  self.search_byname.Checked := true;
  self.Search_Btn.Enabled := true;
  self.View_Btn.Enabled := false;
end;

procedure TThemoviedb.Search_BtnClick(Sender: TObject);
var

  rq: string;

begin

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;


  self.Write_Btn.Enabled := false;

  // Delete all
  ClearAll();


    if self.SearchEdit.Text = '' then
    begin
      if self.FMassScrap = false then
      begin
        ShowMessage(FTranslateList[7]);
        ShowJRiverId(FCurrentJRiverId);
        Screen.Cursor := crDefault;
        Exit;
      end
      else
      begin
        Form3.MassTag;
        Screen.Cursor := crDefault;
        Exit;
      end;
    end;

     if  self.TVdb_Rd.Checked = true then
    begin

     rq := StringReplace(self.SearchEdit.Text, ' ', '+',
      [rfReplaceAll, rfIgnoreCase]);

    rq := 'http://thetvdb.com/api/GetSeries.php?seriesname=' + rq + '&language='
      + FCurrentLangShort;

        try
    MovieThreadSearch1 := TThreadsearch.Create(Tcod.utf8 , rq, After_Thread_Search_Search_tvdb);
    // Le thread est désormais créé, et actif.

  except
    Screen.Cursor := crDefault;
    logger.error('Error: Error for this request');
  end;

    end
    else
    begin

    rq := DeleteAccents(self.SearchEdit.Text);

    rq := StringReplace(rq, ' ', '+', [rfReplaceAll, rfIgnoreCase]);
    rq := 'http://api.themoviedb.org/3/search/movie?api_key=' + FMovieAPIkey +
      '&query=' + rq + '&language=' + self.FCurrentLangShort;

        try
    MovieThreadSearch1 := TThreadsearch.Create(Tcod.ansi , rq, After_Thread_Search_Search_imdb);
    // Le thread est désormais créé, et actif.

  except
    Screen.Cursor := crDefault;
    logger.error('Error: Error for this request');
  end;

    end;


end;

procedure TThemoviedb.search_byimdbClick(Sender: TObject);
begin
  self.View_Btn.Enabled := true;
  self.Search_Btn.Enabled := false;
end;

procedure TThemoviedb.search_bynameClick(Sender: TObject);
begin
  self.View_Btn.Enabled := false;
  self.Search_Btn.Enabled := true;
end;

procedure TThemoviedb.After_Thread_Search_IMDB_ID;
var
  rq, id: string;
begin

  try
    FJSonReader := TlkJSON.ParseText(MovieThreadSearch1.TextToParse)
      as TlkJSONobject;
  except
    Screen.Cursor := crDefault;
    logger.error('Error: Parsing');
  end;


    try

      if (FJSonReader.Field['movie_results'] as TlkJSONList).Count = 1 then
      begin

        id := (((FJSonReader.Field['movie_results'] as TlkJSONList)
          .child[0] as TlkJSONobject).Field['id'].value);

        FTheMoviedb_ID := (((FJSonReader.Field['movie_results'] as TlkJSONList)
          .child[0] as TlkJSONobject).Field['id'].value);

        rq := 'https://api.themoviedb.org/3/movie/' + id + '?api_key=' + FMovieAPIkey
          + '&language=' + self.FCurrentLangShort;

        MovieThreadSearch1 := TThreadsearch.Create(Tcod.ansi  ,rq, After_Thread_Search_Basic_Info);

      end
      else
      begin
        logger.error('No results for this Imbd search !');

        if (FMassScrap = True) then
         begin
           form3.MassTag ;
         end;
        if (FMassScrap = False) then
         begin
        ShowMessage(FTranslateList[10]);
        ShowJRiverId(FCurrentJRiverId);
        Screen.Cursor := crDefault;
        Exit;
         end;

      end;

    except
      logger.error('No parse text retrieved ?');
      Screen.Cursor := crDefault;
    end;

  Screen.Cursor := crDefault;
  Application.ProcessMessages;

end;

procedure TThemoviedb.After_Thread_Search_Search_imdb;
var
  i: Integer;

begin

  try
    FJSonReader := TlkJSON.ParseText(MovieThreadSearch1.TextToParse)
      as TlkJSONobject;
  except
    Screen.Cursor := crDefault;
    logger.error('Error: Parsing');
  end;

  // Name search    : Fills the Grid with possible movies
  if self.search_byname.Checked = true then
  begin

    try

    except
      Screen.Cursor := crDefault;
    end;
    try
    if (FJSonReader.Field['results'] as TlkJSONList).Count < 1 then
    begin
      if self.FMassScrap = false then
      begin
        ShowMessage(FTranslateList[10]);
        ShowJRiverId(FCurrentJRiverId);
      end
      else
        Form3.MassTag;

      Screen.Cursor := crDefault;
      Exit;
    end
    else
    begin

      self.Movie_Search_Grid.RowCount :=
        (FJSonReader.Field['results'] as TlkJSONList).Count;

      try
        for i := 0 to (FJSonReader.Field['results'] as TlkJSONList).Count - 1 do
        begin
          self.Movie_Search_Grid.Cells[0, i] :=
            (((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['title'].value);
          self.Movie_Search_Grid.Cells[1, i] :=
            (((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['release_date'].value);
          self.Movie_Search_Grid.Cells[2, i] :=
            (((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['id'].value);

        end;
      except
        Screen.Cursor := crDefault;
        logger.error('Error: Could not write results in Movie_Search_Grid');
      end;

      if self.FMassScrap = true then
      begin
        self.Movie_Search_Grid.Row := 0;
        self.Movie_Search_Grid.Col := 1;
        self.Movie_Search_Grid.SetFocus;
        self.View_BtnClick(self);
      end;

    end;
    except

    end;
  end;

  Screen.Cursor := crDefault;
  Application.ProcessMessages;

end;



procedure TThemoviedb.Enterakey1Click(Sender: TObject);
var
  Msg: string;
  RegNGFS: TRegistry;

begin
  RegNGFS := TRegistry.Create;
  try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRScrap', false) then
    begin
      Msg := RegNGFS.Readstring('APIKey');

    end;
  finally
    RegNGFS.Free;
  end;

  FMovieAPIkey := InputBox(FTranslateList[1], FTranslateList[2], Msg);
  FMovieAPIkey := trim(FMovieAPIkey);

  RegNGFS := TRegistry.Create;
  try
    RegNGFS.RootKey := HKEY_CURRENT_USER;
    if RegNGFS.OpenKey('SOFTWARE\JRScrap', true) then
    begin
      RegNGFS.WriteString('APIKey', FMovieAPIkey);

    end;
  finally
    RegNGFS.Free;
  end;

end;

procedure TThemoviedb.Episode_Spin_WChange(Sender: TObject);
begin
self.View_Btn.Enabled := true ;
if  Fon_enter = true then
self.Write_Btn.Enabled := true ;
end;

procedure TThemoviedb.Episode_Spin_WEnter(Sender: TObject);
begin
  Fon_enter := true ;
end;

procedure TThemoviedb.Episode_Spin_WExit(Sender: TObject);
begin
  Fon_enter := false ;
end;

procedure TThemoviedb.Eraseallinfo1Click(Sender: TObject);
var
  crew_list: TStringList;
  i, j: Integer;
begin

  if self.Movie_Browser.Cells[7, self.Movie_Browser.Row] = 'YES' then
  begin
    ShowMessage(FTranslateList[18]);
    ShowJRiverId(FCurrentJRiverId);
    Exit;
  end;
  try
  FCurrentJRiverId := StrToint(self.Movie_Browser.Cells[0, self.Movie_Browser.Row]);
  except
  logger.error('Error: 2912' +self.Movie_Browser.Cells[0, self.Movie_Browser.Row]);
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
  FCurrentMovie.Set_('Description', '');
  FCurrentMovie.Set_('Lock External Tag Editor', 'NO');
  except
  logger.error('Error: 2965');
  end;
  try
  crew_list := TStringList.Create;
  for i := 0 to self.Crew_Grid.RowCount - 1 do
  begin
    crew_list.Add(self.Crew_Grid.Cells[0, i]);
  end;
  RemoveDuplicates(crew_list);
  except
  logger.error('Error: 2975');
  end;
  try
  for i := 0 to crew_list.Count - 1 do
  begin
    for j := 0 to self.Crew_Grid.RowCount - 1 do
    begin
      FCurrentMovie.Set_(crew_list[i], '');
    end;
  end;
  except
  logger.error('Error: 2986');
  end;
  crew_list := nil;

  try
    FCurrentMovie.SetImageFile('', IMAGEFILE_IN_DATABASE);

  except
    Screen.Cursor := crDefault;
  end;

  try
    FCurrentMovie.SetImageFile('', IMAGEFILE_DISPLAY);
  except
    Screen.Cursor := crDefault;

  end;

  try
    FCurrentMovie.SetImageFile('', IMAGEFILE_IN_FILE);
  except
    Screen.Cursor := crDefault;
  end;

  ClearAll;
  try
  self.Movie_Browser.Cells[10, self.Movie_Browser.Row] := '';
  self.Movie_Browser.Cells[11, self.Movie_Browser.Row] := '';
  self.Movie_Browser.Cells[7, self.Movie_Browser.Row] := 'NO';
  except
  logger.error('Error: 3016');
  end;

  ShowJRiverId(FCurrentJRiverId);

end;

procedure TThemoviedb.EraseHistory1Click(Sender: TObject);
begin
RemoveAllFilesFromFolder(self.FlogFolder, '*.*');
end;

procedure TThemoviedb.FormActivate(Sender: TObject);
begin
self.Subtitle_Btn.Enabled := false ;
After_Thread_Search_Basic_Info_Bool := false;
After_Thread_Search_Keywords_Bool :=  false;
After_Thread_Search_Credits_Bool :=  false;
After_Thread_Search_Image_Bool :=  false;

  if self.FHideForm = true then
    ShowWindow(Application.Handle, SW_HIDE);

  FCurrentLang := TranslateJRStyle(FCurrentLang, false);

  self.Movie_Search_Grid.ColWidths[0] := 515;
  self.Movie_Search_Grid.ColWidths[1] := 165;
  self.Movie_Search_Grid.ColWidths[2] := 0;

  self.Cast_Grid.ColWidths[0] := 330;
  self.Cast_Grid.ColWidths[1] := 330;
  self.Cast_Grid.ColWidths[2] := 0;

  self.Crew_Grid.ColWidths[0] := 330;
  self.Crew_Grid.ColWidths[1] := 330;
  self.Crew_Grid.ColWidths[2] := 0;
  self.Crew_Grid.ColWidths[3] := 0;

  self.Movie_Browser.ColWidths[0] := 0; // hide this Columns
  self.Movie_Browser.ColWidths[1] := 240; // Nom

  self.Movie_Browser.ColWidths[2] := 0;  // Serie Name
  self.Movie_Browser.ColWidths[3] := 0;  //Season
  self.Movie_Browser.ColWidths[4] := 0;  //Ep
  self.Movie_Browser.ColWidths[5] := 0;

  self.Movie_Browser.ColWidths[6] := 0; // Date Format Excel
  self.Movie_Browser.ColWidths[7] := 0; // YES/NO
  self.Movie_Browser.ColWidths[8] := 30; // Lock
  self.Movie_Browser.ColWidths[9] := 120; // Import Date
  self.Movie_Browser.ColWidths[10] := 70; // IMDb ID
  self.Movie_Browser.ColWidths[11] := 250; // Description
  self.Movie_Browser.ColWidths[12] := 1000; // FileName

  self.Movie_Browser.Cells[1, 0] := FTranslateList[23];
  self.Movie_Browser.Cells[2, 0] := 'Serie';
  self.Movie_Browser.Cells[3, 0] := 'S';
  self.Movie_Browser.Cells[4, 0] := 'E';
  self.Movie_Browser.Cells[8, 0] := FTranslateList[22];
  self.Movie_Browser.Cells[9, 0] := FTranslateList[19];
  self.Movie_Browser.Cells[10, 0] := 'Imdb ID';
  self.Movie_Browser.Cells[11, 0] := FTranslateList[21];
  self.Movie_Browser.Cells[12, 0] := FTranslateList[25];

  self.Star_Panel.Reset ;


  ShowJRiverId(FCurrentJRiverId);
  if self.FHideForm = true then
  begin
    self.scrapall1.Click;
  end;

end;

procedure TThemoviedb.MemoOverviewKeyPress(Sender: TObject; var Key: Char);
begin
  self.Overview_Chk.Checked := true;
  self.Write_Btn.Enabled := true;

end;

procedure TThemoviedb.Movie_BrowserClick(Sender: TObject);
begin
     if Movie_Browser.Col <> 8 then
    begin
    self.Movie_Search_Grid.RowCount := 0;
    self.Movie_Search_Grid.Cells[0, 0] := '';
    self.Movie_Search_Grid.Cells[1, 0] := '';
    self.Movie_Search_Grid.Cells[2, 0] := '';

    end;

   try

  if self.Movie_Browser.Cells[0, self.Movie_Browser.Row] <> '' then
  begin
  FCurrentJRiverId := StrToint(self.Movie_Browser.Cells[0, self.Movie_Browser.Row]);
  Themoviedb.FCurrentMovie := Themoviedb.FMoviesList.GetFile(FCurrentJRiverId);
   end;


  except
  logger.error('Error: 3045'+self.Movie_Browser.Cells[0, self.Movie_Browser.Row]);
  end;

    if Movie_Browser.Col = 8 then
    begin

  if (Movie_Browser.Cells[7, Movie_Browser.Row] = 'YES') then
  begin
    Movie_Browser.Cells[7, Movie_Browser.Row] := 'NO';
    FCurrentMovie.Set_('Lock External Tag Editor', 'NO');

  end
  else
  begin
    Movie_Browser.Cells[7, Movie_Browser.Row] := 'YES';
    FCurrentMovie.Set_('Lock External Tag Editor', 'YES');
  end;
  exit ;
    end;

  self.Write_Btn.Enabled := false;

  // Erase all
  ClearAll;

  ShowJRiverId(FCurrentJRiverId);



end;

procedure TThemoviedb.Movie_BrowserDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  s: string;
  aCanvas: TCanvas;
begin

  if (ACol <> 8) or (ARow = 0) then
    Exit;

  s := (Sender as TStringGrid).Cells[7, ARow];

  aCanvas := (Sender as TStringGrid).Canvas; // To avoid with statement
  // Clear current cell rect

  if (s <> 'YES') then
  begin
    aCanvas.FillRect(Rect);
  end
  else
  begin
    aCanvas.FillRect(Rect);
    aCanvas.StretchDraw(Rect, self.lock_img);
  end;

end;

procedure TThemoviedb.Movie_BrowserFixedCellClick(Sender: TObject;
  ACol, ARow: Integer);
begin
  // Prevents event Onclick to fire if the Browser is sorted
  self.Movie_Browser.Col := 0;
  self.Movie_Browser.Col := ARow;

  if ((ACol = 1) or (ACol = 9) or (ACol = 10) or (ACol = 8) or (ACol = 2)) then
  begin
    if ACol = 9 then
      ACol := 2;

     if ACol = 8 then
      ACol := 7;

    SortStringGrid(self.Movie_Browser, ACol);
  end;

end;

procedure TThemoviedb.Movie_BrowserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
  s: Char;

begin

  try
    for i := 0 to self.Movie_Browser.RowCount - 1 do
    begin
      s := (self.Movie_Browser.Cells[1, i])[1];

      if ((ansilowercase(s) = Char(Key)) or (ansiuppercase(s) = Char(Key))) then
      begin
        self.Movie_Browser.Row := i;
        break;
      end;
    end;
  except

  end;

end;

procedure TThemoviedb.Movie_BrowserMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Column, Row: Longint;
begin
  if Button = mbRight then
  begin
    Movie_Browser.MouseToCell(X, Y, Column, Row);
    if (Column > -1) and (Row > -1) then
    begin
      Movie_Browser.Col := Column;
      Movie_Browser.Row := Row;
    end;
  end;

end;

procedure TThemoviedb.Movie_BrowserMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Movie_Browser.Repaint;
end;



procedure TThemoviedb.Movie_Search_GridClick(Sender: TObject);
begin

 if  self.TVdb_Rd.Checked = true then
begin
   self.Imdb_search.Text :=   self.Movie_Search_Grid.Cells[2,self.Movie_Search_Grid.Row] ;
end;


  self.View_Btn.Enabled := true;
  self.Search_Btn.Enabled := false;

  FTheMoviedb_ID := self.Movie_Search_Grid.cells[2,self.Movie_Search_Grid.Row];
end;

procedure TThemoviedb.None1Click(Sender: TObject);
begin
  self.Title_Chk.Checked := false;
  self.Original_Title_Chk.Checked := false;
  self.release_date_Chk.Checked := false;
  self.API_id_chk.Checked := false;
  self.Original_Title_Chk.Checked := false;
  self.Vote_Average_Chk.Checked := false;
  self.Genres_Chk.Checked := false;
  self.Production_Comp_Chk.Checked := false;
  self.Cast_Chk.Checked := false;
  self.Crew_Chk.Checked := false;
  self.Keywords_Chk.Checked := false;
  self.Overview_Chk.Checked := false;
  self.Picture_Chk.Checked := false;
end;

procedure TThemoviedb.None2Click(Sender: TObject);
var
  i: Integer;
begin
  try
    for i := 1 to self.FMoviesCount do
    begin
      Movie_Browser.Cells[7, i] := 'NO';
      try
      Themoviedb.FCurrentMovie := Themoviedb.FMoviesList.GetFile(StrToint(Themoviedb.Movie_Browser.Cells[0, i]));
      except
       logger.error('Error: 3191'+Themoviedb.Movie_Browser.Cells[0, i]);
      end;
      FCurrentMovie.Set_('Lock External Tag Editor', 'NO');
    end;
  except

  end;

  Movie_Browser.Repaint;

end;

procedure TThemoviedb.OpenFolder1Click(Sender: TObject);
begin
 ShellExecute(Application.Handle, PChar('explore'), PChar(FlogFolder), nil, nil,
    SW_SHOWNORMAL);
end;



procedure TThemoviedb.Original_title_EdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  self.Original_Title_Chk.Checked := true;
  self.Write_Btn.Enabled := true;
end;

procedure TThemoviedb.Original_title_EdKeyPress(Sender: TObject; var Key: Char);
begin
 self.Original_Title_Chk.Checked := true;
  self.Write_Btn.Enabled := true;
end;



end.
