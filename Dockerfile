# Use the Ubuntu base image
FROM ubuntu:latest

# Update the package list and install apache2 (HTTPD) web server
RUN apt-get update && apt-get install -y apache2

# Copy the file from the current location to the document root
# Replace 'your-file.html' with the actual file name you want to copy
COPY myfile.html /var/www/html/

# Expose port 200 for the HTTPD server
EXPOSE 200

# Start the HTTPD server
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/apache2ctl"]

