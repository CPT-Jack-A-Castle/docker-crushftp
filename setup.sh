#!/usr/bin/env bash

if [ -f /var/opt/CrushFTP9_PC/installed ] ; then
	echo "CrushFTP installed"
else
  echo "Initializing CrushFTP"
  unzip -o -q /tmp/CrushFTP9_PC.zip -d /var/opt/
  rm -f /tmp/CrushFTP9_PC.zip
  touch /var/opt/CrushFTP9_PC/installed
  echo "Removing crap"
  rm -Rf /var/opt/CrushFTP9_PC/CrushFTP*.exe /var/opt/CrushFTP9_PC/Install.txt
  echo " " > /var/opt/CrushFTP9_PC/WebInterface/custom.css
fi

[ -z ${CRUSH_ADMIN_USER} ] && CRUSH_ADMIN_USER=crushadmin
[ -z ${CRUSH_ADMIN_PASSWORD} ] && CRUSH_ADMIN_PASSWORD=crushadmin

if [[ -f /var/opt/CrushFTP9_PC/admin_set ]] ; then
    echo "Admin is already set"
else
    echo "Creating admin user: ${CRUSH_ADMIN_USER} with password: ${CRUSH_ADMIN_PASSWORD}"
    cd /var/opt/CrushFTP9_PC && java -jar /var/opt/CrushFTP9_PC/CrushFTP.jar -a "${CRUSH_ADMIN_USER}" "${CRUSH_ADMIN_PASSWORD}"
    touch /var/opt/CrushFTP9_PC/admin_set
fi

/var/opt/run-crushftp.sh start
while true; do sleep 86400; done
