# using latest version of ubuntu
FROM ubuntu:latest

# Update package lists and install required utilities
RUN apt update  -y && \
    apt install -y cron \
                nano

# setting the working direcctory to the home  directory
WORKDIR /home/ubuntu/

# copy the files in the current to the home direclty
COPY . .

# Grant execute permissions to the scripts
RUN chmod +x ./backup.sh && \
    chmod +x ./recovery_script.sh


# Add a cron job to execute the backup script every minute
RUN echo "* * * * * /home/ubuntu/backup.sh" > /etc/cron.d/my-cron-job && \
    chmod 0644 /etc/cron.d/my-cron-job && \
    crontab /etc/cron.d/my-cron-job

# Create a directory for cron logs
RUN mkdir -p /var/log/cron

# Default command to run cron in the foreground
CMD ["cron", "-f"]