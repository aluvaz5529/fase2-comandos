$dominio=san-gva.es
$dc="dc=hgeneral,dc=san-gva,dc=es"
$equiposCsv=Read-Host "Introduce el fichero csv de Equipos"
$fichero= import-csv -Path $equiposCsv -delimiter ":"

foreach($linea in $fichero)
{
	$pathObject=$linea.Path+","+$dc	
	#Comprobamos que no exista el equipo en el sistema
	if ( !(Get-ADComputer -Filter { name -eq $linea.Computer }) )
	{
		New-ADComputer -Enabled:$true -Name:$linea.Computer -Path:$pathObject -SamAccountName:$linea.Computer
	}
	else { Write-Host "El equipo $linea.Computer ya existe en el sistema"}
}
