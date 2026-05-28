#!/usr/bin/env bash

SESSION="Main"

# Check if tmux server is running and session exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
	exec tmux attach -t "$SESSION"
else
	exec tmux new-session -s "$SESSION"
fi
