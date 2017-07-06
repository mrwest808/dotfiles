function toggle_npmrc
  set ON $HOME/.npmrc
  set OFF $HOME/.npmrc_disabled

  if test -e $ON
    echo "+ Disabling .npmrc"
    mv $ON $OFF
  else if test -e $OFF
    echo "+ Enabling .npmrc"
    mv $OFF $ON
  end
end
