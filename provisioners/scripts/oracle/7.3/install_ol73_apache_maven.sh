#!/bin/sh -eux
# install maven build tool by apache.

# install apache maven. --------------------------------------------------------
mvnrelease="3.5.0"
mvnfolder="apache-maven-${mvnrelease}"
mvnbinary="${mvnfolder}-bin.tar.gz"

# create apache parent folder.
mkdir -p /usr/local/apache
cd /usr/local/apache

# download maven binary from apache.org.
wget --no-verbose http://archive.apache.org/dist/maven/maven-3/${mvnrelease}/binaries/${mvnbinary}

# extract maven binary.
tar -zxvf ${mvnbinary} --no-same-owner --no-overwrite-dir
chown -R root:root ./${mvnfolder}
ln -s ${mvnfolder} apache-maven
rm -f ${mvnbinary}

# set jdk home environment variables.
JAVA_HOME=/usr/local/java/jdk180
export JAVA_HOME

# set maven home environment variables.
M2_HOME=/usr/local/apache/apache-maven
export M2_HOME
M2_REPO=$HOME/.m2
export M2_REPO
MAVEN_OPTS=-Dfile.encoding="UTF-8"
export MAVEN_OPTS
M2=$M2_HOME/bin
export M2
PATH=${M2}:${JAVA_HOME}/bin:$PATH
export PATH

# verify installation.
mvn --version
