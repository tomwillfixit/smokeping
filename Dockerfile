#Description

#Smokeping is a tool to graph network latency over time.
#This image contains the smokeping tool and a lighttpd webserver to display the graphs.
#It was built on a alpine linux image in order to keep the image size as small as possible.

#Build : docker build -t smokeping:latest .

#Run : docker run -d -p 85:80 smokeping:latest

#Available at http://<server ip>:85

FROM alpine:3.4

MAINTAINER tomwillfixit 

RUN apk add --update smokeping lighttpd perl-cgi bash curl bc && rm -rf /var/cache/apk/*

#Creating Directory Structure

RUN [ -d /usr/data ] || mkdir -p /usr/data && \
    [ -d /usr/cache/smokeping ] || mkdir -p /usr/cache/smokeping

#Setup smokeping directories

RUN mkdir -p /var/www/smokeping/cgi-bin && \
    cp -r /usr/share/webapps/smokeping/* /var/www/smokeping/cgi-bin/ && \
    ln -s /usr/cache/smokeping /var/www/smokeping/cgi-bin/cache

#Change permissions and ownership

RUN chown -R lighttpd:lighttpd /usr/data /usr/cache /var/www/smokeping
RUN chmod -R g+ws /usr/data /usr/cache /var/www/smokeping

# Using prebaked config files since there are alot of variables to be changed.

ADD config/lighttpd.conf /etc/lighttpd/lighttpd.conf
ADD config/mod_cgi.conf /etc/lighttpd/mod_cgi.conf
ADD config/smokeping.conf /etc/smokeping/config
ADD config/services.conf /etc/smokeping/services.conf

ADD slack_notify.sh /tmp/slack_notify.sh
RUN chmod 777 /tmp/slack_notify.sh
RUN chown smokeping:smokeping /tmp/slack_notify.sh

ADD entry.sh /tmp/entry.sh
RUN chmod 777 /tmp/entry.sh

EXPOSE 80

ENTRYPOINT /tmp/entry.sh

