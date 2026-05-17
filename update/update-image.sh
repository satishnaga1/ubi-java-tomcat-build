#!/bin/bash

set -e

FILE="configuration/tomcat/build-images.txt"

mkdir -p configuration/tomcat

touch $FILE

IMAGE_TAG="ubi${UBI_VERSION}-java${JAVA_VERSION}-tomcat${TOMCAT_MAJOR}"

NEW_IMAGE="${DOCKER_USERNAME}/${IMAGE_NAME}:latest"

echo "======================================"
echo "Updating build-images.txt"
echo "======================================"

# ==========================================
# GET OLD IMAGE FOR SAME TAG
# ==========================================
OLD_IMAGE=$(awk -v tag="$IMAGE_TAG" '
BEGIN {found=0}

$0 ~ tag {
  found=1
  next
}

found && /Docker Image :/ {
  sub("Docker Image : ","")
  print
  exit
}

found && /^======================================$/ {
  exit
}
' $FILE)

OLD_IMAGE_NO_LATEST=$(echo "$OLD_IMAGE" | sed 's/:latest//')

# ==========================================
# REMOVE EXISTING ENTRY
# ==========================================
awk -v tag="$IMAGE_TAG" '
BEGIN {
  skip=0
}

$0 ~ tag {
  skip=1
  next
}

skip && /^======================================$/ {
  skip=0
  next
}

!skip {
  print
}
' $FILE > temp.txt

mv temp.txt $FILE

# ==========================================
# ADD UPDATED ENTRY
# ==========================================
{
  echo "======================================"
  echo "$IMAGE_TAG"
  echo "Docker Image : $NEW_IMAGE"

  if [ ! -z "$OLD_IMAGE" ]; then
    echo "Docker old image : $OLD_IMAGE_NO_LATEST"
  fi

  echo "Build Date : $(date)"
  echo "======================================"
  echo ""
} >> $FILE

echo ""
echo "Updated File:"
echo ""

cat $FILE
