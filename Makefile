SERVICE_NAME=panda50-front

release: 
	docker build -t panda50-front .

run:
	docker run --rm --name panda50-front -p 8080:8080 -d panda50-front

stop:
	docket stop panda50-front

