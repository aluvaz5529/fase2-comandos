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
#creas una variable con el nombre de fichero en el que le importas el csv con el delimitador de ; que quiere decir que el fichero esta separado por puntos y comas
#El path es el que tu le pongas cuando lo arrastras a powershell
#foreach es el bucle y lo que permite que lea linea a linea , campo por campò
foreach($linea in $fichero)
{
$path_OU=$linea.Path +","+$path
NEW-ADGroup -Name $linea.Name -Description $linea.Description -Path $path_OU -GroupScope $linea.Scope
}
