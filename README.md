# themepack.fish

> Popular Fish color schemes


## Description

In its [3.4 release][fish_3_4], The Fish shell defined a new way of handling themes. Setting themes has always been available via the `fish_config` web interface, but now there is a robust command line interface as well as the ability to easily define your own themes with `.theme` files. Many great Fish theme plugins have taken awhile to catch up to this new method. This Theme Pack pulls together some of the best [Fish themes][gh-topic-fish-theme] into one place and gives you acceess to all the goodies that come now with using `.theme` files.

Setting up themes this way gives support for [the built-in theme configuration commands](fish_config].

```fish
fish_config theme (choose | demo | dump | list | save | show)
```

themepak.fish is not meant to house every theme. Its intent is to expand the selection of themes you already get with Fish by including additional high-quality themes. This theme pack is designed to co-exist with other [properly constructed theme plugins](#fish-theme-plugin-conventions) without having to uninstall it to try a new theme.

## Installation

The recommended way to install themepack.fish is with [Fisher][fisher], the popular Fish plugin manager.

```fish
fisher install mattmc3/themepack.fish
```

## Theme seletion

Once you have installed themepack.fish, you should see the new themes when you run the `fish_config` web interface. You can also select the theme via the command line interface (CLI).

```fish
fish_config theme choose gruvbox
```

If you don't see the themes when you run `fish_config` make sure you have `XDG_CONFIG_HOME` properly set and exported.

```fish
set -Ux XDG_CONFIG_HOME $HOME/.config
```

## Conventions

My preference would be that theme authors host their own themes rather than pulling theme into a single theme pack. However, the current state of Fish themes is pretty rough, and many of the theme plugins available today are just not set up well. The addition of `.theme` files to Fish gives us a chance to rectify that. As such, I'd like to pose a simple set of Fish theme conventions.

### Fish Theme Plugin Conventions

A proper Fish theme plugin meets these simple criteria. The theme:

- is color scheme only (no prompts)
- is defined using Fish `.theme` files and works with `fish_config`
- can co-exist with other themes (ie: **NO** _only-set-this-theme_ scripts in `conf.d`)
- is maintained, and defines nearly all modern Fish color variables
- is properly installable with a theme-aware plugin manager (eg: [Fisher][fisher])
- is properly labeled for discoverability (ie: using GitHub's [fish-theme topic][gh-topic-fish-theme])


## Adding themepack.fish themes

If you have a popular theme that you think should be included in this theme pack, feel free to [open an issue](https://github.com/mattmc3/themepack.fish/issues).

In an effort to not bloat this project with too many themes, only a limited number of well-known, popular themes (with a permissive open source license) will be accepted. Also, most themes will not be included if they already exist as a stand-alone plugin meeting all the [Fish Theme Plugin Conventions](#fish-theme-plugin-conventions). However, this project will [maintain a list of those themes](#other-great-themes).

## Discover great Fish themes

### Themes included in this themepack.fish:

- [gruvbox][gruvbox]
- [Lighthaus][lighthaus]
- [TokyoNight][tokyonight]

### Other great themes

- [catppuccin](https://github.com/catppuccin/fish)

### Themes included with Fish

- [fish default][fish_incl_themes]
- [ayu Dark][fish_incl_themes]
- [ayu Light][fish_incl_themes]
- [ayu Mirage][fish_incl_themes]
- [Base16 Default Dark][fish_incl_themes]
- [Base16 Default Light][fish_incl_themes]
- [Base16 Eighties][fish_incl_themes]
- [Bay Cruise][fish_incl_themes]
- [Cool Beans][fish_incl_themes]
- [Dracula][fish_incl_themes]
- [Fairground][fish_incl_themes]
- [Just a Touch][fish_incl_themes]
- [Lava][fish_incl_themes]
- [Mono Lace][fish_incl_themes]
- [Mono Smoke][fish_incl_themes]
- [(Almost) No Colors][fish_incl_themes]
- [Nord][fish_incl_themes]
- [Old School][fish_incl_themes]
- [Seaweed][fish_incl_themes]
- [Snow Day][fish_incl_themes]
- [Solarized Dark][fish_incl_themes]
- [Solarized Light][fish_incl_themes]
- [Tomorrow Night Bright][fish_incl_themes]
- [Tomorrow Night][fish_incl_themes]
- [Tomorrow][fish_incl_themes]


[fish_config]:          https://fishshell.com/docs/current/cmds/fish_config.html
[fish_3_4]:             https://github.com/fish-shell/fish-shell/releases/tag/3.4.0
[fisher]:               https://github.com/jorgebucaran/fisher
[gh-topic-fish-theme]:  https://github.com/topics/fish-theme
[gruvbox]:              https://github.com/morhetz/gruvbox
[lighthaus]:            https://github.com/lighthaus-theme/fish
[tokyonight]:           https://github.com/folke/tokyonight.nvim
[fish_incl_themes]:     https://github.com/fish-shell/fish-shell/tree/master/share/tools/web_config/themes
