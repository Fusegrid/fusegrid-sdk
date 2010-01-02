<cfset numObjects = 10000>
<cfset start = getTickCount()>
<cfloop index="i" from="1" to="#numObjects#">
<cfset createObject("component","Object").init()>
</cfloop>
<cfset end = getTickCount()>
<cfset seconds = (end-start) / 1000>
<cfset objectsPerSecond = numObjects / seconds>
<cfoutput>
Objects: #numObjects#<br/>
Seconds: #seconds#<br/>
Objects per second: #objectsPerSecond#<br/>
</cfoutput>