#!/bin/bash

if [[ -e /opt/app/$PROJECT.jar ]]; then
  echo "启动jar $PROJECT.jar"
    java -Djava.security.egd=file:/dev/./urandom -jar -Dfile.encoding=UTF-8 $JAVA_OPTS /opt/app/$PROJECT.jar
else
  echo "检查 jar 是否早mount/app/文件夹中存在"
fi

exec "$@";