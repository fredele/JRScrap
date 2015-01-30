// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit TheMoviedB_Unit;

interface

uses
  uLKJSon, dialogs, Forms, strutils, sysUtils, Utils_Unit, Threadsearch_Unit,
  Types_Unit, TranslateJRStyle_Unit, jpeg, Vcl.StdCtrls, debug_Unit,
  Vcl.Grids, mnEdit, Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Classes,
  Winapi.Windows, Winapi.Messages, System.Variants, String_Unit,
  ThreadManager_Unit, Generic_Search_Unit, MediaCenter_TLB, Languagues_Unit,
  Vcl.Graphics, Vcl.themes;

type

  TTheMoviedB_Cl = class(TGeneric_Search)

  var

  public

    Thrd_Search, Thrd_IMDB_ID, Thrd_Basic_Se_Ep_Info, Thrd_ext_IDs,
      Thrd_Basic_Info, Thrd_Credits, Thrd_Keywords: TThreadsearch;
    Thrd_Image: TThreadsearch_Image;
    FManager: TThreadManager;
    FMovie: IMJFileAutomation;
    constructor Create(id: integer; CurrentLangShort: string); overload;
    constructor Create(id: integer; se: integer; ep: integer;
      CurrentLangShort: string); overload;
    procedure TheMoviedB_IMDB_Search_Proc;
    procedure TheMoviedB_TVDB_Search_Proc;

    procedure TheMoviedB_Movie_ID_Search_Proc;
    procedure TheMoviedB_Serie_Se_Ep_ID_Search_Proc;

    procedure After_Thread_Search_Serie_Se_Ep_ext_IDs(str: string);
    procedure After_Thread_Search_IMDB_ID(str: string);
    procedure After_Thread_Search_TVDB_ID(str: string);

    procedure Searchfiles(title: string); override;

    procedure After_Thread_Search_Movie_Search(str: string);
    procedure After_Thread_Search_Serie_Search(str: string);

    procedure After_Thread_Search_Movie_Basic_Info(str: string);
    procedure After_Thread_Search_Serie_Se_Ep_Basic_Info(str: string);
    procedure After_Thread_Search_Serie_Basic_Info(str: string);

    procedure After_Thread_Search_Movie_Credits(str: string);
    procedure After_Thread_Search_Serie_Se_Ep_Credits(str: string);
    procedure After_Thread_Search_Movie_Keywords(str: string);
    procedure After_Thread_Search_Movie_Videos(str: string);
    procedure After_Thread_Movie_Image(img: TJPEGImage);
    procedure After_Thread_Serie_Se_Ep_Image(img: TJPEGImage);

    Procedure After_Movie_Manager;
    Procedure After_Serie_Se_Ep_Manager;

    procedure Auto_search; override;
    procedure Display_Search; override;
    procedure SaveTags; override;
  end;

const
  TheMoviedB_APIkey = '3b608fc11821e92cd2459320206a9d9b';

implementation

uses

  JRScrap_Unit,
  Search_Unit,
  Freebase_Unit,
  Traileraddict_Unit,
  MassScrap_Unit,
  JRiverXML_Unit;

var
  md: TMedia;

procedure TTheMoviedB_Cl.SaveTags;
var
  NpWnd: HWnd;
  FJRiverXml: TJRiverXml;
  day: TDateTime;
  s: string;
  i, j: integer;
  crew_list: TStringList;

begin

  if lock = true then
    Exit;

  JRScrap_Frm.Movie_Browser.cells[5, JRScrap_Frm.Movie_Browser.row] := name;

  if length(Overview) <> 0 then
    JRScrap_Frm.Movie_Browser.cells[11, JRScrap_Frm.Movie_Browser.row] :=
      Leftstr(Overview, 40) + '...'
  else
    JRScrap_Frm.Movie_Browser.cells[11, JRScrap_Frm.Movie_Browser.row] := '';

  JRScrap_Frm.Movie_Browser.cells[12, JRScrap_Frm.Movie_Browser.row] :=
    filename;
  JRScrap_Frm.Movie_Browser.cells[10, JRScrap_Frm.Movie_Browser.row] := imdb_id;

  s := ExtractFilePath(filename) + ExtractFileNameWithoutExt(filename) + '.jpg';
  if JRScrap_Frm.MassScrap_Frm.Picture_Rec_Chk.Checked = true then
  begin
    // Save image in directory
    try
      image.SaveToFile(s);
    except
      screen.cursor := crdefault;
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

  if not assigned(FCurrentMovie) then
  begin
    ShowMessage(Translate_String_JRStyle('No Movie selected !',
      JRScrap_Frm.FCurrentLang_GUI));
    screen.cursor := crdefault;
    Exit;
  end;

  try

    FJRiverXml := TJRiverXml.Create(filename);
  except
    screen.cursor := crdefault;
  end;

  FMovie.Set_('Name', Name);
  FJRiverXml.SetField('Name', Name);

  FMovie.Set_('original title', Original_name);
  FJRiverXml.SetField('original title', Original_name);

  day := StrToDate(release_date);
  s := '';

  FMovie.Set_('Date', Floattostr(day));
  FJRiverXml.SetField('Date', Floattostr(day));

  // TODO : continue this !
  for i := 0 to length(Persons) - 1 do
  begin
    s := s + ';' + Persons[i].Actor_Name;
  end;

  s := Copy(s, 2, length(s) - 1);
  FMovie.Set_('Actors', s);
  FJRiverXml.SetField('Actors', s);
  s := '';

  for i := 0 to length(Persons) - 1 do
  begin
    s := s + ';' + Persons[i].Character;
  end;
  s := Copy(s, 2, length(s) - 1);
  FMovie.Set_('Character', s);
  FJRiverXml.SetField('Character', s);
  s := '';

  for i := 0 to length(Persons) - 1 - 1 do
  begin
    if (Persons[i].Actor_Name <> '') and (Persons[i].Character <> '') then
    begin
      s := s + ';' + Persons[i].Actor_Name + ', ' + Persons[i].Character;
    end;
  end;
  s := Copy(s, 2, length(s) - 1);
  FMovie.Set_('ActorAsCharacter', s);
  FJRiverXml.SetField('ActorAsCharacter', s);
  s := '';

  FMovie.Set_('IMDb ID', imdb_id);
  FJRiverXml.SetField('IMDb ID', imdb_id);

  FMovie.Set_('TMDB ID', Tmdb_id);
  FJRiverXml.SetField('TMDB ID', Tmdb_id);

  FMovie.Set_('TheTVDB Series ID', Tvdb_id);
  FJRiverXml.SetField('TheTVDB Series ID', Tvdb_id);

  FMovie.Set_('Budget', budget);
  FJRiverXml.SetField('Budget', budget);

  FMovie.Set_('Gross Revenue', revenue);
  FJRiverXml.SetField('Gross Revenue', revenue);

  FMovie.Set_('Critic Rating', Vote_Average);
  FJRiverXml.SetField('Critic Rating', Vote_Average);

  FMovie.Set_('Trailer', trailer);
  FJRiverXml.SetField('Trailer', trailer);

  FMovie.Set_('Description', Overview);
  FJRiverXml.SetField('Description', Overview);

  s := serialize(Keywords);
  FMovie.Set_('Keywords', s);
  FJRiverXml.SetField('Keywords', s);
  s := emptystr;

  s := serialize(Country);
  s := replaceStr(s, ' ', '');
  FMovie.Set_('Country', s);
  FJRiverXml.SetField('Country', s);
  s := emptystr;

  s := serialize(Genre);
  FMovie.Set_('Genre', s);
  FJRiverXml.SetField('Genre', s);
  s := emptystr;

  s := serialize(Production_Companies);
  FMovie.Set_('Production Company', s);
  FJRiverXml.SetField('Production Company', s);
  s := emptystr;

  s := serialize(Director);
  FMovie.Set_('Director', s);
  FJRiverXml.SetField('Director', s);
  s := emptystr;

  s := serialize(Executive_Producer);
  FMovie.Set_('Executive Producer', s);
  FJRiverXml.SetField('Executive Producer', s);
  s := emptystr;

  s := serialize(Cinematographer);
  FMovie.Set_('Cinematographer', s);
  FJRiverXml.SetField('Cinematographer', s);
  s := emptystr;

  s := serialize(Casting);
  FMovie.Set_('Casting', s);
  FJRiverXml.SetField('Casting', s);
  s := emptystr;

  s := serialize(Screenwriter);
  FMovie.Set_('Screenwriter', s);
  FJRiverXml.SetField('Screenwriter', s);
  s := emptystr;

  s := serialize(Music_by);
  FMovie.Set_('Music by', s);
  FJRiverXml.SetField('Music by', s);
  s := emptystr;

  s := serialize(Novel);
  FMovie.Set_('Novel', s);
  FJRiverXml.SetField('Novel', s);
  s := emptystr;

  s := serialize(Production_Design);
  FMovie.Set_('Production Design', s);
  FJRiverXml.SetField('Production Design', s);
  s := emptystr;

  if JRScrap_Frm.WriteXMLsideCar1.Checked = true then
  begin
    FJRiverXml.Save_Close;
  end;
end;

procedure TTheMoviedB_Cl.Auto_search;
begin
  inherited;
  imdb_id := FMoviesList.GetFile(FMediaList_Id).Get('IMDB ID', true);
  Tmdb_id := FMoviesList.GetFile(FMediaList_Id).Get('TMDB ID', true);

  if self.lock = false then
  begin

    // 0 0 0

    if ((self.Tmdb_id = emptystr) and (self.imdb_id = emptystr) and
      (Name = emptystr)) then
    begin
      if JRScrap_Frm.FMassScrap = false then
      begin
        ShowMessage(Translate_String_JRStyle('Nothing to search !',
          JRScrap_Frm.FCurrentLang_GUI));
        screen.cursor := crdefault;
        Exit;

      end
      else
      begin
        if JRScrap_Frm.FMassScrap = true then
          JRScrap_Frm.WaitAllServices;
      end;
    end;

    // 1 0 0
    if ((self.Tmdb_id <> emptystr) and (self.imdb_id = emptystr) and
      (Name = emptystr)) then
    begin
      TheMoviedB_Ins.Tmdb_id := self.Tmdb_id;
      TheMoviedB_Ins.TheMoviedB_Movie_ID_Search_Proc;
    end;

    // 0 1 0
    if ((self.Tmdb_id = emptystr) and (self.imdb_id <> emptystr) and
      (Name = emptystr)) then
    begin
      TheMoviedB_Ins.imdb_id := self.imdb_id;
      TheMoviedB_Ins.TheMoviedB_IMDB_Search_Proc;
    end;

    /// *******

    // 1 1 0
    if ((self.Tmdb_id <> emptystr) and (self.imdb_id <> emptystr) and
      (Name = emptystr)) then
    begin
      TheMoviedB_Ins.Tmdb_id := self.Tmdb_id;
      TheMoviedB_Ins.TheMoviedB_Movie_ID_Search_Proc;
    end;

    // 0 1 1
    if ((self.Tmdb_id = emptystr) and (self.imdb_id <> emptystr) and
      (Name <> emptystr)) then
    begin
      TheMoviedB_Ins.imdb_id := self.imdb_id;
      TheMoviedB_Ins.TheMoviedB_IMDB_Search_Proc;
    end;

    // 1 0 1
    if ((self.Tmdb_id <> emptystr) and (self.imdb_id = emptystr) and
      (Name <> emptystr)) then
    begin
      TheMoviedB_Ins.Tmdb_id := self.Tmdb_id;
      TheMoviedB_Ins.TheMoviedB_Movie_ID_Search_Proc;
    end;

    // 1 1 1
    if ((self.Tmdb_id <> emptystr) and (self.imdb_id <> emptystr) and
      (Name <> emptystr)) then
    begin
      TheMoviedB_Ins.Tmdb_id := self.Tmdb_id;
      TheMoviedB_Ins.TheMoviedB_Movie_ID_Search_Proc;
    end;

    // *********
    // 0 0 1
    if ((self.Tmdb_id = emptystr) and (self.imdb_id = emptystr) and
      (Name <> emptystr)) then
    begin
      Searchfiles(self.name);

    end;
  end
  else
  begin
    // if Lock = true
    // After_Manager;
  end;
end;

procedure TTheMoviedB_Cl.Display_Search;
begin
  inherited;

  screen.cursor := crdefault;
  JRScrap_Frm.Write_Btn.Enabled := true;
end;

Procedure TTheMoviedB_Cl.After_Serie_Se_Ep_Manager;
begin
  self.Display_Search;
  debug('After Manager');
  screen.cursor := crdefault;
  JRScrap_Frm.FSearching := false;
  application.processmessages;

  if JRScrap_Frm.FMassScrap = true then
  begin
    self.SaveTags;
  end;
  JRScrap_Frm.WaitAllServices;

end;

Procedure TTheMoviedB_Cl.After_Movie_Manager;
begin

  self.Display_Search;
  debug('After Manager');
  screen.cursor := crdefault;
  JRScrap_Frm.FSearching := false;
  application.processmessages;



  // Launche after TheMoviedB if selected ...

  // Freebase

  if JRScrap_Frm.freebase_Btn.down = true then
  begin
    TFreebase_Ins := TFreebase_Cl.Create;
    TFreebase_Ins.Freebase_getID();
  end;

  // Traileraddict

  if JRScrap_Frm.Traileraddict_Search_Btn.down = true then
  begin
    TTrailerAddict_Ins := TTrailerAddict_Cl.Create;
    TTrailerAddict_Ins.Search_Name;

  end;

  if JRScrap_Frm.FMassScrap = true then
  begin
    self.SaveTags;
  end;
  JRScrap_Frm.WaitAllServices;

end;

constructor TTheMoviedB_Cl.Create(id: integer; se: integer; ep: integer;
  CurrentLangShort: string);
begin
  inherited Create(id, CurrentLangShort);
  episode := ep;
  season := se;

  FMovie := FCurrentMovie;

  if FMovie.Get('Lock External Tag Editor', true) = 'YES' then
  begin
    if JRScrap_Frm.FMassScrap = true then
      JRScrap_Frm.WaitAllServices;

    // Freebase
    if JRScrap_Frm.freebase_Btn.down = true then
    begin
      JRScrap_Frm.WaitAllServices;
    end;

    // Traileraddict
    if JRScrap_Frm.Traileraddict_Search_Btn.down = true then
    begin
      JRScrap_Frm.WaitAllServices;
    end;

  end;
end;

constructor TTheMoviedB_Cl.Create(id: integer; CurrentLangShort: string);
begin
  inherited Create(id, CurrentLangShort);

  FMovie := FCurrentMovie;

  if FMovie.Get('Lock External Tag Editor', true) = 'YES' then
  begin
    if JRScrap_Frm.FMassScrap = true then
      JRScrap_Frm.WaitAllServices;

    // Freebase
    if JRScrap_Frm.freebase_Btn.down = true then
    begin
      JRScrap_Frm.WaitAllServices;
    end;

    // Traileraddict
    if JRScrap_Frm.Traileraddict_Search_Btn.down = true then
    begin
      JRScrap_Frm.WaitAllServices;
    end;

  end;
end;

procedure TTheMoviedB_Cl.TheMoviedB_TVDB_Search_Proc;
var
  rq: string;

begin

  rq := 'http://api.themoviedb.org/3/find/' + Tvdb_id + '?api_key=' +
    TheMoviedB_APIkey + '&external_source=tvdb_id' + '&language=' + FLang;

  try

    self.Thrd_IMDB_ID := TThreadsearch.Create(nil, Tcod.ansi, rq,
      self.After_Thread_Search_TVDB_ID);
    // Le thread est désormais créé, et actif.

  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Error for this request');
  end;

end;

procedure TTheMoviedB_Cl.TheMoviedB_IMDB_Search_Proc;
var
  rq: string;

begin

  imdb_id := StringReplace(imdb_id, 'TT', 'tt', [rfReplaceAll, rfIgnoreCase]);

  rq := 'http://api.themoviedb.org/3/find/' + imdb_id + '?api_key=' +
    TheMoviedB_APIkey + '&external_source=imdb_id' + '&language=' + FLang;

  try

    self.Thrd_IMDB_ID := TThreadsearch.Create(nil, Tcod.ansi, rq,
      self.After_Thread_Search_IMDB_ID);
    // Le thread est désormais créé, et actif.

  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Error for this request');
  end;
end;

procedure TTheMoviedB_Cl.TheMoviedB_Serie_Se_Ep_ID_Search_Proc;
var
  rq: string;
begin
  if ((self.season <> -1) and (self.episode <> -1)) then
  begin

    if FLang <> 'en' then
    begin
      rq := 'https://api.themoviedb.org/3/tv/' + Tmdb_id + '/season/' +
        inttostr(season) + '/episode/' + inttostr(episode) + '?api_key=' +
        TheMoviedB_APIkey + '&language=' + FLang;
    end
    else
    begin
      rq := 'https://api.themoviedb.org/3/tv/' + Tmdb_id + '/season/' +
        inttostr(season) + '/episode/' + inttostr(episode) + '?api_key=' +
        TheMoviedB_APIkey + '&language=';
    end;

    self.Thrd_Basic_Info := TThreadsearch.Create(nil, Tcod.ansi, rq,
      After_Thread_Search_Serie_Se_Ep_Basic_Info);

    rq := 'https://api.themoviedb.org/3/tv/' + Tmdb_id +
      '/external_ids??api_key=' + TheMoviedB_APIkey + '&language=' + FLang;
    // self.Thrd_ext_IDs := TThreadsearch.Create(nil, Tcod.ansi, rq,   After_Thread_Search_Serie_Se_Ep_ext_IDs);
    // https://api.themoviedb.org/3/tv/873/season/1/episode/3/external_ids?api_key=3b608fc11821e92cd2459320206a9d9b
  end
  else
  begin
    if JRScrap_Frm.FMassScrap = false then

      ShowMessage(Translate_String_JRStyle('Set episode and season number !',
        JRScrap_Frm.FCurrentLang_GUI));
  end;
end;

procedure TTheMoviedB_Cl.TheMoviedB_Movie_ID_Search_Proc;
var
  rq: string;
begin

  if FLang <> 'en' then
  begin
    rq := 'https://api.themoviedb.org/3/movie/' + self.Tmdb_id + '?api_key=' +
      TheMoviedB_APIkey + '&language=' + FLang;
  end
  else
  begin
    rq := 'https://api.themoviedb.org/3/movie/' + self.Tmdb_id + '?api_key=' +
      TheMoviedB_APIkey;
  end;

  self.Thrd_Basic_Info := TThreadsearch.Create(nil, Tcod.ansi, rq,
    After_Thread_Search_Movie_Basic_Info);
end;

procedure TTheMoviedB_Cl.After_Thread_Search_Serie_Basic_Info(str: string);
var
  FJSonReader: TlkJSONobject;
  s: string;
  i: integer;
begin
  debug(str);
  if str <> '' then
  begin
    try
      FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error('Error: Parsing');
    end;

    try
      self.serie_name := FJSonReader.getString('name');
    except
    end;

    if (FJSonReader.Field['origin_country'] as TlkJSONList).Count <> 0 then
    begin

      for i := 0 to (FJSonReader.Field['origin_country'] as TlkJSONList)
        .Count - 1 do
      begin
        try
          Country.Add(trim((FJSonReader.Field['origin_country'] as TlkJSONList)
            .child[i].value));
        except
        end;
      end;
    end;

  end;
end;

procedure TTheMoviedB_Cl.After_Thread_Search_Serie_Se_Ep_Basic_Info
  (str: string);
var
  FJSonReader: TlkJSONobject;
  rq, posterpath, s: string;
  job, db: string;
  i: integer;
begin

  screen.cursor := crhourglass;

  if str <> '' then
  begin
    try
      FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error('Error: Parsing');
    end;

    posterpath := emptystr;
    if FJSonReader.getString('still_path') <> '' then
    begin

      if FJSonReader.getString('still_path') <> emptystr then
        posterpath := 'http://image.tmdb.org/t/p/w500' +
          FJSonReader.getString('still_path');

    end;

    try
      self.name := FJSonReader.getString('name');
    except
    end;

    try
      self.Overview := FJSonReader.getString('overview');
    except
    end;

    try
      self.episode := FJSonReader.getint('episode_number');
    except
    end;

    try
      self.season := FJSonReader.getint('season_number');
    except
    end;

    try
      release_date := formatdateToCurrentRegion
        (FJSonReader.getString(('air_date')));
    except
    end;

    {
      try
      if (FJSonReader.Field['crew'] as TlkJSONList).Count <> 0 then
      begin

      for i := 0 to (FJSonReader.Field['crew'] as TlkJSONList).Count - 1 do
      begin
      job := ((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['job'].value;
      if job = 'Executive Producer' then
      Executive_Producer.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else if job = 'Casting' then
      Casting.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else if job = 'Novel' then
      Novel.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else if job = 'Production Design' then
      Production_Design.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else if job = 'Original Music Composer' then
      Music_by.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else if job = 'Director of Photography' then
      Cinematographer.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else if job = 'Screenplay' then
      Screenwriter.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else if job = 'Director' then
      Director.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['name'].value))
      else
      begin
      db := ((FJSonReader.Field['crew'] as TlkJSONList)
      .child[i] as TlkJSONobject).Field['job'].value;
      debug(db);
      end;

      end;
      end;
      except
      screen.cursor := crdefault;
      end; }

    FManager := TThreadManager.Create(self, After_Serie_Se_Ep_Manager);

    if posterpath <> emptystr then
    begin
      if assigned(image) then
        FreeAndNil(image);
      image := TJPEGImage.Create;

      rq := posterpath;
      FManager.Addthread(rq, self.After_Thread_Serie_Se_Ep_Image);
    end;

    rq := 'https://api.themoviedb.org/3/tv/' + self.Tmdb_id + '?api_key=' +
      TheMoviedB_APIkey + '&language=' + FLang;
    FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Serie_Basic_Info);

    rq := 'https://api.themoviedb.org/3/tv/' + Tmdb_id + '/season/' +
      inttostr(season) + '/episode/' + inttostr(episode) + '/credits?api_key=' +
      TheMoviedB_APIkey + '&language=' + FLang;

    FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Serie_Se_Ep_Credits);

    rq := 'https://api.themoviedb.org/3/tv/' + Tmdb_id +
      '/external_ids?api_key=' + TheMoviedB_APIkey + '&language=' + FLang;

    FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Serie_Se_Ep_ext_IDs);

    FManager.Resume;

  end
  else
  begin
    if JRScrap_Frm.FMassScrap = false then
    begin
      ShowMessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_Frm.FCurrentLang_GUI));
      JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);
    end
  end;

  screen.cursor := crdefault;
end;

procedure TTheMoviedB_Cl.After_Thread_Search_Movie_Basic_Info(str: string);
var
  FJSonReader: TlkJSONobject;
  rq, posterpath, s: string;
  i: integer;

begin

  posterpath := emptystr;

  screen.cursor := crhourglass;
  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  try

    if FJSonReader.getString('poster_path') <> '' then
    begin

      if FJSonReader.getString('poster_path') <> emptystr then
        posterpath := 'http://image.tmdb.org/t/p/w500' +
          FJSonReader.getString('poster_path');

    end;
  except
    screen.cursor := crdefault;

  end;

  try
    if FJSonReader.getint('budget') <> 0 then
      self.budget := inttostr((FJSonReader.getint('budget')));

    if FJSonReader.getint('revenue') <> 0 then
      self.revenue := inttostr((FJSonReader.getint('revenue')));
  except
  end;

  try
    self.imdb_id := (FJSonReader.getString('imdb_id'));
  except
  end;

  try
    self.Tmdb_id := inttostr((FJSonReader.getint('id')));
  except
  end;

  try
    self.Original_name := FJSonReader.getString('original_title');
  except
  end;

  try
    self.name := FJSonReader.getString('title');
  except
  end;

  try
    self.Vote_Average := Floattostr(FJSonReader.getDouble('vote_average'));
  except
  end;

  try
    self.release_date := formatdateToCurrentRegion
      (FJSonReader.getString(('release_date')));
  except
  end;

  try
    self.Overview := FJSonReader.getString('overview');
  except
  end;

  if (FJSonReader.Field['production_countries'] as TlkJSONList).Count <> 0 then
  begin

    for i := 0 to (FJSonReader.Field['production_countries'] as TlkJSONList)
      .Count - 1 do
    begin
      try
        self.Country.Add
          (trim((((FJSonReader.Field['production_countries'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['iso_3166_1'].value)));
      except
      end;
    end;
  end;

  if (FJSonReader.Field['genres'] as TlkJSONList).Count <> 0 then
  begin

    for i := 0 to (FJSonReader.Field['genres'] as TlkJSONList).Count - 1 do
    begin
      try
        self.Genre.Add
          (trim((((FJSonReader.Field['genres'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['name'].value)));
      except
      end;
    end;
  end;

  if (FJSonReader.Field['production_companies'] as TlkJSONList).Count <> 0 then
  begin
    try
      for i := 0 to (FJSonReader.Field['production_companies'] as TlkJSONList)
        .Count - 1 do
      begin
        self.Production_Companies.Add
          (trim((((FJSonReader.Field['production_companies'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['name'].value)));
      end;
    except
    end;
  end;

  FManager := TThreadManager.Create(self, After_Movie_Manager);

  rq := 'https://api.themoviedb.org/3/movie/' + Tmdb_id + '/credits?api_key=' +
    TheMoviedB_APIkey + '&language=' + FLang;

  FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Movie_Credits);

  rq := 'https://api.themoviedb.org/3/movie/' + Tmdb_id + '/keywords?api_key=' +
    TheMoviedB_APIkey + '&language=' + FLang;

  FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Movie_Keywords);

  rq := 'https://api.themoviedb.org/3/movie/' + Tmdb_id + '/videos?api_key=' +
    TheMoviedB_APIkey;

  FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Movie_Videos);

  if posterpath <> emptystr then
  begin
    if assigned(image) then
      FreeAndNil(image);
    image := TJPEGImage.Create;

    rq := posterpath;
    FManager.Addthread(rq, self.After_Thread_Movie_Image);
  end;

  FManager.Resume;

  application.processmessages;
  screen.cursor := crdefault;
end;

procedure TTheMoviedB_Cl.After_Thread_Search_TVDB_ID(str: string);
var
  rq, id: string;
  FJSonReader: TlkJSONobject;
  i: integer;
begin

  try

    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  if (FJSonReader.Field['tv_results'] as TlkJSONList).Count = 1 then
  begin

    try

      if (((FJSonReader.Field['tv_results'] as TlkJSONList)
        .child[0] as TlkJSONobject).Field['origin_country'] as TlkJSONList)
        .Count <> 0 then
      begin

        for i := 0 to (((FJSonReader.Field['tv_results'] as TlkJSONList)
          .child[0] as TlkJSONobject).Field['origin_country'] as TlkJSONList)
          .Count - 1 do
        begin
          try
            // Country.Add(
            // (((FJSonReader.Field['tv_results'] as TlkJSONList).child[0] as TlkJSONobject).Field['origin_country'] as TlkJSONList).child[i].value
            // );
          except
          end;
        end;
      end;

    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error('Error: Parsing');
    end;

    Tmdb_id := (((FJSonReader.Field['tv_results'] as TlkJSONList)
      .child[0] as TlkJSONobject).Field['id'].value);

    if FLang <> 'eng' then
    begin
      rq := 'https://api.themoviedb.org/3/tv/' + Tmdb_id + '/season/' +
        inttostr(season) + '/episode/' + inttostr(episode) + '?api_key=' +
        TheMoviedB_APIkey + '&language=' + FLang;
    end
    else
    begin
      rq := 'https://api.themoviedb.org/3/tv/' + Tmdb_id + '/season/' +
        inttostr(season) + '/episode/' + inttostr(episode) + '?api_key=' +
        TheMoviedB_APIkey + '&language=';
    end;

    Thrd_Basic_Se_Ep_Info := TThreadsearch.Create(nil, Tcod.ansi, rq,
      After_Thread_Search_Serie_Se_Ep_Basic_Info);

  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_Serie_Se_Ep_ext_IDs(str: string);
var
  rq, id: string;
  FJSonReader: TlkJSONobject;
begin

  try
    if str = '' then
      Exit;

    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  try

    self.Tvdb_id := inttostr(FJSonReader.getint('tvdb_id'));
  except
  end;

  try
    if FJSonReader.getString('imdb_id') <> '' then
    begin
      self.imdb_id := FJSonReader.getString('imdb_id');
    end;
  except
  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_IMDB_ID(str: string);
var
  rq, id: string;
  FJSonReader: TlkJSONobject;
begin

  try

    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  if (FJSonReader.Field['movie_results'] as TlkJSONList).Count = 1 then
  begin

    Tmdb_id := (((FJSonReader.Field['movie_results'] as TlkJSONList)
      .child[0] as TlkJSONobject).Field['id'].value);

    rq := 'https://api.themoviedb.org/3/movie/' + Tmdb_id + '?api_key=' +
      TheMoviedB_APIkey + '&language=' + FLang;

    Thrd_Basic_Info := TThreadsearch.Create(nil, Tcod.ansi, rq,
      After_Thread_Search_Movie_Basic_Info);

  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_Serie_Se_Ep_Credits(str: string);
var
  rq: string;
  i: integer;
  FJSonReader: TlkJSONobject;
  pe: TPerson;
  job, name, db: string;

begin
  screen.cursor := crhourglass;
  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  if (FJSonReader.Field['cast'] as TlkJSONList).Count <> 0 then
  begin

    for i := 0 to (FJSonReader.Field['cast'] as TlkJSONList).Count - 1 do
    begin

      pe.Actor_Name :=
        (((FJSonReader.Field['cast'] as TlkJSONList).child[i] as TlkJSONobject)
        .Field['name'].value);

      pe.Character :=
        (((FJSonReader.Field['cast'] as TlkJSONList).child[i] as TlkJSONobject)
        .Field['character'].value);

      pe.id := (((FJSonReader.Field['cast'] as TlkJSONList)
        .child[i] as TlkJSONobject).Field['id'].value);
      self.AddPerson(pe);
    end;

  end;

  try
    if (FJSonReader.Field['crew'] as TlkJSONList).Count <> 0 then
    begin

      for i := 0 to (FJSonReader.Field['crew'] as TlkJSONList).Count - 1 do
      begin
        job := ((FJSonReader.Field['crew'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['job'].value;
        if job = 'Executive Producer' then
          Executive_Producer.Add
            (trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else if job = 'Casting' then
          Casting.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else if job = 'Novel' then
          Novel.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else if job = 'Production Design' then
          Production_Design.Add
            (trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else if job = 'Original Music Composer' then
          Music_by.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else if job = 'Director of Photography' then
          Cinematographer.Add
            (trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else if job = 'Screenplay' then
          Screenwriter.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else if job = 'Director' then
          Director.Add(trim(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value))
        else
        begin
          db := ((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['job'].value;
          debug(db);
        end;

      end;
    end;
  except
    screen.cursor := crdefault;
  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_Movie_Credits(str: string);
var
  rq: string;
  i: integer;
  FJSonReader: TlkJSONobject;
  pe: TPerson;
  job, name, db: string;

begin
  screen.cursor := crhourglass;
  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  if (FJSonReader.Field['cast'] as TlkJSONList).Count <> 0 then
  begin

    for i := 0 to (FJSonReader.Field['cast'] as TlkJSONList).Count - 1 do
    begin

      pe.Actor_Name :=
        (((FJSonReader.Field['cast'] as TlkJSONList).child[i] as TlkJSONobject)
        .Field['name'].value);

      pe.Character :=
        (((FJSonReader.Field['cast'] as TlkJSONList).child[i] as TlkJSONobject)
        .Field['character'].value);

      pe.id := (((FJSonReader.Field['cast'] as TlkJSONList)
        .child[i] as TlkJSONobject).Field['id'].value);
      self.AddPerson(pe);
    end;

  end;

  try
    if (FJSonReader.Field['crew'] as TlkJSONList).Count <> 0 then
    begin

      for i := 0 to (FJSonReader.Field['crew'] as TlkJSONList).Count - 1 do
      begin
        job := ((FJSonReader.Field['crew'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['job'].value;
        if job = 'Executive Producer' then
          Executive_Producer.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else if job = 'Casting' then
          Casting.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else if job = 'Novel' then
          Novel.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else if job = 'Production Design' then
          Production_Design.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else if job = 'Original Music Composer' then
          Music_by.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else if job = 'Director of Photography' then
          Cinematographer.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else if job = 'Screenplay' then
          Screenwriter.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else if job = 'Director' then
          Director.Add(((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value)
        else
        begin
          db := ((FJSonReader.Field['crew'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['job'].value;
          debug(db);
        end;

      end;
    end;
  except
    screen.cursor := crdefault;
  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_Movie_Videos(str: string);
var
  i: integer;
  FJSonReader: TlkJSONobject;
  tp, site: string;
begin
  screen.cursor := crhourglass;
  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  if (FJSonReader.Field['results'] as TlkJSONList).Count <> 0 then
  begin
    for i := 0 to (FJSonReader.Field['results'] as TlkJSONList).Count - 1 do
    begin
      try
        tp := ((FJSonReader.Field['results'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['type'].value;
        if tp = 'Trailer' then
          site := ((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['site'].value;
        if site = 'YouTube' then
        begin
          self.trailer := 'https://www.youtube.com/watch?v=' +
            ((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['key'].value;
          break;
        end;
      except
      end;

    end;

  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_Movie_Keywords(str: string);
var
  i: integer;
  FJSonReader: TlkJSONobject;

begin
  screen.cursor := crhourglass;

  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Parsing');
  end;

  if (FJSonReader.Field['keywords'] as TlkJSONList).Count <> 0 then
  begin

    for i := 0 to (FJSonReader.Field['keywords'] as TlkJSONList).Count - 1 do
    begin
      Keywords.Add(trim((((FJSonReader.Field['keywords'] as TlkJSONList)
        .child[i] as TlkJSONobject).Field['name'].value)));
    end;
  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Serie_Se_Ep_Image(img: TJPEGImage);
begin
  try
    image.Assign(img);
  except
  end;
end;

procedure TTheMoviedB_Cl.After_Thread_Movie_Image(img: TJPEGImage);
begin
  try
    image.Assign(img);
  except

  end;
end;

procedure TTheMoviedB_Cl.Searchfiles(title: string);
var
  rq: string;

begin

  if JRScrap_Frm.Movie_Btn.down = true then
  begin
    rq := DeleteAccents(title);
    rq := StringReplace(rq, ' ', '+', [rfReplaceAll, rfIgnoreCase]);
    rq := 'http://api.themoviedb.org/3/search/movie?api_key=' +
      TheMoviedB_APIkey + '&query=' + rq + '&language=' + FLang;

    try

      Thrd_Search := TThreadsearch.Create(nil, Tcod.ansi, rq,
        After_Thread_Search_Movie_Search);
      // Le thread est désormais créé, et actif.

    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error('Error: Error for this request');
    end;

  end;

  if JRScrap_Frm.Serie_Btn.down = true then
  begin
    rq := DeleteAccents(title);
    rq := StringReplace(rq, ' ', '+', [rfReplaceAll, rfIgnoreCase]);
    rq := 'http://api.themoviedb.org/3/search/tv?api_key=' + TheMoviedB_APIkey +
      '&query=' + rq + '&language=' + FLang;

    try
      Thrd_Search := TThreadsearch.Create(nil, Tcod.ansi, rq,
        After_Thread_Search_Serie_Search);
      // Le thread est désormais créé, et actif.

    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error('Error: Error for this request');
    end;

  end;

  screen.cursor := crdefault;
  application.processmessages;
end;

procedure TTheMoviedB_Cl.After_Thread_Search_Serie_Search(str: string);
var
  i: integer;
  FJSonReader: TlkJSONobject;
begin
  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    JRScrap_Frm.logger.error('Error: Parsing');
    debug('error');
  end;

  debug('Count :');
  debug((FJSonReader.Field['results'] as TlkJSONList).Count);

  if ((FJSonReader.Field['results'] as TlkJSONList).Count = 0) then
  begin

    if JRScrap_Frm.FMassScrap = false then
    begin
      ShowMessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_Frm.FCurrentLang_GUI));
      JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);
    end
    else
    begin

      if JRScrap_Frm.FMassScrap = true then
      begin
        JRScrap_Frm.WaitAllServices;
      end;

    end
  end

  else
  begin

    debug((FJSonReader.Field['results'] as TlkJSONList).Count);

    try

      for i := 0 to (FJSonReader.Field['results'] as TlkJSONList).Count - 1 do
      begin
        try
          md.name :=
            (((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['name'].value);
          md.release_date :=
            (((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['first_air_date'].value);
          md.API_Id :=
            StrToInt((((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['id'].value));

          self.AddMedia(md);
        except

        end;
      end;

      if JRScrap_Frm.FMassScrap = false then
      begin
        Display_Searches;
      end
      else
      begin

        if JRScrap_Frm.MassScrap_Frm.CheckBox1.Checked = true then
        begin

          Tmdb_id := inttostr(Medias[0].API_Id); // Frantic 10675
          TheMoviedB_Serie_Se_Ep_ID_Search_Proc;

        end
        else
        begin
          JRScrap_Frm.WaitAllServices;

          // Freebase
          if JRScrap_Frm.freebase_Btn.down = true then
          begin
            JRScrap_Frm.WaitAllServices;
          end;

          // Traileraddict
          if JRScrap_Frm.Traileraddict_Search_Btn.down = true then
          begin
            JRScrap_Frm.WaitAllServices;
          end;

        end;
      end;

    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error
        ('Error: Could not write results in Movie_Search_Grid');
    end;
  end;
  application.processmessages;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_Movie_Search(str: string);
var
  i: integer;
  FJSonReader: TlkJSONobject;
begin
  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    // JRScrap_Frm.Cursor := crDefault;
    JRScrap_Frm.logger.error('Error: Parsing');
    debug('error');
  end;

  debug('Count :');
  debug((FJSonReader.Field['results'] as TlkJSONList).Count);

  if ((FJSonReader.Field['results'] as TlkJSONList).Count = 0) then
  begin

    if JRScrap_Frm.FMassScrap = false then
    begin
      ShowMessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_Frm.FCurrentLang_GUI));
      JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);
    end
    else
    begin

      if JRScrap_Frm.FMassScrap = true then
      begin
        JRScrap_Frm.WaitAllServices;

        // Freebase
        if JRScrap_Frm.freebase_Btn.down = true then
        begin
          JRScrap_Frm.WaitAllServices;
        end;

        // Traileraddict
        if JRScrap_Frm.Traileraddict_Search_Btn.down = true then
        begin
          JRScrap_Frm.WaitAllServices;
        end;
      end;

    end
  end

  else
  begin

    debug((FJSonReader.Field['results'] as TlkJSONList).Count);

    try

      for i := 0 to (FJSonReader.Field['results'] as TlkJSONList).Count - 1 do
      begin
        try
          md.name :=
            (((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['title'].value);
          md.release_date :=
            (((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['release_date'].value);
          md.API_Id :=
            StrToInt((((FJSonReader.Field['results'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['id'].value));

          self.AddMedia(md);
        except

        end;
      end;

      if JRScrap_Frm.FMassScrap = false then
      begin
        Display_Searches;
      end
      else
      begin

        if JRScrap_Frm.MassScrap_Frm.CheckBox1.Checked = true then
        begin

          Tmdb_id := inttostr(Medias[0].API_Id); // Frantic 10675
          TheMoviedB_Movie_ID_Search_Proc;

        end
        else
        begin
          JRScrap_Frm.WaitAllServices;

          // Freebase
          if JRScrap_Frm.freebase_Btn.down = true then
          begin
            JRScrap_Frm.WaitAllServices;
          end;

          // Traileraddict
          if JRScrap_Frm.Traileraddict_Search_Btn.down = true then
          begin
            JRScrap_Frm.WaitAllServices;
          end;

        end;
      end;

    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error
        ('Error: Could not write results in Movie_Search_Grid');
    end;
  end;
  application.processmessages;

end;

end.
