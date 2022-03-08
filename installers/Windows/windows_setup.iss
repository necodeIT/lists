; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Lists"
#define MyAppVersion "0.0.1"
#define MyAppPublisher "necodeIT"
#define MyAppURL "https://github.com/necodeIT/lists"
#define MyAppExeName "lists.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{74ED020C-132D-4DB5-A74C-158B32FBBD1F}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=..\..\installers\windows
OutputBaseFilename=WindowsSetup
SetupIconFile=..\..\lists\windows\runner\resources\app_icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\lists\build\windows\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\lists\build\windows\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion
;Source: "..\..\lists\build\windows\runner\Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
;Source: "..\..\lists\build\windows\runner\Release\window_size_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
;Source: "..\..\url protocol handler\url protocol handler\bin\Release\netcoreapp3.1\win-x86\publish\*"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\lists\build\windows\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

;[Registry]
;Root: HKCR; Subkey: "codebook"; ValueType: string; ValueData: "CodeBook"; Flags: uninsdeletekey
;Root: HKCR; Subkey: "codebook"; ValueName: "URL Protocol"; ValueType: string; ValueData: "CodeBook"; Flags: uninsdeletekey
;Root: HKCR; Subkey: "codebook\shell"; ValueType: string; ValueData: "CodeBook"; Flags: uninsdeletekey
;Root: HKCR; Subkey: "codebook\shell\open"; ValueType: string; ValueData: "CodeBook"; Flags: uninsdeletekey
;Root: HKCR; Subkey: "codebook\shell\open\command"; ValueType: string; ValueData: "{app}\url protocol handler.exe '%1'"; Flags: uninsdeletekey

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
