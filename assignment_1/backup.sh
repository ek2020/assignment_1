#!/bin/bash


USER='root'      
PASSWORD=''
BACKUP_PATH='/home/karthick/mysql/backup'

if [ ! -d $BACKUP_PATH ]; then
  mkdir -p $BACKUP_PATH
fi

databases=`sudo mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "|" | grep -v Database`

for db in $databases; do

  if [ $db == 'information_schema' ] || [ $db == 'performance_schema' ] || [ $db == 'mysql' ] || [ $db == 'sys' ]; then
    echo "Skipping database: $db"
    continue
  fi
  

  day=$(date +%d)
  month=$(date +%m)
  year=$(date +%Y)
  date="$day-$month-$year";
  FINAL_PATH=$BACKUP_PATH/$year/$month/$day

  if [ ! -d $FINAL_PATH ]; then
    mkdir -p $FINAL_PATH
  fi

  echo "Backing up database: $db with compression"
  sudo mysqldump -u $USER -p$PASSWORD --databases $db | gzip -c > $FINAL_PATH/$db-$date.gz

done
