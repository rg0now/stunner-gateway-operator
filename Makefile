VERSION = 0.0.1
TAG = $(VERSION)
PREFIX = nginx-gateway

GIT_COMMIT = $(shell git rev-parse HEAD)
DATE = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

TARGET ?= local

KIND_KUBE_CONFIG_FOLDER = $${HOME}/.kube/kind

export DOCKER_BUILDKIT = 1

.PHONY: container
container: build
	docker build --build-arg VERSION=$(VERSION) --build-arg GIT_COMMIT=$(GIT_COMMIT) --build-arg DATE=$(DATE) --target $(TARGET) -f build/Dockerfile -t $(PREFIX):$(TAG) .

.PHONY: build
build:
ifeq (${TARGET},local)
	CGO_ENABLED=0 GOOS=linux go build -trimpath -a -ldflags "-s -w -X main.version=${VERSION} -X main.commit=${GIT_COMMIT} -X main.date=${DATE}" -o gateway github.com/nginxinc/nginx-gateway-kubernetes/cmd/gateway
endif

.PHONY: deps
deps:
	@go mod tidy && go mod verify && go mod download

.PHONY: create-kind-cluster
create-kind-cluster:
	kind create cluster --image kindest/node:v1.22.1
	kind export kubeconfig --kubeconfig $(KIND_KUBE_CONFIG_FOLDER)/config

.PHONY: delete-kind-cluster
delete-kind-cluster:
	kind delete cluster