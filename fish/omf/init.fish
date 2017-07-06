source "$OMF_CONFIG/alias.fish"
source "$OMF_CONFIG/functions.fish"

if type -q yarn
  set PATH (yarn global bin) $PATH
end
