#!/bin/sh

rsync $@ -avzhe ssh --progress --exclude '.env' --exclude 'docker-compose.override.yml' --exclude '.git*' --exclude 'rsync-deploy.sh' . core@jameslind.info:/opt/dickwettstone_com