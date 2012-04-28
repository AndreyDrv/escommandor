#!/bin/bash
# This deploy script should be configured by you
# Here the attachments example

ESLOCATION='localhost:9200'
SHARDSCNT=5
REPLICASCNT=2
CLUSTERNAME='dummy'
BRANCH='branch'
ATTACHMENTS='document'


echo "adding shard config..."
curl -XPUT $ESLOCATION/$CLUSTERNAME -d '{"settings":{"index":{"number_of_shards":$SHARDSCNT, 
"number_of_replicas":$REPLICASCNT}}}'

sleep 1
echo "..."
echo "adding $ATTACHMENTS mapping..."
curl -XPUT $ESLOCATION/$CLUSTERNAME/$ATTACHMENTS/_mapping -d '{ "attachment" : { "properties" : { "content" : { "type" : "attachment", "fields":{"title" : { "store" : "yes" },"content":{"store":"yes"}}}}}}'

sleep 1
echo "..."
echo "adding $BRANCH mapping..."
curl -XPUT $ESLOCATION/$CLUSTERNAME/$BRANCH/_mapping -d "{\"$BRANCH\":{\"properties\":{\"link\":{\"type\":\"string\"},\"cancel\":{\"type\":\"string\"},\"type\":{\"type\":\"string\"}}}}"

sleep 1
echo "..."
echo "adding $ATTACHMENTS mapping parentness..."
curl -XPUT $ESLOCATION:9200/$CLUSTERNAME/$ATTACHMENTS/_mapping -d '{"document" : {"_parent" : {"type" : "$BRANCH"}}}'
