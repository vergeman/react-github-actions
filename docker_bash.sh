#!/usr/bin/bash

# docker run -v "$(pwd)"/app:/app -it react-github-actions_app zsh

# want to use config hierarchy setup in docker-compose.yml
docker-compose run app zsh
