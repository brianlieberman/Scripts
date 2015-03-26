Scripts
=======

Various scripts used for system management and automation

-DFSPermissions.ps1
Used to audit changes to DFS file shares specified in the array and output any changes in a machine parasable format.
Currently used in conjunction with Splunk to demonstrate SOX compliance.

-AMXCGI.sh
Used with an Apache web server as a CGI page to parse the passed query string and either passes the paramters to changeDevice.sh or passes the user through to the device depending on what is entered.  This allows changing of a virtual panel to control our A/V systems in the confrence rooms. 


-changeDevice.sh
Uses 'expect' to spawn a telnet session to the vitrual panel and reconfigure the virtual panel to the desired room the user selected.

