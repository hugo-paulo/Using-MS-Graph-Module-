#Note if get error with Import-Module Microsoft.Graph.Authentication after installing mg graph module run command in this link
#Set-ExecutionPolicy Unrestricted
#https://docs.microsoft.com/en-us/troubleshoot/azure/active-directory/cannot-run-scripts-powershell

#Try using MS Graph, if not use AZure AD moodules

#need to sign in a SP
#How to use this with provided credentials instead of interactive log in?
#How to login as a SP
#see link https://docs.microsoft.com/en-us/graph/powershell/app-only?tabs=powershell

#Needed to add the platform in authentication

Connect-MgGraph -Scopes 'User.Read.All'

$appId = ""
$tenantId = "" 
$certThumbPrint = ""

Connect-MgGraph -ClientID $appId -TenantId $tenantId -CertificateThumbprint $certThumbPrint #-Scopes 'User.Read.All Group.Read.All'

#verfy that authenticated with app-only
Get-MgContext

# list users 
# add app permission User.Read.All
Get-MgUser

# list groups
Get-MgGroup

######################
#First need to create a certificate using this doc https://blogs.aaddevsup.xyz/2020/07/using-msal-net-to-perform-the-client-credentials-flow-with-a-certificate-instead-of-a-client-secret-in-a-netcore-console-appliction/

$tenant_id = '' # tenant id is used for the cert name / subject name and matches the .netcore code sample that goes with this script
$client_id = '' # client id is used for the cert name / subject name and cert password and matches the .netcore code sample that goes with this script
$FilePath = 'C:\Users\<local path>'
$StoreLocation = 'CurrentUser' # be aware that LocalMachine requires elevated privileges
$expirationYears = 1
 
$SubjectName = $tenant_id + '.' + $client_id
$cert_password = $client_id
 
$pfxFileName = $SubjectName + '.pfx'
$cerFileName = $SubjectName + '.cer'
 
$PfxFilePath = $FilePath + $pfxFileName
$CerFilePath = $FilePath + $cerFileName
 
$CertBeginDate = Get-Date
$CertExpiryDate = $CertBeginDate.AddYears($expirationYears)
$SecStringPw = ConvertTo-SecureString -String $cert_password -Force -AsPlainText
$Cert = New-SelfSignedCertificate -DnsName $SubjectName -CertStoreLocation "cert:\$StoreLocation\My" -NotBefore $CertBeginDate -NotAfter $CertExpiryDate -KeySpec Signature
Export-PfxCertificate -cert $Cert -FilePath $PFXFilePath -Password $SecStringPw
Export-Certificate -cert $Cert -FilePath $CerFilePath

######################

$cert = New-SelfSignedCertificate -CertStoreLocation "cert:\CurrentUser\My" `

  -Subject "CN=exampleappScriptCert" `

  -KeySpec KeyExchange

$keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())
