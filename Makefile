DOCKERFILE := Dockerfile.template
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
ROOT_DIR_PATH := $(dir $(MKFILE_PATH))
CONFIG_PATH := ${ROOT_DIR_PATH}config.json
DOCKER_BAKERY_PATH := /home/dev/bin/docker-bakery
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
HASH := $(shell git rev-parse HEAD)

.DEFAULT_GOAL: usage

# tell Makefile not to search files with such names and run tasks unconditionally 
.PHONY: usage debug show-structure dump-latest-versions build-patch build-patch-all build-minor build-minor-all build-major build-major-all push-patch push-patch-all push-minor push-minor-all push-major push-major-all

usage:
	@echo "Use one of following commands:"
	@echo "\tmake show-structure - shows structure of the images"
	@echo "\tmake dump-latest-versions - dumps latest versions of the images to json file"
	@echo "\tmake build-patch - build next patch version of the image without triggering of dependant build"
	@echo "\tmake build-minor - build next minor version of the image without triggering of dependant build"
	@echo "\tmake build-major - build next major version of the image without triggering of dependant build"
	@echo "\tmake build-patch-all - build next patch version of the image and trigger dependant builds"
	@echo "\tmake build-minor-all - build next minor version of the image and trigger dependant builds"
	@echo "\tmake build-major-all - build next major version of the image and trigger dependant builds"
	@echo "\tmake push-patch - push next patch version of the image without triggering push of dependants"
	@echo "\tmake push-minor - push next patch version of the image without triggering push of dependants"
	@echo "\tmake push-major - push next patch version of the image without triggering push of dependants"
	@echo "\tmake push-patch-all - push next patch version of the image and trigger push of dependants"
	@echo "\tmake push-minor-all - push next patch version of the image and trigger push of dependants"
	@echo "\tmake push-major-all - push next patch version of the image and trigger push of dependants"

debug:
	@echo "Using following configuration:"
	@echo "\tMKFILE_PATH: ${MKFILE_PATH}"
	@echo "\tROOT_DIR_PATH: ${ROOT_DIR_PATH}"
	@echo "\tCONFIG_PATH: ${CONFIG_PATH}"
	@echo "\tDOCKER_BAKERY_PATH: ${DOCKER_BAKERY_PATH}"
	@echo "\tBRANCH: ${BRANCH}"

show-structure:
	${DOCKER_BAKERY_PATH} show-structure -c ${CONFIG_PATH}

dump-latest-versions:
	${DOCKER_BAKERY_PATH} dump-latest-versions -c ${CONFIG_PATH}

build-patch:
	${DOCKER_BAKERY_PATH} build -s patch -c ${CONFIG_PATH} -d ${DOCKERFILE} -p BRANCH=${BRANCH} --skip-dependants

build-patch-all:
	${DOCKER_BAKERY_PATH} build -s patch -c ${CONFIG_PATH} -d ${DOCKERFILE} -p BRANCH=${BRANCH}

build-minor:
	${DOCKER_BAKERY_PATH} build -s minor -c ${CONFIG_PATH} -d ${DOCKERFILE} --skip-dependants

build-minor-all:
	${DOCKER_BAKERY_PATH} build -s minor -c ${CONFIG_PATH} -d ${DOCKERFILE} -p BRANCH=${BRANCH}

build-major:
	${DOCKER_BAKERY_PATH} build -s major -c ${CONFIG_PATH} -d ${DOCKERFILE} -p BRANCH=${BRANCH} --skip-dependants

build-major-all:
	${DOCKER_BAKERY_PATH} build -s major -c ${CONFIG_PATH} -d ${DOCKERFILE} -p BRANCH=${BRANCH}

push-patch:
	${DOCKER_BAKERY_PATH} push -s patch -c ${CONFIG_PATH} -d ${DOCKERFILE} --skip-dependants

push-patch-all:
	${DOCKER_BAKERY_PATH} push -s patch -c ${CONFIG_PATH} -d ${DOCKERFILE}

push-minor:
	${DOCKER_BAKERY_PATH} push -s minor -c ${CONFIG_PATH} -d ${DOCKERFILE} --skip-dependants

push-minor-all:
	${DOCKER_BAKERY_PATH} push -s minor -c ${CONFIG_PATH} -d ${DOCKERFILE}

push-major:
	${DOCKER_BAKERY_PATH} push -s major -c ${CONFIG_PATH} -d ${DOCKERFILE} --skip-dependants

push-major-all:
	${DOCKER_BAKERY_PATH} push -s major -c ${CONFIG_PATH} -d ${DOCKERFILE}
