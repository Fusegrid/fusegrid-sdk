@Echo off

REM *** Working directory for your WebApplications root ***
REM *** Defaults to var/webapps in Java root {FusegridSDK.app/Contents/Resources/Java} ***
set fgWebappdir=../../../../workspace

REM *** Name of the folder for your WebApplications webroot ***
set fgWebappname=default

REM *** Set the maximum RAM in Megabytes available to the JVM ***
set fgXmx=256

REM *** Set the minimum RAM in Megabytes available to the JVM ***
set fgXms=256

REM *** You should not need to change these yet -- CAREFULL! ***
set fgCache=var/cache/jetty
set fgJavalib=usr/lib
set fgStartcfg=etc/jetty/start.config
set fgJettyhome=usr/share/jetty
set fgConfhome=etc/jetty



echo -- --- --- --- --- --- --- --- --- --
echo -- --- --- --- --- --- --- --- --- --
echo FusegridSDK v0.9.8 is now starting up
echo -- --- --- --- --- --- --- --- --- --
echo		[CTRL-C] to Shutdown		  
echo -- --- --- --- --- --- --- --- --- --
echo -- --- --- --- --- --- --- --- --- --

cd %~dp0
cd FusegridSDK.app\Contents\Resources\Java

java -Djava.awt.headless=true -Dfusegrid.webappdir=%fgWebappdir% -Dfusegrid.webappname=%fgWebappname% -Djava.io.tmpdir=%fgCache% -Djava.library.path=%fgJavalib% -DSTART=%fgStartcfg% -Djetty.home=%fgJettyhome% -Dconfig.home=%fgConfhome% -Djava.class.path=%fgJettyhome%/lib/start.jar -Xms%fgXms%m -Xmx%fgXmx%m -jar %fgJettyhome%/lib/start.jar

echo 
echo "FusegridSDK v0.9.5 has terminated, if this was unexpected:"
echo "Maybe you're using the wrong version of Java?"
echo "This program is tested against and works best with with Sun's JRE, Java 1.5+."
echo "The version of Java in your PATH is:"
java -version
echo "Press any key to continue or any other key to quit... no, No, NO, NOT THAT ONE!"
pause
