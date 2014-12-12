// This file is part of the JRScrap project.

// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

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
    FProcedureStrobj: TProcedureStrobj;
    Fquery, FParseText: string;
    Fs: TMemoryStream;
    LHandler: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP1: TidHTTP;
    FTerminated: boolean;
    Fcod: Tcod;
    FUserAgent: string;
    FTM: Tobject;
    procedure Set_Useragent(ua: string);

  public

    constructor Create(TM: Tobject; coding: Tcod; query: string;
      Proc: TProcedureStr); overload;
    constructor Create(TM: Tobject; coding: Tcod; query: string;
      Proc: TProcedureStrobj); overload;

    constructor Create(TM: Tobject; ua: string; coding: Tcod; query: string;
      Proc: TProcedureStr); overload;
    constructor Create(TM: Tobject; ua: string; coding: Tcod; query: string;
      Proc: TProcedureStrobj); overload;

    destructor Destroy; override;

    property TextToParse: string read FParseText;
    property terminated: boolean read FTerminated write FTerminated;
    property Useragent: string read FUserAgent write Set_Useragent;
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
  FParseText := '';
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

constructor TThreadsearch.Create(TM: Tobject; coding: Tcod; query: string;
  Proc: TProcedureStrobj);
begin
  inherited Create(True);
  FParseText := '';
  FTM := TM;
  FTerminated := False;
  Fquery := query;
  FProcedureStrobj := Proc;
  Fcod := coding;
  Fs := TMemoryStream.Create;
  IdHTTP1 := TidHTTP.Create;
  if not assigned(TM) then
    resume;

end;

constructor TThreadsearch.Create(TM: Tobject; ua: string; coding: Tcod;
  query: string; Proc: TProcedureStr);
begin
  inherited Create(True);
  FUserAgent := ua;
  FParseText := '';
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

constructor TThreadsearch.Create(TM: Tobject; ua: string; coding: Tcod;
  query: string; Proc: TProcedureStrobj);
begin
  inherited Create(True);
  FUserAgent := ua;
  FParseText := '';
  FTM := TM;
  FTerminated := False;
  Fquery := query;
  FProcedureStrobj := Proc;
  Fcod := coding;
  Fs := TMemoryStream.Create;
  IdHTTP1 := TidHTTP.Create;
  if not assigned(TM) then
    resume;

end;

procedure TThreadsearch.Set_Useragent(ua: string);
begin
  self.FUserAgent := ua;
end;

procedure TThreadsearch.Execute;
begin

  JRScrap_frm.StatusLed.LedValue := True;
  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHTTP1.IOHandler := LHandler;

  try

    if FUserAgent <> '' then
      IdHTTP1.Request.Useragent := FUserAgent;

    IdHTTP1.get(Fquery, Fs);
  except
    debug('Error : IdHTTP get');
    FTerminated := True;
    Fs.Free;
    Terminate;
  end;
  try
    if Fcod = Tcod.ansi then
      FParseText := MemoryStreamToString2(Fs);
    if Fcod = Tcod.utf8 then
      FParseText := MemoryStreamToString1(Fs);
  except

  end;

  JRScrap_frm.StatusLed.LedValue := False;

  if assigned(FProcedureStr) then
  begin
    Synchronize(
      procedure
      begin
        FProcedureStr(FParseText);
      end);
  end;

  if assigned(FProcedureStrobj) then
  begin
    Synchronize(
      procedure
      begin
        FProcedureStrobj(FParseText);
      end);
  end;

  if assigned(FTM) then
  begin
    Synchronize(
      procedure
      begin
        (FTM as TThreadManager).IncFActualthreadCompleted;
      end);
  end;

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
    JRScrap_frm.StatusLed.LedValue := True;
    LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    debug(Fquery);
    IdHTTP1.get(Fquery, Fs);
    Fs.Seek(0, soFromBeginning);
    jpeg.LoadFromStream(Fs);
    JRScrap_frm.StatusLed.LedValue := False;
  except
    debug('Error getting image ! ');

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
