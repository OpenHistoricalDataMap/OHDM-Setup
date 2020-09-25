#!/bin/bash

file=".env"

if [ -f "$file" ]
then
  echo "$file file found."

  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval ${key}=\${value}
  done < "$file"
else
  echo "$file file not found. Skipping"
  exit 1
fi

if [ ! "$(ls -A ${GEOSERVER_VOLUME_PATH})" ]; then
	echo "loading fresh data for the geoserver"
	cd ${GEOSERVER_VOLUME_PATH}
	wget --no-check-certificate --progress=bar:force:noscroll https://build.geo-solutions.it/geonode/geoserver/latest/data-2.17.2.zip 
	unzip -q data-2.17.2.zip -d data
	mv data/data/* ./
	rm -r -f data
	rm -r -f data-2.17.2.zip
else
	echo "there is already data for the geoserver"
fi

if [ ! "$(ls -A ${TOMCAT_VOLUME_PATH}/ohdm.war)" ]; then
	echo "loading webapp for ohdm frontend"
	cd ${TOMCAT_VOLUME_PATH}
	wget --no-check-certificate --progress=bar:force:noscroll https://github.com/OpenHistoricalDataMap/OHDM-Webseite-Backend/raw/master/ohdm_war 
	mv ohdm_war ohdm.war
else
	echo "there is already an ohdm frontend"
fi
