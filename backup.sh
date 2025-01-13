#!/bin/bash

# Prompt the user to enter filenames to backup
read -p "Enter the filenames to backup (space-separated): " -a backupFiles

# Initialize an array to hold the found file paths
filePath=()

# Loop through each file name provided by the user
for file in "${backupFiles[@]}"; do
    # Use find to locate the file in the home directory
    foundFile=$(find /home/ubuntu -type f -name "$file" 2>/dev/null) 

    # Check if the file was found
    if [[ -n $foundFile ]]; then
        echo "Found file: $foundFile"
        filePath+=("$foundFile")
    else
        echo "File: $file doesn't exist"
    fi
done

# Check if any files were found
if [[ ${#filePath[@]} -eq 0 ]]; then
    echo "No valid files to backup. Exiting."
fi

# Check if the backup directory exists
if [[ -d backup ]]; then
    # Check if the archive file already exists
    if [[ -f ./backup/archive.tar.gz ]]; then
        echo -e "Archive file: archive.tar.gz exists, adding files to it"
        # Unzip the existing archive
        gunzip -f "./backup/archive.tar.gz"
        # Add new files to the existing tar archive
        tar -rvf "./backup/archive.tar" "${filePath[@]}"
        # Re-compress the tar archive
        gzip -f "./backup/archive.tar"
        echo "Files ${filePath[@]} were backed up at $(date)" >>  ./backup/backup.log
    else
        echo -e "Creating archive file \n"
        tar -czvf backup/archive.tar.gz "${filePath[@]}"
        echo "Files ${filePath[@]} were backed up at $(date)" >>  ./backup/backup.log
    fi
else
    echo -e "Creating new backup directory \n"
    mkdir -p backup
    tar -czvf backup/archive.tar.gz "${filePath[@]}"
    echo "Files ${filePath[@]} were backed up at $(date)" >>  ./backup/backup.log
fi