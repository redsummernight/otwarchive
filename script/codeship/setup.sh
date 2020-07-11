#!/bin/bash

# Skip if there's a special string in the commit message.
if [[ $CI_MESSAGE =~ "[skip codeship tests]" ]]; then
  echo "Skipped Codeship tests."
  exit 0
fi

gem install bundler
bundle install

# Elasticsearch
# https://documentation.codeship.com/basic/services/elasticsearch/
export ELASTICSEARCH_VERSION=6.8.8
export ELASTICSEARCH_PORT=9400
\curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/elasticsearch.sh | bash -s

# Downloads
bash script/codeship/ebook_converters.sh

# Redis
# https://documentation.codeship.com/basic/queues/redis/
# In addition to the default instance, start 2 more:
echo "cat /etc/redis/redis.conf | sed -e 's/.pid$/2.pid/' -e 's/^port 6379/port 6380/' -e 's/.rdb$/2.rdb/' > /etc/redis/redis2.conf" | sudo sh
echo "cat /etc/redis/redis.conf | sed -e 's/.pid$/3.pid/' -e 's/^port 6379/port 6381/' -e 's/.rdb$/3.rdb/' > /etc/redis/redis3.conf" | sudo sh
sudo diff /etc/redis/redis.conf /etc/redis/redis2.conf

sudo redis-server /etc/redis/redis2.conf
sudo redis-server /etc/redis/redis3.conf
