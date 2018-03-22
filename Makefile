DOTFILES_DIR := $(shell pwd)/dotfiles
DOTFILES = $(wildcard ${DOTFILES_DIR}/.*/)

.PHONY: install uninstall

install: $(DOTFILES)
	rsync -av $(DOTFILES_DIR)/ $(HOME)/

uninstall:
	for dotfile in $(DOTFILES); do \
		rm -f $$(HOME)/$$(basename $$dotfile); \
	done

print-%:
	@echo '$*=$($*)'
