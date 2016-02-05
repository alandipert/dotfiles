DOTFILES_DIR := $(shell pwd)
LN_FLAGS = -fs
symlinks = \
	bash_profile \
	screenrc \
	tmux.conf \
	vimrc
.PHONY: $(symlinks)
install: $(symlinks)
$(symlinks):
	ln $(LN_FLAGS) $(DOTFILES_DIR)/$@ ${HOME}/.$@
stale:
	find ${HOME} -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -print
clean:
	find ${HOME} -maxdepth 1 -name '.*' -type l -exec test ! -e {} \; -delete
