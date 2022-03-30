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

Install-ADDSDomainController -DomainName "san-gva.es" –Credential (Get-Credential) –SiteName “Default-First-Site-Name” –InstallDNS:$True –NoGlobalCatalog:$false -CreateDNSDelegation:$false -ReplicationSourceDC "SRVMASTER.san-gva.es" –CriticalReplicationOnly:$False –DatabasePath “C:\Windows\NTDS” –LogPath “C:\Windows\NTDS” –SysVolPath “C:\Windows\SysVol” –NoRebootOnCompletion:$False -Force:$true
#Luego para comprobar a que dominio esta conectado nuestro equipo podemos poner este comando, que te dice la variable de entorno en la que estas (en cmd)
echo %logonserver%

#Parametros del último comando 
#ADDSDomainController --> Comando de powershell (cmdlet) que permite instalar un controlador de dominio tanto principal o adicional según lo que le digas
#DomainName --> Ponemos el nombre del dominio existente en el que queremos unir al equipo
#Credential (Get-Credential) -->  Credential pregunta por el nombre del administrador que administra el sistema (administrador del master) y con poner Get-Credential lo que hace es preguntarnos al momento por el administradore n vez de poner una ruta con el un fichero que ponga las credenciales (obviamente para ser más seguro)
#SiteName “Default-First-Site-Name” --> Pregunta por la ubicación de la réplica y con Default-First-Site-Name le decimos que lo deje en el lugar por defecto
#InstallDNS --> El DNS de la replica es para que en caso de que el principal cayera los equipos todavia puedan resolve el nombre, para esto ponemos un True con un $
#NoGlobalCatalog --> Este parametro significa que tiene información parcial de los objetos de todos los dominios del bosque,para buscar un objeto es más facil pero el problema es ue la información solo esd parcial,entonces lo pongo en $false
#ReplicationSourceDC --> Esta opción te pregunta por el dominio que quieres hacer la copia 
#CriticalReplicationOnly --> Es para que replice solo lo esencial (para ocupar menos y no gastar tanto tiempo) pero en mi caso le digo que no
#LogPath --> Aquí tendrás que indicar la ruta donde se registraran las entradas de los usuarios
#SysvolPath -->Aquí indicas la rut donde se guardaran los ficheros de los clientes como los scripts de inicio de sesión
#NoRebootOnCompletion --> Pemite que al finalizar se reinicie el equipo para aplicar los cambios (con $false le decimos que sí y con $True le decimos que no)
#Force --> Si lo pones en $True evita preguntas de confirmación
