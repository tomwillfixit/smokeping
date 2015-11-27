# Smokeping

Smokeping is a really useful tool to graph network latency over time. 

More details about smokeping : http://oss.oetiker.ch/smokeping/

Why run Smokeping using Docker?

It is portable, simple to run from any docker enabled host and it is relatively lightweight.  There are other smokeping images in DockerHub but this is the first based on Alpine Linux which helped keep the image small.

# Build and run Smokeping locally 

Build :
```
docker build -t smokeping:latest .
```

Run : 
```
docker run -d -p 85:80 smokeping:latest
```

Available at http://localhost:85

# Configuration

There are 4 configuration files under the config directory :

services.conf  lighttpd.conf  mod_cgi.conf  smokeping.conf

# services.conf

This contains a list of services to ping.

# lighttpd.conf and mod_cgi.conf

There should be no need change these unless you wish to change the location of the smokeping.cgi script or maybe update to use fast-cgi.

# smokeping.conf

The configuration for the smokeping script. 

# Versions
```
lighttpd : 1.4.36  

smokeping : 2.006011

perl : v5.20.2
```

# Known Issues

None.  Life is good. Ignorance is bliss.

