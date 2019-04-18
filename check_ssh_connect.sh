#!/bin/bash

#check this our server
log="$HOME/log/"$1"_backup.log"

logerr="$HOME/log/"$1"_backup_error.log"

exec 2>$logerr

function errexit {
  failed=$?
  echo "============================="
  if [[ "$failed" != 0 ]]
  then
    echo "||--------WARNING----------||"
    echo "||=====Script=Corrupt======||"
    echo "||send message administator||"
    if [[ -f "/etc/Muttrc" ]]
    then
      if [[ $failed > 1 ]]
      then
        mesg=$mesg+" details in $logerr and $log"
      fi
      echo "Script minification / obfuscation is failed on $DEPLOYMENT_ID .  $mesg " | sed 's/\./\n/' | mutt -s "Script $0 failed on $DEPLOYMENT_ID host" sherlock-exceptions@haulmont.com
    fi
  else
    echo "||--------SUCCESS-----------||"
    echo "||=====Script=Complete======||"
  fighj
  echo "============================="
}

trap "errexit" EXIT >> $log


DEPLOYMENT_ID=$1
if [ -z "$DEPLOYMENT_ID" ]; then
    echo "Deployment ID is not specified"
    exit 1
fi


DUMP_FILE="_backup/$DB_FILE"
case "$DEPLOYMENT_ID" in
  angola)
    REMOTE_HOST=angola-app1
    ;;
  beirut)
    REMOTE_HOST=beirut-app1
    ;;
  cambridge)
    REMOTE_HOST=cambridge-app1
    ;;
  carasap)
    REMOTE_HOST=carasap-app1
    ;;
  coventry)
    REMOTE_HOST=coventry-app1
    ;;
  cabssmart)
    REMOTE_HOST=cabssmart
    ;;
  dunedin)
    REMOTE_HOST=dunedin-app1
    ;;
  miiles)
    REMOTE_HOST=miiles-app1
    ;;
  bizcab)
    REMOTE_HOST=miiles-app1
    ;;
  luxecars)
    REMOTE_HOST=miiles-app1
    ;;
  pewin)
    REMOTE_HOST=pewin-app1
    ;;
  smartcars)
    REMOTE_HOST=smartcars-app1
    ;;
  hansom)
    REMOTE_HOST=hansom-app1
    ;;
  africab)
    REMOTE_HOST=africab-app1
    ;;
  morocco)
    REMOTE_HOST=morocco-app1
    ;;
  gtaxi)
    REMOTE_HOST=gtaxi-app1
    ;;
  electric)
    REMOTE_HOST=electric-app1
    ;;
  westquay)
    REMOTE_HOST=westquay-prod
    ;;
  mycar)
    REMOTE_HOST=mycar-app1
    ;;
  drivr)
    REMOTE_HOST=westquay-prod
    ;;
  eurekar)
    REMOTE_HOST=westquay-prod
    ;;
  priorycars)
    REMOTE_HOST=westquay-prod
    ;;
  bev)
    REMOTE_HOST=bev-app1
    ;;
  onetouch)
    REMOTE_HOST=onetouch-app1
    ;;
  streamline)
    REMOTE_HOST=streamline
    ;;
  flash)
    REMOTE_HOST=electric-app1
    ;;
  *)
    echo "Unknown deployment ID"
    mesg="Unknown deployment ID: $DEPLOYMENT_ID"
    exit 1;
esac



timestamp()
{
 date '+%Y-%m-%d %H:%M:%S'
}

# check connect host
ssh -q $REMOTE_HOST exit
if [[ $? != 0 ]]
then
  echo "Connect is false"
  mesg='ssh host '$REMOTE_HOST' is not avaible'
  exit 1
fi

set -e

echo ''
echo "$(timestamp) get-prod-dump.sh started"
echo "$(timestamp) Download dump from production server"


exit 0
