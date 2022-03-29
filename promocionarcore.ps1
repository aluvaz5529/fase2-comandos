#Lo primero es importar el modulo con el que voy a administrar el servidor
Import-Module ServerManager

#Ahora tengo que añadir este comando que instala servicios de directorios
#que proporciona los métodos para almacenar datos de directorio 
#y hace que estos datos estén disponibles para los usuarios y administradores de la red
Add-WindowsFeature AD-Domain-Services
#Ahora compruebo que el modulo ADDSDeployment está, y si no lo añado
if (!(Get-Module -Name ADDSDeployment))
#con este comando lo añado
{
  Import-Module ADDSDeployment #Se carga el módulo
}
#Este modulo añade estos comandos https://docs.microsoft.com/es-es/powershell/module/addsdeployment/?view=windowsserver2022-ps&viewFallbackFrom=win10-ps
#Una vez añadido todos los modulos y características ya podemos pasar a promocionar como adicional al controlador replica

Install-ADDSDomainController -DomainName "smr.local" –Credential (Get-Credential) –SiteName “Default-First-Site-Name” –InstallDNS:$True –NoGlobalCatalog:$false -CreateDNSDelegation:$false -ReplicationSourceDC "orion.smr.local" –CriticalReplicationOnly:$False –DatabasePath “C:\Windows\NTDS” –LogPath “C:\Windows\NTDS” –SysVolPath “C:\Windows\SysVol” –NoRebootOnCompletion:$False -Force:$true
#luego para comprobar a que dominio esta conectado nuestro equipo podemos poner este comando, que te dice la variable de entorno en la que estas
echo %logonserver%
