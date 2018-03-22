.PHONY: install uninstall

install:
	stow -v -t $(HOME) -S default

uninstall:
	stow -v -t $(HOME) -D default
