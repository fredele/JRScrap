unit TheMoviedB_Unit;

interface

uses
  uLKJSon, dialogs, Forms, strutils, sysUtils, Utils_Unit, Threadsearch_Unit,
  Types_Unit, TranslateJRStyle_Unit, jpeg, Vcl.StdCtrls, debug_Unit,
  Vcl.Grids, mnEdit, Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Classes,
  Winapi.Windows, Winapi.Messages, System.Variants, String_Unit,
  ThreadManager_Unit, Generic_Search_Unit,  MediaCenter_TLB,
  Vcl.Graphics, Vcl.themes;

type

  TTheMoviedB_Cl = class(TGeneric_Search)
  var
    imdb_id, tmdb_id: string;
  public

    Thrd_Search, Thrd_IMDB_ID, Thrd_Basic_Info, Thrd_Credits,
      Thrd_Keywords: TThreadsearch;
    Thrd_Image: TThreadsearch_Image;
    FManager: TThreadManager;

    constructor Create(id: integer; CurrentLangShort: string);

    procedure TheMoviedB_IMDB_Search_Proc;
    procedure After_Thread_Search_IMDB_ID(str: string);

    procedure TheMoviedB_ID_Search_Proc;

    procedure Searchfiles(title: string); override;
    procedure After_Thread_Search_Search(str: string);

    procedure After_Thread_Search_Basic_Info(str: string);
    procedure After_Thread_Search_Credits(str: string);
    procedure After_Thread_Search_Keywords(str: string);
    procedure After_Thread_Image(img: TJPEGImage);
    Procedure After_Manager;
    procedure Auto_search ;   override;
    procedure Display_Search; override;
    procedure SaveTags ; override;
  end;

implementation

uses

  MassScrap_Unit,
  JRScrap_Unit,
  Search_Unit,
  JRiverXML_Unit ;
var
  md: TMedia;


procedure TTheMoviedB_Cl.SaveTags ;
var
    NpWnd: HWnd;
    FJRiverXml: TJRiverXml;
    day: TDateTime;
    s: string;
    i, j: Integer;
    crew_list: TStringList;

begin

 if lock = true then Exit ;



JRScrap_Frm.Movie_Browser.cells[5, JRScrap_Frm.Movie_Browser.row] := name;

    if length(Overview) <> 0 then
     JRScrap_Frm.Movie_Browser.cells[11, JRScrap_Frm.Movie_Browser.row] :=Leftstr(Overview,40) + '...'
     else
     JRScrap_Frm.Movie_Browser.cells[11, JRScrap_Frm.Movie_Browser.row] := '';

 JRScrap_Frm.Movie_Browser.cells[12, JRScrap_Frm.Movie_Browser.row] := filename ;
 JRScrap_Frm.Movie_Browser.cells[10, JRScrap_Frm.Movie_Browser.row] := imdb_id ;

 if JRScrap_Frm.Writepicture1.Checked = true  then
 begin

    s := ExtractFilePath(Filename) + ExtractFileNameWithoutExt(Filename) + '.jpg';

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
      ShowMessage(Translate_String_JRStyle('No Movie selected !',JRScrap_frm.FCurrentLang));
      screen.cursor := crdefault;
      Exit;
    end;


    try

      FJRiverXml := TJRiverXml.Create(filename);
    except
      screen.cursor := crdefault;
    end;


      FCurrentMovie.Set_('Name', Name);
      FJRiverXml.SetField('Name', Name);

      FCurrentMovie.Set_('original title', Original_name);
      FJRiverXml.SetField('original title', Original_name);

        day := StrToDate(release_date);
        s := '';

      FCurrentMovie.Set_('Date', Floattostr(day));
      FJRiverXml.SetField('Date', Floattostr(day));

       // TODO : continue this !
      for i := 0 to length(Persons) - 1 do
      begin
        s := s + ';' + Persons[i].Actor_Name;
      end;

      s := Copy(s, 2, length(s) - 1);
      FCurrentMovie.Set_('Actors', s);
      FJRiverXml.SetField('Actors', s);
      s := '';

      for i := 0 to length(Persons) - 1 do
      begin
        s := s + ';' +Persons[i].Character;
      end;
      s := Copy(s, 2, length(s) - 1);
      FCurrentMovie.Set_('Character', s);
      FJRiverXml.SetField('Character', s);
      s := '';

      for i := 0 to length(Persons) - 1 - 1 do
      begin
        if (Persons[i].Actor_Name <> '') and
          (Persons[i].Character <> '') then
        begin
          s := s + ';' + Persons[i].Actor_Name + ', ' +
            Persons[i].Character;
        end;
      end;
      s := Copy(s, 2, length(s) - 1);
      FCurrentMovie.Set_('ActorAsCharacter', s);
      FJRiverXml.SetField('ActorAsCharacter', s);
      s := '';

      FCurrentMovie.Set_('IMDb ID', imdb_id);
      FJRiverXml.SetField('IMDb ID',imdb_id);

      FCurrentMovie.Set_('TMDB ID', Tmdb_id);
      FJRiverXml.SetField('TMDB ID', Tmdb_id);


      FCurrentMovie.Set_('Critic Rating', Vote_Average);
      FJRiverXml.SetField('Critic Rating', Vote_Average);

      FCurrentMovie.Set_('Description', Overview);
      FJRiverXml.SetField('Description',  Overview);

      s := serialize(Keywords);
      FCurrentMovie.Set_('Keywords', s);
      FJRiverXml.SetField('Keywords', s);
      s := emptystr;

      s := serialize(Genre);
      FCurrentMovie.Set_('Genre', s);
      FJRiverXml.SetField('Genre', s);
      s := emptystr;

      s := serialize(Production_Companies);
      FCurrentMovie.Set_('Production Company', s);
      FJRiverXml.SetField('Production Company', s);
      s := emptystr;

      s := serialize(Director);
      FCurrentMovie.Set_('Director', s);
      FJRiverXml.SetField('Director', s);
      s := emptystr;

      s := serialize(Executive_Producer);
      FCurrentMovie.Set_('Executive Producer', s);
      FJRiverXml.SetField('Executive Producer', s);
      s := emptystr;

      s := serialize(Cinematographer);
      FCurrentMovie.Set_('Cinematographer', s);
      FJRiverXml.SetField('Cinematographer', s);
      s := emptystr;

      s := serialize(Casting);
      FCurrentMovie.Set_('Casting', s);
      FJRiverXml.SetField('Casting', s);
      s := emptystr;


      s := serialize(Screenwriter);
      FCurrentMovie.Set_('Screenwriter', s);
      FJRiverXml.SetField('Screenwriter', s);
      s := emptystr;

      s := serialize(Music_by);
      FCurrentMovie.Set_('Music by', s);
      FJRiverXml.SetField('Music by', s);
      s := emptystr;

      s := serialize(Novel);
      FCurrentMovie.Set_('Novel', s);
      FJRiverXml.SetField('Novel', s);
      s := emptystr;

      s := serialize(Production_Design);
      FCurrentMovie.Set_('Production Design', s);
      FJRiverXml.SetField('Production Design', s);
      s := emptystr;

end;

 procedure TTheMoviedB_Cl.Auto_search ;
begin
 inherited ;
   imdb_id := FMoviesList.GetFile(FMediaList_Id ).Get('IMDB ID',true ) ;
   tmdb_id := FMoviesList.GetFile(FMediaList_Id ).Get('TMDB ID',true ) ;


    if self.lock = false then
    begin

      // 0 0 0

      if ((self.tmdb_id = emptystr) and
        (self.imdb_id = emptystr) and (Name = emptystr)) then
      begin
         if  JRScrap_Frm.FMassScrap = false then
         begin
          ShowMessage(Translate_String_JRStyle('Nothing to search !', JRScrap_Frm.FCurrentLang));
          screen.Cursor := crdefault;
          Exit;

         end
         else
         begin
          MassScrap_Frm.masstag ;
         end;
      end;

      // 1 0 0
      if ((self.tmdb_id <> emptystr) and
        (self.imdb_id  = emptystr) and (Name = emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.tmdb_id;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

      // 0 1 0
      if ((self.tmdb_id = emptystr) and
        (self.imdb_id  <> emptystr) and (Name = emptystr)) then
      begin
        TheMoviedB_Ins.imdb_id := self.imdb_id;
        TheMoviedB_Ins.TheMoviedB_IMDB_Search_Proc;
      end;

      ///*******

      // 1 1 0
      if ((self.Tmdb_id <> emptystr) and
        (self.imdb_id<> emptystr) and (Name= emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.Tmdb_id;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

      // 0 1 1
      if ((self.Tmdb_id= emptystr) and
        (self.imdb_id<> emptystr) and (Name<> emptystr)) then
      begin
        TheMoviedB_Ins.imdb_id := self.imdb_id;
        TheMoviedB_Ins.TheMoviedB_IMDB_Search_Proc;
      end;

      // 1 0 1
      if ((self.Tmdb_id<> emptystr) and
        (self.imdb_id= emptystr) and (Name<> emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.Tmdb_id;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

      // 1 1 1
      if ((self.Tmdb_id<> emptystr) and
        (self.imdb_id<> emptystr) and (Name<> emptystr)) then
      begin
        TheMoviedB_Ins.tmdb_id := self.Tmdb_id;
        TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
      end;

        // *********
       // 0 0 1
      if ((self.Tmdb_id= emptystr) and
        (self.imdb_id= emptystr) and (Name<> emptystr)) then
      begin
         Searchfiles(self.name);

      end;
    end
    else
    begin
      //if Lock = true
      After_Manager;
    end;
end;


procedure TTheMoviedB_Cl.Display_Search;
begin
  inherited;
  JRScrap_Frm.imdb_id_Ed.text:= imdb_id;
  JRScrap_Frm.tmdb_id_Ed.text:= tmdb_id;
   screen.Cursor := crDefault;
   JRScrap_Frm.Write_Btn.Enabled := true ;
end;

Procedure TTheMoviedB_Cl.After_Manager;
begin
  self.Display_Search;
 // showmessage('fait');
  debug('After Manager');
  screen.cursor := crdefault;
  JRScrap_Frm.FSearching := false;
  application.processmessages ;

  if  JRScrap_Frm.FMassScrap = true then
  begin
   saveTags;
    MassScrap_Frm.masstag ;
  end;

end;

constructor TTheMoviedB_Cl.Create(id: integer; CurrentLangShort: string);
begin
  inherited Create(id, CurrentLangShort);
  APIkey := '3b608fc11821e92cd2459320206a9d9b';
end;

procedure TTheMoviedB_Cl.TheMoviedB_IMDB_Search_Proc;
var
  rq: string;

begin

  imdb_id := StringReplace(imdb_id, 'TT', 'tt', [rfReplaceAll, rfIgnoreCase]);

  rq := 'http://api.themoviedb.org/3/find/' + imdb_id + '?api_key=' + APIkey +
    '&external_source=imdb_id' + '&language=' + FCurrentLangShort;

  try

    self.Thrd_IMDB_ID := TThreadsearch.Create(nil, Tcod.ansi, rq,
      self.After_Thread_Search_IMDB_ID);
    // Le thread est d�sormais cr��, et actif.

  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Error for this request');
  end;
end;

procedure TTheMoviedB_Cl.TheMoviedB_ID_Search_Proc;
var
  rq: string;
begin


  rq := 'https://api.themoviedb.org/3/movie/' + self.tmdb_id + '?api_key=' +
    APIkey + '&language=' + FCurrentLangShort;

  self.Thrd_Basic_Info := TThreadsearch.Create(nil, Tcod.ansi, rq,
    After_Thread_Search_Basic_Info);
end;

procedure TTheMoviedB_Cl.After_Thread_Search_Basic_Info(str: string);
var
  FJSonReader: TlkJSONobject;
  rq, posterpath, s: string;
  i: integer;

begin

  posterpath := EmptyStr;

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

      if FJSonReader.getString('poster_path') <> EmptyStr then
        posterpath := 'http://image.tmdb.org/t/p/w500' +
          FJSonReader.getString('poster_path');

    end;
  except
    screen.cursor := crdefault;

  end;

  if FJSonReader.getString('imdb_id') <> '' then
    imdb_id := (FJSonReader.getString('imdb_id'));

  tmdb_id := inttostr((FJSonReader.getint('id')));
  // debug(FJSonReader.getint('id'));

  if FJSonReader.getString('original_title') <> '' then
    original_name := FJSonReader.getString('original_title');

  if FJSonReader.getString('title') <> '' then
    name := FJSonReader.getString('title');

  if FJSonReader.getDouble('vote_average') <> 0 then
    Vote_Average := FloatToStr(FJSonReader.getDouble('vote_average'));

  if FJSonReader.getString('release_date') <> '' then
    release_date := formatdateEngToFrench
      (FJSonReader.getString(('release_date')));

  if FJSonReader.getString('overview') <> '' then
    overview := FJSonReader.getString('overview');

  if (FJSonReader.Field['genres'] as TlkJSONList).Count <> 0 then
  begin

    for i := 0 to (FJSonReader.Field['genres'] as TlkJSONList).Count - 1 do
    begin

      Genre.Add(trim((((FJSonReader.Field['genres'] as TlkJSONList)
        .child[i] as TlkJSONobject).Field['name'].value)));
    end;
  end;

  if (FJSonReader.Field['production_companies'] as TlkJSONList).Count <> 0 then
  begin

    for i := 0 to (FJSonReader.Field['production_companies'] as TlkJSONList)
      .Count - 1 do
    begin
      production_companies.Add
        (trim((((FJSonReader.Field['production_companies'] as TlkJSONList)
        .child[i] as TlkJSONobject).Field['name'].value)));
    end;
  end;

  FManager := TThreadManager.Create(self, After_Manager);

  rq := ('https://api.themoviedb.org/3/movie/' + imdb_id + '/credits?api_key=' +
    APIkey + '&language=' + FCurrentLangShort);

  FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Credits);

  rq := ('https://api.themoviedb.org/3/movie/' + imdb_id + '/keywords?api_key='
    + APIkey + '&language=' + FCurrentLangShort);

  FManager.Addthread(Tcod.ansi, rq, After_Thread_Search_Keywords);

  if posterpath <> EmptyStr then
  begin
  if assigned(image) then FreeAndNil(image);
    image := TJPEGImage.Create;

    rq := posterpath;
    FManager.Addthread(rq, self.After_Thread_Image);
  end;

  FManager.Resume;

  application.ProcessMessages;
  screen.cursor := crdefault;
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

    tmdb_id := (((FJSonReader.Field['movie_results'] as TlkJSONList)
      .child[0] as TlkJSONobject).Field['id'].value);

    rq := 'https://api.themoviedb.org/3/movie/' + tmdb_id + '?api_key=' + APIkey
      + '&language=' + FCurrentLangShort;

    Thrd_Basic_Info := TThreadsearch.Create(nil, Tcod.ansi, rq,
      After_Thread_Search_Basic_Info);

  end;

end;

procedure TTheMoviedB_Cl.After_Thread_Search_Credits(str: string);
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
          director.Add(((FJSonReader.Field['crew'] as TlkJSONList)
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

procedure TTheMoviedB_Cl.After_Thread_Search_Keywords(str: string);
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

procedure TTheMoviedB_Cl.After_Thread_Image(img: TJPEGImage);
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

  rq := DeleteAccents(title);

  rq := StringReplace(rq, ' ', '+', [rfReplaceAll, rfIgnoreCase]);
  rq := 'http://api.themoviedb.org/3/search/movie?api_key=' + APIkey + '&query='
    + rq + '&language=' + FCurrentLangShort;

  try
    Thrd_Search := TThreadsearch.Create(nil, Tcod.ansi, rq,
      After_Thread_Search_Search);
    // Le thread est d�sormais cr��, et actif.

  except
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Error for this request');
  end;

  screen.cursor := crdefault;
  application.ProcessMessages;
end;

procedure TTheMoviedB_Cl.After_Thread_Search_Search(str: string);
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

  if (FJSonReader.Field['results'] as TlkJSONList).Count < 1 then
  begin

    ShowMessage(Translate_String_JRStyle('No results for this search !',
      JRScrap_Frm.FCurrentLang));
    JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);
  end;

  begin
    debug((FJSonReader.Field['results'] as TlkJSONList).Count);


    debug(Search_Frm.Movie_Search_Grid.RowCount);
    try

      for i := 0 to (FJSonReader.Field['results'] as TlkJSONList).Count - 1 do
      begin

        md.name := (((FJSonReader.Field['results'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['title'].value);
        md.release_date :=
          (((FJSonReader.Field['results'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['release_date'].value);
        debug(Search_Frm.Movie_Search_Grid.Cells[1, i]);
        md.API_Id :=
          StrToInt((((FJSonReader.Field['results'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['id'].value));
        debug(Search_Frm.Movie_Search_Grid.Cells[2, i]);

        self.AddMedia(md);
      end;


      if JRScrap_Frm.FMassScrap = false then
      begin
      Display_Searches;
      end
      else
      begin
      if MassScrap_Frm.CheckBox1.Checked = true then
       begin
       tmdb_id := inttostr( Medias[0].API_Id) ;      //Frantic 10675
       TheMoviedB_ID_Search_Proc;
      end
      else
      begin
      Display_Searches;
      end;
      end;




    except
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error
        ('Error: Could not write results in Movie_Search_Grid');
    end;
    application.ProcessMessages;

  end;

end;

end.
