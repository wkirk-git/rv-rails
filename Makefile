.PHONY: build run

build:
	docker buildx build --platform linux/arm64 -t rv-rails .

run:
	docker run -it -p 3000:3000 rv-rails