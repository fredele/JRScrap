// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit TVdB_Unit;

interface

uses

  jpeg, dialogs, Forms, strutils, sysUtils, Utils_Unit, mystringutil,
  Threadsearch_Unit, Types_Unit, TranslateJRStyle_Unit, mydebug,
  MSXML, String_Unit, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc,
  Vcl.StdCtrls, Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Classes,
  Generic_Search_Unit, MediaCenter_TLB, Languagues_Unit,
  System.Variants;

type

  TTVdB_Cl = class(TGeneric_Search)
  public
  var

    MovieThreadSearch1: TThreadsearch;
    MovieThreadSearch_Image: TThreadsearch_Image;
    constructor Create(id: integer; CurrentLangShort: string; ep, se: integer);
    procedure SearchFiles(title: string); override;
    procedure After_Thread_Search_Search(str: string);
    procedure After_Thread_SearchSerieEpisode(str: string);
    procedure After_Thread_Image(img: TJpegimage);
    procedure Display_Search; override;
    procedure TheTVDB_ID_Search_Proc;
    procedure Auto_search; override;
    procedure SaveTags; override;
  end;

function getlid(lg: string): integer;

const

  TVDB_API_Key = '1A501B293D1EF0C7';

implementation

uses
  Search_Unit, MassScrap_Unit, JRScrap_Unit, JRiverXML_Unit;

var
  MassScrap_Frm: TMassScrap_Frm;

function getlid(lg: string): integer;
begin
  result := -1;
  // See this values in  :
  // http://thetvdb.com/api/1A501B293D1EF0C7/languages.xml

  if lg = 'da' then
    result := 10;

  if lg = 'fi' then
    result := 11;

  if lg = 'nl' then
    result := 13;

  if lg = 'de' then
    result := 14;

  if lg = 'it' then
    result := 15;

  if lg = 'es' then
    result := 16;

  if lg = 'fr' then
    result := 17;

  if lg = 'pl' then
    result := 18;

  if lg = 'hu' then
    result := 19;

  if lg = 'tr' then
    result := 21;

  if lg = 'ru' then
    result := 22;

  if lg = 'he' then
    result := 24;

  if lg = 'ja' then
    result := 25;

  if lg = 'pt' then
    result := 26;

  if lg = 'zh' then
    result := 27;

  if lg = 'cs' then
    result := 28;

  if lg = 'sl' then
    result := 30;

  if lg = 'hr' then
    result := 31;

  if lg = 'ko' then
    result := 32;

  if lg = 'en' then
    result := 7;

  if lg = 'sv' then
    result := 8;

  if lg = 'no' then
    result := 9;
end;

procedure TTVdB_Cl.SaveTags;
var
  FJRiverXml: TJRiverXml;
  day: TDateTime;
  s: string;
  i, j: integer;
  crew_list: TStringList;

begin

  if lock = true then
    Exit;

  JRScrap_Frm.Movie_Browser.cells[3, JRScrap_Frm.Movie_Browser.row] :=
    inttostr(Season);
  JRScrap_Frm.Movie_Browser.cells[4, JRScrap_Frm.Movie_Browser.row] :=
    inttostr(Episode);
  JRScrap_Frm.Movie_Browser.cells[5, JRScrap_Frm.Movie_Browser.row] := name;
  JRScrap_Frm.Movie_Browser.cells[2, JRScrap_Frm.Movie_Browser.row] :=
    Serie_Name;

  if length(Overview) <> 0 then
    JRScrap_Frm.Movie_Browser.cells[11, JRScrap_Frm.Movie_Browser.row] :=
      Leftstr(Overview, 40) + '...'
  else
    JRScrap_Frm.Movie_Browser.cells[11, JRScrap_Frm.Movie_Browser.row] := '';

  JRScrap_Frm.Movie_Browser.cells[12, JRScrap_Frm.Movie_Browser.row] :=
    filename;
  JRScrap_Frm.Movie_Browser.cells[10, JRScrap_Frm.Movie_Browser.row] := tvdb_id;

  s := ExtractFilePath(filename) + ExtractFileNameWithoutExt(filename) + '.jpg';

  if JRScrap_Frm.MassScrap_Frm.Picture_Rec_Chk.Checked = true then
  begin

    // Save image in directory
    try
      image.SaveToFile(s);
    except
      debug('except');
      // screen.cursor := crdefault;
    end;

    try
      FCurrentMovie.SetImageFile(s, IMAGEFILE_IN_DATABASE);
    except
      debug('except');
      // screen.cursor := crdefault;
    end;

    try
      FCurrentMovie.SetImageFile(s, IMAGEFILE_DISPLAY);
    except
      debug('except');
      // screen.cursor := crdefault;
    end;

    try
      FCurrentMovie.SetImageFile(s, IMAGEFILE_IN_FILE);
    except
      debug('except');
      // screen.cursor := crdefault;
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
    debug('except');
    screen.cursor := crdefault;
  end;

  FCurrentMovie.Set_('Season', inttostr(Season));
  FJRiverXml.SetField('Season', inttostr(Season));

  FCurrentMovie.Set_('Episode', inttostr(Episode));
  FJRiverXml.SetField('Episode', inttostr(Episode));

  FCurrentMovie.Set_('Series', Serie_Name);
  FJRiverXml.SetField('Series', Serie_Name);

  FCurrentMovie.Set_('IMDb ID', imdb_id);
  FJRiverXml.SetField('IMDb ID', imdb_id);

  FCurrentMovie.Set_('Tmdb ID', tmdb_id);
  FJRiverXml.SetField('Tmdb ID', tmdb_id);

  FCurrentMovie.Set_('TheTVDB Series ID', tvdb_id);
  FJRiverXml.SetField('TheTVDB Series ID', tvdb_id);

  FCurrentMovie.Set_('Name', Name);
  FJRiverXml.SetField('Name', Name);

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
    s := s + ';' + Persons[i].Character;
  end;
  s := Copy(s, 2, length(s) - 1);
  FCurrentMovie.Set_('Character', s);
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
  FCurrentMovie.Set_('ActorAsCharacter', s);
  FJRiverXml.SetField('ActorAsCharacter', s);
  s := '';

  FCurrentMovie.Set_('Critic Rating', Vote_Average);
  FJRiverXml.SetField('Critic Rating', Vote_Average);

  FCurrentMovie.Set_('Description', Overview);
  FJRiverXml.SetField('Description', Overview);

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

  s := serialize(Country);
  FCurrentMovie.Set_('Country', s);
  FJRiverXml.SetField('Country', s);
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

procedure TTVdB_Cl.Auto_search;
begin
  inherited;
  Season := 0;
  Episode := 0;
  tvdb_id := FMoviesList.GetFile(FMediaList_Id).Get('TheTVDB Series ID', true);

  if FMoviesList.GetFile(FMediaList_Id).Get('Season', true) <> emptystr then
    Season := strtoint(FMoviesList.GetFile(FMediaList_Id).Get('Season', true));
  if FMoviesList.GetFile(FMediaList_Id).Get('Episode', true) <> emptystr then
    Episode := strtoint(FMoviesList.GetFile(FMediaList_Id)
      .Get('Episode', true));

  if self.lock = false then
  begin

    if ((Season = 0) or (Episode = 0)) then
    begin
      MassScrap_Frm.masstag;
      Exit;
    end;

    if ((tvdb_id = emptystr) and (Serie_Name = emptystr)) then
    begin
      MassScrap_Frm.masstag;
      Exit;
    end;

    if (tvdb_id <> emptystr) then
    begin
      TtvdB_Ins.tvdb_id := tvdb_id;
      TtvdB_Ins.TheTVDB_ID_Search_Proc;
    end;

    if ((tvdb_id = emptystr) and (Serie_Name <> emptystr)) then
    begin
      SearchFiles(self.Serie_Name);
    end;

  end
  else
  begin
    // if Lock = true
    MassScrap_Frm.masstag;
  end;

end;

procedure TTVdB_Cl.Display_Search;
begin
  inherited;
  JRScrap_Frm.Serie_Name_Ed.Text := Serie_Name;
  JRScrap_Frm.Episode_Ed.Text := inttostr(Episode);
  JRScrap_Frm.Season_Ed.Text := inttostr(Season);
  JRScrap_Frm.tvdb_id_Ed.Text := tvdb_id;
  JRScrap_Frm.imdb_id_Ed.Text := imdb_id;
  JRScrap_Frm.tmdb_id_Ed.Text := tmdb_id;
  screen.cursor := crdefault;
  JRScrap_Frm.Write_Btn.Enabled := true;

  if JRScrap_Frm.FMassScrap = true then
  begin
    SaveTags;
    MassScrap_Frm.masstag;
  end;

end;

constructor TTVdB_Cl.Create(id: integer; CurrentLangShort: string;
  ep, se: integer);
begin
  inherited Create(id, CurrentLangShort);
  Episode := ep;
  Season := se;
end;

procedure TTVdB_Cl.SearchFiles(title: string);
var
  rq: string;
begin
  rq := StringReplace(title, ' ', '+', [rfReplaceAll, rfIgnoreCase]);

  if FLang <> 'en' then
  begin
    rq := 'http://thetvdb.com/api/GetSeries.php?seriesname=' + rq +
      '&language=' + FLang;
  end
  else
  begin
    rq := 'http://thetvdb.com/api/GetSeries.php?seriesname=' + rq;
  end;

  try
    MovieThreadSearch1 := TThreadsearch.Create(nil, Tcod.utf8, rq,
      self.After_Thread_Search_Search);
    // Le thread est d�sormais cr��, et actif.

  except
    debug('except');
    screen.cursor := crdefault;
    JRScrap_Frm.logger.error('Error: Error for this request');
  end;

end;

procedure TTVdB_Cl.After_Thread_Search_Search(str: string);
var
  i, j: integer;
  rq, id: string;
  root, node: IXMLDOMNode;
  FXMLReader: IXMLDOMDocument;
begin

  if str <> '' then
  begin

    try
      FXMLReader := CoDOMDocument.Create;
      FXMLReader.loadXML(str);
    except
      debug('except');
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error('Error: Parsing');
    end;

    root := FXMLReader.DocumentElement;

    Search_Frm.Movie_Search_Grid.rowcount := root.childNodes.length;

    if ((Search_Frm.Movie_Search_Grid.rowcount = 1) and
      (JRScrap_Frm.FMassScrap = false)) then
    begin
      ShowMessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_Frm.FCurrentLang_GUI));
      JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);
      Exit;
    end;

    for i := 0 to root.childNodes.length - 1 do
    begin
      node := root.childNodes[i];

      for j := 0 to node.childNodes.length - 1 do
      begin
        if node.childNodes[j].nodeName = 'seriesid' then
          Search_Frm.Movie_Search_Grid.cells[2, i] := node.childNodes[j].Text;

        if node.childNodes[j].nodeName = 'SeriesName' then
          Search_Frm.Movie_Search_Grid.cells[0, i] := node.childNodes[j].Text;

      end;
    end;

    if JRScrap_Frm.tvdb_id_Ed.Text <> emptystr then
    begin
      MassScrap_Frm.masstag;
    end;

    if JRScrap_Frm.FMassScrap = true then
    begin
      Search_Frm.Movie_Search_Grid.row := 0;
      Search_Frm.Movie_Search_Grid.col := 1;
      Search_Frm.Movie_Search_Grid.SetFocus;
    end;

  end;

  Application.ProcessMessages;

  if JRScrap_Frm.FMassScrap = false then
  begin
    Display_Searches;
  end
  else
  begin
    if MassScrap_Frm.CheckBox1.Checked = true then
    begin
      tvdb_id := inttostr(Medias[0].API_Id);
      TheTVDB_ID_Search_Proc;
    end
    else
    begin
      Display_Searches;
    end;
  end;

end;

procedure TTVdB_Cl.After_Thread_SearchSerieEpisode(str: string);
var
  rq, posterpath, s, s2, actorliststr, Directorliststr, Writerliststr: string;
  i, j, k: integer;
  actorlist, Directorlist, Writerlist: TArrayOfString;

  root, node: IXMLDOMNode;
  epnum, senum: integer;
  FXMLReader: IXMLDOMDocument;
  pe: TPerson;
begin

  screen.cursor := crhourglass;

  posterpath := emptystr;

  if (str = '') then
  begin
    if JRScrap_Frm.FMassScrap = false then
    begin
      ShowMessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_Frm.FCurrentLang_GUI));
      JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);
      screen.cursor := crdefault;
      Exit;
    end
    else
    begin
      MassScrap_Frm.masstag;
    end;
  end;

  if str <> '' then

  begin

    try
      FXMLReader := CoDOMDocument.Create;
      FXMLReader.loadXML(str);

    except
      debug('except');
      screen.cursor := crdefault;
      JRScrap_Frm.logger.error('Error: Parsing');
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
              tvdb_id := node.childNodes[j].Text;

            end;

            if node.childNodes[j].nodeName = 'Actors' then
            begin
              actorliststr := node.childNodes[j].Text;
              actorlist := SplitString('|', actorliststr);

              for k := 0 to length(actorlist) - 1 do
              begin
                DeletefirstandLastchar(actorlist[k]);
              end;

              for k := 1 to length(actorlist) - 2 do
              begin

                pe.Actor_Name := actorlist[k];
                addperson(pe);
              end;

            end;

            if node.childNodes[j].nodeName = 'SeriesName' then
            begin
              Serie_Name := node.childNodes[j].Text;

            end;
          end;
        end;
        if node.nodeName = 'Episode' then
        begin
          for j := 0 to node.childNodes.length - 1 do
          begin
            if node.childNodes[j].nodeName = 'EpisodeNumber' then
            begin
              epnum := strtoint(node.childNodes[j].Text);
            end;
            if node.childNodes[j].nodeName = 'SeasonNumber' then
            begin
              senum := strtoint(node.childNodes[j].Text);
            end;
          end;
          if ((epnum = Episode) and (senum = Season)) then
          /// ///Episode /season !
          begin
            for j := 0 to node.childNodes.length - 1 do
            begin
              if node.childNodes[j].nodeName = 'Overview' then
              begin

                Overview := string(node.childNodes[j].Text);
              end;

              if node.childNodes[j].nodeName = 'Language' then
              begin
                // Country.Add(node.childNodes[j].Text);
              end;

              if node.childNodes[j].nodeName = 'IMDB_ID' then
              begin
                imdb_id := node.childNodes[j].Text;
              end;

              if node.childNodes[j].nodeName = 'EpisodeName' then
              begin
                self.Name := string(node.childNodes[j].Text);

              end;

              if node.childNodes[j].nodeName = 'Director' then
              begin

                Directorliststr := node.childNodes[j].Text;
                Directorlist := SplitString('|', Directorliststr);

                for k := 0 to length(Directorlist) - 1 do
                begin
                  DeletefirstandLastchar(Directorlist[k]);
                end;

                Director := ArrayofStringToStringList(Directorlist);

              end;

              if node.childNodes[j].nodeName = 'Writer' then
              begin

                Writerliststr := node.childNodes[j].Text;
                Writerlist := SplitString('|', Writerliststr);

                for k := 0 to length(Writerlist) - 1 do
                begin
                  DeletefirstandLastchar(Writerlist[k]);
                end;
                Screenwriter := ArrayofStringToStringList(Writerlist);
              end;

              if node.childNodes[j].nodeName = 'filename' then
              begin
                posterpath := 'http://thetvdb.com/banners/' +
                  node.childNodes[j].Text;
                if assigned(image) then
                  FreeAndNil(image);
                image := TJpegimage.Create;

              end;
              if node.childNodes[j].nodeName = 'FirstAired' then
              begin
                s := node.childNodes[j].Text;
                s2 := s[9] + s[10] + '/' + s[6] + s[7] + '/' + s[1] + s[2] +
                  s[3] + s[4];
                release_date := s2;

              end;
              if node.childNodes[j].nodeName = 'Rating' then
              begin
                Vote_Average := node.childNodes[j].Text;
              end;

            end;
          end;
        end;

      end;

    except

    end;

  end;

  MovieThreadSearch_Image := TThreadsearch_Image.Create(nil, posterpath,
    After_Thread_Image);

end;

procedure TTVdB_Cl.After_Thread_Image(img: TJpegimage);
begin
  self.image.Assign(img);
  JRScrap_Frm.Picture_Img.Picture.Assign(image);

  Display_Search;
end;

procedure TTVdB_Cl.TheTVDB_ID_Search_Proc;
var
  rq: string;
begin
  try

    if FLang <> 'en' then
    begin
      rq := 'http://thetvdb.com/api/' + TVDB_API_Key + '/series/' + self.tvdb_id
        + '/all/' + FLang + '.xml';
    end
    else
    begin
      rq := 'http://thetvdb.com/api/' + TVDB_API_Key + '/series/' + self.tvdb_id
        + '/all/';
    end;

    MovieThreadSearch1 := TThreadsearch.Create(nil, Tcod.utf8, rq,
      After_Thread_SearchSerieEpisode);
    // Le thread est d�sormais cr��, et actif.

  except
    debug('except');
    screen.cursor := crdefault;
  end;

end;

end.
