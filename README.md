# dotfiles

My dotfiles. I clone this on machines I use and type `make` to synchronize the
`dotfiles` directory to the home directory, prepending each file with a dot.

Installation:

    git clone https://github.com/alandipert/dotfiles.git && make
    
Housekeeping:

    git pull -f # update the repo
    make stale # see a list of symlinks in ~ that are bad (dotfiles were removed)
    make clean # delete bad symlinks in ~
