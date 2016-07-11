CRYSTAL_BIN ?= $(shell which crystal)
BOJACK_BIN ?= $(shell which bojack-server)
PREFIX ?= /usr/local

build:
	$(CRYSTAL_BIN) compile --release -o bin/bojack-server src/bojack/run.cr $(CRFLAGS)

clean:
	rm -f ./bin/bojack-server

test: build
	$(CRYSTAL_BIN) spec

install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/bojack-server $(PREFIX)/bin

reinstall: build
	cp ./bin/bojack-server $(BOJACK_BIN) -rf
