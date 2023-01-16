function themepack \
    -d "Add more themes to Fish" \
    -a cmd

    set -l themepack_version 0.1.0

    if not set -q fish_theme_colors_path
        set -l prjdir (path dirname (path resolve (status dirname)))
        set -gx fish_theme_colors_path $prjdir/themes/colors
    end

    switch "$cmd"
        case ''
            echo >&2 "themepack: missing subcommand"
            echo >&2 ""
            echo >&2 "(Type 'themepack --help' for documentation)"
        case -v --version
            echo "themepack, version $themepack_version"
        case -h --help
            man themepack.fish
        case list
            set -l file
            for file in $fish_theme_colors_path/*.json
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

function __themepack_prereqs
    if not type yq &>/dev/null
        echo >&2 "themepack generate: Required command not found 'yq'."
        echo >&2 ""
        echo >&2 "Use your OS package manager to install (eg: brew install yq)."
        return 1
    end
end

function __themepack_generator_default -a name template jsonfile
    __themepack_prereqs || return 1

    set code (
        yq -o=props $jsonfile |
        string replace -r '^' 'set -l ' |
        string replace '= #' '= ' |
        string replace ' = ' ' "' |
        string replace -r '$' '"'
    )
    eval (string join ';' $code)

    set -l fn_template "__themepack_template_"$template
    $fn_template \
        --name=$name \
        --bg=$background \
        --fg=$foreground \
        --black=$black \
        --red=$red \
        --green=$green \
        --yellow=$yellow \
        --blue=$blue \
        --magenta=$magenta \
        --cyan=$cyan \
        --white=$white \
        --brblack=$brblack \
        --brred=$brred \
        --brgreen=$brgreen \
        --bryellow=$bryellow \
        --brblue=$brblue \
        --brmagenta=$brmagenta \
        --brcyan=$brcyan \
        --brwhite=$brwhite \
        --selection_bg=$selection_background \
        --selection_text=$selection_text \
        $cursor_color $cursor_text
end

function __themepack_generator_alacritty -a name template ymlfile
    __themepack_prereqs || return 1

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
        'brblack=' 'brred=' 'brgreen=' 'bryellow=' 'brblue=' 'brmagenta=' 'brcyan=' 'brwhite=' \
        'selection_bg=' 'selection_text='

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
