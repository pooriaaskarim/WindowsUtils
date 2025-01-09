$Path = $env:TEMP;

$Installerchrome = "GoogleChromeInstaller.exe";
(new-object System.Net.WebClient).DownloadFile('https://dl.google.com/chrome/install/chrome_installer.exe', "$Path\$Installerchrome");
& "$Path\$Installerchrome"  /install;
$ProcesstoMonitor = "GoogleChromeInstaller";

Do
{ $ProcessFound = Get-Process | ?{$ProcesstoMonitor -contains $_.Name} | Select-Object -ExpandProperty Name;
If ($ProcessFound) { "Still running: $($ProcessFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 }
else
{ rm "$Path\$Installerchrome" -ErrorAction SilentlyContinue -Verbose } }
Until (!$ProcessFound)
