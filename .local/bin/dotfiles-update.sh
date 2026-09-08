#!/bin/bash

# Sync home into .dotfiles 
rsync -av --delete \
   --filter='merge /home/pretzels/.dotfiles-filter.txt' \
   ~/ ~/.dotfiles

echo "Dotfiles updated at $(date)"

