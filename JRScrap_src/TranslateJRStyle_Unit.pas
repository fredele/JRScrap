unit TranslateJRStyle_Unit;

interface

uses

  Vcl.Menus, Vcl.StdCtrls,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, System.Classes,
  System.SysUtils, System.Variants, Vcl.Forms,
  mystringutil, File_Unit, IOUtils, JPEG, Vcl.CheckLst,
  Types_Unit, StrUtils, debug_Unit, MediaCenter_TLB ;

var

  TranslateArray: array of TTranslate;

function TranslateJRStyle(lang: string; UnRevert: Boolean): string;
function Translate_String_JRStyle(ENGStrToTranslate: string;
  lang: string): string;
procedure readfile(UnRevert: Boolean; lfile: string);

implementation

uses
  JRScrap_Unit;



function Translate_String_JRStyle(ENGStrToTranslate: string;
  lang: string): string;
var
  k: Integer;
  filelang: string;
begin
  result := ENGStrToTranslate;

  if length(TranslateArray) = 0 then
    Exit;

  if lang = 'English' then
    result := ENGStrToTranslate;

  if lang <> 'English' then
  begin

    for k := 0 to length(TranslateArray) - 1 do
    begin
      if ENGStrToTranslate = TranslateArray[k].original then
        result := TranslateArray[k].translate;
    end;
  end;

  application.ProcessMessages;

end;

procedure readfile(UnRevert: Boolean; lfile: string);
var
  i, j: Integer;
  lineoriginal, linetranslate: string;

  S: TStrings;
begin
  S := TStringList.Create();
  // DO NOT USE system.Textfile !! Unicode or ANSI supported this way !
  if not Fileexists(lfile) then
    Exit;

  S.LoadFromFile(lfile);
  // Fill  TranslateArray
  debug(S.Count);
  i := 0;
  while i < S.Count - 2 do
  begin
    lineoriginal := S[i];
    Inc(i);

    if not((Leftstr(lineoriginal, 1) = '#') or (Leftstr(lineoriginal, 2) = '//'))
    then
    begin
      if (lineoriginal <> '') then
      begin
        linetranslate := S[i];
        Inc(i);
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

  end;

  S.Free;

end;

function TranslateJRStyle(lang: string; UnRevert: Boolean): string;
var
  i, j, k, l: Integer;
  capt, filelang, lineoriginal, linetranslate: string;
  myFile: TextFile;
begin

  filelang := ExtractFilePath(application.ExeName) + '\..\languages\' +
    lang + '.txt';
  readfile(UnRevert, filelang);

  JRScrap_Frm.Movie_Browser.Cells[5, 0] :=
    Translate_String_JRStyle('Name', lang);
  JRScrap_Frm.Movie_Browser.Cells[8, 0] :=
    Translate_String_JRStyle('Lock', lang);
  JRScrap_Frm.Movie_Browser.Cells[9, 0] :=
    Translate_String_JRStyle('Date Imported', lang);
  JRScrap_Frm.Movie_Browser.Cells[11, 0] :=
    Translate_String_JRStyle('Overview', lang);
  JRScrap_Frm.Movie_Browser.Cells[12, 0] :=
    Translate_String_JRStyle('Filename', lang);

  for i := 0 to application.ComponentCount - 1 do
  begin
    for j := 0 to application.Components[i].ComponentCount - 1 do
    begin

      if application.Components[i].Components[j].InheritsFrom(TLabel) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          capt := (application.Components[i].Components[j] as TLabel).Caption;
          if (application.Components[i].Components[j] as TLabel)
            .Caption = TranslateArray[k].original then
          begin

            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (application.Components[i].Components[j] as TLabel).Caption := capt;
          end;
        end;
      end;

      if application.Components[i].Components[j].InheritsFrom(TCheckListbox)
      then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          for l := 0 to (application.Components[i].Components[j]
            as TCheckListbox).Items.Count - 1 do
          begin

            capt := (application.Components[i].Components[j]
              as TCheckListbox).Items[l];
            if capt = TranslateArray[k].original then
            begin

              capt := StringReplace(capt, TranslateArray[k].original,
                TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
              (application.Components[i].Components[j] as TCheckListbox)
                .Items[l] := capt;
            end;
          end;
        end;
      end;

      if application.Components[i].Components[j].InheritsFrom(TRadioButton) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (application.Components[i].Components[j] as TRadioButton)
            .Caption = TranslateArray[k].original then
          begin
            capt := (application.Components[i].Components[j]
              as TRadioButton).Caption;

            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (application.Components[i].Components[j] as TRadioButton)
              .Caption := capt;
          end;
        end;
      end;

      if application.Components[i].Components[j].InheritsFrom(TCheckBox) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (application.Components[i].Components[j] as TCheckBox)
            .Caption = TranslateArray[k].original then
          begin
            capt := (application.Components[i].Components[j]
              as TCheckBox).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (application.Components[i].Components[j] as TCheckBox)
              .Caption := capt;
          end;
        end;
      end;

      if application.Components[i].Components[j].InheritsFrom(TPanel) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (application.Components[i].Components[j] as TPanel)
            .Caption = TranslateArray[k].original then
          begin

            capt := (application.Components[i].Components[j] as TPanel).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (application.Components[i].Components[j] as TPanel).Caption := capt;
          end;
        end;
      end;

      if application.Components[i].Components[j].InheritsFrom(TMenuItem) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (application.Components[i].Components[j] as TMenuItem)
            .Caption = TranslateArray[k].original then
          begin
            capt := (application.Components[i].Components[j]
              as TMenuItem).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (application.Components[i].Components[j] as TMenuItem)
              .Caption := capt;
          end;
        end;
      end;

      if application.Components[i].Components[j].InheritsFrom(TButton) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (application.Components[i].Components[j] as TButton)
            .Caption = TranslateArray[k].original then
          begin
            capt := (application.Components[i].Components[j]
              as TButton).Caption;
            capt := StringReplace(capt, TranslateArray[k].original,
              TranslateArray[k].translate, [rfReplaceAll, rfIgnoreCase]);
            (application.Components[i].Components[j] as TButton)
              .Caption := capt;
          end;
        end;
      end;

      if application.Components[i].Components[j].InheritsFrom(TTabSheet) then
      begin
        for k := 0 to length(TranslateArray) - 1 do
        begin
          if (application.Components[i].Components[j] as TTabSheet)
            .Caption = TranslateArray[k].original then
          begin
            capt := (application.Components[i].Components[j]
              as TTabSheet).Caption;
            if trim(capt) = trim(TranslateArray[k].original) then
            begin
              capt := StringReplace(capt, trim(TranslateArray[k].original),
                trim(TranslateArray[k].translate),
                [rfReplaceAll, rfIgnoreCase]);
              (application.Components[i].Components[j] as TTabSheet)
                .Caption := capt;
            end;
          end;
        end;

      end;

      /// //////
    end;
  end;
  result := lang;
end;

end.
