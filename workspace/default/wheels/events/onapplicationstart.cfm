<cffunction name="onApplicationStart" returntype="void" access="public" output="false">
	<cfscript>
		var loc = {};

		// abort if called from incorrect file
		$abortInvalidRequest();

		// set or reset all settings but make sure to pass along the reload password between forced reloads with "reload=x"
		if (StructKeyExists(application, "wheels") && StructKeyExists(application.wheels, "reloadPassword"))
			loc.oldReloadPassword = application.wheels.reloadPassword;
		application.wheels = {};
		if (StructKeyExists(loc, "oldReloadPassword"))
			application.wheels.reloadPassword = loc.oldReloadPassword;

		// check and store server engine name, throw error if using a version that we don't support
		if (StructKeyExists(server, "railo"))
		{
			application.wheels.serverName = "Railo";
			application.wheels.serverVersion = server.railo.version;
		}
		else
		{
			application.wheels.serverName = "Adobe ColdFusion";
			application.wheels.serverVersion = server.coldfusion.productversion;
		}
		loc.majorVersion = Left(application.wheels.serverVersion, 1);
		if ((application.wheels.serverName == "Railo" && loc.majorVersion < 3) || (application.wheels.serverName == "Adobe ColdFusion" && loc.majorVersion < 8))
			$throw(type="Wheels.EngineNotSupported", message="#application.wheels.serverName# #application.wheels.serverVersion# is not supported by Wheels.", extendedInfo="Upgrade to Adobe ColdFusion 8 (or higher) or Railo 3.0 (or higher).");

		// copy over the cgi variables we need to the request scope (since we use some of these to determine URL rewrite capabilities we need to be able to access them directly on application start for example)
		request.cgi = $cgiScope();

		// set up containers for routes, caches, settings etc
		application.wheels.version = "1.1 Beta 1";
		application.wheels.controllers = {};
		application.wheels.models = {};
		application.wheels.existingModelFiles = "";
		application.wheels.existingControllerFiles = "";
		application.wheels.nonExistingControllerFiles = "";
		application.wheels.existingLayoutFiles = "";
		application.wheels.nonExistingLayoutFiles = "";
		application.wheels.existingHelperFiles = "";
		application.wheels.nonExistingHelperFiles = "";
		application.wheels.routes = [];
		application.wheels.namedRoutePositions = {};
		application.wheels.mixins = {};
		application.wheels.cache = {};
		application.wheels.cache.sql = {};
		application.wheels.cache.image = {};
		application.wheels.cache.main = {};
		application.wheels.cache.action = {};
		application.wheels.cache.page = {};
		application.wheels.cache.partial = {};
		application.wheels.cache.query = {};
		application.wheels.cacheLastCulledAt = Now();

		// set up paths to various folders in the framework
		application.wheels.webPath = Replace(request.cgi.script_name, Reverse(spanExcluding(Reverse(request.cgi.script_name), "/")), "");
		application.wheels.rootPath = "/" & ListChangeDelims(application.wheels.webPath, "/", "/");
		application.wheels.rootcomponentPath = ListChangeDelims(application.wheels.webPath, ".", "/");
		application.wheels.wheelsComponentPath = ListAppend(application.wheels.rootcomponentPath, "wheels", ".");
		application.wheels.configPath = "config";
		application.wheels.eventPath = "events";
		application.wheels.filePath = "files";
		application.wheels.imagePath = "images";
		application.wheels.javascriptPath = "javascripts";
		application.wheels.modelPath = "models";
		application.wheels.modelComponentPath = "models";
		application.wheels.pluginPath = "plugins";
		application.wheels.pluginComponentPath = "plugins";
		application.wheels.stylesheetPath = "stylesheets";
		application.wheels.viewPath = "views";

		// set environment either from the url or the developer's environment.cfm file
		if (StructKeyExists(URL, "reload") && !IsBoolean(URL.reload) && Len(url.reload) && StructKeyExists(application.wheels, "reloadPassword") && (!Len(application.wheels.reloadPassword) || (StructKeyExists(URL, "password") && URL.password == application.wheels.reloadPassword)))
			application.wheels.environment = URL.reload;
		else
			$include(template="#application.wheels.configPath#/environment.cfm");

		// load wheels settings
		$include(template="wheels/events/onapplicationstart/settings.cfm");

		// set a default (can be overridden in developer settings below) for whether or not to show the links in the debug area to run tests
		if (DirectoryExists(GetDirectoryFromPath(GetBaseTemplatePath()) & "wheels/tests"))
			application.wheels.enableTests = true;
		else
			application.wheels.enableTests = false; // the tests folder has been removed (as it will be for official Wheels releases until we support application tests) so we default to not show the links

		// load general developer settings first, then override with environment specific ones
		$include(template="#application.wheels.configPath#/settings.cfm");
		$include(template="#application.wheels.configPath#/#application.wheels.environment#/settings.cfm");

		if(application.wheels.clearQueryCacheOnReload)
		{
			$objectcache(action="clear");
		}

		$loadRoutes();

		// add all public controller / view methods to a list of methods that you should not be allowed to call as a controller action from the url
		loc.allowedGlobalMethods = "get,set,addroute,addDefaultRoutes";
		loc.protectedControllerMethods = StructKeyList($createObjectFromRoot(path=application.wheels.controllerPath, fileName="Wheels", method="$initControllerClass"));
		application.wheels.protectedControllerMethods = "";
		loc.iEnd = ListLen(loc.protectedControllerMethods);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
		{
			loc.method = ListGetAt(loc.protectedControllerMethods, loc.i);
			if (Left(loc.method, 1) != "$" && !ListFindNoCase(loc.allowedGlobalMethods, loc.method))
				application.wheels.protectedControllerMethods = ListAppend(application.wheels.protectedControllerMethods, loc.method);
		}

		// reload the plugins each time we reload the application
		$loadPlugins();

		// allow developers to inject plugins into the application variables scope
		if (!StructIsEmpty(application.wheels.mixins))
			$include(template="wheels/plugins/injection.cfm");

		// create the dispatcher that will handle all incoming requests
		application.wheels.dispatch = $createObjectFromRoot(path="wheels", fileName="Dispatch", method="$init");

		// run the developer's on application start code
		$include(template="#application.wheels.eventPath#/onapplicationstart.cfm");
	</cfscript>
</cffunction>