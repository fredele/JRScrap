unit Threadsearch;

interface

uses
   Winapi.Windows,System.Classes, dialogs,IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL,Types_Unit;

type
  TProcedure = procedure  of object;
  TThreadsearch = class(TThread)
private
    FProcedure  : TProcedure  ;
    Fquery,FParseText : string ;
    Fs : TMemoryStream ;
    LHandler : TIdSSLIOHandlerSocketOpenSSL   ;
    IdHTTP1 : TidHTTP ;
    FTerminated : boolean ;
    Fcod : Tcod ;
public
    constructor Create(coding : Tcod ; query: string ; Proc : TProcedure);
    destructor Destroy; override;
    property TextToParse : string read FParseText ;
    property terminated : boolean read  FTerminated write FTerminated ;
  protected
    procedure Execute; override;

  end;

implementation


function MemoryStreamToString1(M: TMemoryStream): AnsiString;
var
  SS: TStringStream;
begin
  if M <> nil then
  begin
    SS := TStringStream.Create('',CP_UTF8);//here did not suffice in the second parameter CP_UTF8
    try
      SS.CopyFrom (M, 0);
      Result := SS.DataString;
    finally
      SS.Free;
    end;
  end else
  begin
    Result := '';
  end;
end;

function MemoryStreamToString2(M: TMemoryStream): AnsiString;
begin
  SetString(Result, PAnsiChar(M.Memory), M.Size);
end;

destructor TThreadsearch.Destroy;
begin
  inherited;
end;

constructor TThreadsearch.Create(coding : Tcod ; query: string ; Proc : TProcedure);
begin
  inherited Create(True);
  FTerminated := False ;
  Fquery := query;
  FProcedure := Proc ;
  Fcod  :=   coding ;
  Fs := TMemoryStream.Create;
  IdHTTP1 := TidHTTP.Create;
  Resume ;

end;

procedure TThreadsearch.Execute;
begin

 try
    LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdHTTP1.IOHandler := LHandler;
    IdHTTP1.get(Fquery, Fs);
    if Fcod = Tcod.ansi then
    FParseText := MemoryStreamToString2(Fs);
    if Fcod = Tcod.utf8 then
    FParseText := MemoryStreamToString1(Fs);

  except

 end;

  Fs.Free;
  LHandler.Free;
   synchronize(FProcedure );
   FTerminated := True ;
   Terminate;
end;


end.
