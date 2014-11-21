unit Freebase_Unit;

interface

uses
vcl.forms, uLKJSon ,String_Unit , System.Classes , StrUtils ,sysutils ,
 dialogs,   Utils_Unit, Threadsearch_Unit,
  Types_Unit, TranslateJRStyle_Unit, jpeg, Vcl.StdCtrls, debug_Unit,
  Vcl.Grids, mnEdit, Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Winapi.Windows, Winapi.Messages, System.Variants,
  ThreadManager_Unit, Generic_Search_Unit,  MediaCenter_TLB,
  Vcl.Graphics, Vcl.themes;
type

TFreebase_Cl = class
  var

     url_Allocine,
     url_rottentomatoes ,
     url_Wikipedia_eng,
     url_Wikipedia_CurrentLang ,
     url_traileraddict,
     url_metacritic

     : string;

      urls_Wikipedia_eng,
      urls_Wikipedia_CurrentLang
     : TstringList ;
public

procedure Freebase_getID() ;
procedure After_Thrd_Get_ID (str : string) ;
procedure After_Thrd_Get_RDF (str : string) ;
constructor Create;
procedure Display ;
procedure savetags ;
end;





function Invert_Date (dt : string) : string ;


implementation

uses
 JRScrap_Unit ,  MassScrap_Unit ;

var
  Thrd_Get_ID : TThreadsearch ;

function Invert_Date (dt : string) : string ;
begin
  result := dt[7] +dt[8]+ dt[9]+ dt[10] + '-'  + dt[4] + dt[5]  + '-'  +  dt[1] + dt[2] ;
end;


procedure  TFreebase_Cl.savetags ;
begin

if self.url_Allocine <> emptystr then
begin
FCurrentMovie.Set_('Url Allocine', self.url_Allocine);
JRScrap_frm.FJRiverXml.SetField('Url Allocine', self.url_Allocine);
end;

if self.url_rottentomatoes <> emptystr then
begin
FCurrentMovie.Set_('Url rottentomatoes', self.url_rottentomatoes);
JRScrap_frm.FJRiverXml.SetField('Url rottentomatoes', self.url_rottentomatoes);
end;

if self.url_Wikipedia_eng <> emptystr then
begin
FCurrentMovie.Set_('Url Wikipedia eng', self.url_Wikipedia_eng);
JRScrap_frm.FJRiverXml.SetField('Url Wikipedia eng', self.url_Wikipedia_eng);
end;

if self.url_Wikipedia_CurrentLang <> emptystr then
begin
FCurrentMovie.Set_('Url Wikipedia', self.url_Wikipedia_CurrentLang);
JRScrap_frm.FJRiverXml.SetField('Url Wikipedia', self.url_Wikipedia_CurrentLang);
end;

if self.url_traileraddict <> emptystr then
begin
FCurrentMovie.Set_('Url traileraddict', self.url_traileraddict);
JRScrap_frm.FJRiverXml.SetField('Url traileraddict', self.url_traileraddict);
end;

if self.url_metacritic <> emptystr then
begin
FCurrentMovie.Set_('Url metacritic', self.url_metacritic);
JRScrap_frm.FJRiverXml.SetField('Url metacritic', self.url_metacritic);
end;


end;



procedure TFreebase_Cl.Display ;
begin


   if   self.url_Allocine <> emptystr then
   JRScrap_frm.allocine_ed.text := self.url_Allocine ;
    if   self.url_rottentomatoes <> emptystr then
   JRScrap_frm.RottenTomatoes_Ed.Text := self.url_rottentomatoes ;
    if   self.url_Wikipedia_eng <> emptystr then
   JRScrap_frm.Wikipediaeng_ed.text  := self.url_Wikipedia_eng ;
    if   self.url_Wikipedia_CurrentLang <> emptystr then
   JRScrap_frm.Wikipedia_ed.text    := self.url_Wikipedia_CurrentLang ;
    if   self.url_traileraddict <> emptystr then
   JRScrap_frm.traileraddict_Ed.Text := self.url_traileraddict;
    if   self.url_metacritic <> emptystr then
   JRScrap_frm.Metacritic_Ed.Text  := self.url_metacritic ;

   screen.cursor := crdefault ;
   JRScrap_frm.Write_Btn.Enabled := true ;

  if  JRScrap_Frm.FMassScrap = true then
  begin
    self.saveTags;
  end ;

  JRScrap_frm.WaitAllServices ;


end;

constructor TFreebase_Cl.Create;
begin

  urls_Wikipedia_eng  := TstringList.create ;
  urls_Wikipedia_CurrentLang  := TstringList.create ;

end;

procedure TFreebase_Cl.After_Thrd_Get_ID (str : string) ;
var
 FJSonReader: TlkJSONobject;
 id , rq: string ;
 i ,count: integer ;
begin
  id := '';

  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    JRScrap_Frm.logger.error('Error: Parsing');
  end;
  try

    // Get the First Result ...
    id :=  ((FJSonReader.Field['result']as TlkJSONList).child[0] as TlkJSONobject).Field['id'].value;

  except

  end;

     if id <> '' then
     begin
      rq := 'https://www.googleapis.com/freebase/v1/rdf' + id ;

       Thrd_Get_ID := TThreadsearch.Create(nil, Tcod.ansi, rq, self.After_Thrd_Get_RDF);
     end
     else
     begin
     if  JRScrap_Frm.FMassScrap = true then
       MassScrap_Frm.masstag ;
     end;

end;

procedure TFreebase_Cl.After_Thrd_Get_RDF (str : string) ;
var
 FJSonReader: TlkJSONobject;
 id , rq: string ;
 i : integer ;
 httpList :  TstringList ;
begin
debug(str);
httpList :=  TstringList.Create ;
httpList := ExtractText( str , '<http://','>' );

for i := 0 to httpList.Count -1 do
begin
   httpList[i] := 'http://' +  httpList[i] ;
end;

for i := 0 to httpList.Count -1 do
begin

   debug(httpList[i]) ;

   if AnsiContainsStr( httpList[i] , 'allocine.fr' ) then
   begin
   url_Allocine :=  httpList[i] ;
   end;

   if AnsiContainsStr( httpList[i] , JRScrap_frm.FCurrentLangshort + '.wikipedia.org' ) then
   begin
   urls_Wikipedia_CurrentLang.add(httpList[i]) ;
   end;

   if AnsiContainsStr( httpList[i] , 'en.wikipedia.org' ) then
   begin
   urls_Wikipedia_eng.add(httpList[i]) ;
   end;

   if AnsiContainsStr( httpList[i] , 'http://www.rottentomatoes.com/' ) then
   begin
   url_rottentomatoes :=  httpList[i] ;
   end;

   if AnsiContainsStr( httpList[i] , 'www.traileraddict.com/' ) then
   begin
   url_traileraddict :=  httpList[i] ;
   end;

   if AnsiContainsStr( httpList[i] , 'www.metacritic.com' ) then
   begin
   url_metacritic :=  httpList[i] ;
   end;

end;

if urls_Wikipedia_CurrentLang.Count >= 1 then
url_Wikipedia_CurrentLang  := urls_Wikipedia_CurrentLang[0] ;

if urls_Wikipedia_eng.Count >= 1 then
url_Wikipedia_eng := urls_Wikipedia_eng[0] ;

for i  := 0 to urls_Wikipedia_CurrentLang.Count -1 do
   begin
      if AnsiContainsStr( urls_Wikipedia_CurrentLang[i] , 'film' )  then
       url_Wikipedia_CurrentLang  := urls_Wikipedia_CurrentLang[i] ;
   end;

   for i  := 0 to urls_Wikipedia_eng.Count -1 do
   begin
      if AnsiContainsStr( urls_Wikipedia_eng[i] , 'film' )  then
       url_Wikipedia_eng  := urls_Wikipedia_eng[i] ;
   end;

    Display ;
end;

procedure TFreebase_Cl.Freebase_getID() ;
var
  rq,name : string ;
  begin

  if FCurrentMovie.Get('Lock External Tag Editor',true ) = 'YES' then
  begin
  if  JRScrap_Frm.FMassScrap = true then
        MassScrap_Frm.masstag ;
    exit;
  end;

  if   JRScrap_Frm.Original_title_Ed.Text <> emptystr  then
  name := replacestr( JRScrap_Frm.Original_title_Ed.Text, ' ', '%20' )
  else
  name := replacestr( JRScrap_Frm.name_Ed.Text, ' ', '%20' );

  rq :=   'https://www.googleapis.com/freebase/v1/mqlread?query=[{%22id%22:%20null,%22name%22:%20%22'+name+'%22,%22type%22:%20%22/film/film%22,%22/common/topic/topic_equivalent_webpage%22:%20[]}]' ;
  try
   Thrd_Get_ID := TThreadsearch.Create(nil, Tcod.ansi, rq, self.After_Thrd_Get_ID);
  except
    JRScrap_Frm.logger.error('Error: Error for this request');
  end;

end;

end.
