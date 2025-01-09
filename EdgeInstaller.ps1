$Path = $env:TEMP;

$Installeropera = "OperaInstaller.exe";
(new-object System.Net.WebClient).DownloadFile('https://edgeupdates.microsoft.com/api/products?view=enterprise', "$Path\$Installeropera");
& "$Path\$Installeropera"  /install;
$ProcesstoMonitor = "OperaInstaller";

Do
{ $ProcessFound = Get-Process | ?{$ProcesstoMonitor -contains $_.Name} | Select-Object -ExpandProperty Name;
If ($ProcessFound) { "Still running: $($ProcessFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 }
else
{ rm "$Path\$Installeropera" -ErrorAction SilentlyContinue -Verbose } }
Until (!$ProcessFound)
