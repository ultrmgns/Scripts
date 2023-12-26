# Define the directory to search
$directoryPath = Read-Host "Enter the directory path"

# Get all files from the directory and its subfolders
$files = Get-ChildItem -Path $directoryPath -Recurse -File

# Group the files by their size
$groupedFiles = $files | Group-Object Length

# Iterate over each group
foreach ($group in $groupedFiles) {
    # Check if the group has more than one file (potential duplicates)
    if ($group.Count -gt 1) {
        # Output the names of the files in the group
        Write-Host "The following files have the same size ("$group.Name" bytes):"
        $group.Group | ForEach-Object { Write-Host $_.FullName }

        # Ask the user if they want to delete the duplicates
        $userInput = Read-Host "Do you want to delete the duplicates? (y/n)"

        # If user confirms, delete all but the first file in the group
        if ($userInput -eq "y") {
            $group.Group | Select-Object -Skip 1 | ForEach-Object { Remove-Item $_.FullName -Force }
            Write-Host "Duplicates deleted."
        }
    }
}

Write-Host "Operation completed."
