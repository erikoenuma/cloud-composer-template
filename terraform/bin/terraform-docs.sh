#!/bin/bash
# README.mdを作成したいディレクトリで実行

WORK_DIR=$(pwd)
SCRIPT_DIR=$(cd $(dirname $0) && pwd)

DOCKERSCRIPT=$(
  cat <<EOF
FROM golang:1.19.1-alpine
RUN go install github.com/terraform-docs/terraform-docs@v0.16.0
WORKDIR /work
ENTRYPOINT ["terraform-docs"]
EOF
)

NAME_IMAGE=terraform-docs-cli

if [ ! "$(docker image ls -q $NAME_IMAGE)" ]; then
  echo "Image $NAME_IMAGE does not exist. Building it now."
  echo "$DOCKERSCRIPT" > $SCRIPT_DIR/Dockerfile
  docker build -t $NAME_IMAGE -f $SCRIPT_DIR/Dockerfile $SCRIPT_DIR
  rm $SCRIPT_DIR/Dockerfile
fi

docker run -it --rm \
  -v $WORK_DIR:/work \
  -w /work \
  $NAME_IMAGE markdown table --output-file README.md --output-mode inject .
