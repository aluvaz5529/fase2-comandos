$dominio="san-gva"
$sufijo=es
$dc="dc="+$dominio+",dc="+$sufijo
#si no tiene el modulo de active directory entonces lo importará
if (!(Get-Module -Name ActiveDirectory)) #Accederá al then solo si no existe una entrada llamada ActiveDirectory
{
  Import-Module ActiveDirectory #Se carga el módulo
}
#
$fileUsersCsv=Read-Host "Introduce el fichero csv de los usuarios:"
$fichero = import-csv -Path $fileUsersCsv -Delimiter :
#
foreach($linea_leida in $fichero)
{
	Add-ADGroupMember -Identity $linea_leida.Grupo -Members $linea_leida.Usuario
}
