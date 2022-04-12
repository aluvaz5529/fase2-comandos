$dominio=san-gva.es
$dc="dc=hgeneral,dc=san-gva,dc=es"
Write-Host $dc
$Path=$linea.Path+","+$dc	
$ficheroCsvUO=Read-Host "Introduce el fichero csv de UO's:"
$fichero = import-csv -Path $ficheroCsvUO -delimiter :
foreach($linea in $fichero)
{
   New-ADOrganizationalUnit -Description:$linea.Description -Name:$linea.Name -Path:$Path -ProtectedFromAccidentalDeletion:$true
}
#El parametro del final quiere decir que si quieres que se proteja para que no lo borres sin querer ,pero si quieres hacer pruebas mejor false porque tendrás
#que borrarlo bastantes veces
