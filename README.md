# MongoDB

This cookbook is an attempt to create a initial prototype to install mongodb server on a node. The cookbook assumes that we are using centos version 8 and that http and https ports are open on firewall to enable communication from chef server to node.


# Files

The mail files in this cookbook are default.rb in recipies directory which has the code to install the mongo server.
The other file is the redhat-mongodb.init.erb file in templates directory which has the init file file.
We have a definition/default.rb file that helps us to initialize the init file and set directory permissions
Other files being the default.rb, repository.rb and ulimit.rb in attributes directory that holds the values that are being used in recipies/default.rb file.


## Running the Cookbook

Clone the cookbook in your workstation cookbooks directory and upload to chef-server. Add this cookbook to the run list for a desired node.
Please open ports in firewall for http, https.
Login to your node and run chef-client.

## Status Check for Mongo
we can check the status if the mongod server is running or not using 

> systemctl status mongod.service


