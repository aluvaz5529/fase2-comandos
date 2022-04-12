$equiposCsv=Read-Host "Introduce el fichero csv de Equipos"
$fichero= import-csv -Path $equiposCsv -delimiter ":"

foreach($line in $fichero)
{
	$pathObject=$line.Path+","+$domainComponent	
	#Comprobamos que no exista el equipo en el sistema
	if ( !(Get-ADComputer -Filter { name -eq $line.Computer }) )
	{
		New-ADComputer -Enabled:$true -Name:$line.Computer -Path:$pathObject -SamAccountName:$line.Computer
	}
	else { Write-Host "El equipo $line.Computer ya existe en el sistema"}
}
