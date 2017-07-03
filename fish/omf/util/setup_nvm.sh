# Symlinks binaries for the current nvm version into ~/local/node_bin
# Expects fish to export ~/local/node_bin to $PATH
function setup_nvm {
  source ~/.nvm/nvm.sh

  NVM_CURRENT_VERSION=$(nvm current)
  NVM_CURRENT_PATH=$(nvm which current)
  NVM_BIN=$(dirname $NVM_CURRENT_PATH)
  LOCAL_NODE_BIN=$HOME/local/node_bin

  for f in $NVM_BIN/*
  do
    ln -sf $f $LOCAL_NODE_BIN
  done
}

setup_nvm &
