#!/bin/bash
# Collects syscall for each container running (sequential)
# Usage: sudo bash collect-sysdig.sh <path/to/0to9folders> <image_name>
# Example: sudo bash collect-sysdig.sh jitsi-videobridge/maxleiko/polyversed-jitsi maxleiko/polyversed-jitsi

BASE=$1
IMAGE=$2
cd $BASE
echo "Working dir: $BASE"
echo "Docker image: $IMAGE"
for i in `seq 0 9`;
do
    cd $i
    echo "Syscall for $IMAGE:$i..."
    sysdig -c syscall_3d_matrix > syscall.json &
    SYSDIG=$!
    docker run -it -v /home/leiko/.m2:/root/.m2 $IMAGE:$i > /dev/null
    kill -SIGINT $SYSDIG
    echo "Created."
    cd ..
    echo ""
done

echo ""
echo "Bye."
