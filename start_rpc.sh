#!/bin/bash

##get profile credentials from s3 and overwrite profile.yml
#if [[ $ENVIRONMENT != local ]];  then
#  echo "Reading profiles.yml from $KEY_FILE s3 location to /root/.dbt/ "
#  aws s3 cp $KEY_FILE /root/.dbt/
#  mv /root/.dbt/keys.yaml /root/.dbt/profiles.yml
#else
#  echo "Using profiles.yml from local file on /root/.dbt/ "
#fi

echo "Set source of raw data to $SIMPLEX_RAW_SOURCE "
echo "Running with following params:"
sed '/password/d' /root/.dbt/profiles.yml

#install additional packages
echo " Installing dbt packages "
dbt deps

#Run rpc
#echo " Starting rpc server "
#dbt-rpc -d serve

exec "$@"