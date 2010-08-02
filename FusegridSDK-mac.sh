#!/bin/bash

# START -- Configure your application

# Working directory for your WebApplications root
# Defaults to 'var/webapps' in Java root {FusegridSDK.app/Contents/Resources/Java}

fgWebappdir="../../../../workspace"

# Name of the folder for your WebApplications webroot
fgWebappname="default"

# Set the maximum RAM in Megabytes available to the JVM
fgXmx=256

# Set the minimum RAM in Megabytes available to the JVM
fgXms=256

# END -- Configure your application


# You should not need to change these yet - CAREFUL
fgCache="var/cache/jetty"
fgJavalib="usr/lib"
fgStartcfg="etc/jetty/start.config"
fgJettyhome="usr/share/jetty"
fgConfhome="etc/jetty"


echo "-- --- --- --- --- --- --- --- --- --"
echo "-- --- --- --- --- --- --- --- --- --"
echo "FusegridSDK v0.9.8 is now starting up"
echo "-- --- --- --- --- --- --- --- --- --"
echo "         [CTRL-C] to Shutdown        "
echo "-- --- --- --- --- --- --- --- --- --"
echo "-- --- --- --- --- --- --- --- --- --"

# Change the directory in case we were started from a graphical shell like Nautilus
cd "`dirname "$0"`"
cd "FusegridSDK.app/Contents/Resources/Java"

java -Djava.awt.headless=true -Dfusegrid.webappdir=$fgWebappdir -Dfusegrid.webappname=$fgWebappname -Djava.io.tmpdir=$fgCache -Djava.library.path=$fgJavalib -DSTART=$fgStartcfg -Djetty.home=$fgJettyhome -Dconfig.home=$fgConfhome -Djava.class.path=$fgJettyhome/lib/start.jar -Xms"$fgXms"m -Xmx"$fgXmx"m -jar "$fgJettyhome"/lib/start.jar

echo 
echo "FusegridSDK v0.9.8 has terminated, if this was unexpected:"
echo "Maybe you're using the wrong version of Java?"
echo "This program is tested against and works best with with Sun's JRE, Java 1.5+."
echo "The version of Java in your PATH is:"
java -version
echo "Press any key to continue or any other key to quit... no, No, NO, NOT THAT ONE!"
read
