# fancy output: prompt and quiet
M = $(shell printf "\033[34;1m▶\033[0m")
Q = $(if $(filter 1,0),,@)

# basic env
DATE ?= $(shell date +%FT%T%z)
VERSION ?= $(shell git describe --tags --always --dirty --match=v* 2> /dev/null || cat $(CURDIR)/.version 2> /dev/null || echo v0)

# project paths
BINARY := main
PKGS := $(shell go list ./... | grep -v /vendor)
DEPLOY_DIR := deploy
BIN_DIR := $(GOPATH)/bin

.PHONY: all
all: vendor lint test build package
	@echo Building is done, run \"make deploy\" to deploy to AWS.

GLIDE := $(BIN_DIR)/glide
$(GLIDE): ; $(info $(M) getting glide)
	$Q go get -u github.com/Masterminds/glide
	$Q $(BIN_DIR)/glide install

GOMETALINTER := $(BIN_DIR)/gometalinter
$(GOMETALINTER): ; $(info $(M) getting gometalinter…)
	$Q go get -u github.com/alecthomas/gometalinter
	$Q $(BIN_DIR)/gometalinter --install

vendor: $(GLIDE) ; $(info $(M) getting dependencies…)
	$Q $(BIN_DIR)/glide update
	$Q $(BIN_DIR)/glide install

.PHONY: test
test: vendor lint ; $(info $(M) testing…)
	go test $(PKGS)

.PHONY: lint
lint: $(GOMETALINTER) ; $(info $(M) linting…)
	$Q $(GOMETALINTER) --vendor --disable gotype --deadline=90s ./...

.PHONY: build
build: vendor lint test ; $(info $(M) building…)
	$Q GOOS=linux GOARCH=amd64 go build -o bin/$(BINARY)

.PHONY: package
package: build ; $(info $(M) packaging…)
	$Q mkdir -p deploy && cd bin && zip -q ../deploy/main.zip main

.PHONY: deploy
deploy: package ; $(info $(M) deploying…)
	$Q aws lambda update-function-code --function-name lambda-go --zip-file fileb://deploy/main.zip --region us-east-1

.PHONY: clean
clean: ; $(info $(M) cleanup…)
	@rm -rf bin
	@rm -rf deploy
	@rm -rf test
	@rm -rf vendor
