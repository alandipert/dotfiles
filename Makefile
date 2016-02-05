DOTFILES_DIR := $(shell pwd)/dotfiles
links = $(wildcard ${DOTFILES_DIR}/*/)
.PHONY: $(links)
install: $(links)
$(links):
	ln -fns $@ ${HOME}/.$(shell basename $@)
stale:
	find ${HOME} -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print
clean:
	find ${HOME} -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete
