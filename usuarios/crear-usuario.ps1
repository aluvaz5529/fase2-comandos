param($a,$b)
$dominio=san-gva
$sufijo=.es
#En la variable dc componemos el nombre dominio y sufijo. Ejemplo: dc=san-gva,dc=es.
$dc="dc="+$dominio+",dc="+$sufijo
if (!(Get-Module -Name ActiveDirectory)) #accederá al then si no tiene ActiveDirectory sería como decirle al ordenador si no lo tienes carga el modulo,si lo tienes no hagas nada
{
  Import-Module ActiveDirectory #carga el modulo ActiveDirectory
}
#crea una variable del fichero que le pongas
$fichero_csv=Read-Host "Introduce el fichero csv de los usuarios:"

#Ahora le importamos con la segunda parte el fichero (import-csv) la variable que contiene el fichero csv previamente seleccionado
$fichero_csv_importado = import-csv -Path $fichero_csv -Delimiter : 			     
foreach($linea_leida in $fichero_csv_importado)
#path es la ruta y el delimitar es lo que separa los nombres del csv , es decir seria algo algo
#juan:sanchez:departamento_informatica:san-gva.es <-- solo es un ejemplo
#creas una variable que contiene el path (ruta) que va a tener el usuario OU=Departamento_informatica,dc=san-gva,dc=es
$rutaContenedor =$linea_leida.ContainerPath+","+$dc 
#convertimos la contraseña en una segura en mi caso es el dni
$passAccount=ConvertTo-SecureString $linea_leida.dni -AsPlainText -force
#Ahora le ponemos nombre a los campos del csv para facilitar la escritura
	$name=$linea.Name
	$nameShort=$linea.Name+'.'+$linea_leida.Surname1
	$Surnames=$linea.Surname
	$nameLarge=$linea.Name+' '+$linea_leida.Surname1+' '+$linea_leida.Surname2
	$computerAccount=$linea_leida.Computer
	$email=$linea_email
