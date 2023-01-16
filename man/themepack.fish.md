---
title: themepack.fish
section: 1
header: themepack.fish manual
---

# NAME

**themepack.fish** - add more themes to Fish

# SYNOPSIS

| themepack [-v | --version] [-h | --help] <command> [<args> ...]
| themepack list
| themepack generate [(-g | --generator) GENERATOR] [(-t | --template) TEMPLATE]
|                    [(-n | --name) NAME] FILE

# DESCRIPTION

**themepack** adds more themes to Fish.

# OPTIONS

-h, \--help
:   Show context-sensitive help for themepack.

-v, \--version
:   Show currently installed themepack version.

# LIST SUBCOMMAND

**themepack list** lists available color schemes.

# GENERATE SUBCOMMAND

**themepack generate** generates a Fish .theme file.

The _\-\-generator_ option tells themepack what kind of color file is provided. If _\-\-generator_ is not specified _default_ is assumed.

Alacritty YAML files are also supported. The Alacritty generator can be used with the option _\-\-generator=alacritty_. Currently, no other color scheme generators are supported, however you can easily expand the available themepack generators by implementing your own function called '__themepack_generator_XXXXX' where _XXXXX_ is whatever name you want to pass to _\-\-generator_.

A _\-\-template_ is simply a Fish function whose job it is to output the _.theme_ file contents. If _\-\-template_ is not specified, then _default_ is assumed.

_FILE_ is the color file the generator uses to feed the template to create the theme file. This file should be in the themepack JSON format, unless a different _\-\-generator_ is provided.

# SEE ALSO

For more information, visit https://github.com/mattmc3/themepack.fish
