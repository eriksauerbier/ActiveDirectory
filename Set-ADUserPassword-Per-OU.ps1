# Dieses Skript setzt f�r alle User innerhalb der gew�hlte OU das User-Passwort
# Stannek GmbH v.1.0 - 08.06.2022 - E.Sauerbier

# Organisationseinheit ausw�hlen
$OU = Get-ADOrganizationalUnit -Filter * | Out-GridView -Title "Organisationseinheit ausw�hlen" -PassThru

# Skript abbrechen wenn keine OU ausgew�hlt wurde
If ($OU -eq $Null) {Break}

# Passwort auslsen
$Password = Get-Credential -UserName UserName -Message "Bitte das gew�nschte Passwort eingeben"

# Skript abbrechen wenn Eingabe abgebrochen wurde
If ($Password -eq $Null) {Break}

# AD-Benutzer innerhalb der OU auslesen
$Users = Get-ADUser -Filter * -SearchBase $Ou.DistinguishedName

# Passwort f�r alle Benutzer der OU �ndern
foreach ($User in $Users) {Set-ADAccountPassword $User -NewPassword $Password.Password}