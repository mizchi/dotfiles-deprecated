# tmux
SESSION_NAME='t'
tmux has-session -t $SESSION_NAME
if [ $? -ne 0 ]; then
  tmux -q new-session -s $SESSION_NAME
elif [ "$TMUX" = "" ]; then
  echo '==== tmux ========================================'
  tmux list-clients
  echo "tmux attach-session -d -t $SESSION_NAME"
  echo '======================================== tmux ===='
  tmux attach-session -d -t $SESSION_NAME
fi
