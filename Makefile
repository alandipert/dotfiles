DOTFILES_DIR := $(shell pwd)/dotfiles
PRE_ARG := $(shell mkdir -p ${HOME}/.local/foobar/bin)
links = $(wildcard ${DOTFILES_DIR}/*/)
.PHONY: $(links)
install: $(links)
$(links):
	ln -fns $@ ${HOME}/.$(shell basename $@)
uninstall:
	git clean -fdx
	for link in $(links); do \
		rm -f $${HOME}/.$$(basename $$link); \
	done
