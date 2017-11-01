N = $(PWD)/node_modules/.bin/

.SUFFIXES:
.PHONY: all clean

all: node_modules \
	$(patsubst src/%.md,build/%.html,$(shell find src -name '*.md'))

clean:
	rm -rf build

node_modules:
	npm i

build/%.html: src/%.md src/style.css
	mkdir -p $(dir $@)
	$(N)markdown-to-slides -d --level 2 -i -s src/style.css -o $@ $< $(Q)
