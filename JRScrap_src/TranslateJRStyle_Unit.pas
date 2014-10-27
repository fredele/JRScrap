unit TranslateJRStyle_Unit;

interface
uses

  Vcl.Menus, Vcl.StdCtrls,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Classes,
  System.SysUtils, System.Variants,Vcl.Forms,
   mystringutil,myFileUnit, IOUtils, JPEG,Vcl.CheckLst,
  Types_Unit,  StrUtils
   ;
 var
    FTranslateList: TStringList;
    TranslateArray: array of TTranslate;

 function TranslateJRStyle(lang: string; UnRevert: Boolean) : string ;
// function Translate (str : string) : string ;
 procedure SetTranslateList ;
implementation

procedure SetTranslateList ;
begin
  FTranslateList := TStringList.Create;
  FTranslateList.Add('Done !'); // 0
  FTranslateList.Add('Enter Key');
  FTranslateList.Add('Please enter your API key :'); // 2
  FTranslateList.Add('Check the Fields and hit Write');
  FTranslateList.Add('Select the Movie you want and hit Get and view');
  FTranslateList.Add('Check the Fields and hit Write'); // 5
  FTranslateList.Add('Enter a value');
  FTranslateList.Add('Enter a Movie Name !'); // 7
  FTranslateList.Add('Please enter a valid API key !'); // 8
  FTranslateList.Add('Cannot process multiple files for now'); // 9
  FTranslateList.Add('No results for this search !'); // 10
  FTranslateList.Add('No Movie selected !'); // 11
  FTranslateList.Add('This is not a Movie !'); // 12
  FTranslateList.Add('No Movie available !'); // 13
  FTranslateList.Add('IMDB Id does not begin with tt !'); // 14
  FTranslateList.Add('New Fields created !'); // 15
  FTranslateList.Add('Media :'); // 16
  FTranslateList.Add('Progress :'); // 17
  FTranslateList.Add('File locked !'); // 18
  FTranslateList.Add('Date Imported'); // 19
  FTranslateList.Add('IMDB ID'); // 20
  FTranslateList.Add('Overview'); // 21
  FTranslateList.Add('Lock'); // 22
  FTranslateList.Add('Name'); // 23
  FTranslateList.Add('Scrap first Media found if API ID is missing'); // 24
  FTranslateList.Add('Filename'); // 25
  FTranslateList.Add('No Movie Found !' ); // 26
  FTranslateList.Add('Picture' ); // 27
  FTranslateList.Add('Title' ); // 28
  FTranslateList.Add('Original Title' ); // 29
  FTranslateList.Add('release date' ); // 30
  FTranslateList.Add('imdb id' ); // 31
  FTranslateList.Add('Overview'  ); // 32
  FTranslateList.Add('Vote Average'  ); // 33
  FTranslateList.Add('Production Company'  ); // 34
  FTranslateList.Add('Genres'   ); // 35
  FTranslateList.Add('Keywords'  ); // 36
  FTranslateList.Add('Cast'  ); // 37
  FTranslateList.Add('Crew' ); // 38
  FTranslateList.Add('Select here fields to save :' ); // 39
  FTranslateList.Add('File Downloaded !' ); // 40
  end;
 {
  function Translate (str : string) : string ;
  var
   i : integer ;
   found : boolean ;
  begin

    for i := 0 to length(TranslateArray) - 1 do
    begin
      if TranslateArray[i].original = str then
      begin
      result:= TranslateArray[i].translate ;
      found := true ;
      end;
    end;
    if found = false then
    begin
      result := str ;
    end;

  end;
}

 function TranslateJRStyle(lang: string; UnRevert: Boolean): string ;
var
  i, j, k , l: Integer;
  capt, filelang, lineoriginal, linetranslate: string;
  myFile: TextFile;
begin
  if lang = 'English' then
    Exit; // Do not translate from English

  filelang := ExtractFilePath(Application.ExeName) + '\..\languages\' + lang + '.txt';
  if not Fileexists(filelang) then
    Exit;
  // Opens the file
  AssignFile(myFile, filelang);
  Reset(myFile);

  // Fill  TranslateArray
  while not Eof(myFile) do
  begin
    ReadLn(myFile, lineoriginal);

    if (Leftstr(lineoriginal, 2) <> '//') and (lineoriginal <> '') then
    begin
      ReadLn(myFile, linetranslate);
      setlength(TranslateArray, length(TranslateArray) + 1);
      if UnRevert = false then
      begin
        TranslateArray[length(TranslateArray) - 1].original := lineoriginal;
        TranslateArray[length(TranslateArray) - 1].translate := linetranslate;
      end
      else
      begin
        TranslateArray[length(TranslateArray) - 1].original := linetranslate;
        TranslateArray[length(TranslateArray) - 1].translate := lineoriginal;
      end;
    end;

  end;
  CloseFile(myFile);

  // Get all components and translate them

  for i := 0 to Application.ComponentCount - 1 do
  begin
    for j := 0 to Application.Components[i].ComponentCount - 1 do
    begin

      if Application.Components[i].Components[j].InheritsFrom(TLabel) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          capt := (Application.Components[i].Components[j] as TLabel).Caption;
          if (Application.Components[i].Components[j] as TLabel)
            .Caption = TranslateArray[k].original then
          begin

            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (Application.Components[i].Components[j] as TLabel).Caption := capt;
          end;
        end;
      end;


      if Application.Components[i].Components[j].InheritsFrom(TCheckListbox) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
           for l := 0 to (Application.Components[i].Components[j] as TCheckListbox).Items.Count - 1 do
        begin

          capt := (Application.Components[i].Components[j] as TCheckListbox).items[l];
          if capt = TranslateArray[k].original then
          begin

            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (Application.Components[i].Components[j] as TCheckListbox).items[l] := capt;
           end;
          end;
        end;
      end;


      if Application.Components[i].Components[j].InheritsFrom(TRadioButton) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (Application.Components[i].Components[j] as TRadioButton)
            .Caption = TranslateArray[k].original then
          begin
            capt := (Application.Components[i].Components[j]
              as TRadioButton).Caption;

            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (Application.Components[i].Components[j] as TRadioButton)
              .Caption := capt;
          end;
        end;
      end;

      if Application.Components[i].Components[j].InheritsFrom(TCheckBox) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (Application.Components[i].Components[j] as TCheckBox)
            .Caption = TranslateArray[k].original then
          begin
            capt := (Application.Components[i].Components[j]
              as TCheckBox).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (Application.Components[i].Components[j] as TCheckBox)
              .Caption := capt;
          end;
        end;
      end;

      if Application.Components[i].Components[j].InheritsFrom(TPanel) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (Application.Components[i].Components[j] as TPanel)
            .Caption = TranslateArray[k].original then
          begin

            capt := (Application.Components[i].Components[j] as TPanel).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (Application.Components[i].Components[j] as TPanel).Caption := capt;
          end;
        end;
      end;

      if Application.Components[i].Components[j].InheritsFrom(TMenuItem) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (Application.Components[i].Components[j] as TMenuItem)
            .Caption = TranslateArray[k].original then
          begin
            capt := (Application.Components[i].Components[j]
              as TMenuItem).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (Application.Components[i].Components[j] as TMenuItem)
              .Caption := capt;
          end;
        end;
      end;

      if Application.Components[i].Components[j].InheritsFrom(TButton) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (Application.Components[i].Components[j] as TButton)
            .Caption = TranslateArray[k].original then
          begin
            capt := (Application.Components[i].Components[j]
              as TButton).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (Application.Components[i].Components[j] as TButton)
              .Caption := capt;
          end;
        end;
      end;

      if Application.Components[i].Components[j].InheritsFrom(TTabSheet) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (Application.Components[i].Components[j] as TTabSheet)
            .Caption = TranslateArray[k].original then
          begin
            capt := (Application.Components[i].Components[j]
              as TTabSheet).Caption;
            if trim(capt) = trim(TranslateArray[k].original) then
            begin
              capt := StringReplace(capt, trim(TranslateArray[k].original),
                trim(TranslateArray[k].translate),
                [rfReplaceAll, rfIgnoreCase]);
              (Application.Components[i].Components[j] as TTabSheet)
                .Caption := capt;
            end;
          end;
        end;

      end;

    end;
  end;

  // Translate FTranslateList
  for i := 0 to FTranslateList.Count - 1 do
  begin

    for j := 0 to length(TranslateArray) - 1 do
    begin
      if FTranslateList[i] = TranslateArray[j].original then
      begin
        FTranslateList[i] := TranslateArray[j].translate;
      end;
    end;
  end;
    Result := lang ;
  Finalize(TranslateArray);
end;


end.
