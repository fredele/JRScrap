program JRScrap;

uses
  TConfiguratorUnit,
  MassScrap_Unit in 'MassScrap_Unit.pas' {MassScrap_Frm},
  OpenSub_Unit in 'OpenSub_Unit.pas' {OpenSub_Form},
  Dialogs,
  Vcl.Forms,
  JRScrap_Unit in 'JRScrap_Unit.pas' {JRScrap_Frm},
  Vcl.Themes,
  Vcl.Styles,
  Winapi.Windows,
  Winapi.Messages,
  Sysutils,
  Strutils,
  CheckPrevious in 'CheckPrevious.pas',
  ImageDropDown in 'ImageDropDown.pas',
  MC_Commands_Unit in 'MC_Commands_Unit.pas',
  Types_Unit in 'Types_Unit.pas',
  uLkJSON in 'uLkJSON.pas',
  About_Frm in 'About_Frm.pas' {Form2},
  TranslateJRStyle_Unit in 'TranslateJRStyle_Unit.pas',
  Threadsearch_Unit in 'Threadsearch_Unit.pas',
  TheMoviedB_Unit in 'TheMoviedB_Unit.pas',
  TVdB_Unit in 'TVdB_Unit.pas',
  File_Unit in 'File_Unit.pas',
  debug_Unit in 'debug_Unit.pas',
  Utils_Unit in 'Utils_Unit.pas',
  String_Unit in 'String_Unit.pas',
  JRiverXML_Unit in 'JRiverXML_Unit.pas',
  ThreadManager_Unit in 'ThreadManager_Unit.pas',
  Search_Unit in 'Search_Unit.pas' {Search_Frm},
  Generic_Search_Unit in 'Generic_Search_Unit.pas',
  Image_Form_Unit in 'Image_Form_Unit.pas' {Image_Form},
  XML_Export_Unit in 'XML_Export_Unit.pas' {XML_Export_Frm},
  Freebase_Unit in 'Freebase_Unit.pas',
  Traileraddict_Unit in 'Traileraddict_Unit.pas';

{$R *.res}

var

  i: integer;
  PreviousHandle: THandle;
  FParameterStr: string;
  copyDataStruct: TCopyDataStruct;
  Search_Frm: TSearch_Frm;
  frm_openSub: TOpenSub_Form;

procedure SendData(copyDataStruct: TCopyDataStruct);
var
  receiverHandle: THandle;
begin
  receiverHandle := FindWindow(PChar('TJRScrap'), nil);
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

    Application.MainFormOnTaskbar := false;
    Application.ShowMainForm := True;
    Application.CreateForm(TJRScrap_Frm, JRScrap_Frm);
  Application.CreateForm(TImage_Form, Image_Form);
  Application.CreateForm(TXML_Export_Frm, XML_Export_Frm);
  Application.Run;

  end
  else

  begin
    sleep(2000);
    PreviousHandle := FindWindow('TJRScrap', nil);
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
