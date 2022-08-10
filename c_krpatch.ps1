function GoAdmin { Start-Process powershell –Verb RunAs }
$default = [Environment]::UserName
$default2 = "C\Users\Administrator\Desktop"
$TargetFile= "C:\Riot Games\Riot Client\RiotClientServices.exe"
$ShortcutFile = "C:\Users\$default\Desktop\League_KR.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Arguments= "--launch-product=league_of_legends --launch-patchline=live"
$Shortcut.IconLocation = "%SystemDrive%/ProgramData/Riot Games/Metadata/league_of_legends.live/league_of_legends.live.ico"
$Shortcut.Save()