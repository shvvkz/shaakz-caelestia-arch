#!/bin/bash

extensions=(
  rust-lang.rust
  pinage404.rust-extension-pack
  rust-lang.rust-analyzer
  fill-labs.dependi
  vscode-icons-team.vscode-icons
  LyonSyonII.rust-syntax
  GitHub.github-vscode-theme
  aaron-bond.better-comments
)

for ext in "${extensions[@]}"; do
  echo "Installing $ext"
  code --install-extension "$ext"
done