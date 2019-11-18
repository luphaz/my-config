#/bin/sh -eu
# Cleanup thinpool by removing no longer used docker images

container_images=$(docker ps --format '{{.Image}}')
all_images="$(docker images -q | sort)"

for image in ${all_images}; do
  echo -n "Image: ${image} - "
  if echo $container_images | grep -w $image > /dev/null; then
    echo "currently running, not removing"
  else
    echo "no running container, removing image"
    ( set -x; docker rmi ${image} )
  fi
done