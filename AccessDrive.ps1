while ($true) {
    try {
        if (Test-Path "I:\") {
            Get-ChildItem "I:\" | Out-Null
            Add-Content -Path "C:\scripts\drive_access.log" -Value "$(Get-Date) - Successfully accessed I: drive"
        } else {
            Add-Content -Path "C:\scripts\drive_access.log" -Value "$(Get-Date) - I: drive not found"
        }
    } catch {
        Add-Content -Path "C:\scripts\drive_access.log" -Value "$(Get-Date) - Error: $_"
    }

    Start-Sleep -Seconds 60
}
