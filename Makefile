
TARGET=gradescores
PACKAGES=utils

.PHONY: all
all: build

build:
		@go build -o ./bin/$(TARGET) -mod=vendor

