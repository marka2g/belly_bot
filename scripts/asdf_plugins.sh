#!/bin/bash

plugins=(
  "github-cli"
  "packer"
  "terraform"
  "awscli"
  "elixir"
  "erlang"
  "postgres"
  "jq"
  "age"
  "sops"
)
for plugin in "${plugins[@]}"; do
    asdf plugin-add "$plugin" || true 
    #"|| true" ignores errors if plugin already exists
done

echo "Installation Complete"
echo "Please restart your terminal or source your profile file."
