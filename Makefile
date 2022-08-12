REPO ?= thiswebsitedoesnottrackyou/thiswebsitedoesnottrackyou.com
GITSHA=$(shell git rev-parse --short HEAD)
TAG_COMMIT=$(REPO):$(GITSHA)
TAG_LATEST=$(REPO):latest

all: dev

.PHONY: build
build:
	@docker build -t $(TAG_LATEST) .

.PHONY: publish
publish:
	docker push $(TAG_LATEST)
	@docker tag $(TAG_LATEST) $(TAG_COMMIT)
	docker push $(TAG_COMMIT)

.PHONY: dev
dev:
	open http://0.0.0.0:8000
	cd public && python3 -m http.server
