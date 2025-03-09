function tmx:select() {
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
      (cd ~; tmux)
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
    (cd ~; tmux)
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

function tmx:template() {
  if [[ -z ${TMUX} ]]; then
    echo "Not in a tmux session, aborting..."
    return
  fi

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

  if [[ -f $HOME/.tmux-templates/$1 ]]; then
    zsh $HOME/.tmux-templates/$1
    return
  fi

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

function tmx() {
  if ! [[ -z ${TMUX} ]]; then
    tmx:template "$@"
  else
    tmx:select
  fi
}

function t() {
  CYAN="\033[0;36m"
  NC='\033[0m'

  input="$*"

  # Get a list of sessions
  active_sessions=("${(@f)$(tmux ls | awk -F: '{ print $1 }')}")

  # Read filenames in ~/.tmux-templates
  templates=()
  for file in "$HOME/.tmux-templates"/*; do
    if [[ -f "$file" ]]; then
        templates+=($(basename "$file"))
    fi
  done

  session=""

  if [[ -z "$input" ]]; then
    # Print each template and have user select one
    echo "\nAvailable sessions:\n"
    i=1
    for template in $templates; do
      # Check if this template is an active session
      if [[ ${active_sessions[(r)$template]} == $template ]]; then
        echo "  ${i}) ${template} ${CYAN}(active)${NC}"
      else
        echo "  ${i}) ${template}"
      fi
      ((i++))
    done

    echo "\nOther sessions:\n"

    # TODO: Add other active sessions
    for session in $active_sessions; do
      if [[ ${templates[(r)$session]} == $session ]]; then
        # Do nothing...
      else
        echo "  ${i}) ${session} ${CYAN}(active)${NC}"
        ((i++))
      fi
    done

    echo -n "\nSelect a template: "
    read -r selection

    if [[ -z "$selection" ]]; then
      return
    fi

    if ! [[ "$selection" =~ ^[0-9]+$ ]]; then
      # Use fzf to perform fuzzy matching
      session=$(printf '%s\n' "${active_sessions[@]}" | fzf --filter="$selection" --no-sort)
    else
      session=${active_sessions[$((selection))]}
    fi
  else
    # Use fzf to perform fuzzy matching
    session=$(printf '%s\n' "${active_sessions[@]}" | fzf --filter="$input" --no-sort)
  fi

  if [[ -z "$session" ]]; then
    echo "WARN: No session selected."
    return
  fi

  tmux has-session -t $session 2>/dev/null

  if [[ $? != 0 ]]; then
    tmux new-session -d -s $session "zsh $HOME/.tmux-templates/$session"
  fi

  tmux attach-session -t $session
}
