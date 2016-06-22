#!/bin/bash

for i in Docker*; do
  args=$(echo $i | awk -F"-" '{print $1,$2,$3,$4}')
  set -- $args
  image_name="$2-$3-$4"
  echo $image_name
  docker build -f $i -t $image_name .
  container_id=$(docker run -dit $image_name bash)
  echo $container_id
  mkdir -p $image_name
  docker cp $container_id:/root/build ./$image_name
  docker stop $container_id
  docker rm $container_id
  docker rmi $image_name
done
