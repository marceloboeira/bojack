CRYSTAL_BIN ?= $(shell which crystal)
BOJACK_BIN ?= $(shell which bojack)
PREFIX ?= /usr/local

build:
	$(CRYSTAL_BIN) deps
	$(CRYSTAL_BIN) build --release -o bin/bojack src/bojack/bootstrap.cr $(CRFLAGS)

dev:
	$(CRYSTAL_BIN) build -o bin/bojack src/bojack/bootstrap.cr $(CRFLAGS)

clean:
	rm -f ./bin/bojack

test:
	$(CRYSTAL_BIN) spec --verbose

spec: test

install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/bojack $(PREFIX)/bin

reinstall: build
	cp -rf ./bin/bojack $(BOJACK_BIN)
