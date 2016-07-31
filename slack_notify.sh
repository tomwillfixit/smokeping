#!/bin/bash

#Loss description can be found in the smokeping.conf file.

function send_alert {
    # Send a SmokePing status alert to the slack #smokeping channel

    alertname="$1"
    target="$2"
    losspattern="$3"
    rtt="$4"
    hostname="$5"

    case "${alertname}" in
        someloss)
 	    #not ideal but will continue
            color="good" 
            ;;
        highloss)
	    #we will live
            color="warning" 
            ;;
        majorloss)
	    #this is real bad.
            color="danger" 
            ;;
        *)
            echo "Unsupported loss alert name"
esac

    #get current packet loss %. If loss pattern is empty in the slack alert then this is the first place to debug.
    #The loss pattern gets appended to with each probe execution. We want the loss_now value from the pattern
    #Example : 

    #smokeinfo /etc/smokeping/config --filter /Service/google
    #node_path;med_avg;med_min;med_max;med_now;loss_avg;loss_max;loss_now
    #/Service/google;NaN;NaN;NaN;NaN;1.000000e+00;1.000000e+00;1.000000e+00 

    losspattern=$(echo $losspattern | rev | cut -d',' -f 1 | rev)

    echo "Sending Slack alert, Alert: $alertname, Target: $target, Loss Pattern: $losspattern, RTT: $rtt, Hostname: $hostname" >> /tmp/smokeping.log

    data='{
            "username": "SmokePing - Network Latency Check",
            "icon_url": "http://www.free-icons-download.net/images/online-icon-24325.png",
            "attachments": [                                                                                                                                                                   
                {
		    "title": "Alert type : '${alertname}'",
                    "color": "'${color}'"
                },
                {
                    "text": " ",
                    "fields": [
                        { 
                            "title": "Packet Source",
                            "value": "'${HOSTNAME}'",
                            "short": "true"
                        },
                        { 
                            "title": "Packet Destination",
                            "value": "'${target}'('${hostname}')",
                            "short": "true"
                        },
			{
			    "title": "Packet Loss (%)",
                            "value": "'${losspattern}'",
                            "short": "true"
			},
		        {
                            "title": "Graph",
                            "value": "http://'${HOSTNAME}':85/smokeping/cgi-bin/smokeping.cgi?target='${target}'",
                            "short": "true"
                        }
                    ]
                }
            ],
            "channel": "<insert_channel_name_in_here>"
        }'

    echo $data
    curl -X POST -H "Content-type: application/json" --data "$data" https://hooks.slack.com/services/<insert_token_in_here>

}

send_alert "$1" "$2" "$3" "$4" "$5"

exit 0
