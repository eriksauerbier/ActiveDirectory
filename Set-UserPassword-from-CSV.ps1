# Skript zum �ndern der User-Passw�rter anhand einer CSV-Datei
# Stannek GmbH - v.1.0 - 19.10.2022 - E.Sauerbier

# Parameter


# Skriptpfad auslesen
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# CSV-Datei ausw�hlen
$CSVFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$CSVFileDialog.initialDirectory = $PSScriptRoot
$CSVFileDialog.filter = "CSV (*.csv)| *.csv"
$CSVFileDialog.ShowDialog() | Out-Null


# Inhalt der CSV auslesen

$Users = Import-CSV -Path $CSVFileDialog.filename -Delimiter ","

# Passwort f�r alle Benutzer
foreach ($User in $Users) {
# Passwort generieren
Get-ADUser -Filter { userPrincipalName -eq "$User.UPN"} | Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -String $User.Password -AsPlainText -Force) -PassThru -Debug
Write-Host "Passwort f�r $($User.UPN) wurde auf $($User.Password) gesetzt" -ForegroundColor Red
}