#define MyAppName "JRScrap"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "Fredele"
#define MyAppExeName "JRScrap.exe"

[Setup]
AppId={{BB0F7CD9-0D27-42C1-AB4D-278950BF3264}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename=Setup_for_JRScrap
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
OutputDir={#SourcePath}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"



[Files]
Source: "{#SourcePath}\bin\JRScrap.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "{#SourcePath}\images\*"; DestDir: "{app}\images"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#SourcePath}\languages\*"; DestDir: "{app}\languages"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon
;Name: "{commondesktop}\{#MyAppName} MassScrap"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon ;Parameters: "-MassScrap"
[Registry]                                                                                 
Root: HKCU; Subkey: "Software\JRScrap"; Flags: uninsdeletekey
;Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "APIKey"; ValueData: "3b608fc11821e92cd2459320206a9d9b"
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: dword; ValueName: "Firstrun"; ValueData: 1
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: dword; ValueName: "MassScrapWimdbID"; ValueData: 1  
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "MassScrapbooleans"; ValueData: "1111111111111" ; 
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "Language"; ValueData: "english" ; Languages: english
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "Language"; ValueData: "french" ; Languages: french
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "Language"; ValueData: "german" ; Languages: german

Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "QueryLanguage"; ValueData: "eng"; Languages: english
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "QueryLanguage"; ValueData: "fr" ; Languages: french
Root: HKCU; Subkey: "Software\JRScrap"; ValueType: string; ValueName: "QueryLanguage"; ValueData: "de" ; Languages: german

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "ImportantTask1"; Description: "Download and install vscredit_x86 by Microsoft"; GroupDescription: "Important tasks";
Name: "ImportantTask2"; Description: "Download and install Win32OpenSSL by slproweb"; GroupDescription: "Important tasks";
[Run]
Filename: "{app}\bin\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

#include ReadReg(HKEY_LOCAL_MACHINE,'Software\Sherlock Software\InnoTools\Downloader','ScriptPath','');

[Code]
var
  downloadvsCredit ,downloadWin32OpenSSL  : boolean; 

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  
  if (CurPageID = wpSelectTasks) then
  begin

   if IsTaskSelected('ImportantTask1') then
  begin
  itd_addfile('http://frederic.klieber.free.fr/utils/vcredist_x86.exe',expandconstant('{tmp}\vcredist_x86.exe')); 
   downloadvsCredit := true ;
   
  end;

  if  IsTaskSelected('ImportantTask2') then
  begin
  itd_addfile('http://frederic.klieber.free.fr/utils/Win32OpenSSL_Light.exe',expandconstant('{tmp}\Win32OpenSSL_Light.exe')); 
   downloadWin32OpenSSL := true ;
   
  end;

 if  (( downloadvsCredit = true)or( downloadWin32OpenSSL = true)) then
 begin
 itd_downloadafter(wpReady);
 end;

 end;
 


end;

procedure InitializeWizard();
begin
  itd_init;
   downloadvsCredit := false ;
   downloadWin32OpenSSL := false ;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: integer;
begin
 if CurStep=ssInstall then 
 begin 

 if downloadvsCredit = true then 
 begin 
 MsgBox('Installing vcredist_x86.exe', mbInformation, MB_OK);
  Exec(ExpandConstant('{tmp}\vcredist_x86.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode)
  end;

 if downloadWin32OpenSSL = true then 
 begin 
 MsgBox('Installing Win32OpenSSL', mbInformation, MB_OK);
  Exec(ExpandConstant('{tmp}\Win32OpenSSL_Light.exe'), '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode)
  end;

 end;
end;