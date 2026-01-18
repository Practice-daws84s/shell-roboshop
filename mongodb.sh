#!/bin/sh

source ./commmon.sh
app_name=mongodb

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo | tee -a &>>$LOG_FILE
VALIDATE $? "copying MongoDB repo"

dnf install mongodb-org -y  | tee -a &>>$LOG_FILE
VALIDATE $? "Installing mongodb server"

systemctl enable mongod  | tee -a &>>$LOG_FILE
VALIDATE $? "Enabling MongoDB"

systemctl start mongod  | tee -a &>>$LOG_FILE
VALIDATE $? "Starting MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf  | tee -a &>>$LOG_FILE
VALIDATE $? "Editing MongoDB conf file to accept for remote connections"

systemctl restart mongod | tee -a &>>$LOG_FILE
VALIDATE $? "Restating the mongo DB"

print_time


