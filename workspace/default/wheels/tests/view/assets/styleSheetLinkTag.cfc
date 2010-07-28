<cfcomponent extends="wheelsMapping.test">

	<cffunction name="setup">
		<cfset loc.controller = $controller(name="dummy")>
		<cfset loc.args = {}>
	</cffunction>

	<cffunction name="test_should_handle_extensions_nonextensions_and_multiple_extensions">
		<cfset loc.args.source = "test,test.css,jquery.dataTables.min,jquery.dataTables.min.css">
		<cfset loc.e = loc.controller.styleSheetLinkTag(argumentcollection=loc.args)>
		<cfset loc.r = '<link href="#application.wheels.webpath#stylesheets/test.css" media="all" rel="stylesheet" type="text/css" />#chr(10)#<link href="#application.wheels.webpath#stylesheets/test.css" media="all" rel="stylesheet" type="text/css" />#chr(10)#<link href="#application.wheels.webpath#stylesheets/jquery.dataTables.min.css" media="all" rel="stylesheet" type="text/css" />#chr(10)#<link href="#application.wheels.webpath#stylesheets/jquery.dataTables.min.css" media="all" rel="stylesheet" type="text/css" />#chr(10)#'>
		<cfset halt(expression='htmleditformat(loc.e)', halt=false, format="text")>
		<cfset halt(expression='htmleditformat(loc.r)', halt=false, format="text")>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

	<cffunction name="test_no_automatic_extention_when_cfm">
		<cfset loc.args.source = "test.cfm,test.css.cfm">
		<cfset loc.e = loc.controller.styleSheetLinkTag(argumentcollection=loc.args)>
		<cfset loc.r = '<link href="#application.wheels.webpath#stylesheets/test.cfm" media="all" rel="stylesheet" type="text/css" />#chr(10)#<link href="#application.wheels.webpath#stylesheets/test.css.cfm" media="all" rel="stylesheet" type="text/css" />#chr(10)#'>
		<cfset halt(expression='htmleditformat(loc.e)', halt=false, format="text")>
		<cfset halt(expression='htmleditformat(loc.r)', halt=false, format="text")>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

	<cffunction name="test_support_external_links">
		<cfset loc.args.source = "http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/start/jquery-ui.css,test.css,https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/start/jquery-ui.css">
		<cfset loc.e = loc.controller.styleSheetLinkTag(argumentcollection=loc.args)>
		<cfset loc.r = '<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/start/jquery-ui.css" media="all" rel="stylesheet" type="text/css" />#chr(10)#<link href="#application.wheels.webpath#stylesheets/test.css" media="all" rel="stylesheet" type="text/css" />#chr(10)#<link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/start/jquery-ui.css" media="all" rel="stylesheet" type="text/css" />#chr(10)#'>
		<cfset halt(expression='htmleditformat(loc.e)', halt=false, format="text")>
		<cfset halt(expression='htmleditformat(loc.r)', halt=false, format="text")>
		<cfset assert("loc.e eq loc.r")>
	</cffunction>

</cfcomponent>