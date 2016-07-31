# Smokeping

Smokeping is a tool to graph network latency over time. [Website](http://oss.oetiker.ch/smokeping/)

# Slack notifications 

To get Slack Notifications when packet loss has been detected then add your Slack auth token and channel name into the following script :

[slack_notify.sh] (slack_notify.sh)

# Build and run smokeping
```
make build
```

# Run smokeping

The host ip is used by Slack Notifications :

To change alert criteria update : [slack_notify.sh] (slack_notify.sh)
```
make host=<ip> start
```

Available at http://host_ip:85

# Configuration

There are 4 configuration files under the config directory :
```
services.conf  
lighttpd.conf  
mod_cgi.conf  
smokeping.conf
```

## services.conf

This contains a list of services to ping.

## lighttpd.conf and mod_cgi.conf

There should be no need change these unless you wish to change the location of the smokeping.cgi script or maybe update to use fast-cgi.

## smokeping.conf

The configuration for the smokeping script. 

# Versions

lighttpd : 1.4.36  

smokeping : 2.006011

perl : v5.20.2

# Known Issues

None.  Life is good. Ignorance is bliss.

