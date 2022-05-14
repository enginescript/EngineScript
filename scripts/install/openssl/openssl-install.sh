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

# Download OpenSSL
cd /usr/src
wget https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz
apt remove openssl -y
tar -xvzf openssl-${OPENSSL_VER}.tar.gz
cd openssl-${OPENSSL_VER}

# Compile OpenSSL
chmod +x ./config
./Configure
make -j${CPU_COUNT}
#make test
make install

# Link OpenSSL
sudo touch /etc/ld.so.conf.d/openssl.conf
echo "/usr/local/lib64" >> /etc/ld.so.conf.d/openssl.conf
ldconfig
ln -s /usr/local/bin/openssl /usr/bin/
openssl version

# Reinstall Dependencies
# A few packages were uninstalled when we removed OpenSSL. Let's add them back.
apt install -qy ca-certificates libruby2.7 python-pip-whl python3-certifi python3-docker python3-influxdb python3-pip python3-requests python3-requests-unixsocket rake ruby ruby-dev ruby2.7 ruby2.7-dev rubygems-integration software-properties-common

# OpenSSL Installation Completed
echo ""
echo ""
echo "============================================================="
echo ""
echo "${BOLD}OpenSSL ${OPENSSL_VER} installed.${NORMAL}"
echo ""
echo "============================================================="
echo ""
echo ""

sleep 5
