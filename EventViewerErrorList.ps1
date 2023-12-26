# PowerShell Script to Search Event Viewer for Errors using Get-WinEvent, Ignoring Event ID 0 and Outputting Only Entries with Messages

# Define the log you want to search, such as 'Application', 'System', etc.
$logName = "Application"

# Create a query to filter the logs. Here we filter for 'Error' level events.
$query = "*[System[Level=2]]" # Level 2 is for 'Error'

# Get the error logs
$errorLogs = Get-WinEvent -LogName $logName -FilterXPath $query -MaxEvents 5000

# Display the results, excluding Event ID 0 and entries without a message
foreach ($log in $errorLogs) {
    if ($log.Id -ne 0 -and $log.Message) {
        Write-Host "Time Created: $($log.TimeCreated)"
        Write-Host "Provider Name: $($log.ProviderName)"
        Write-Host "Event ID: $($log.Id)"
        Write-Host "Message: $($log.Message)"
        Write-Host "------------------------"
    }
}
