# Run publican within Docker

This procedure explains how to build a publican Docker container, or run a previously made one.

## Procedures

### Build a container


### First time run of a built publican container on a server

If you can find a `webspecs/publican` image on docker hub, you could pull it and run with the following.

    docker pull webspecs/publican

If you got an error, you will have to build an image, push it to docker hub, then come back here.

Continue with the following if its the first time you run publican on the machine you want to have it running;

In order to make publican run successfully, we have to have it ready to run with its repositories it manages.

Repositories are cloned and compiled automatically and stored outside of the Docker container.
The folders we have to have will be written in `data/` and `spec-data/`, we’ll ask Publican to launch itself.
If its the first time you are to run publican on that machine, the folders `data/` and `spec-data/` are most likely empty.

Let’s prepare the directories and ask publican to generate them;

1. Create the directory tree

        mkdir -p data/{gits,logs,publish,queue,temp}

2. Copy the suggested configuration file

  Most details should be fine by default

        cp data/config.json.dist data/config.json

3. In `docker-compose.yml`, comment the line `command: bin/run.sh`.

  That way we’ll be able to acces the VM.
  This step is only required the first time you run the container on a fresh runner VM.

4. Ask docker-compose to run the container, you should gain access inside the VM

        docker-compose run

