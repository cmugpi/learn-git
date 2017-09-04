N = $(PWD)/node_modules/.bin/

.SUFFIXES:
.PHONY: all clean watch
.PRECIOUS: node_modules build/%.html

all: node_modules build/pres.html

clean:
	rm -rf build

watch:
	trap exit INT && find src | entr -c $(MAKE)

node_modules:
	npm i

build/%.html: src/%.md src/%.css
	mkdir -p $(dir $@)
	$(N)markdown-to-slides -d --level 2 -i -s src/$*.css -o $@ $<
