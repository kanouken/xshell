#!/bin/bash


flags_noaddr_node_id="82c901f1159fabf1d8939bbb5a84baf3bae9940c"

ip_port=$(redis-cli  cluster nodes | egrep -v 'noaddr|handshake|fail' | awk '{print $2}')



for i in $ip_port

do

  eval $(echo $i | awk -F: '{printf("ip=%s;port=%s",$1,$2)}')

  redis-cli -h $ip -p $port cluster forget $flags_noaddr_node_id



  #flags_noaddr_node_id=$(redis-cli -h $ip -p $port cluster nodes | grep 'noaddr' | awk '{print $1; exit; }')

  #test -n "$flags_noaddr_node_id" && echo $ip, $port, $flags_noaddr_node_id



done
