#!/bin/bash

function sed_name
{
    cat $1 | sed -e "s/distributed_mvc_frame/$2/g" > $1.new && mv $1.new $1
}

if [ ! -n "$1" ] ;then
    echo "Usage: $0 <name>"
    exit
fi

ROOT_DIR="$(cd "$(dirname $0)" && pwd)"/../../

mv $ROOT_DIR/project/config/development/nginx/distributed_mvc_frame.conf $ROOT_DIR/project/config/development/nginx/$1.conf
mv $ROOT_DIR/project/config/production/nginx/distributed_mvc_frame.conf $ROOT_DIR/project/config/production/nginx/$1.conf

sed_name $ROOT_DIR/project/config/development/nginx/$1.conf $1
sed_name $ROOT_DIR/project/config/production/nginx/$1.conf $1
sed_name $ROOT_DIR/project/tool/start_dev_server.sh $1
