# Use the Ubuntu base image
FROM ubuntu:latest

# Update the package list and install apache2 (HTTPD) web server
RUN apt-get update && apt-get install -y apache2

# Copy the file from the current location to the document root
COPY myfile.html /var/www/html/

# Expose port 80 for the HTTPD server
EXPOSE 80

# Start the HTTPD server
CMD ["apache2ctl", "-D", "FOREGROUND"]
