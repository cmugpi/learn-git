N = $(PWD)/node_modules/.bin/

.SUFFIXES:
.PHONY: all clean

all: node_modules build/pres.html

clean:
	rm -rf build

node_modules:
	npm i

build/%.html: src/%.md src/%.css
	mkdir -p $(dir $@)
	$(N)markdown-to-slides -d --level 2 -i -s src/$*.css -o $@ $< $(Q)
