#!/bin/bash
############################################################# 
#							    #
#	  SCRIPT BACKUP - JMV TECHNOLOGY CHALLENGE          #
#			                                                   #
#############################################################

##### INFORMAÇÕES DE ACESSO - MYSQL #####
##########################################
USER_MYSQL="root"
PASS_MYSQL="h4ck3r1918"
HOST_MYSQL="localhost"
DATABASE_MYSQL="curriculo"
##########################################

##### ACCESS INFO - MONGODB ####
USER_MONGO="root"
PASS_MONGO="h4ck3r1918"
HOST_MONGO="localhost"
PORT_MONGO="27017"
DATABASE_MONGO="admin"
##########################################

########### COMMANDS PATHS ############
MYSQLDUMP="$(which mysqldump)"
MONGODUMP="$(which mongodump)"
TAR="$(which tar)"
##########################################

####### FORMATE DATE AND HOUR ########
NOW_DATE="$(date +"%Y%m%d-%H%M")"
##########################################

######### FILES AND DIRECTORIES ##########
FILE_EXTENSION=".tar.gz"
FILE_NAME_DUMP_MYSQL="backupMySQL-$NOW_DATE.dump"
FILE_NAME_DUMP_MONGO="backupMongo-$NOW_DATE.dump"
FILE_NAME_BK_HOME="backupHome"
DIR_BK_DB="/backup/backup_banco/"
DIR_BK_RAIZ="/backup"
DIR_HOME="/home/vinicius/Imagens"
DIR_BK_DB_NAME="$DIR_BK_DB $FILE_EXTENSION"
FILE_COMPACT_MYSQL="$FILE_NAME_DUMP_MYSQL$FILE_EXTENSION";
FILE_COMPACT_MONGO="$FILE_NAME_DUMP_MONGO$FILE_EXTENSION";
##########################################

###### BACKUP FUNCTION - MYSQL ##########
function mysqlbk_dump(){
   if [ ! -e "$DIR_BK_DB" ]; then
      mkdir -p $DIR_BK_DB
      cd $DIR_BK_DB
      $MYSQLDUMP -u $USER_MYSQL -p$PASS_MYSQL -h $HOST_MYSQL $DATABASE_MYSQL > $FILE_NAME_DUMP_MYSQL 2> /dev/null  
      $TAR czpf $FILE_COMPACT_MYSQL $DIR_BK_DB 1&> /dev/null
      mv $FILE_COMPACT_MYSQL $DIR_BK_RAIZ
   fi
}
##########################################

####### BACKUP FUNCTION - MONGODB ########
function mongobk_dump(){
   if [ -e "$DIR_BK_DB" ]; then
      cd $DIR_BK_DB
      $MONGODUMP --authenticationDatabase=$DATABASE_MONGO --host $HOST_MONGO:$PORT_MONGO -u $USER_MONGO -p $PASS_MONGO --out $FILE_NAME_DUMP_MONGO 2> /dev/null
      $TAR czpf $FILE_COMPACT_MONGO $DIR_BK_DB 1&> /dev/null
      mv $FILE_COMPACT_MONGO $DIR_BK_RAIZ
   fi
}
##########################################

########## BACKUP FUNCTION - HOME ########
function homebk_dump(){
   if [ -e "$DIR_BK_RAIZ" ]; then
      cd $DIR_BK_RAIZ
      $TAR czpf $FILE_NAME_BK_HOME-$NOW_DATE$FILE_EXTENSION $DIR_HOME  1&> /dev/null
   fi
}
##########################################

###### CALL OF FUNCTIONS - BAKUPs #######
mysqlbk_dump
mongobk_dump
homebk_dump
##########################################

######## SERVER TIMMIMG - RSYNC ##########
SRV_REMOTE="192.168.2.101"
USER_SRV="bk"
DIR_BK_DST="/backup/servidor_teste/"
RSYNC="$(which rsync)"
LOG_FILE_RSYNC="rsync-bk.log"
MAIL="$(which mail)"

########## NOTIFICATION EMAIL ############
EMAIL_DST="vinicius.redes2011@gmail.com"
EMAIL_SRC="root@vinicius-not"
SUBJECT_SUCCESS="BACKUP REALIZADO COM SUCESSO!"
SUBJECT_ERROR="FALHA AO REALIZAR BACKUP!"
##########################################

function rsync_conn() {
    $RSYNC -acvhi --remove-source-files $DIR_BK_RAIZ/*.tar.gz $USER_SRV@$SRV_REMOTE:$DIR_BK_DST 1> $LOG_FILE_RSYNC
    if [ $? != 0 ]; then
       $MAIL -s "$SUBJECT_ERROR" $EMAIL_SRC < $LOG_FILE_RSYNC
       rm -rf $LOG_FILE_RSYNC
    else 
       $MAIL -s "$SUBJECT_SUCCESS" $EMAIL_SRC < $LOG_FILE_RSYNC
       rm -rf $LOG_FILE_RSYNC
    fi   
}

rsync_conn
##########################################

########### CONTAINERs START #############
DOCKER="$(which docker)"
function containers_start(){
    $DOCKER container run -td -v /backup:/backups --name debian debian:1.0 1> /dev/null	
    $DOCKER container run -td -v /backup:/backups --name centos centos:1.0 1> /dev/null
}

containers_start
##########################################
