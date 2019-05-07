#!/bin/bash
JAR_FILE=./app.jar
JAVA_OPTS="-Xms512M -Xmx512M"
PROFILE=pro
pid=0
#start app
start(){
echo "grant access"
chmod 777 ./$JAR_FILE
echo "start $JAR_FILE ...."
nohup nice java -server $JAVA_OPTS  -jar ./$JAR_FILE --spring.profiles.active=$PROFILE >/dev/null 2>&1 &
echo "start $JAR_FILE success"

}

checkpid(){
    pid=`ps -ef |grep $JAR_FILE |grep -v grep |awk '{print $2}'`
}

stop(){
	checkpid
    if [ ! -n "$pid" ]; then
     echo "$JAR_FILE not runing"
    else
      echo "$JAR_FILE stop..."
      kill -9 $pid
    fi 
}

restart(){
   stop
   sleep 5s
   start
}

case $1 in  
          start) start;;  
          stop)  stop;; 
          restart)  restart;;  
              *)  echo "require start|stop|restart"  ;;  
esac 
