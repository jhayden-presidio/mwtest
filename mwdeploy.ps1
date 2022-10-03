Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
 Install-Module -Name Az.Storage -AllowClobber -Force
 Import-Module -Name Az.Storage -Force
 $StorageAccountName = "vmartifactstor001"
 $ContainerName = "vmtemplatescripts"
 $Blob1Name = "StorageExplorer.exe"
 $TargetFolderPath = "C:\"
 $context = New-AzStorageContext -StorageAccountName $StorageAccountName -SASToken "sp=r&st=2022-09-28T23:08:31Z&se=2023-09-29T07:08:31Z&spr=https&sv=2021-06-08&sr=c&sig=q8PjrLyy%2FFotHzaMvl%2FCsZiNbdbcw7md4islRlA2qqE%3D"
 Get-AzStorageBlobContent -Blob $Blob1Name -Container $ContainerName -Context $context -Destination $TargetFolderPath
 $arg="/VERYSILENT /NORESTART /ALLUSERS"
 Start-Process StorageExplorer.exe -Wait -ArgumentList $arg 