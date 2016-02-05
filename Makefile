DOTFILES_DIR := $(shell pwd)/dotfiles
links = $(wildcard ${DOTFILES_DIR}/*/)
.PHONY: $(links)
install: $(links)
$(links):
	ln -fns $@ ${HOME}/.$(shell basename $@)
