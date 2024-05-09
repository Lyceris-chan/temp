$releaseUrl = "https://api.github.com/repos/ungoogled-software/ungoogled-chromium-windows/releases/latest"
$response = Invoke-WebRequest -Uri $releaseUrl -UseBasicParsing
$releaseData = ConvertFrom-Json -InputObject $response.Content
$downloadUrl = $releaseData.assets.browser_download_url | Where-Object { $_ -like "*installer_x64.exe" }

if ($downloadUrl) {
    $fileName = [System.IO.Path]::GetFileName($downloadUrl)
    Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName
    
    # Run the downloaded executable silently
    Start-Process -FilePath $fileName -ArgumentList "/silent" -Wait
} else {
    Write-Host "Failed to retrieve the download URL"
}
