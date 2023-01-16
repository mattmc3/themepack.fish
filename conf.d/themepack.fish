set themepack_manpath (path dirname (path resolve (status dirname)))/man
if not contains $themepack_manpath $MANPATH
    set -gx MANPATH $MANPATH $themepack_manpath
end
