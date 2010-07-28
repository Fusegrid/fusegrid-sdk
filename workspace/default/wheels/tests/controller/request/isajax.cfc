<cfcomponent extends="wheelsMapping.test">

	<cfinclude template="common.cfm">

	<cffunction name="test_isAjax_valid">
		<cfset request.cgi.http_x_requested_with = "XMLHTTPRequest">
		<cfset assert("controller.isAjax() eq true")>
	</cffunction>

	<cffunction name="test_isAjax_invalid">
		<cfset request.cgi.http_x_requested_with = "">
		<cfset assert("controller.isAjax() eq false")>
	</cffunction>

</cfcomponent>