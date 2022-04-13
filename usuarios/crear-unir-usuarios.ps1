$dominio="san-gva.es"
$dc="dc=hgeneral,dc=san-gva,dc=es"
#Creas una variable con el nombre del dominio Ejemplo: dc=san-gva,dc=es.
if (!(Get-Module -Name ActiveDirectory)) #accederá al then si no tiene ActiveDirectory sería como decirle al ordenador si no lo tienes carga el modulo,si lo tienes no hagas nada
{
  Import-Module ActiveDirectory #carga el modulo ActiveDirectory
}
#crea una variable del fichero que le pongas
$fichero_csv=Read-Host "Introduce el fichero csv de los usuarios"

#Ahora le importamos con la segunda parte el fichero (import-csv) la variable que contiene el fichero csv previamente seleccionado
$fichero_csv_importado = import-csv -Path $fichero_csv -Delimiter : 			     
foreach($linea in $fichero_csv_importado)
{
#path es la ruta y el delimitar es lo que separa los nombres del csv , es decir seria algo algo
#juan:sanchez:departamento_informatica:san-gva.es <-- solo es un ejemplo
#creas una variable que contiene el path (ruta) que va a tener el usuario OU=Departamento_informatica,dc=san-gva,dc=es
$Path =$linea.Path+","+$dc 
#convertimos la contraseña en una segura en mi caso es el dni
$passAccount=ConvertTo-SecureString $linea.Dni -AsPlainText -force
#Ahora le ponemos nombre a los campos del csv para facilitar la escritura
	$name=$linea.Name
	$nameShort=$linea.Name+'.'+$linea.Surname1
	$Surnames=$linea.Surname
	$cuenta=$linea.account
	$nameLarge=$linea.Name+' '+$linea.Surname1+' '+$linea.Surname2
	$computerAccount=$linea.Computer
	$email=$linea.email
	$DNI=$linea.Dni
	$Delegation=$linea.delegation
	$departament=$linea.departament
	$password=$linea.password
	$days=$linea.TurnPassDays
#    $enabled=$linea.enabled


New-ADUser -SamAccountName $cuenta -UserPrincipalName $nameShort -Name $cuenta -Surname $Surnames -DisplayName $nameLarge -GivenName $name -LogonWorkstations: $computerAccount -Description "Cuenta de $nameLarge" -EmailAddress $email -AccountPassword $passAccount -Enabled $True `
		-CannotChangePassword $false `
    		-ChangePasswordAtLogon $true `
		-PasswordNotRequired $false `
    		-Path $Path
    Write-Host $linea.department
    Write-Host $linea.account
    $grupoGG =$linea.Department+"_GG"
    $grupoGL =$linea.Department+"_GL"
    Write-Host $grupo
Add-ADGroupMember -Identity $grupoGG -Members $linea.account
Add-ADGroupMember -Identity $grupoGL -Members $grupoGG
}
