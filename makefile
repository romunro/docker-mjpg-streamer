# build:
# 	docker build -t ronnieonthehub/mjpg-streamer:latest	.
buildamd:
	docker buildx build --platform linux/amd64 -t alpine-amd64 --load .

buildarm64:
	docker buildx build --platform linux/arm64/v8 -t alpine-arm64/v8 --load .

buildarm32:
	docker buildx build --platform linux/arm/v8 -t ronnieonthehub/mjpg-streamer:arm32 --load .

build:
	docker buildx build --push --platform linux/arm64/v8,linux/amd64  --tag ronnieonthehub/mjpg-streamer:latest .
# 	docker buildx build  --platform linux/amd64,linux/arm64/v8 -t ronnieonthehub/mjpg-streamer:latest --push .

push:
	docker push ronnieonthehub/mjpg-streamer:latest

pull:
	docker image pull ronnieonthehub/mjpg-streamer:latest

run:
	-mkdir volume
	-docker stop ronnie
	-docker rm ronnie
	docker run --name ronnie -it \
	-d alpine-amd64 /bin/bash
	docker exec -it ronnie /bin/bash

clean:
	docker system prune
