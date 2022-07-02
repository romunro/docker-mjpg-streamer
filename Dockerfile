FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get update && apt-get install git cmake make build-essential libjpeg-dev imagemagick subversion libv4l-dev checkinstall libjpeg8-dev libv4l-0 -y
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/jacksonliam/mjpg-streamer.git 

WORKDIR /mjpg-streamer/mjpg-streamer-experimental

RUN make 
RUN make install

ENV DEV_VIDEO="/dev/video0"
ENV MJPG_PORT='9090'
ENV MJPG_STREAMER_INPUT="-r 1920x1080 -f 20"

EXPOSE 9090

CMD mjpg_streamer -i "input_uvc.so -d $DEV_VIDEO $MJPG_STREAMER_INPUT" -o "output_http.so -w ./www -p $MJPG_PORT"