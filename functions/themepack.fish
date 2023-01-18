function themepack \
    -d "Add more themes to Fish" \
    -a cmd

    set -l themepack_version 0.1.0
    __themepack_prereqs or return 1

    set -l prjdir (path dirname (path resolve (status dirname)))
    set -l metadatafile $prjdir/themes/themepack.yml

    switch "$cmd"
        case ''
            echo >&2 "themepack: missing subcommand"
            echo >&2 ""
            echo >&2 "(Type 'themepack --help' for documentation)"
            return 1
        case -v --version
            echo "themepack, version $themepack_version"
            return 0
        case -h --help
            man themepack.fish
            return 0
        case list
            yq '.themes[].name' $metadatafile | column
            return 0
        case install
            set -l usage "Usage: themepack install [(-t | --template) TEMPLATE] THEME"

            # parse args
            argparse --name=themepack 't/template=' -- $argv[2..]
            or return 1

            test -n "$_flag_template" || set _flag_template default
            if test -f $template_file ||
                set -l template_file $prjdir/themes/$_flag_template.tpl
            end

            # validate args
            set -l errmsg
            if not test (count $argv) -eq 1
                set errmsg "themepack install: Expecting argument 'THEME'."
            else if not contains "$argv" (themepack list) -s $argv
                set errmsg "themepack install: Theme not found '$argv'."
            else if test -f $template_file
                set errmsg "themepack install: Template not found '$template_file'."
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

function __themepack_envsubst \
    --description="A simple substitute for envsubst if missing"

    python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'
end
if not type envsubst &>/dev/null
    alias envsubst __themepack_envsubst
end
