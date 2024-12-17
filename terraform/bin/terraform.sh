#!/bin/bash
# terraformコマンドを実行したいディレクトリ（envs/*）で実行

command=${@:1}

WORK_DIR=$(pwd)
CWD=$(cd $(dirname $0) && pwd)

DOCKERSCRIPT=$(
    cat <<EOF
FROM --platform=linux/amd64 hashicorp/terraform:latest
WORKDIR /work
ENTRYPOINT ["terraform"]
EOF
)

NAME_IMAGE=terraform-cli

if [ ! "$(docker image ls -q $NAME_IMAGE)" ]; then
    echo "Image $NAME_IMAGE does not exist. Building it now."
    echo "$DOCKERSCRIPT" > $CWD/Dockerfile
    docker build -t $NAME_IMAGE -f $CWD/Dockerfile $CWD
    rm $CWD/Dockerfile
fi

docker run -it --rm \
    --platform linux/amd64 \
    -v "$WORK_DIR":/work \
    -v "$WORK_DIR/../../modules":/modules \
    -v $HOME/.config/gcloud:/root/.config/gcloud \
    -w /work \
    $NAME_IMAGE $command
