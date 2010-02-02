<cffunction name="onSessionStart" returntype="void" access="public" output="false">
	<cfscript>
		$simpleLock(execute="$runOnSessionStart", name="wheelsReloadLock", type="readOnly");
	</cfscript>
</cffunction>

<cffunction name="$runOnSessionStart" returntype="void" access="public" output="false">
	<cfscript>
		$include(template="#application.wheels.eventPath#/onsessionstart.cfm");
	</cfscript>
</cffunction>