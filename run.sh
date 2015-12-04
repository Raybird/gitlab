#! /bin/bash
# PostgreSQL container
docker run --name gitlab-postgresql -d \
       	--env 'DB_NAME=gitlabhq_production' \
       	--env 'DB_USER=gitlab' --env 'DB_PASS=password' \
	--volume /srv/docker/gitlab/postgresql:/var/lib/postgresql \
       	sameersbn/postgresql

# Redis container 
docker run --name gitlab-redis -d \
	--volume /srv/docker/gitlab/redis:/var/lib/redis \
       	sameersbn/redis

# default username: root password: 5iveL!fe
docker run --name gitlab -d \
       	--link gitlab-postgresql:postgresql --link gitlab-redis:redisio \
       	--publish 10022:22 --publish 10080:80 \
       	--env 'GITLAB_HOST=127.0.0.1' \
       	--env 'GITLAB_PORT=10080' --env 'GITLAB_SSH_PORT=10022' \
       	--env 'GITLAB_SECRETS_DB_KEY_BASE=longandrandomalphanumericstring' \
	--volume /srv/docker/gitlab/gitlab:/home/git/data \
	sameersbn/gitlab
