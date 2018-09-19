#!/bin/sh

rsync "$@" -avzhe ssh --progress --exclude '.env' --exclude 'docker-compose.override.yml' --exclude '.git*' --exclude 'rsync-deploy.sh' . core@richardwettstone.com:/opt/dickwettstone_com