#!/usr/bin/with-contenv bashio

if [ ! "$(docker ps -q -f name=hassio_supervisor)" ]; then
	echo "Supervisor not detected, exiting"
	exit 1
fi

if ! ( docker cp hassio_supervisor:/usr/src/supervisor/supervisor/resolution/checks/addon_pwned.py - | grep -q check_pwned_password ); then
	echo "Seems Supervisor has already been patched, exiting"
	exit 1
fi

echo "Replacing the addon_pwned check with a stub"
docker cp /app/addon_pwned.py hassio_supervisor:/usr/src/supervisor/supervisor/resolution/checks/addon_pwned.py
echo "Restarting supervisor"
docker restart hassio_supervisor
echo "Done"

