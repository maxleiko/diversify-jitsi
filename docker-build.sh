#!/bin/bash
BASE=$1
IMAGE=$2
cd $BASE
echo "Working dir: $BASE"
echo "Image name: $IMAGE"
for i in `seq 0 9`;
do
    cd $i
    echo "$IMAGE:$i..."
    docker build --no-cache -t $IMAGE:$i . > /dev/null
    cd ..
    echo "Created."
    echo ""
done
echo ""
echo "Bye."
