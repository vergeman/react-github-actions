#!/usr/bin/bash

docker run -v "$(pwd)"/app:/app -it react-github-actions_app zsh
