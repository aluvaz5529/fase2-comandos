#Lo primero es importar el modulo con el que voy a administrar el servidor
Import-Module ServerManager

#Ahora tengo que añadir este comando que instala servicios de directorios
#que proporciona los métodos para almacenar datos de directorio 
#y hace que estos datos estén disponibles para los usuarios y administradores de la red
Add-WindowsFeature AD-Domain-Services
