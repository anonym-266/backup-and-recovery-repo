# Overview of content
### This repo consists of four main files...

The **backup script**, the **recovery script**, the **run script** and the **Dockerfile** along side mock files.

> ### 1. The backup script
  
&nbsp; &nbsp; The script prompts the user to enter the names of files they want to back up when sourced or executed. it also contains default mock files to backup and the user simply presses on enter to use default mock files
  File Search: For each filenames, the script uses the find command to search for the file in /home/ubuntu to narrow the search. It checks if the files entered exists and appends the full path of found files to the mock files found in an array called filePath.

  File Existence Check: If a file is not found, the script outputs a message indicating that the file does not exist.

  Backup Directory Check: The script checks if a directory named backup exists:
  - If it exists, it checks if an archive file named archive.tar.gz already exists in that directory
  - If the archive exists, it decompresses it, adds the newly found files to the existing archive, and then compresses it again.
  - If the archive does not exist, it creates a new archive file containing the found files.
  - If the backup directory does not exist, the script creates it and then creates a new archive file containing the found files.

Output Messages: Throughout the process, the script provides feedback to the user, indicating whether files were found, whether the backup directory was created, and when the backup was completed.

  Date Stamping: The script includes a timestamp in the output message to indicate when the backup was performed.

In summary, the script automates the process of backing up specified files from the user's home directory into a compressed archive, handling both the creation of new archives and the updating of existing ones. It provides user feedback and ensures that the backup process is clear and organized.


> ### 2. The recovery script

it extracts files from the backup archive to the root directory 


> ### 3. the dockerfile

It is used to create an image based on the latest version of ubuntu
It sets the working directory to `/home/ubuntu`
It copies the two scripts from the directory where the dockerfile is located into `/home/ubuntu` and makes them executable..
It may add cron job to execute the backup script every minute..(we're still working on fixing the bug). If the cronjob isn't executed, the user may have to execute the script manually

# User guide
Once the repo is pulled, the run.sh script can be sourced to build the image and run a container with the required configurations using the syntax:
```bash
source run.sh
```


In the case the cronjob isn't running in the container, the scripts can either be executed or sourced using
```bash
./backup.sh # to execute it
source backup.sh # to source the file
```
For the backup files for example both of the above commands will have as result running the scripts..
the files to be backed up
Once run, the mock files can be removed to test the recovery script using:
```bash
rm -rf mock* && ls
```
They can then recovered by following the same procedure for the recovery script

The backup directory is created and contains the compressed archive file along a log file that contains logs for all files that were backed up.. Its content can be viewed using:
```bash
tar -tf backup/archive.tar.gz
```
