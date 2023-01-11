# jq -r '.tokyonight_night | to_entries | .[] |  "set -l \(.key) \'\(.value)\'"' ./bin/color_palette.json
# jq -r '.tokyonight_night | to_entries | .[] | .value |= sub("\\\\#"; "") | "set -l \(.key) \'\(.value)\'"' ./bin/color_palette.json

cat ./bin/color_palette.json |
string replace -r '^\s*\/\/.*$' '' |
string replace -r '(["\']),\s*\/\/.*$' '$1,' |
jq -r '
  .tokyonight_night |
  to_entries |
  .[] |
  .value |= sub("\\\\#"; "") |
  "set -l \(.key) \'\(.value)\'"'
