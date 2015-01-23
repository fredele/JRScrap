unit Poster_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.extctrls, Threadsearch_Unit,
  String_Unit, Types_unit, TranslateJRStyle_Unit, debug_Unit, uLkJSON,
  ThreadManager_Unit, jpeg,
  Vcl.StdCtrls, cyBasePanel, cyPanel;

type
  TPoster_Frm = class(TForm)

    CyPanel1: TCyPanel;
    Close: TButton;
    ScrollBox1: TScrollBox;
    Status_Lbl: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseClick(Sender: TObject);
  private

  public

  var
    Thrd_Search: TThreadsearch;
    Thrd_Image: TThreadsearch_Image;
    id: string;
    Thrd_Mng_hdmovielogo: TThreadManager;
    Thrd_Mng_movieposter: TThreadManager;
    Thrd_Mng_moviebanner: TThreadManager;
    moviebanner, movieposter, hdmovielogo: Tstringlist;

    hdmovielogo_count, moviebanner_count, movieposter_count,
      hdmovielogo_tot_count, moviebanner_tot_count,
      movieposter_tot_count: integer;
    FService: string;

    procedure After_Thread_Search_FanArt(str: string);
    procedure After_Thread_Search_TheMoviedB(str: string);
    procedure After_thread_Manager_hdmovielogo;
    procedure After_thread_Manager_movieposter;
    procedure After_thread_Manager_moviebanner;

    procedure After_Thread_Image_hdmovielogo(img: TJPEGImage);
    procedure After_Thread_Image_movieposter(img: TJPEGImage);
    procedure After_Thread_Image_moviebanner(img: TJPEGImage);
    procedure clickimg(Sender: TObject);

    constructor create_Param(AOwner: TComponent; param: string);

  end;

var
  Poster_Frm: TPoster_Frm;

const
  fanart_API_key = '290fc646d21781416de3274019879458';

implementation

uses

  JRScrap_Unit, TheMoviedB_Unit;

{$R *.dfm}

constructor TPoster_Frm.create_Param(AOwner: TComponent; param: string);
begin
  inherited Create(AOwner);
  FService := param ;
end;

procedure TPoster_Frm.FormActivate(Sender: TObject);
var
  rq: string;
begin

  self.Top := JRScrap_frm.Top + round((JRScrap_frm.Height - self.Height) / 2);
  self.Left := JRScrap_frm.Left + round((JRScrap_frm.Width - self.Width) / 2);

  self.Status_Lbl.Caption := Translate_String_JRStyle('Searching ...',
    JRScrap_frm.FCurrentLang);
  self.Close.Caption := Translate_String_JRStyle('Close',
    JRScrap_frm.FCurrentLang);

  moviebanner := Tstringlist.Create;
  movieposter := Tstringlist.Create;
  hdmovielogo := Tstringlist.Create;

  hdmovielogo_count := 0;
  moviebanner_count := 0;
  movieposter_count := 0;

  if FService = 'FanArt' then
  begin
    id := FCurrentMovie.Get('IMDb ID', true);
    if id = emptystr then
    begin
      id := FCurrentMovie.Get('TMDB ID', true);
    end;

    if id = emptystr then
    begin

    end
    else
    begin
      rq := 'http://webservice.fanart.tv/v3/movies/' + id + '?api_key=' +
        fanart_API_key;

      try
        Thrd_Search := TThreadsearch.Create(nil, Tcod.ansi, rq,
          After_Thread_Search_FanArt);
      except
        screen.cursor := crdefault;
        JRScrap_frm.logger.error('Error: Error for this request');
      end;
      application.ProcessMessages;

    end;
  end;

  if FService = 'TheMoviedB' then
  begin
    rq := 'https://api.themoviedb.org/3/movie/' + FCurrentMovie.Get('TMDB ID',
      true) + '/images?api_key=' + TheMoviedB_APIkey + '&language=' +
      JRScrap_frm.FCurrentLangShort + '&include_image_language=en,' +
      JRScrap_frm.FCurrentLangShort;

    try
      Thrd_Search := TThreadsearch.Create(nil, Tcod.ansi, rq,
        After_Thread_Search_TheMoviedB);
    except
      screen.cursor := crdefault;
      JRScrap_frm.logger.error('Error: Error for this request');
    end;
    application.ProcessMessages;

  end;

end;

procedure TPoster_Frm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  screen.cursor := crdefault;
  modalresult := mrok;
end;

procedure TPoster_Frm.clickimg(Sender: TObject);
begin
  try
    JRScrap_frm.Picture_Img.Picture.Assign((Sender as Timage).Picture.Graphic);
    JRScrap_frm.Write_Btn.Enabled := true;
  except

  end;
end;

procedure TPoster_Frm.CloseClick(Sender: TObject);
begin
  modalresult := mrok;
end;

procedure TPoster_Frm.After_Thread_Image_movieposter(img: TJPEGImage);
const
  offset = 5;
  fontheigth = 18;
var
  image: Timage;
  panel: TCyPanel;
  lbl: TLabel;
begin
  try

    lbl := TLabel.Create(self);
    panel := TCyPanel.Create(self);
    image := Timage.Create(self);

    lbl.Caption := inttostr(img.Width) + ' X ' + inttostr(img.Height);

    image.Height := 240;
    image.Width := round(img.Width * image.Height / img.Height);

    panel.Height := image.Height + fontheigth + 2 * offset;
    panel.Width := image.Width + 2 * offset;

    image.Stretch := true;
    image.Parent := panel;
    image.Anchors := [akTop, akLeft];
    image.Left := offset;
    image.Top := offset;
    image.Picture.Assign(img);

    panel.Parent := self.ScrollBox1;
    panel.Align := alright;

    lbl.Parent := panel;
    lbl.Top := image.Height + 2 * offset;
    lbl.Left := 0;
    lbl.Width := panel.Width;
    lbl.Alignment := taCenter;
    lbl.Font.Size := 8;

    image.OnClick := clickimg;
    panel.OnClick := clickimg;

  except
  end;

  inc(moviebanner_count);
  debug('moviebanner_count :' + inttostr(moviebanner_count) + '/' +
    inttostr(moviebanner_tot_count));

end;

procedure TPoster_Frm.After_Thread_Image_moviebanner(img: TJPEGImage);
begin
  inc(movieposter_count);
  debug('moviebanner_count :' + inttostr(moviebanner_count) + '/' +
    inttostr(moviebanner_tot_count));
end;

procedure TPoster_Frm.After_Thread_Image_hdmovielogo(img: TJPEGImage);
begin
  inc(hdmovielogo_count);
  debug('hdmovielogo_count :' + inttostr(moviebanner_count) + '/' +
    inttostr(moviebanner_tot_count));
end;

procedure TPoster_Frm.After_thread_Manager_hdmovielogo;
begin
  screen.cursor := crdefault;
end;

procedure TPoster_Frm.After_thread_Manager_movieposter;
begin
  screen.cursor := crdefault;
  self.Status_Lbl.Caption := Translate_String_JRStyle('OK',
    JRScrap_frm.FCurrentLang);
end;

procedure TPoster_Frm.After_thread_Manager_moviebanner;
begin
  screen.cursor := crdefault;
end;

procedure TPoster_Frm.After_Thread_Search_TheMoviedB(str: string);
var
  FJSonReader: TlkJSONobject;
  i: integer;
begin
  debug(str);

   if str = emptystr then
    begin
      showmessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_frm.FCurrentLang));
      screen.cursor := crdefault;
     modalresult := mrok;
       exit ;
    end;

  try
    FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
  except
    JRScrap_frm.cursor := crdefault;
    JRScrap_frm.logger.error('Error: Parsing');
    debug('error');
  end;

  try

    if ((FJSonReader.Field['posters'] as TlkJSONList).Count <> 0) then
    begin
      for i := 0 to (FJSonReader.Field['posters'] as TlkJSONList).Count - 1 do
      begin
        movieposter.Add((((FJSonReader.Field['posters'] as TlkJSONList)
          .child[i] as TlkJSONobject).Field['file_path'].value));
      end;
    end;

    if movieposter.Count = 0 then
    begin
      showmessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_frm.FCurrentLang));
      screen.cursor := crdefault;
      modalresult := mrok;
    end;

    Thrd_Mng_movieposter := TThreadManager.Create
      (After_thread_Manager_movieposter);

    for i := 0 to movieposter.Count - 1 do
    begin
      str := 'http://image.tmdb.org/t/p/w500' + movieposter[i];
      debug(str);
      Thrd_Mng_movieposter.Addthread(str, self.After_Thread_Image_movieposter);
    end;

    Thrd_Mng_movieposter.Resume;

  except

  end;

end;

procedure TPoster_Frm.After_Thread_Search_FanArt(str: string);
var
  FJSonReader: TlkJSONobject;
  i: integer;
  img_Count: integer;
begin
  debug(str);

  if str = emptystr then
    begin
      showmessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_frm.FCurrentLang));
      screen.cursor := crdefault;
      modalresult := mrok;
      exit ;
    end;

  if FService = 'FanArt' then
  begin
    try
      FJSonReader := TlkJSON.ParseText(str) as TlkJSONobject;
    except
      JRScrap_frm.cursor := crdefault;
      JRScrap_frm.logger.error('Error: Parsing');
      debug('error');
    end;

    try
      if ((FJSonReader.Field['hdmovielogo'] as TlkJSONList).Count <> 0) then
      begin
        for i := 0 to (FJSonReader.Field['hdmovielogo'] as TlkJSONList)
          .Count - 1 do
        begin
          hdmovielogo.Add((((FJSonReader.Field['hdmovielogo'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['url'].value));
        end;
      end;
    except

    end;

    try
      if ((FJSonReader.Field['movieposter'] as TlkJSONList).Count <> 0) then
      begin
        for i := 0 to (FJSonReader.Field['movieposter'] as TlkJSONList)
          .Count - 1 do
        begin
          movieposter.Add((((FJSonReader.Field['movieposter'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['url'].value));
        end;
      end;
    except

    end;

    try
      if ((FJSonReader.Field['moviebanner'] as TlkJSONList).Count <> 0) then
      begin
        for i := 0 to (FJSonReader.Field['moviebanner'] as TlkJSONList)
          .Count - 1 do
        begin
          moviebanner.Add((((FJSonReader.Field['moviebanner'] as TlkJSONList)
            .child[i] as TlkJSONobject).Field['url'].value));
        end;
      end;
    except

    end;

    hdmovielogo_tot_count := hdmovielogo.Count;
    moviebanner_tot_count := moviebanner.Count;
    movieposter_tot_count := movieposter.Count;

    if movieposter_tot_count = 0 then
    begin
      showmessage(Translate_String_JRStyle('No results for this search !',
        JRScrap_frm.FCurrentLang));
      screen.cursor := crdefault;
      modalresult := mrok;
    end;

    // Thrd_Mng_hdmovielogo   := TThreadManager.Create(After_thread_Manager_hdmovielogo);
    Thrd_Mng_movieposter := TThreadManager.Create
      (After_thread_Manager_movieposter);
    // Thrd_Mng_moviebanner := TThreadManager.Create(After_thread_Manager_moviebanner);

    for i := 0 to hdmovielogo.Count - 1 do
    begin
      // Thrd_Mng_hdmovielogo.Addthread(hdmovielogo[i], self.After_Thread_Image_hdmovielogo);
    end;

    for i := 0 to movieposter.Count - 1 do
    begin
      Thrd_Mng_movieposter.Addthread(movieposter[i],
        self.After_Thread_Image_movieposter);
    end;

    for i := 0 to moviebanner.Count - 1 do
    begin
      // Thrd_Mng_moviebanner.Addthread(moviebanner[i], self.After_Thread_Image_moviebanner);
    end;

    // Thrd_Mng_hdmovielogo.Resume;
    Thrd_Mng_movieposter.Resume;
    // Thrd_Mng_moviebanner.Resume;
  end;

end;

end.
