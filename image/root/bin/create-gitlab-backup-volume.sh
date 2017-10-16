#!/bin/sh

if [ ! -f ${HOME}/docker/volumes/gitlab-backup ]
then
    docker volume create > ${HOME}/docker/volumes/gitlab-backup &&
        docker \
            container \
            run \
            --interactive \
            --tty \
            --rm \
            --mount type=volume,source=gitlab-backup,destination=/var/backups \
            --workdir /var/backups \
            alpine:3.4 \
                mkdir gitlab &&
        docker \
            container \
            run \
            --interactive \
            --tty \
            --rm \
            --mount type=volume,source=gitlab-backup,destination=/var/backups \
            --workdir /var/backups \
            alpine:3.4 \
                chmod 0777 gitlab &&
        docker \
            container \
            run \
            --env AWS_ACCESS_KEY_ID \
            --env AWS_SECRET_ACCESS_KEY \
            --env AWS_DEFAULT_REGION \
            --interactive \
            --tty \
            --rm \
            --mount type=volume,source=gitlab-backup,destination=/var/backups \
            --workdir /var/backups/gitlab \
            xueshanf/awscli:latest \
                aws \
                s3 \
                cp \
                --include '*gitlab_backup.tar' \
                --recursive \
                s3://${GITLAB_BACKUP_BUCKET} .

fi