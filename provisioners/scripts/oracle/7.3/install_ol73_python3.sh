#!/bin/sh -eux
# install python 3.3 from the software collection library for linux 7.x..

# create temporary scripts directory. ------------------------------------------
mkdir -p /tmp/scripts/oracle
cd /tmp/scripts/oracle

# update the repository list. --------------------------------------------------
yum repolist

# install python 3.3. ----------------------------------------------------------
yum -y install python33 python-devel
scl enable python33 -- python --version

# install python 3.3 pip. ------------------------------------------------------
wget --no-verbose https://bootstrap.pypa.io/get-pip.py
scl enable python33 -- python /tmp/scripts/oracle/get-pip.py
scl enable python33 -- pip --version
scl enable python33 -- pip3 --version

# change ownership for the entire temporary directory structure.
cd /tmp/scripts
chown -R vagrant:vagrant .
