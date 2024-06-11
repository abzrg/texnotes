#!/bin/sh

set -e

sessionname='university'

if tmux has-session -t="$sessionname" 2> /dev/null; then
  echo
  tmux attach -t "$sessionname"
  exit
fi

tmux new-session -d -s "$sessionname" -n main -x $(tput cols) -y $(tput lines)

tmux split-window -t "$sessionname":main -h

tmux send-keys -t "$sessionname":main.left "nvim current-course/main.tex -c VimtexCompile" Enter
tmux send-keys -t "$sessionname":main.right "git st" Enter

tmux switch-client -t $sessionname:main.right
