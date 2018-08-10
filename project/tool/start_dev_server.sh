#!/bin/bash

ROOT_DIR="$(cd "$(dirname $0)" && pwd)"/../../

DEP_SERVICE_FILE=$ROOT_DIR/dep_service_list
if [ ! -f $DEP_SERVICE_FILE ]
then
    echo "DEP_SERVICE_FILE 不存在，检查 $DEP_SERVICE_FILE"
    exit
fi

DEP_CLI_FILE=$ROOT_DIR/dep_cli_list
if [ ! -f $DEP_CLI_FILE ]
then
    echo "DEP_CLI_FILE 不存在，检查 $DEP_CLI_FILE"
    exit
fi

sh $ROOT_DIR/project/tool/dep_build.sh link

DEP_VOLUMN="-v $ROOT_DIR/../frame:/var/www/frame"

LINK=""
while read line
do
    SERVICE_NAME=`echo $line | grep -v ^# | awk '{print $1}'`
    if [ "$SERVICE_NAME" != "" ]
    then
        DEP_VOLUMN="$DEP_VOLUMN -v $ROOT_DIR/../$SERVICE_NAME:/var/www/$SERVICE_NAME"

        if docker exec $SERVICE_NAME echo ok > /dev/null 2>&1
        then
            LINK="$LINK --link $SERVICE_NAME:$SERVICE_NAME";
        fi
    fi
done<$DEP_SERVICE_FILE

while read line
do
    CLI_NAME=`echo $line | grep -v ^# | awk '{print $1}'`
    if [ "$CLI_NAME" != "" ]
    then
        DEP_VOLUMN="$DEP_VOLUMN -v $ROOT_DIR/../$CLI_NAME:/var/www/$CLI_NAME"

        if docker exec $CLI_NAME echo ok > /dev/null 2>&1
        then
            LINK="$LINK --link $CLI_NAME:$CLI_NAME";
        fi
    fi
done<$DEP_CLI_FILE

sudo docker run --rm -ti -p 80:80 --name distributed_mvc_frame \
    $LINK $DEP_VOLUMN \
    -v $ROOT_DIR/:/var/www/distributed_mvc_frame \
    -v $ROOT_DIR/project/config/development/nginx/distributed_mvc_frame.conf:/etc/nginx/sites-enabled/default \
kikiyao/debian_php_dev_env start
