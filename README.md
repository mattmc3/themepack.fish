# themepak.fish

> Popular Fish color schemes

## Description

In its [3.4 release][fish_3_4], The Fish shell defined a new way of handling themes. Setting themes has always been available via the `fish_config` web interface, but now there is a robust command line interface as well as the ability to easily define your own themes with `.theme` files. Many great Fish theme plugins have taken awhile to catch up to this new method. This Theme Pack pulls together some of the best [Fish themes][gh-topic-fish-theme] into one place and gives you access to all the goodies that come now with using `.theme` files.

Setting up themes this way gives support for [the built-in theme configuration commands](fish_config].

```fish
fish_config theme (choose | demo | dump | list | save | show)
```

## Installation

You likely don't want every single theme, so you can just install individual themes like so:

```fish
set theme_name tokyonight_night.theme
curl -fsSL https://raw.githubusercontent.com/mattmc3/themepak.fish/refs/heads/main/themes/$theme_name -o ~/.config/fish/themes/$theme_name
```

To get every single theme, you can install themepak.fish is with [Fisher][fisher].

```fish
fisher install mattmc3/themepak.fish
```

## Theme selection

Once you have installed themepak.fish, you should see the new themes when you run the `fish_config` web interface. You can also select the theme via the command line interface (CLI).

```fish
fish_config theme choose gruvbox
```

If you don't see the themes when you run `fish_config` make sure you have `XDG_CONFIG_HOME` properly set and exported. `fish_config` expects this variable.

```fish
set -Ux XDG_CONFIG_HOME $HOME/.config
```

## Discover great Fish themes

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
