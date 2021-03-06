#!/bin/sh -eux
# create default desktop environment profiles for devops users.

# create default environment profile for user 'root'. --------------------------
rootprofile="/tmp/scripts/oracle/7.3/users/user-root-bash_profile.sh"
rootrc="/tmp/scripts/oracle/7.3/users/user-root-bashrc.sh"

# uncomment proxy environment variables (if set).
proxy_set="${http_proxy:-}"
if [ -n "${proxy_set}" ]; then
  sed -i 's/^#http_proxy/http_proxy/g;s/^#export http_proxy/export http_proxy/g' ${rootrc}
  sed -i 's/^#https_proxy/https_proxy/g;s/^#export https_proxy/export https_proxy/g' ${rootrc}
fi

# uncomment out vim gui for desktop users.
sed -i 's/^#alias gvim/alias gvim/g' ${rootrc}

# copy environment profiles to user 'root' home.
cd /root
cp -p .bash_profile .bash_profile.orig
cp -p .bashrc .bashrc.orig

cp -f ${rootprofile} .bash_profile
cp -f ${rootrc} .bashrc

cp -f /tmp/scripts/oracle/7.3/tools/vim-files.tar.gz .
tar -zxvf vim-files.tar.gz --no-same-owner --no-overwrite-dir
rm -f vim-files.tar.gz

chown -R root:root .
chmod 644 .bash_profile .bashrc

# create default environment profile for user 'vagrant'. -----------------------
vagrantprofile="/tmp/scripts/oracle/7.3/users/user-vagrant-bash_profile.sh"
vagrantrc="/tmp/scripts/oracle/7.3/users/user-vagrant-bashrc.sh"

# uncomment postman home path for desktop users.
sed -i 's/^#POSTMAN_HOME/POSTMAN_HOME/g;s/^#export POSTMAN_HOME/export POSTMAN_HOME/g' ${vagrantrc}
sed -i 's/^PATH=/##PATH=/g;s/^#PATH=/PATH=/g;s/^##PATH=/#PATH=/g' ${vagrantrc}

# uncomment proxy environment variables (if set).
proxy_set="${http_proxy:-}"
if [ -n "${proxy_set}" ]; then
  sed -i 's/^#http_proxy/http_proxy/g;s/^#export http_proxy/export http_proxy/g' ${vagrantrc}
  sed -i 's/^#https_proxy/https_proxy/g;s/^#export https_proxy/export https_proxy/g' ${vagrantrc}
fi

# uncomment gvim alias for desktop users.
sed -i 's/^#alias gvim/alias gvim/g' ${vagrantrc}

# copy environment profiles to user 'vagrant' home.
cd /home/vagrant
cp -p .bash_profile .bash_profile.orig
cp -p .bashrc .bashrc.orig

cp -f ${vagrantprofile} .bash_profile
cp -f ${vagrantrc} .bashrc

cp -f /tmp/scripts/oracle/7.3/tools/vim-files.tar.gz .
tar -zxvf vim-files.tar.gz --no-same-owner --no-overwrite-dir
rm -f vim-files.tar.gz

chown -R vagrant:vagrant .
chmod 644 .bash_profile .bashrc

# configure gnome-3 desktop properties for devops users. --------------------------
cd /tmp/scripts/oracle/7.3
chmod 755 config_ol73_gnome_desktop.sh
runuser -c "/tmp/scripts/oracle/7.3/config_ol73_gnome_desktop.sh" - vagrant
