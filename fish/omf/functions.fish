# nvm wrapper
# --------------------------------------
function nvm
  bash "$OMF_CONFIG/util/nvm.sh" $argv
end

# Quicker (global packages work across different node versions)
function setup_nvm_bash
  bash "$OMF_CONFIG/util/setup_nvm.sh" $argv
  set PATH $HOME/local/node_bin $PATH
end

# Slower (global packages are namespaced by node version)
function setup_nvm_fish
  mkdir -p $HOME/local

  set NVM_CURRENT_VERSION (nvm current)
  set NVM_CURRENT_BIN (dirname (nvm which current))
  set LOCAL_NVM_BIN $HOME/local/$NVM_CURRENT_VERSION

  rm -rf $LOCAL_NVM_BIN
  ln -sF $NVM_CURRENT_BIN $LOCAL_NVM_BIN

  set PATH $LOCAL_NVM_BIN $PATH
end
