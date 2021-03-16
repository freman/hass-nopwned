#!/usr/bin/with-contenv bashio

if [ ! "$(docker ps -q -f name=hassio_supervisor)" ]; then
    echo "Supervisor not detected, exiting"
    exit 1
fi

if ! ( docker cp hassio_supervisor:/usr/src/supervisor/supervisor/resolution/checks/addon_pwned.py - | grep -q check_pwned_password ); then
    echo "Seems Supervisor has already been patched, exiting"
    exit 1
fi

VER=$(docker cp d83:usr/src/supervisor/supervisor/const.py - | awk '/^SUPERVISOR_VERSION/ {gsub(/"/, "", $3); print $3}')

vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

for i in $(ls -rd versions/*); do
    CHK="$(basename "$i")"
    echo "$CHK ? $VER"
    vercomp $CHK $VER
    case $? in
        0 | 2)
            echo "Replacing the addon_pwned check with a stub from $CHK"
            docker cp /app/versions/$CHK/addon_pwned.py hassio_supervisor:/usr/src/supervisor/supervisor/resolution/checks/addon_pwned.py
            echo "Restarting supervisor"
            docker restart hassio_supervisor
            echo "Done"
            
        break;;
        
        1) echo "$CHK > $VER";;
    esac
done


