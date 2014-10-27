unit Threadsearch_Image;

interface

uses
  System.Classes, dialogs,IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL,
   jpeg;

type
  TProcedure = procedure  of object;
  TThreadsearch_Image = class(TThread)
private
    FProcedure  : TProcedure  ;
    Fquery : string ;
    Fs : TMemoryStream ;
    LHandler : TIdSSLIOHandlerSocketOpenSSL   ;
    IdHTTP1 : TidHTTP ;
public
var
    JPEG : TJPEGImage ;
    constructor Create(query: string ; Proc : TProcedure);
    destructor Destroy; override;
    property Image : TJPEGImage read JPEG ;

  protected
    procedure Execute; override;

  end;

implementation
  uses
  Themoviedb_Frm;

function MemoryStreamToString(M: TMemoryStream): AnsiString;
begin
  SetString(Result, PAnsiChar(M.Memory), M.Size);
end;

destructor TThreadsearch_Image.Destroy;
begin
  inherited;
end;

constructor TThreadsearch_Image.Create(query: string ;Proc : TProcedure);
begin
  inherited Create(True);
  Fquery := query;
  FProcedure := Proc ;
  Fs := TMemoryStream.Create;
  IdHTTP1 := TidHTTP.Create;
  Resume ;

  JPEG := TJPEGImage.Create;








end;

procedure TThreadsearch_Image.Execute;
begin

 try
    LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    idHTTP1.get(Fquery, Fs);
    Fs.Seek(0, soFromBeginning);
    JPEG.LoadFromStream(Fs);
      if JPEG <> nil
  then
  ThemoviedB.Picture_Img.Picture.Assign(JPEG);


  except

 end;

  Fs.Free;
  JPEG.Free;
  LHandler.Free;
   synchronize(FProcedure );
   Terminate;
end;


end.

