#!/bin/bash
dir="$(git rev-parse --show-toplevel)/jupyter"
mkdir -p $dir
docker run -d -p 8888:8888 --name my-pytorch -v "${dir}":/home/jovyan/work quay.io/jupyter/pytorch-notebook
#docker container logs --tail 3 notebook | awk 'NR==2'
