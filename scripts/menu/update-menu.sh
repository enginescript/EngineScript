#!/usr/bin/env bash
#----------------------------------------------------------------------------
# EngineScript - High-Performance WordPress LEMP Server
#----------------------------------------------------------------------------
# Website:      https://EngineScript.com
# GitHub:       https://github.com/Enginescript/EngineScript
# Company:      VisiStruct / EngineScript
# License:      GPL v3.0
# OS:           Ubuntu 22.04 (jammy)
#----------------------------------------------------------------------------

# EngineScript Variables
source /usr/local/bin/enginescript/enginescript-variables.txt
source /home/EngineScript/enginescript-install-options.txt

# Check current user's ID. If user is not 0 (root), exit.
if [ "${EUID}" != 0 ];
  then
    echo "${BOLD}ALERT:${NORMAL}"
    echo "EngineScript should be executed as the root user."
    exit
fi

#----------------------------------------------------------------------------
# Start Main Script

# Main Menu
while true
  do
    clear
    echo -e "Update Software" | boxes -a c -d shell -p a1l2
    echo ""
    echo ""

    PS3='Please enter your choice: '
    options=("Update EngineScript" "Update MariaDB" "Update Nginx" "Update OpenSSL" "Update PHP" "Update Server Tools" "Update Ubuntu Distribution (apt full-upgrade)" "Update Ubuntu Software (apt upgrade)" "Update Software Menu")
    select opt in "${options[@]}"
    do
      case $opt in
        "Update EngineScript")
          /usr/local/bin/enginescript/scripts/update/enginescript-update.sh
          break
          ;;
        "Update MariaDB")
          echo "Currently disabled as it's not needed."
          sleep 5
          break
          ;;
        "Update Nginx")
          /usr/local/bin/enginescript/scripts/update/nginx-update.sh
          break
          ;;
        "Update OpenSSL")
          echo "Currently disabled as it's not needed."
          sleep 5
          #/usr/local/bin/enginescript/scripts/update/openssl-update.sh
          break
          ;;
        "Update PHP")
          /usr/local/bin/enginescript/scripts/update/php-8.1-update.sh
          break
          ;;
        "Update Server Tools")
          /usr/local/bin/enginescript/scripts/update/software-update.sh
          break
          ;;
        "Update Ubuntu Distribution (apt full-upgrade)")
          apt full-upgrade
          break
          ;;
        "Update Ubuntu Software (apt upgrade)")
          /usr/local/bin/enginescript/scripts/functions/enginescript-apt-update.sh
          break
          ;;
        "Exit Update Software Menu")
          exit
          ;;
        *) echo invalid option;;
      esac
    done
  done
