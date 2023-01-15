MAKEFLAGS += --no-print-directory

# Do not remove this block. It is used by the 'help' rule when
# constructing the help output.
##?
##? themepack.fish
##?

##? help       - display this makefile's help information
.PHONY: help
help:
	@grep "^##?" makefile | cut -c 5-

##? pretty     - perform code style format
.PHONY: pretty
pretty:
	fish -c 'fish_indent -w ./tools/tpak'; \
	fish -c 'fish_indent -w ./**/*.fish'

##? bulidman   - build the man pages
.PHONY: buildman
buildman:
	pandoc --standalone --to man ./man/themepack.fish.md -o ./man/man1/themepack.fish.1

##?
