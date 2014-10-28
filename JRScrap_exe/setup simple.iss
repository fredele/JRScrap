
#define MyAppName "JRMoviedB"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "Fredele"
#define MyAppExeName "JRMoviedB.exe"

[Setup]

AppId={{BB0F7CD9-0D27-42C1-AB4D-278950BF3264}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename=Setup_for_JRMoviedB
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
OutputDir={#SourcePath}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#SourcePath}\bin\JRMoviedB.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
;Source: "{#SourcePath}\help\*"; DestDir: "{app}\help"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\images\*"; DestDir: "{app}\images"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\languages\*"; DestDir: "{app}\languages"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\utils_exec\vcredist_x86.exe"; DestDir: "{app}\utils_exec"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\utils_exec\Win32OpenSSL_Light-1_0_1j.exe"; DestDir: "{app}\utils_exec"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon
Name: "{commondesktop}\{#MyAppName} MassScrap"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon ;Parameters: "-MassScrap"
[Registry]                                                                                 
Root: HKCU; Subkey: "Software\JRMoviedB"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: string; ValueName: "APIKey"; ValueData: "3b608fc11821e92cd2459320206a9d9b"
Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: dword; ValueName: "Firstrun"; ValueData: 1


Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: string; ValueName: "Language"; ValueData: "english" ; Languages: english
Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: string; ValueName: "Language"; ValueData: "french" ; Languages: french
Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: string; ValueName: "Language"; ValueData: "german" ; Languages: german

Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: string; ValueName: "QueryLanguage"; ValueData: "eng"; Languages: english
Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: string; ValueName: "QueryLanguage"; ValueData: "fr" ; Languages: french
Root: HKCU; Subkey: "Software\JRMoviedB"; ValueType: string; ValueName: "QueryLanguage"; ValueData: "de" ; Languages: german

[Run]
Filename: "{app}\bin\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]

[code]
function PrepareToInstall(var NeedsRestart: Boolean): String;
var
  ResultCode: integer;
begin
  if (msgbox('vsCredit by Microsoft must be installed. Proceed?', mbConfirmation, MB_YESNO) = IDYES) then
  begin
    if Exec(ExpandConstant('{app}\utils_exec\vcredist_x86.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
    begin
      // handle success if necessary; ResultCode contains the exit code
      // MsgBox('Everything is proceeding according to plan', mbInformation, MB_OK);
    end;
             
  end;

  if (msgbox('OpenSSL by slproweb must be installed. Proceed?', mbConfirmation, MB_YESNO) = IDYES) then
  begin
    if Exec(ExpandConstant('{app}\utils_exec\Win32OpenSSL_Light-1_0_1j.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
    begin
      // handle success if necessary; ResultCode contains the exit code
      // MsgBox('Everything is proceeding according to plan', mbInformation, MB_OK);
    end;
    
  end;

end;
