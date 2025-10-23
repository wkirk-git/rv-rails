.PHONY: build run shell

build:
	docker buildx build --platform linux/amd64,linux/arm64 -t rv-rails .

run:
	docker run -it -p 3000:3000 rv-rails

shell:
	docker run -it --entrypoint /bin/bash rv-rails
