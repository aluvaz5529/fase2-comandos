#Antes de eliminarlo hay que comprobar
#Para comprobar Estado del salud Controlador de Dominio (replica)
dcdiag /c /e /v
#Parametros
#/c hace todas las pruebas
#/e prueba todos los servidores de la empresa
#/v te hace un informe detallado

#Desintalar el ADDSDomaincontroller AD-Domain-Services y el DNS
Uninstall-ADDSDomainController `
-DemoteOperationMasterRole:$true `
-ForceRemoval:$true `
-Force:$true
Uninstall-WindowsFeature -Name AD-Domain-Services, DNS -Confirm:$false
