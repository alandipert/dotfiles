DOTFILES_DIR := $(shell pwd)/dotfiles
sources = $(wildcard ${DOTFILES_DIR}/*/)
.PHONY: $(sources)
install: $(sources)
$(sources):
	cp -RT $@ ${HOME}/.$(shell basename $@)
