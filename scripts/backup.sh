#!/bin/bash


USER="java_user"
OUTPUT="/coin_broker/backups"
PASSWORD="javapass"

mysqldump --force --opt --user=$USER --password=$PASSWORD bitcoin  > $OUTPUT/bitcoin_`date +%Y%m%d`.sql
