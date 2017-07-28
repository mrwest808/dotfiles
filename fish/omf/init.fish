source "$OMF_CONFIG/alias.fish"

if type -q yarn
  set PATH (yarn global bin) $PATH
end

# Load computer/profile specific extensions
if test -e $HOME/init.fish
  source "$HOME/init.fish"
end
