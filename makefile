build:
	docker build -t smokeping:latest .

start:
	docker run -d --restart=always --hostname $(host) --name smokeping -v ${PWD}/config/smokeping.conf:/etc/smokeping/config -v ${PWD}/config/beng.conf:/etc/smokeping/beng.conf -p 85:80 smokeping:latest 

status:
	docker ps |grep smokeping

#Useful if you want to update a file in the config directory and get the change picked up
restart:
	docker restart smokeping
stop:
	docker stop smokeping

clean:
	docker rm -f smokeping

#send a test message to slack
slack:
	docker exec -it smokeping /bin/sh -c "/tmp/slack_notify.sh"
