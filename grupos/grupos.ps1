$dominio="san-gva.es"
$path= "dc=hgeneral,dc=san-gva,dc=es"
#si no tiene el modulo de active directory entonces lo importará
if (!(Get-Module -Name ActiveDirectory)) #Accederá al then solo si no existe una entrada llamada ActiveDirectory
{
  Import-Module ActiveDirectory #Se carga el módulo
}
#
$fileUsersCsv=Read-Host "Introduce el fichero csv de los grupos"
$fichero = import-csv -Path $fileUsersCsv -Delimiter ";"
#Con este comando creas los grupos
#foreach es el bucle y lo que permite que lea linea a linea , campo por campò
foreach($linea in $fichero)
{
$path_OU=$linea.Path +","+$path
NEW-ADGroup -Name $linea.Name -Description $linea.Description -Path $path_OU -GroupScope $linea.Scope
}
