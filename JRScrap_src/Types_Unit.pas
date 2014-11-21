unit Types_Unit;

interface

uses
  jpeg;

type
  TProcedureStrObj = procedure(str: string) of object;
  TProcedureImg = procedure(img: TJPEGImage) of object;
  TProcedureStr = procedure (str: string);

  TProcedureObj = procedure of object;
  TProcedure = procedure ;

type

  TMessageData = class
    UneChaine: string;
  end;

type

  TPerson = record
    Actor_Name: string;
    Character: string;
    id: integer;
  end;

  TLang = record
    Language: string;
    Search: string;
  end;

  TTranslate = record
    original: string;
    translate: string;
  end;

  TCopyDataType = (cdtString = 0, cdtImage = 1, cdtRecord = 2);

  TFilm = record
    name: string;
    filename: string;
  end;

  TMedia = record
    API_Id: integer;
    name: string;
    release_date: string;
  end;

  TCod = (ansi, utf8);

type

  TString = class
  private
    Fstr: string;
    procedure W_proc(str: string);
    property str: string read Fstr write W_proc;
  end;

implementation

procedure TString.W_proc(str: string);
begin
  Fstr := str;

end;

end.
