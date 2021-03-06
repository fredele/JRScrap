// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit Traileraddict_Unit;

interface

uses
  vcl.forms, uLKJSon, String_Unit, System.Classes, StrUtils, sysutils,
  dialogs, Utils_Unit, Threadsearch_Unit,
  Types_Unit, TranslateJRStyle_Unit, jpeg, vcl.StdCtrls, debug_Unit,
  vcl.Grids, mnEdit, vcl.Controls, vcl.ExtCtrls, vcl.ComCtrls,
  Winapi.Windows, Winapi.Messages, System.Variants, VerySimple_Xml,
  ThreadManager_Unit, Generic_Search_Unit, MediaCenter_TLB,
  vcl.Graphics, vcl.themes;

type

  TTrailerAddict_Cl = class

  private
    url_trailer: string;

    FMovie: IMJFileAutomation;
  public
    procedure Search_Name();
    procedure After_Thrd(str: string);
    constructor Create;
    procedure Display;
    procedure savetags;

  end;

implementation

uses
  JRScrap_Unit, MassScrap_Unit;

var
  Thrd_Get: TThreadsearch;
  XMLDoc: TXmlVerySimple;
  link: string;

constructor TTrailerAddict_Cl.Create;
begin

  link := emptystr;
  FMovie := FCurrentMovie;

  if FMovie.Get('Lock External Tag Editor', true) = 'YES' then
  begin
    if JRScrap_Frm.FMassScrap = true then
      JRScrap_Frm.WaitAllServices;
    freeandnil(self);
    exit;
  end;
end;

procedure TTrailerAddict_Cl.Search_Name();
var
  rq, name: string;
begin

  if JRScrap_Frm.Original_title_Ed.Text <> emptystr then
    name := replacestr(JRScrap_Frm.Original_title_Ed.Text, ' ', '-')
  else
    name := replacestr(JRScrap_Frm.name_Ed.Text, ' ', '-');

  rq := 'http://api.traileraddict.com/?film=' + name + '&count=5';
  debug(rq);
  try
    Thrd_Get := TThreadsearch.Create(nil, Tcod.ansi, rq, self.After_Thrd);
  except
    JRScrap_Frm.logger.error('Error: Error for this request');
  end;

end;

procedure TTrailerAddict_Cl.After_Thrd(str: string);
var
  stream: Tstream;
  rootnode, TrailersNode, TrailerNode: TXmlNode;
  i: Integer;
  imdb: string;
begin

  XMLDoc := TXmlVerySimple.Create;
  stream := Tstream.Create;
  stream := StringToStream(str);
  debug(stream.Size);
  XMLDoc.LoadFromStream(stream);
  rootnode := XMLDoc.Root;
  TrailersNode := rootnode.ChildNodes[1]; // Trailers ;

  imdb := emptystr;
  try
    imdb := FCurrentMovie.Get('IMDB ID', true);
    imdb := replacestr(imdb, 'tt', '');
    imdb := replacestr(imdb, 'TT', '');
    imdb := inttostr(strtoint(imdb));
  except

  end;

  for i := 0 to TrailersNode.ChildNodes.Count - 1 do
  begin
    TrailerNode := TrailersNode.ChildNodes[i];
    try
      if inttostr(strtoint(TrailerNode.Find('imdb').Text)) = imdb then
      begin
        link := emptystr;
        link := TrailerNode.Find('link').Text;
      end;
    except
    end;
  end;

  Display;

end;

procedure TTrailerAddict_Cl.savetags;
begin
  if link <> emptystr then
  begin

    FCurrentMovie.Set_('Url traileraddict', link);
    JRScrap_Frm.FJRiverXml.SetField('Url traileraddict', link);
  end
  else
  begin

  end;

end;

procedure TTrailerAddict_Cl.Display;
begin

  if link <> emptystr then
  begin
    JRScrap_Frm.traileraddict_Ed.Text := link;
    JRScrap_Frm.Write_Btn.Enabled := true;
  end
  else
  begin
    if JRScrap_Frm.FMassScrap = false then
    begin
      ShowMessage('Traileraddict : ' + Translate_String_JRStyle
        ('No results for this search !', JRScrap_Frm.FCurrentLang_GUI));
      screen.Cursor := crdefault;
      exit;
    end;
  end;
  if JRScrap_Frm.FMassScrap = true then
  begin
    self.savetags;
  end;

  JRScrap_Frm.WaitAllServices;
  screen.Cursor := crdefault;

end;

end.
