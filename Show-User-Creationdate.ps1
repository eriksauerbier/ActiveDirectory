# Skript zum Abfragen des Erstelldatums von Benutzern
# Stannek GmbH - v.1.0 - 25.08.2022 - E.Sauerbier
 
 # Organisationseinheit erfragen, bei Abbruch wird das gesamte AD abgefragt
$OrgUnit = Get-ADOrganizationalUnit -Filter * | Select-Object DistinguishedName | Out-GridView -Title "Bitte w�nschte Organisationseinheit angeben, f�r alle PCs der Dom�ne Abbrechen-Button dr�cken" -OutPutMode Single

# Benutzererstelldatum abfragen
If ($OrgUnit -eq $Null) {Get-ADUser -Filter "*" | get-aduser -Properties whenCreated |FT Name, whenCreated}
Else {Get-ADUser -SearchBase $OrgUnit.DistinguishedName -Filter "*" | get-aduser -Properties whenCreated |FT Name, whenCreated}