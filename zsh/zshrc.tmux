function tmx() {
  if ! [[ -z ${TMUX} ]]; then
    echo "Already in a tmux session, aborting..."
    return
  fi

  # Get a list of sessions
  sessions=("${(@f)$(tmux ls | awk -F: '{ print $1 }')}")

  if [[ -z ${sessions} ]]; then
    echo "\ntmux isn't running, do you want to create a new session? [Y/n]"
    read -r should_continue

    if [[ $should_continue == "n" ]]; then
      # Abort
    else
      tmux
    fi

    return
  fi

  # Display the list of sessions
  echo "Available sessions:"
  i=1
  for session in $sessions; do
    echo "  ${i}) ${session}"
    ((i++))
  done

  echo "\n  n) Create new session"

  echo "\nSelect a session:"
  read -r session_number

  if [[ -z $session_number ]]; then
    return
  fi

  if [[ $session_number == "n" ]]; then
    tmux
    return
  fi

  if ! [[ $session_number -ge 1 ]] || ! [[ $session_number -le (($i - 1)) ]]; then
    echo "Invalid selection"
    return
  fi

  # zsh arrays indexing starts at 1 (by default)
  selected_session=($sessions[$session_number])
  echo "Selected: ${selected_session}"

  tmux attach -t $selected_session
}

function tmx:tmpl() {
  if ! [[ -d $HOME/.tmux-templates ]]; then
    mkdir $HOME/.tmux-templates
  fi

  files=()
  i=1

  for file in $HOME/.tmux-templates/*; do
    name="${file:t:r}"
    files+=($file)

    echo "  $i) $name"
    ((i++))
  done

  if ! [[ ${#files[@]} -gt 0 ]]; then
    echo "Empty template folder, create a file to get started."
    echo ""
    echo "[Example: $HOME/.tmux-templates/foo]"
    echo ""
    echo "#!/bin/zsh"
    echo ""
    echo "tmux rename-session <session_name>"
    echo "tmux new-window -c \$HOME/path/to/project -n <window_name>"
    echo "tmux kill-window -t 1"
    return
  fi

  echo "\n Choose template:"
  read -r template_number

  if [[ $template_number -le 0 ]] || [[ $template_number -gt (($i - 1)) ]]; then
    echo "Invalid input"
    return
  fi

  template=${files[$template_number]}
  zsh $template
}
