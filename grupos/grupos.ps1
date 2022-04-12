$dominio="san-gva.es"
$path= "dc=hgeneral,dc=san-gva,dc=es"
#esto solo funcionara en el subdominio hegeneral porque al final el la ruta hace referencia a una variable que contiene la uo en la que se tiene que poner el grupo
#y también contiene a parte de la uo la varibale path que has definido en la segunda linea
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
#foreach es el bucle y lo que permite que lea linea a linea , campo por campo
#es decir lo que hace foreach con lo que le has puesto dentro es, coge la variable que le dice donde esta el csv y lo referencia con el nombre linea
#entonces cuando quieras hacer refererncia a algo del csv le pones linea (en este caso por lo que pone en el foreach) seguido de un punto y el nombre
#que hayas elegido de cada campo
foreach($linea in $fichero)
{
$path_OU=$linea.Path +","+$path
NEW-ADGroup -Name $linea.Name -Description $linea.Description -Path $path_OU -GroupScope $linea.Scope
Add-ADGroupMember -Identity $linea.Departament -Members $linea.account
}
