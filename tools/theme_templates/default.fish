# name: "$name"
# preferred_background: $background
# url: $url

set -gx fish_color_autosuggestion "555" "$brblack"
set -gx fish_color_cancel -r
set -gx fish_color_command $blue
set -gx fish_color_comment $red
set -gx fish_color_cwd $green
set -gx fish_color_cwd_root $red
set -gx fish_color_end $green
set -gx fish_color_error $brred
set -gx fish_color_escape $brcyan
set -gx fish_color_history_current --bold
set -gx fish_color_host normal
set -gx fish_color_host_remote $yellow
set -gx fish_color_keyword $blue
set -gx fish_color_match --background=$brblue
set -gx fish_color_normal normal
set -gx fish_color_operator $brcyan
set -gx fish_color_option $cyan
set -gx fish_color_param $cyan
set -gx fish_color_quote $yellow
set -gx fish_color_redirection "$cyan" "--bold"
set -gx fish_color_search_match "$bryellow" "--background=$brblack"
set -gx fish_color_selection "$white"  "--bold" "--background=$brblack"
set -gx fish_color_status $red
set -gx fish_color_user $brgreen
set -gx fish_color_valid_path --underline
set -gx fish_pager_color_background
set -gx fish_pager_color_completion normal
set -gx fish_pager_color_description "B3A06D" "$yellow"  "-i"
set -gx fish_pager_color_prefix "normal"  "--bold"  "--underline"
set -gx fish_pager_color_progress "$brwhite" "--background=$cyan"
set -gx fish_pager_color_secondary_background
set -gx fish_pager_color_secondary_completion
set -gx fish_pager_color_secondary_description
set -gx fish_pager_color_secondary_prefix
set -gx fish_pager_color_selected_background -r
set -gx fish_pager_color_selected_completion
set -gx fish_pager_color_selected_description
set -gx fish_pager_color_selected_prefix
