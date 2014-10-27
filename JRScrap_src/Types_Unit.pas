unit Types_Unit;

interface
type

  TMessageData = class
    UneChaine: string;
  end;

type
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

  TCod =( ansi, utf8) ;
implementation

end.
