#!/bin/bash

for i in Docker*; do
  args=$(echo $i | awk -F"-" '{print $1,$2,$3,$4}')
  set -- $args
  image_name="$2-$3-$4"
  echo $image_name
  docker build -f $i -t $image_name .
  container_id=$(docker run --detach $image_name)
  mkdir -p build/$img_name
  docker cp $container_id:/root/build build/$image_name
  sleep 1
  docker rm $container_id
  docker rmi $image_name
done
