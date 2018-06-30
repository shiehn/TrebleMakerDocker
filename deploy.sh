#!/bin/bash

cd /TrebleMakerDocker/

/usr/local/bin/docker-compose stop

kill $(ps aux | grep 'docker' | awk '{print $2}')
sleep 12

kill $(ps aux | grep 'docker' | awk '{print $2}')
sleep 12

/etc/init.d/docker start
sleep 10

/usr/bin/docker kill $(docker ps -q)
/usr/bin/docker rm $(docker ps -a -q)
/usr/bin/docker rmi $(docker images -q -f dangling=true)
/usr/bin/docker rmi $(docker images -q)

docker pull hazelcast/hazelcast

pushd TrebleMakerApi/
    /usr/bin/docker build --no-cache -t treblemakerapi .
popd

git clone https://github.com/shiehn/TrebleMakerClientSynths.git
    
pushd TrebleMakerClientSynths/
    docker build --build-arg TMW_NEXT_TRACK_URL="http:\/\/localhost:7777\/api\/track" --build-arg TMW_S3_BUCKET="https:\/\/s3-us-west-2.amazonaws.com\/[YOUR-BUCKET-NAME]\/" --no-cache -t treblemakerweb . 
popd

pushd TrebleMaker/
    /usr/bin/docker build --no-cache -t treblemaker .
popd

rm -rf treblemaker-db.sql
curl -o treblemaker-db.sql https://s3-us-west-2.amazonaws.com/treblemakerdeps/treblemaker-db.sql
chmod +x treblemaker-db.sql

/usr/local/bin/docker-compose up
