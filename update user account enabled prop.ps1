#need to login as the app, see the case 2202170030001163

$appId = "6a67243e-00d5-4df0-97e4-ff5a23182cd7"
$tenantId = "6528db0a-dd47-4ff9-b0e7-6f5d9a39d0dc" 
$certThumbPrint = "E3A8C914E00064C75C804B6FD61FB4431720C52B"

Connect-MgGraph -ClientID $appId -TenantId $tenantId -CertificateThumbprint $certThumbPrint

Get-MgContext


#command to run
$params = @{
	accountEnabled = $false
}

$userId = '06bbb504-6a52-4edc-8891-d46b3c81a3ce'

# A UPN can also be used as -UserId.
Update-MgUser -UserId $userId -BodyParameter $params

# How to see the status of the account enable, see in the portal user profile > Settings> block sign in yes and no
Get-MgUser -UserId $userId -Property "displayName,givenName,postalCode,identities,accountEnabled" 


#can revoke admin consent on port using right click

#check which is need 
#Directory.ReadWrite.All(seems this should be enough) for ordinary users
#The app also doesn't have any directory roles

#remember to close and open the this ide and reconnect