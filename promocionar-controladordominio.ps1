#script para crear un nuevo bosque junto a el dominio raiz
#
# Script de Windows PowerShell para implementación de AD DS
#

Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "san-gva.es" `
-DomainNetbiosName "SAN-GVA" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true

#Esto es lo que quiere decir
#Domain Mode y -ForestMode
#Windows Server 2003: 2 or Win2003
#Windows Server 2008: 3 or Win2008
#Windows Server 2008 R2: 4 or Win2008R2
#Windows Server 2012: 5 or Win2012
#Windows Server 2012 R2: 6 or Win2012R2
#Windows Server 2016: 7 or WinThreshold
