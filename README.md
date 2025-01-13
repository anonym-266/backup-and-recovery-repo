# Overview of content
### This repo consists of three files...

The **backup script**, the **recovery script** and the **Dockerfile**

1. The backup script
  
Prompt for Input: The script prompts the user to enter the names of files they want to back up. The user can input multiple filenames separated by spaces.

  File Search: For each filename entered by the user, the script uses the find command to search for the file in the user's home directory (~). It checks if the file exists and stores the full path of found files in an array called filePath.

  File Existence Check: If a file is not found, the script outputs a message indicating that the file does not exist.

  Backup Directory Check: The script checks if a directory named backup exists:
  If it exists, it checks if an archive file named archive.tar.gz already exists in that directory
  If the archive exists, it decompresses it, adds the newly found files to the existing archive, and then compresses it again.
  If the archive does not exist, it creates a new archive file containing the found files.
  If the backup directory does not exist, the script creates it and then creates a new archive file containing the found files.

Output Messages: Throughout the process, the script provides feedback to the user, indicating whether files were found, whether the backup directory was created, and when the backup was completed.

  Date Stamping: The script includes a timestamp in the output message to indicate when the backup was performed.

In summary, the script automates the process of backing up specified files from the user's home directory into a compressed archive, handling both the creation of new archives and the updating of existing ones. It provides user feedback and ensures that the backup process is clear and organized.

the recovery script

the recovery script 
it extraccts files from the backup arcchive to the root directory and logs the recovery action including the names of the recorvered files and a timestamp of the recovery

the dockerfile

it is used to create an image based on the latest version of ubuntu
it perfoms several tasks including updating the package list, though not very usefull for this case
  the output of the apt update and apt upgrade  commands are redirected into two mock files, mock1.log and mock2.log which are used as mock files to test the backup script
it sets the working directory to `/home/ubuntu`
it copies the two scripts from the directory where the dockerfile is located into `/home/ubuntu` and makes them executable

# User guide
once the repo is pulled, the following commands are runned to build the image and run a container to run the scripts

to pull build the image
```bash
docker build -t try9 .
```

to run the container
```bash
docker run -it --name con03 try9 /bin/ bash
```
once in the container, the scripts can either be executed or sourced using
```bash
./backup.sh # to execute it
source backup.sh # to source the file
```
for the backup files for example both of the above commands will have as result running the scripts..
the files to be backedup can then be entered
