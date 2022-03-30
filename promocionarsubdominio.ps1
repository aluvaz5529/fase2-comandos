#
# Script de Windows PowerShell para implementación de AD DS
#

Import-Module ADDSDeployment
Install-ADDSDomain `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$true `
-Credential (Get-Credential) `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainType "ChildDomain" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NewDomainName "hgeneral" `
-NewDomainNetbiosName "HGENERAL" `
-ParentDomainName "san-gva.es" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

#Los parametros importantes que solo se dan en el subdominio son los de -DomainType que dice childDomain "hijo de dominio" en español
#ParentDomainName "el nombre del directorio padre/raiz" --> "san-gva.es"
