SHELL                 = /bin/bash
APP_NAME			  = pos
VERSION               = $(shell git describe --always --tags)
GIT_COMMIT            = $(shell git rev-parse HEAD)
GIT_DIRTY             = $(shell test -n "`git status --porcelain`" && echo "+CHANGES" || true)
BUILD_DATE            = $(shell date '+%Y-%m-%d-%H:%M:%S')
MODULE_NAME			  = "github.com/faspay/pos"
APP_FLAG			  = $(flag)
MIGRATION_NAME		  = $(name)
MIGRATION_DIR		  = $(direction)
PROTO_DIR			  = shared/proto

.PHONY: default
default: help

.PHONY: help
help:
	@echo 'Management commands for ${APP_NAME}:'
	@echo
	@echo 'Usage:'
	@echo '    make build                              Compile the project.'
	@echo '    make package                            Build, tag, and push Docker image.'
	@echo '    make deploy                             Deploy to Kubernetes via Helmfile.'
	@echo '    make rollback RELEASE= REVISION=        Rollback via Helm. If REVISION is omitted, it will roll back to the previous release.'
	@echo '    make run flag=                          Run with supplied arguments.'
	@echo '    make test                               Run tests on a compiled project.'
	@echo '    make clean                              Clean the directory tree.'
	@echo '    make newmigrate name=               	   Create new migration file with supplied name.'
	@echo '    make migrate direction=                 Running migration file with supplied direction (up/down).'
	@echo

.PHONY: build
build:
	@echo "Building ${APP_NAME}"
	go build -ldflags "-w -X ${MODULE_NAME}/version.GitCommit=${GIT_COMMIT}${GIT_DIRTY} -X ${MODULE_NAME}/version.Version=${VERSION} -X ${MODULE_NAME}/version.Environment=${ENV} -X ${MODULE_NAME}/version.BuildDate=${BUILD_DATE}" -o bin/${APP_NAME}

.PHONY: run
run: build
	@echo "Running ${APP_NAME}"
	bin/${APP_NAME} ${APP_FLAG}

.PHONY: test
test:
	@echo "Testing ${APP_NAME}"
	go test -race ./...

.PHONY: clean
clean:
	@echo "Removing ${APP_NAME}"
	@test ! -e bin/${APP_NAME} || rm bin/${APP_NAME}

.PHONY: newmigrate
newmigrate:
	@echo "Generating new migration file"
	echo -e "-- +migrate Up\r\n-- SQL in section 'Up' is executed when this migration is applied\r\n-- [your SQL script here]\r\n\r\n\r\n-- +migrate Down\r\n-- SQL section 'Down' is executed when this migration is rolled back\r\n-- [your SQL script here]" > "migration/postgres/$(shell date +%s)_${MIGRATION_NAME}.sql"

.PHONY: migrate
migrate: build
	@echo "Running migration ${APP_NAME}"
	bin/${APP_NAME} migrate direction=${direction}

.PHONY: proto
proto:
	@echo "Compiling protobuf in ${PROTO_DIR}"
	protoc --go_out=. --go_opt=paths=source_relative \
	--go-grpc_out=. --go-grpc_opt=paths=source_relative ${PROTO_DIR}/*.proto;
