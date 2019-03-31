NAME := serverless
#
GITHUB_USER := marcelocorreia
DOCKER_NAMESPACE := marcelocorreia
IMAGE_NAME := $(DOCKER_NAMESPACE)/$(NAME)
GIT_REPO_NAME := docker-$(NAME)
IMAGE_SOURCE_TYPE ?=
REPO_URL := git@github.com:$(GITHUB_USER)/$(GIT_REPO_NAME).git

GIT_BRANCH ?= master
GIT_REMOTE ?= origin
RELEASE_TYPE ?= patch
SEMVER_DOCKER ?= marcelocorreia/semver

release: _release
build: _docker-build
push: _docker-push

all-versions:
	@git ls-remote --tags $(GIT_REMOTE)
current-version: _setup-versions
	@echo $(CURRENT_VERSION)
next-version: _setup-versions
	@echo $(NEXT_VERSION)

_setup-versions:
	$(eval export CURRENT_VERSION=$(shell git ls-remote --tags $(GIT_REMOTE) | grep -v latest | awk '{ print $$2}'|grep -v 'stable'| sort -r --version-sort | head -n1|sed 's/refs\/tags\///g'))
	$(eval export NEXT_VERSION=$(shell docker run --rm --entrypoint=semver $(SEMVER_DOCKER) -c -i $(RELEASE_TYPE) $(CURRENT_VERSION)))


_docker-build: _setup-versions
	docker build -t $(IMAGE_NAME) -f Dockerfile$(IMAGE_SOURCE_TYPE)  .
	docker build -t $(IMAGE_NAME):$(CURRENT_VERSION) -f Dockerfile$(IMAGE_SOURCE_TYPE) .
	$(call  git_push,Post Release Updating auto generated stuff - version: $(CURRENT_VERSION))

_docker-push: _setup-versions
	docker push $(IMAGE_NAME):latest
	docker push $(IMAGE_NAME):$(CURRENT_VERSION)

_release: _setup-versions ;$(call  git_push,Releasing $(NEXT_VERSION)) ;$(info $(M) Releasing version $(NEXT_VERSION)...)## Release by adding a new tag. RELEASE_TYPE is 'patch' by default, and can be set to 'minor' or 'major'.
	github-release release -u marcelocorreia -r $(GIT_REPO_NAME) --tag $(NEXT_VERSION) --name $(NEXT_VERSION)
	$(MAKE) _docker-build _docker-push

define git_push
	-git add .
	-git commit -m "$1"
	-git push
endef