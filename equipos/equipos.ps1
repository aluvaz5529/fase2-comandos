$dc="dc=hgeneral,dc=san-gva,dc=es"
$equiposCsv=Read-Host "Introduce el fichero csv de Equipos"
$fichero= import-csv -Path $equiposCsv -delimiter ":"

foreach($linea in $fichero)
{
New-ADComputer -Enabled:$true -Name:$linea.Computer -Path:$linea.Path -SamAccountName:$linea.Computer
}
