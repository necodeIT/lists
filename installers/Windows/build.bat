cd ..\lists
call flutter pub get
call flutter build windows --release --no-sound-null-safety
@REM cd "..\url protocol handler"
@REM call dotnet publish -c Release --self-contained true -r win-x86
cd ..\installers\Windows
call iscc windows_setup.iss