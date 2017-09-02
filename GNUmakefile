N = $(PWD)/node_modules/.bin/

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: %.html

all: build/pres.html

clean:
	rm -rf build

build/%.html: src/%.md
	mkdir -p $(dir $@)
	$(N)markdown-to-slides -d --level 2 -o $@ $<
