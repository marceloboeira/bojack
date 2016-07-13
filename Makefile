CRYSTAL_BIN ?= $(shell which crystal)
BOJACK_BIN ?= $(shell which bojack)
PREFIX ?= /usr/local

build:
	$(CRYSTAL_BIN) compile --release -o bin/bojack src/bojack/cli.cr $(CRFLAGS)

clean:
	rm -f ./bin/bojack

test: build
	$(CRYSTAL_BIN) spec

install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/bojack $(PREFIX)/bin

reinstall: build
	cp ./bin/bojack $(BOJACK_BIN) -rf
