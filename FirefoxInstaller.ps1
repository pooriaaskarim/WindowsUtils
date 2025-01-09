$Path = $env:TEMP;

$Installerfirefox = "FirefoxInstaller.exe";
(new-object System.Net.WebClient).DownloadFile('https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US', "$Path\$Installerfirefox");
& "$Path\$Installerfirefox"  /S;
$ProcesstoMonitor = "FirefoxInstaller";

Do
{ $ProcessFound = Get-Process | ?{$ProcesstoMonitor -contains $_.Name} | Select-Object -ExpandProperty Name;
If ($ProcessFound) { "Still running: $($ProcessFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 }
else
{ rm "$Path\$Installerfirefox" -ErrorAction SilentlyContinue -Verbose } }
Until (!$ProcessFound)
