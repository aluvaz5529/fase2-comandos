param($a,$b)
$dominio=san-gva
$sufijo=.es
#En la variable dc componemos el nombre dominio y sufijo. Ejemplo: dc=san-gva,dc=es.
$dc="dc="+$dominio+",dc="+$sufijo
if (!(Get-Module -Name ActiveDirectory)) #accederá al then si no tiene ActiveDirectory sería como decirle al ordenador si no lo tienes carga el modulo,si lo tienes no hagas nada
{
  Import-Module ActiveDirectory 
}
#carga el modulo ActiveDirectory
