DOCKER_TAG=oxygen

build:
	export DOCKER_TAG=$(DOCKER_TAG);export IMAGE_NAME="nouchka/eclipse:$(DOCKER_TAG)"; ./hooks/build
