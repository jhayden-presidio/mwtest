param (
    [string] $SomeParameter
)

# File to write logs
$OutputFile = ".\$($env:COMPUTERNAME).log"

# Removing log file if exists
if (Test-Path $OutputFile)
{
    Remove-Item $OutputFile
}


try {
    # ...
    # Performing operations
    # ...
    ">> !!! My log output, some parameter: $($SomeParameter)" | Out-File $OutputFile -Append
} catch {
    ">> ERROR:" | Out-File $OutputFile -Append
    $_ | Out-File $OutputFile -Append
}


# Uploading log file to blob storage
$Name = (Get-Item $OutputFile).Name
$StorageAccount = "vmartifactstor001"
$Container = "vmtemplatescripts"
$SasToken = "?sv=2021-06-08&ss=b&srt=sco&sp=r&se=2023-10-04T06:21:51Z&st=2022-10-03T22:21:51Z&spr=https&sig=u4J7Fpdlr0OohTAxQ35rfCgIiuhikzBNXazJFj%2FFxF8%3D"

$Uri = "https://$($StorageAccount).blob.core.windows.net/$($Container)/$($Name)$($SasToken)"

# Setting TLS protocol version to 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Headers = @{'x-ms-blob-type' = 'BlockBlob'}
Invoke-RestMethod -Uri $Uri -Method Put -Headers $Headers -InFile $OutputFile