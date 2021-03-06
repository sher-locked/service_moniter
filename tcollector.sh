#!/bin/sh
### BEGIN INIT INFO
# Provides:          opsmxagent
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       opsmxagent
### END INIT INFO

#Follow standards https://wiki.debian.org/LSBInitScripts

SCRIPT="python /opt/tcollector/tcollector.py -H 52.8.104.253 -p 4343 -D"
#RUNAS=<USERNAME>

NAME="tcollector"
PIDFILE="/var/run/$NAME.pid"
LOGFILE="/var/log/$NAME.log"

start() {
  if [ -f "$PIDFILE" ] && (ps -p $(cat "$PIDFILE") > /dev/null 2>&1);
  then
     echo 'tcollector already running' >&2
     return 1
  fi
  sudo sh -c "$SCRIPT"
  echo 'tcollector started' >&2
}

stop() {
  if [ -f "$PIDFILE" ] && (ps -p $(cat "$PIDFILE") > /dev/null 2>&1);
  then
    kill -0 $(cat "$PIDFILE") 2> /dev/null
    sudo kill -15 $(cat "$PIDFILE") && sudo rm -f "$PIDFILE"
    #echo "" > /var/run/tcollector.pid
    echo 'tcollector stopped' >&2
  else
    echo 'tcollector not running' >&2
    return 1
  fi
}

status() {
  if [ -f "$PIDFILE" ] && (ps -p $(cat "$PIDFILE") > /dev/null 2>&1);
  then
    echo "tcollector is running" >&2
  else
    echo 'tcollector is not running' >&2
  fi
}

uninstall() {
  echo -n "Are you really sure you want to uninstall this service? That cannot be undone. [yes|No] "
  local SURE
  read SURE
  if [ "$SURE" = "yes" ]; then
    stop
    rm -f "$PIDFILE"
    echo "NOTE: log file is not to be removed: '$LOGFILE'" >&2
    update-rc.d -f $NAME remove
    rm -fv "$0"
  fi
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  uninstall)
    uninstall
    ;;
  status)
    status
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status|uninstall}"
esac
