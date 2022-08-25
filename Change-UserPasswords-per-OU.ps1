 # Skript zum �ndern der User-Passw�rter auf OU-Ebene
# Stannek GmbH - v.1.0 - 25.08.2022 - E.Sauerbier
 
 # Organisationseinheit erfragen
$OrgUnit = Get-ADOrganizationalUnit -Filter * | Select-Object DistinguishedName | Out-GridView -Title "Bitte w�nschte Organisationseinheit angeben, in der die Benutzerpassw�rter ge�ndert werden sollen" -OutPutMode Single

# Zuk�nftiges Passwort abfragen
$Password = read-host "Neues Benutzerpasswort eingeben" -asSecureString

# Passwort�nderung durchf�hren
Get-ADUser -SearchBase $OrgUnit.DistinguishedName -Filter "*" | Set-ADAccountPassword -NewPassword $Password -Reset -PassThru 