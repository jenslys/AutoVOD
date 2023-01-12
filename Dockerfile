FROM alpine:3.14

#Define an arg variable
ARG	TWITCH_USER

# Upgrade the system and install dependencies

RUN	apk add --no-cache --upgrade python3 tar wget bash jq
RUN	python3 -m ensurepip

RUN 	pip3 install --upgrade streamlink 
RUN 	wget https://github.com/porjo/youtubeuploader/releases/download/22.03/youtubeuploader_22.03_Linux_x86_64.tar.gz 
RUN 	tar -xvf youtubeuploader_22.03_Linux_x86_64.tar.gz && rm youtubeuploader_22.03_Linux_x86_64.tar.gz &&\
	mv youtubeuploader /usr/local/bin/youtubeuploader

# Copy the required files

COPY	${TWITCH_USER}.config /autoVOD/dockeruser.config
COPY	AutoVOD.sh /autoVOD/AutoVOD.sh
COPY	client_secrets.json /autoVOD/client_secrets.json
COPY	request.token /autoVOD/request.token


# Start AutoVod

WORKDIR /autoVOD
CMD	["bash", "AutoVOD.sh", "-ndockeruser"]
