#!/bin/sh

source ./setenv.sh
echo "Deploying AMQ plugin: $now "
cd $ONE_OPS_DISTR/oneops/dist
tar -xvf  $ONE_OPS_DISTR/oneops/dist/oneops-amq-plugin-"$@".tar.gz
cp $ONE_OPS_DISTR/oneops/dist/oneops/dist/amq-config.tar.gz  /opt/activemq/amq-config.tar.gz

cp $ONE_OPS_DISTR/oneops/dist/oneops/dist/amqplugin-fat.jar  /opt/activemq/lib/amqplugin-fat.jar

cd /opt/activemq

service activemq stop

tar -xzvf amq-config.tar.gz

cd /opt/activemq/conf

if [ -e activemq.orig ]; then
cp activemq.xml activemq.orig
fi

cp amq_local_kahadb.xml activemq.xml

cp /opt/activemq/keys/* .

service activemq start

cd $OO_HOME
echo "Done with AMQ"

