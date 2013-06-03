Virtual Hosts Helper
====================

Simple bash script to add entry to vhosts and hosts file for local web environments like MAMP.

Setup
-----

1) Open up `vhosts.sh` in a text editor to check configuration.

2) Check `web_root_path` is path to local web root. Example: _/Users/name/Sites/_

3) Check `vhost_path` is correct path to your vhosts file. Example: _/Applications/MAMP/conf/apache/vhosts.conf_

4) Check `apache_restart` contains correct path to `apachectl`. Example: _"/Applications/MAMP/bin/apache2/bin/apachectl restart_

5) Check `apache_port` is the correct port for apache. Default: _8888_

6) Verify vhosts block contains correct configuration (line 58)

Usage
-----

Run as root: `sudo sh vhosts.sh`

1) Enter desired local domain. Example: _newproject.local_

2) Enter desired directory new local domain points to. Example: _newproject_

3) Test new local domain in browser. Example: _http://newproject.local:8888/_
