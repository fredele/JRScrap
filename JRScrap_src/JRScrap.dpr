program JRScrap;



uses
  TConfiguratorUnit,
  MassScrap_Frm in 'MassScrap_Frm.pas' {Form3},
  OpenSub_Unit in 'OpenSub_Unit.pas' {OpenSub_Form},
  Dialogs,
  Vcl.Forms,
  Themoviedb_Frm in 'Themoviedb_Frm.pas' {Themoviedb},
  Vcl.Themes,
  Vcl.Styles,
  Winapi.Windows,
  Winapi.Messages,
  Sysutils,
  Strutils,
  CheckPrevious in 'CheckPrevious.pas',
  ImageDropDown in 'ImageDropDown.pas',
  JRiverXML_Unit in 'JRiverXML_Unit.pas',
  MC_Commands_Unit in 'MC_Commands_Unit.pas',
  mnEdit in 'mnEdit.pas',
  Types_Unit in 'Types_Unit.pas',
  uLkJSON in 'uLkJSON.pas',
  Utils_Unit in 'Utils_Unit.pas',
  About_Frm in 'About_Frm.pas' {Form2},
  Threadsearch in 'Threadsearch.pas',
  Functions_Unit in 'Functions_Unit.pas',
  TranslateJRStyle_Unit in 'TranslateJRStyle_Unit.pas',
  Threadsearch_Image in 'Threadsearch_Image.pas';

{$R *.res}

var
  i: integer;
  PreviousHandle: THandle;
  FParameterStr: string;
  copyDataStruct: TCopyDataStruct;

procedure SendData(copyDataStruct: TCopyDataStruct);
var
  receiverHandle: THandle;
begin
  receiverHandle := FindWindow(PChar('TThemoviedb'), nil);
  if receiverHandle = 0 then
  begin
    ShowMessage('CopyData Receiver NOT found!');
    Exit;
  end;

  SendMessage(receiverHandle, WM_COPYDATA, 0, integer(@copyDataStruct));

end;

begin

  // 1 Only Instance !
  if not CheckPrevious.RestoreIfRunning(Application.Handle, 1) then
  begin

    Application.Initialize;
    TConfiguratorUnit.doPropertiesConfiguration('log4delphi.properties');
    Application.MainFormOnTaskbar := True;

 for i := 1 to ParamCount do
    FParameterStr := FParameterStr + ' ' + ParamStr(i);
  FParameterStr := trim(FParameterStr);

  if ((AnsiLeftStr(FParameterStr,10)  = '-MassScrap')or((AnsiLeftStr(FParameterStr,5)  = '-hide'))) then
begin
Application.MainFormOnTaskbar := false;
Application.ShowMainForm := false;

end;

  Application.CreateForm(TThemoviedb, Themoviedb);
  Themoviedb.FHideForm  := False ;
  Application.CreateForm(TForm2, Form2);
  Application.Run;

  end
  else

  begin
    sleep(2000);
    PreviousHandle := FindWindow('TThemoviedb', nil);
    if PreviousHandle <> 0 then
    begin

      for i := 1 to ParamCount do
        FParameterStr := FParameterStr + ParamStr(i);

      copyDataStruct.dwData := integer(cdtString);
      // use it to identify the message contents
      copyDataStruct.cbData := 200; // ???
      copyDataStruct.lpData := PChar((FParameterStr));

      SendData(copyDataStruct);

    end;
  end;

end.

