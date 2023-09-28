#!/usr/bin/env bash
#----------------------------------------------------------------------------
# EngineScript - A High-Performance WordPress Server Built on Ubuntu and Cloudflare
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

cd /var/www/sites
printf "Please select the site you want to scan for vulnerabilities:\n"
select d in *; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d"/html && echo "WordPress CLI is running. This scan may take a bit, standby for results."
echo "When completed, the scan results will be located at:"
echo "/home/EngineScript/wordfence-scan-results/wordfence-cli-scan-results.csv"

# Scan
/usr/local/src/Wordfence-CLI/wordfence scan --progress --images --output-path /home/EngineScript/wordfence-scan-results/wordfence-cli-scan-results.csv /var/www/sites

# Ask user to acknowledge that the scan has completed before moving on
echo ""
echo ""
echo "The scan results will be located at:"
echo "/home/EngineScript/wordfence-scan-results/wordfence-cli-scan-results.csv"
echo ""
read -n 1 -s -r -p "Press any key to continue"
echo ""
echo ""
