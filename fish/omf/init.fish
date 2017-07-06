source "$OMF_CONFIG/alias.fish"

if type -q yarn
  set PATH (yarn global bin) $PATH
end
