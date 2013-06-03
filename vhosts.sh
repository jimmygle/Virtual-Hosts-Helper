#!/usr/env bash

####################################################################
# Configuration
####################################################################
#
# Path to web root (with trailing slash)
web_root_path="/Users/jimmygle/Sites/"
#
# Path to vhosts config file
vhost_path="/Applications/MAMP/conf/apache/vhosts.conf"
#
# Path to hosts file
hosts_path="/private/etc/hosts"
#
# DNS Flush Cache command
dns_flush="dscacheutil -flushcache"
#
# Apache restart command
apache_restart="/Applications/MAMP/bin/apache2/bin/apachectl restart"
#
# Apache's port (8888 is MAMP's default)
apache_port="8888"
#
####################################################################
echo ""

# Check if being ran as root
if [ "$(whoami)" != "root" ]; then
	echo "You must run this script as root: sudo sh vhosts.sh"
	echo ""
	exit 1
fi

# Check vhosts file exists
if [ ! -f $vhost_path ]; then
	echo "WOOPS, vhosts file does not exist at: $vhost_path"
	echo ""
	exit 1
fi

# Check hosts file exists
if [ ! -f $hosts_path ]; then
	echo "WOOPS, hosts file does not exist at: $hosts_path"
	echo ""
	exit 1
fi

# New site domain and directory
echo "New local domain (eg projectname.local)?"
read local_domain
echo "Directory new local domain points to (located in $web_root_path)?"
read local_directory

# Create directory new local domain points to
mkdir -p "$web_root_path$local_directory"

# Add entry to vhosts file and run restart command
echo "
<VirtualHost *:$apache_port>
    ServerName $local_domain
    DocumentRoot $web_root_path$local_directory/
    <Directory $web_root_path$local_directory/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>" >> $vhost_path
$apache_restart
echo "vhosts file updated: $vhost_path"

# Add entry to hosts file
echo "
127.0.0.1	$local_domain
" >> $hosts_path
$dns_flush
echo "hosts file updated: $dns_flush"

echo "Done! Access new local domain at $local_domain:$apache_port"
echo ""