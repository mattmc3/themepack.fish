function themepack \
    -d "Add more themes to Fish" \
    -a cmd

    set -l themepack_version 1.0.0
    set -q XDG_CACHE_HOME || set XDG_CACHE_HOME $HOME/.cache
    set -l cachedir $XDG_CACHE_HOME/themepack.fish; mkdir -p $cachedir
    if not test -d $cachedir/iterm2cs
        git clone --depth 1 --quiet https://github.com/mbadolato/iTerm2-Color-Schemes $cachedir/iterm2cs 2>/dev/null
    end

    switch "$cmd"
        case ''
            echo "themepack: missing subcommand"
            echo ""
            echo "(Type 'themepack --help' for documentation)"
        case -v --version
            echo "themepack, version $themepack_version"
        case -h --help
            man themepack.fish
        case update
            echo "Refreshing iTerm2-Color-Schemes..."
            git -C $cachedir/iterm2cs pull
        case list
            for file in $cachedir/iterm2cs/alacritty/*.yml
                path basename (path change-extension '' $file)
            end
        case generate
            set -l usage "Usage: themepack generate [(-n | --name) NAME]" \
                         "                          [(-g | --generator) GENERATOR]" \
                         "                          [(-t | --template) TEMPLATE] FILE"

            # parse args
            argparse --name=themepack 'n/name=' 'g/generator=' 't/template=' -- $argv[2..]
            or return 1

            test -n "$_flag_generator" || set _flag_generator alacritty
            set -l fn_generator "__themepack_generator_"$_flag_generator
            test -n "$_flag_template" || set _flag_template default
            set -l fn_template "__themepack_template_"$_flag_template

            # validate args
            set -l errmsg
            if not test (count $argv) -eq 1
                set errmsg "themepack generate: Expecting argument 'FILE'."
            else if not test -s $argv
                set errmsg "themepack generate: File not found '$argv'."
            else if not functions --query $fn_generator
                set errmsg "themepack generate: Generator not found '$_flag_generator'."
            else if not functions --query $fn_template
                set errmsg "themepack generate: Template not found '$_flag_template'."
            end
            if test -n "$errmsg"
                printf >&2 "%s\n" $errmsg "" $usage
                return 1
            end

            if test -z "$_flag_name"
                set _flag_name (path basename (path change-extension '' $argv))
            end
            $fn_generator "$_flag_name" "$_flag_template" "$argv"
            return $status
        case '*'
            echo >&2 "themepack: Unknown command: '$cmd'." && return 1
    end
end

function __themepack_generator_alacritty -a name template ymlfile
    if not type yq &>/dev/null
        echo >&2 "themepack generate: Required command not found 'yq'."
        echo >&2 ""
        echo >&2 "Use your OS package manager to install (ie: brew install yq)."
        return 1
    end

    # colors.primary.background = #c0ffee
    # transform =>
    # set -l colors_primary_background c0ffee
    set -l code (
        yq -o=props $ymlfile |
        string match -rev '^\#' |
        string replace -r '^' 'set -l ' |
        string replace -a '.' '_' |
        string replace -r '= (#|0x)' ''
    )
    eval (string join ';' $code)

    set -l fn_template "__themepack_template_"$template
    $fn_template \
        --name=$name \
        --bg=$colors_primary_background \
        --fg=$colors_primary_foreground \
        --black=$colors_normal_black \
        --red=$colors_normal_red \
        --green=$colors_normal_green \
        --yellow=$colors_normal_yellow \
        --blue=$colors_normal_blue \
        --magenta=$colors_normal_magenta \
        --cyan=$colors_normal_cyan \
        --white=$colors_normal_white \
        --brblack=$colors_bright_black \
        --brred=$colors_bright_red \
        --brgreen=$colors_bright_green \
        --bryellow=$colors_bright_yellow \
        --brblue=$colors_bright_blue \
        --brmagenta=$colors_bright_magenta \
        --brcyan=$colors_bright_cyan \
        --brwhite=$colors_bright_white
end

function __themepack_template_default
    set -l options \
        'name=' 'bg=' 'fg=' \
        'black=' 'red=' 'green=' 'yellow=' 'blue=' 'magenta=' 'cyan=' 'white=' \
        'brblack=' 'brred=' 'brgreen=' 'bryellow=' 'brblue=' 'brmagenta=' 'brcyan=' 'brwhite='

    # parse args
    argparse --name=themepack_template_default $options -- $argv
    or return 1

    set -l theme \
        "# name: \"$_flag_name\"" \
        "# preferred_background: $_flag_bg" \
        "" \
        "fish_color_autosuggestion 555 $_flag_brblack" \
        "fish_color_cancel -r" \
        "fish_color_command $_flag_blue" \
        "fish_color_comment $_flag_red" \
        "fish_color_cwd $_flag_green" \
        "fish_color_cwd_root $_flag_red" \
        "fish_color_end $_flag_green" \
        "fish_color_error $_flag_brred" \
        "fish_color_escape $_flag_brcyan" \
        "fish_color_history_current --bold" \
        "fish_color_host normal" \
        "fish_color_host_remote $_flag_yellow" \
        "fish_color_keyword $_flag_blue" \
        "fish_color_match --background=$_flag_brblue" \
        "fish_color_normal normal" \
        "fish_color_operator $_flag_brcyan" \
        "fish_color_option $_flag_cyan" \
        "fish_color_param $_flag_cyan" \
        "fish_color_quote $_flag_yellow" \
        "fish_color_redirection $_flag_cyan --bold" \
        "fish_color_search_match $_flag_bryellow --background=$_flag_brblack" \
        "fish_color_selection $_flag_white --bold --background=$_flag_brblack" \
        "fish_color_status $_flag_red" \
        "fish_color_user $_flag_brgreen" \
        "fish_color_valid_path --underline" \
        "fish_pager_color_background" \
        "fish_pager_color_completion normal" \
        "fish_pager_color_description $_flag_bryellow $_flag_yellow -i" \
        "fish_pager_color_prefix normal --bold --underline" \
        "fish_pager_color_progress $_flag_brwhite --background=$_flag_cyan" \
        "fish_pager_color_secondary_background" \
        "fish_pager_color_secondary_completion" \
        "fish_pager_color_secondary_description" \
        "fish_pager_color_secondary_prefix" \
        "fish_pager_color_selected_background -r" \
        "fish_pager_color_selected_completion" \
        "fish_pager_color_selected_description" \
        "fish_pager_color_selected_prefix" \

    printf "%s\n" $theme
end
