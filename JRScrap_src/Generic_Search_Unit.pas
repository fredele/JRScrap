// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit Generic_Search_Unit;

interface

uses
  Classes, Types_Unit, system.Sysutils, debug_Unit, jpeg, Dialogs,
  TranslateJRStyle_Unit, vcl.Forms, string_Unit, JvListBox;

type

  TGeneric_Search = class

  public
  var
    lock: boolean;
    FMediaList_Id: integer;
    FileName, Name, Original_Name, Overview, Vote_Average, release_date,
      FLang: string;
    Medias: array of TMedia;
    Persons: array of TPerson;
    Country, Genre, production_companies, Keywords, Casting, Executive_Producer,
      Novel, Production_Design, Music_by, Screenwriter, Cinematographer,
      director: TStringList;
    image: TJPEGImage;
    trailer, budget, revenue: string;
    imdb_id, tmdb_id, tvdb_id: string;
    Episode, Season: integer;
    Serie_Name: string;

    procedure Auto_search; virtual;
    procedure Display_Search; virtual;
    procedure Display_Searches;
    procedure Searchfiles(title: string); virtual; abstract;
    procedure SaveTags; virtual; abstract;
    constructor Create(id: integer; CurrentLangShort: string);
    procedure AddPerson(pe: TPerson);
    procedure AddMedia(md: TMedia);
  private

    procedure Debug_search;
    procedure Erase_search;

  end;

function ItemExists(ListBox: TJvListBox; const Item: string): boolean;

implementation

uses
  JRScrap_Unit, Search_Unit;

function ItemExists(ListBox: TJvListBox; const Item: string): boolean;
begin
  Result := ListBox.Items.IndexOf(Item) >= 0;
end;

procedure TGeneric_Search.Auto_search;
var
  lockstr: string;
begin
  Name := FMoviesList.GetFile(FMediaList_Id).Get('Name', true);
  FileName := FMoviesList.GetFile(FMediaList_Id).Get('Filename', true);
  lockstr := FMoviesList.GetFile(FMediaList_Id)
    .Get('Lock External Tag Editor', true);

  if lockstr = 'YES' then
    lock := true
  else
    lock := false;
end;

constructor TGeneric_Search.Create(id: integer; CurrentLangShort: string);
begin

  FLang := CurrentLangShort;
  FMediaList_Id := id;
  Genre := TStringList.Create;
  Genre.Duplicates := dupIgnore;
  Country := TStringList.Create;
  Country.Duplicates := dupIgnore;
  production_companies := TStringList.Create;
  production_companies.Duplicates := dupIgnore;
  Keywords := TStringList.Create;
  Keywords.Duplicates := dupIgnore;
  Casting := TStringList.Create;
  Casting.Duplicates := dupIgnore;
  Executive_Producer := TStringList.Create;
  Executive_Producer.Duplicates := dupIgnore;
  Novel := TStringList.Create;
  Novel.Duplicates := dupIgnore;
  Production_Design := TStringList.Create;
  Production_Design.Duplicates := dupIgnore;
  Music_by := TStringList.Create;
  Music_by.Duplicates := dupIgnore;
  Screenwriter := TStringList.Create;
  Screenwriter.Duplicates := dupIgnore;
  Cinematographer := TStringList.Create;
  Cinematographer.Duplicates := dupIgnore;
  director := TStringList.Create;
  director.Duplicates := dupIgnore;

  Season := -1;
  Episode := -1;

end;

procedure TGeneric_Search.Display_Search;
var
  i: integer;
  pe: TPerson;
  f: extended;
begin

  if trailer <> EmptyStr then
  begin
    JRScrap_Frm.Trailer_Ed.Text := trailer;
  end;

  if Original_Name <> EmptyStr then
  begin
    JRScrap_Frm.Original_title_Ed.Text := Original_Name;
  end;

  if Name <> EmptyStr then
  begin
    JRScrap_Frm.Name_Ed.Text := Name;
  end;

  if Serie_Name <> EmptyStr then
  begin
    JRScrap_Frm.Serie_Name_Ed.Text := Serie_Name;
  end;

  if Vote_Average <> EmptyStr then
  begin
    try
      Vote_Average := replaceStr(Vote_Average, '.', ',');
      f := StrToFloat(Vote_Average);
      JRScrap_Frm.Star_Panel.DrawStar(round(f));
    except

    end;

  end;

  if release_date <> EmptyStr then
  begin
    JRScrap_Frm.Release_date_Ed.Text := release_date;
  end;

  if Overview <> EmptyStr then
  begin
    JRScrap_Frm.MemoOverview.Lines.Text := Overview;
  end;

  if budget <> EmptyStr then
  begin
    JRScrap_Frm.budget_ed.Text := budget;
  end;

  if revenue <> EmptyStr then
  begin
    JRScrap_Frm.revenue_ed.Text := revenue;
  end;

  if Genre.Count <> 0 then
  begin
    JRScrap_Frm.Genre_ListBox.Items := Genre;
  end;

  if Country.Count <> 0 then
  begin
    JRScrap_Frm.Country_ListBox.Items := Country;
  end;

  if production_companies.Count <> 0 then
  begin
    JRScrap_Frm.Production_Company_ListBox.Items := production_companies;
  end;

  if length(Persons) <> 0 then
  begin
    JRScrap_Frm.Cast_Grid.RowCount := length(Persons);
    for i := 0 to length(Persons) - 1 do
    begin
      pe := Persons[i];
      JRScrap_Frm.Cast_Grid.Cells[0, i] := pe.Actor_Name;
      JRScrap_Frm.Cast_Grid.Cells[1, i] := pe.Character;
      JRScrap_Frm.Cast_Grid.Cells[2, i] := IntToStr(pe.id);
    end;
  end;

  if self.tmdb_id <> EmptyStr then
    JRScrap_Frm.Tmdb_id_Ed.Text := self.tmdb_id;
  if self.imdb_id <> EmptyStr then
    JRScrap_Frm.imdb_id_Ed.Text := self.imdb_id;
  if self.tvdb_id <> EmptyStr then
    JRScrap_Frm.Tvdb_id_Ed.Text := self.tvdb_id;
  try
    if self.Episode <> 0 then
      JRScrap_Frm.Episode_Ed.Text := IntToStr(self.Episode);
  except
  end;

  try
    if self.Season <> 0 then
      JRScrap_Frm.season_Ed.Text := IntToStr(self.Season);
  except
  end;

  if Keywords.Count <> 0 then
  begin
    JRScrap_Frm.Keywords_ListBox.Items := Keywords;
  end;

  if Casting.Count <> 0 then
  begin
    JRScrap_Frm.Casting_ListBox.Items := Casting;
  end;

  if Executive_Producer.Count <> 0 then
  begin
    JRScrap_Frm.Executive_Producer_ListBox.Items := Executive_Producer;
  end;

  if Novel.Count <> 0 then
  begin
    JRScrap_Frm.Novel_ListBox.Items := Novel;
  end;

  if Production_Design.Count <> 0 then
  begin
    JRScrap_Frm.Production_Design_ListBox.Items := Production_Design;
  end;

  if Music_by.Count <> 0 then
  begin
    JRScrap_Frm.Music_by_ListBox.Items := Music_by;
  end;

  if Screenwriter.Count <> 0 then
  begin
    JRScrap_Frm.Screenwriter_ListBox.Items := Screenwriter;
  end;

  if Cinematographer.Count <> 0 then
  begin
    JRScrap_Frm.Cinematographer_ListBox.Items := Cinematographer;
  end;

  if director.Count <> 0 then
  begin
    JRScrap_Frm.director_ListBox.Items := director;
  end;

  if image <> nil then
  begin
    try
      JRScrap_Frm.Picture_Img.Picture.Assign(image);
    except

    end;
    JRScrap_Frm.Write_Btn.Enabled := true;
  end;

  application.ProcessMessages;
end;

procedure TGeneric_Search.AddMedia(md: TMedia);
begin
  setlength(Medias, length(Medias) + 1);
  Medias[length(Medias) - 1] := md;
end;

procedure TGeneric_Search.AddPerson(pe: TPerson);
begin
  setlength(Persons, length(Persons) + 1);
  Persons[length(Persons) - 1] := pe;
end;

procedure TGeneric_Search.Debug_search;
begin
  debug(name);
  debug(Original_Name);
  debug(Overview);

end;

procedure TGeneric_Search.Erase_search;
begin

  Name := EmptyStr;
  Original_Name := EmptyStr;
  Overview := EmptyStr;

end;

procedure TGeneric_Search.Display_Searches;
var
  i: integer;
  md: TMedia;
begin

  if length(Medias) = 0 then
  begin
    // ShowMessage(Translate_String_JRStyle('No results for this search !', JRScrap_Frm.FCurrentLang));
    JRScrap_Frm.ShowJRiverId(JRScrap_Frm.FCurrentJRiverId);

    Exit;
  end;

  try
    for i := 0 to length(Medias) - 1 do
    begin

      md := Medias[i];
      Search_Frm.Movie_Search_Grid.Cells
        [0, Search_Frm.Movie_Search_Grid.RowCount - 1] := md.Name;
      Search_Frm.Movie_Search_Grid.Cells
        [1, Search_Frm.Movie_Search_Grid.RowCount - 1] := md.release_date;
      Search_Frm.Movie_Search_Grid.Cells
        [2, Search_Frm.Movie_Search_Grid.RowCount - 1] := IntToStr(md.API_Id);
      Search_Frm.Movie_Search_Grid.RowCount :=
        Search_Frm.Movie_Search_Grid.RowCount + 1;
    end;
    Search_Frm.Movie_Search_Grid.RowCount :=
      Search_Frm.Movie_Search_Grid.RowCount - 1;
    Search_Frm.Status_Lbl.Caption := Translate_String_JRStyle('OK',
      JRScrap_Frm.FCurrentLang_GUI);
  except
    //
  end;

end;

end.
