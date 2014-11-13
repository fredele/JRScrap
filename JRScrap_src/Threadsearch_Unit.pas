unit Threadsearch_Unit;

interface

uses
  Winapi.Windows, System.Classes, dialogs, IdBaseComponent, IdComponent,
  Utils_Unit,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL, Types_Unit, jpeg,
  debug_Unit;

type

  TThreadsearch = class(TThread)
  private
    FProcedureStr: TProcedureStr;
    Fquery, FParseText: string;
    Fs: TMemoryStream;
    LHandler: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TidHTTP;
    FTerminated: boolean;
    Fcod: Tcod;
    FTM: Tobject;
  public
    constructor Create(TM: Tobject; coding: Tcod; query: string;
      Proc: TProcedureStr);
    destructor Destroy; override;
    property TextToParse: string read FParseText;
    property terminated: boolean read FTerminated write FTerminated;
  protected
    procedure Execute; override;

  end;

  TThreadsearch_Image = class(TThread)

  private
    FTM: Tobject;
    FProcedureImg: TProcedureImg;
    Fquery: string;
    Fs: TMemoryStream;
    LHandler: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TidHTTP;
  public
  var
    jpeg: TJPEGImage;
    FTerminated: boolean;

    constructor Create(TM: Tobject; query: string;
      ProcImg: TProcedureImg); overload;
    destructor Destroy; override;
    property Image: TJPEGImage read jpeg;
    property terminated: boolean read FTerminated;

  protected
    procedure Execute; override;

  end;

implementation

uses
  JRScrap_Unit,
  ThreadManager_Unit;

/// ////////////  TThreadsearch

destructor TThreadsearch.Destroy;
begin
  inherited;
end;

constructor TThreadsearch.Create(TM: Tobject; coding: Tcod; query: string;
  Proc: TProcedureStr);
begin
  inherited Create(True);
  FTM := TM;
  FTerminated := False;
  Fquery := query;
  FProcedureStr := Proc;
  Fcod := coding;
  Fs := TMemoryStream.Create;
  IdHTTP1 := TidHTTP.Create;
  if not assigned(TM) then
    resume;

end;

procedure TThreadsearch.Execute;
begin

  JRScrap_frm.StatusLed.LedValue := true ;
  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHTTP1.IOHandler := LHandler;
  debug(Fquery);
  IdHTTP1.get(Fquery, Fs);
  if Fcod = Tcod.ansi then
    FParseText := MemoryStreamToString2(Fs);
  if Fcod = Tcod.utf8 then
    FParseText := MemoryStreamToString1(Fs);
   JRScrap_frm.StatusLed.LedValue := false ;
  Synchronize(
    procedure
    begin
      FProcedureStr(FParseText);
    end);

  Synchronize(
    procedure
    begin
      (FTM as TThreadManager).IncFActualthreadCompleted;
    end);

  // waits   FProcedure to finish ..
  FTerminated := True;

  Fs.Free;
  Terminate;
end;

/// ////////////  TThreadsearch_Image

destructor TThreadsearch_Image.Destroy;
begin
  inherited;
end;

constructor TThreadsearch_Image.Create(TM: Tobject; query: string;
ProcImg: TProcedureImg);
begin
  inherited Create(True);
  FTM := TM;
  jpeg := TJPEGImage.Create;
  FTerminated := False;
  FProcedureImg := ProcImg;
  Fquery := query;
  FProcedureImg := ProcImg;
  Fs := TMemoryStream.Create;
  IdHTTP1 := TidHTTP.Create;
  if not assigned(TM) then
    resume;
end;

procedure TThreadsearch_Image.Execute;
begin
  // FreeOnTerminate := True;
  try
    JRScrap_frm.StatusLed.LedValue := true ;
    LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdHTTP1.get(Fquery, Fs);
    Fs.Seek(0, soFromBeginning);
    jpeg.LoadFromStream(Fs);
     JRScrap_frm.StatusLed.LedValue := false ;
  except

  end;

  Synchronize(
    procedure
    begin
      FProcedureImg(jpeg);
    end);

  Synchronize(
    procedure
    begin
      (FTM as TThreadManager).IncFActualthreadCompleted;

    end);
  FTerminated := True;
  Fs.Free;
  jpeg.Free;
  Terminate;
end;

end.
