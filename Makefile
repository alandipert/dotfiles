DOTFILES_DIR := $(shell pwd)/dotfiles
links = $(wildcard ${DOTFILES_DIR}/*/)
.PHONY: $(links)
install: $(links)
$(links):
	ln -fns $@ ${HOME}/.$(shell basename $@)
clean:
	for link in $(links); do \
		rm -rf $${HOME}/.$$(basename $$link); \
	done
