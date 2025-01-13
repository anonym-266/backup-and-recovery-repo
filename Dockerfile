# using latest version of ubuntu
FROM ubuntu:latest

# creating output mock files from 
RUN apt update >> /home/ubuntu/mock1.log && apt upgrade -y > /home/ubuntu/mock2.log

# setting the working direcctory to the home  directory
WORKDIR /home/ubuntu/

# copy the backup script to the home direclty
COPY ./backup.sh /home/ubuntu/back.sh

# copy the recovery script to the home direclty
COPY ./recovery_script.sh /home/ubuntu/recovery_script.sh

# giving execute permission to the backup  script
RUN chmod u+x /home/ubuntu/back.sh

# giving execute permission to the recovery  script
RUN chmod u+x /home/ubuntu/recovery_script.sh