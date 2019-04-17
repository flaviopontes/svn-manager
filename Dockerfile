# Alpine Linux with s6 service management
FROM smebberson/alpine-base

	# Install Apache2 and other stuff needed to access svn via WebDav
	# Install svn
	# Installing utilities for SVNADMIN frontend
	# Create required folders
	# Create the authentication file for http access
	# Getting SVNADMIN interface
RUN apk add --no-cache apache2 apache2-utils apache2-ctl apache2-webdav mod_dav_svn &&\
	apk add --no-cache subversion &&\
	apk add --no-cache wget unzip php7 php7-apache2 php7-session php7-json &&\
	apk add --no-cache php7-xml &&\
	mkdir -p /run/apache2/ &&\
	mkdir /var/opt/svn &&\
	mkdir /etc/subversion &&\
	touch /etc/subversion/passwd

# Add distro files
ADD dist /

# Create symbolic links
RUN	ln -s /opt/svnadmin /var/www/localhost/htdocs/svnadmin

# Set permissions
RUN chmod a+w /etc/subversion/* &&\
	chmod a+w /var/opt/svn &&\
	chown -R apache:apache /var/opt/svn &&\
	chmod -R 777 /var/opt/svn &&\
	chmod -R 777 /opt/svnadmin/data

# Expose ports for http and custom protocol access
EXPOSE 80 443 3690