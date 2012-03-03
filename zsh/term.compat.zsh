# 0   to restore default color
# 1   for brighter colors
# 4   for underlined text
# 5   for flashing text
# 30  for black foreground
# 31  for red foreground
# 32  for green foreground
# 33  for yellow (or brown) foreground
# 34  for blue foreground
# 35  for purple foreground
# 36  for cyan foreground
# 37  for white (or gray) foreground
# 40  for black background
# 41  for red background
# 42  for green background
# 43  for yellow (or brown) background
# 44  for blue background
# 45  for purple background
# 46  for cyan background
# 47  for white (or gray) background
#[[ -n "$COLORTERM" ]] && export TERM=xterm-256color
#function term-compat() {
##PROMPT="%{[${col1}m%}%n@%m%{[m%}:%1(j.%j.)%(!.#.>) "
##RPROMPT="[%{[${col2}m%}%~%{[m%}]"
#
#
#}
#term-compat
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
# PROMPT=$'\n''$YELLOW'%~ '$'\n'$DEFAULT'%(!.#.$)
PROMPT="$ "
