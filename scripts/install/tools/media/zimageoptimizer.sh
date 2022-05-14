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

# Install zImageOptimizer
rm -rf /usr/local/bin/zimageoptimizer
git clone --depth 1 https://github.com/zevilz/zImageOptimizer.git -b master /usr/local/bin/zimageoptimizer
find /usr/local/bin/zimageoptimizer -type d,f -exec chmod 755 {} \;
