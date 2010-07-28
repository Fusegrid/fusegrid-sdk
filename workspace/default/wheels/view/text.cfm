<cffunction name="autoLink" returntype="string" access="public" output="false" hint="Turns all URLs and e-mail addresses into clickable links."
	examples=
	'
		##autoLink("Download Wheels from http://cfwheels.org/download")##
		-> Download Wheels from <a href="http://cfwheels.org/download">http://cfwheels.org/download</a>

		##autoLink("Email us at info@cfwheels.org")##
		-> Email us at <a href="mailto:info@cfwheels.org">info@cfwheels.org</a>
	'
	categories="view-helper,text" functions="excerpt,highlight,simpleFormat,titleize,truncate">
	<cfargument name="text" type="string" required="true" hint="The text to create links in.">
	<cfargument name="link" type="string" required="false" default="all" hint="Whether to link URLs, email addresses or both. Possible values are: `all` (default), `URLs` and `emailAddresses`.">
	<cfargument name="domains" type="string" required="false" hint="The domains (.com, .co.uk etc) to auto link, not used with email addresses.">
	<cfscript>
		var loc = {};
		$args(name="autoLink", args=arguments);
		loc.domains = Replace(ListChangeDelims(arguments.domains, "|"), ".", "\.", "all");
		loc.urlRegex = "(?ix)([^(url=)|(href=)'""])(((https?)://([^:]+\:[^@]*@)?)([\d\w\-]+\.)?[\w\d\-\.]+\.(" & loc.domains & ")(( / [\w\d\.\-@%\\\/:]* )+)?(\?[\w\d\?%,\.\/\##!@:=\+~_\-&amp;]*(?<![\.]))?)";
		loc.mailRegex = "(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))";
		loc.returnValue = " " & arguments.text & " "; // spaces added because the regex assumes links are in the middle of the text
		if (arguments.link != "emailAddresses")
			loc.returnValue = loc.returnValue.ReplaceAll(loc.urlRegex, "$1<a href=""$2"">$2</a>");
		if (arguments.link != "URLs")
			loc.returnValue = REReplaceNoCase(loc.returnValue, loc.mailRegex, "<a href=""mailto:\1"">\1</a>", "all");
		loc.returnValue = Mid(loc.returnValue, 2, Len(loc.returnValue)-2);
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="excerpt" returntype="string" access="public" output="false" hint="Extracts an excerpt from text that matches the first instance of phrase."
	examples=
	'
		##excerpt(text="ColdFusion Wheels is a Rails-like MVC framework for Adobe ColdFusion and Railo", phrase="framework", radius=5)##
		-> ... MVC framework for ...
	'
	categories="view-helper,text" functions="autoLink,highlight,simpleFormat,titleize,truncate">
	<cfargument name="text" type="string" required="true" hint="The text to extract an excerpt from.">
	<cfargument name="phrase" type="string" required="true" hint="The phrase to extract.">
	<cfargument name="radius" type="numeric" required="false" default="100" hint="Number of characters to extract surrounding the phrase.">
	<cfargument name="excerptString" type="string" required="false" default="..." hint="String to replace first and/or last characters with.">
	<cfscript>
	var loc = {};
	loc.pos = FindNoCase(arguments.phrase, arguments.text, 1);
	if (loc.pos != 0)
	{
		if ((loc.pos-arguments.radius) <= 1)
		{
			loc.startPos = 1;
			loc.truncateStart = "";
		}
		else
		{
			loc.startPos = loc.pos - arguments.radius;
			loc.truncateStart = arguments.excerptString;
		}
		if ((loc.pos+Len(arguments.phrase)+arguments.radius) > Len(arguments.text))
		{
			loc.endPos = Len(arguments.text);
			loc.truncateEnd = "";
		}
		else
		{
			loc.endPos = loc.pos + arguments.radius;
			loc.truncateEnd = arguments.excerptString;
		}
		loc.returnValue = loc.truncateStart & Mid(arguments.text, loc.startPos, ((loc.endPos+Len(arguments.phrase))-(loc.startPos))) & loc.truncateEnd;
	}
	else
	{
		loc.returnValue = "";
	}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="highlight" returntype="string" access="public" output="false" hint="Highlights the phrase(s) everywhere in the text if found by wrapping it in a `span` tag."
	examples=
	'
		##highlight(text="You searched for: Wheels", phrases="Wheels")##
		-> You searched for: <span class="highlight">Wheels</span>
	'
	categories="view-helper,text" functions="autoLink,excerpt,simpleFormat,titleize,truncate">
	<cfargument name="text" type="string" required="true" hint="Text to search.">
	<cfargument name="phrases" type="string" required="true" hint="List of phrases to highlight.">
	<cfargument name="class" type="string" required="false" default="highlight" hint="Class to use in `span` tags surrounding highlighted phrase(s).">
	<cfscript>
		var loc = {};
		if (!Len(arguments.text) || !Len(arguments.phrases))
		{
			loc.returnValue = arguments.text;
		}
		else
		{
			loc.origText = arguments.text;
			loc.iEnd = ListLen(arguments.phrases);
			for (loc.i=1; loc.i <= loc.iEnd; loc.i=loc.i+1)
			{
				loc.newText = "";
				loc.phrase = Trim(ListGetAt(arguments.phrases, loc.i));
				loc.pos = 1;
				while (FindNoCase(loc.phrase, loc.origText, loc.pos))
				{
					loc.foundAt = FindNoCase(loc.phrase, loc.origText, loc.pos);
					loc.prevText = Mid(loc.origText, loc.pos, loc.foundAt-loc.pos);
					loc.newText = loc.newText & loc.prevText;
					if (Find("<", loc.origText, loc.foundAt) < Find(">", loc.origText, loc.foundAt) || !Find(">", loc.origText, loc.foundAt))
						loc.newText = loc.newText & "<span class=""" & arguments.class & """>" & Mid(loc.origText, loc.foundAt, Len(loc.phrase)) & "</span>";
					else
						loc.newText = loc.newText & Mid(loc.origText, loc.foundAt, Len(loc.phrase));
					loc.pos = loc.foundAt + Len(loc.phrase);
				}
				loc.newText = loc.newText & Mid(loc.origText, loc.pos, Len(loc.origText) - loc.pos + 1);
				loc.origText = loc.newText;
			}
			loc.returnValue = loc.newText;
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="simpleFormat" returntype="string" access="public" output="false" hint="Replaces single newline characters with HTML break tags and double newline characters with HTML paragraph tags (properly closed to comply with XHTML standards)."
	examples=
	'
		<!--- how most of your calls will look --->
		##simpleFormat(post.comments)##

		<!--- demonstrates what output looks like with specific data --->
		<cfsavecontent variable="comment">
			I love this post!

			Here''s why:
			* Short
			* Succinct
			* Awesome
		</cfsavecontent>
		##simpleFormat(comment)##
		-> <p>I love this post!</p>
		   <p>
		       Here''s why:<br />
			   * Short<br />
			   * Succinct<br />
			   * Awesome
		   </p>
	'
	categories="view-helper,text" functions="autoLink,excerpt,highlight,titleize,truncate">
	<cfargument name="text" type="string" required="true" hint="The text to format.">
	<cfargument name="wrap" type="boolean" required="false" default="true" hint="Set to `true` to wrap the result in a paragraph.">
	<cfscript>
		var loc = {};
		loc.returnValue = Trim(arguments.text);
		loc.returnValue = Replace(loc.returnValue, "#Chr(13)##Chr(10)#", Chr(10), "all");
		loc.returnValue = Replace(loc.returnValue, "#Chr(10)##Chr(10)#", "</p><p>", "all");
		loc.returnValue = Replace(loc.returnValue, "#Chr(10)#", "<br />", "all");
		
		// add back in our returns so we can strip the tags and re-apply them without issue
		// this is good to be edited the textarea text in it's original format (line returns)
		loc.returnValue = Replace(loc.returnValue, "</p><p>", "</p>#Chr(13)##Chr(10)##Chr(13)##Chr(10)#<p>", "all");
		loc.returnValue = Replace(loc.returnValue, "<br />", "<br />#Chr(13)##Chr(10)#", "all");
		
		if (arguments.wrap)
			loc.returnValue = "<p>" & loc.returnValue & "</p>";
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="titleize" returntype="string" access="public" output="false" hint="Capitalizes all words in the text to create a nicer looking title."
	examples=
	'
		##titleize("Wheels is a framework for ColdFusion")##
		-> Wheels Is A Framework For ColdFusion
	'
	categories="view-helper,text" functions="autoLink,excerpt,highlight,simpleFormat,truncate">
	<cfargument name="word" type="string" required="true" hint="The text to turn into a title.">
	<cfscript>
		var loc = {};
		loc.returnValue = "";
		loc.iEnd = ListLen(arguments.word, " ");
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
		{
			loc.returnValue = ListAppend(loc.returnValue, capitalize(ListGetAt(arguments.word, loc.i, " ")), " ");
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="truncate" returntype="string" access="public" output="false" hint="Truncates text to the specified length and replaces the last characters with the specified truncate string. (Defaults to ""..."")."
	examples=
	'
		##truncate(text="Wheels is a framework for ColdFusion", length=20)##
		-> Wheels is a frame...

		##truncate(text="Wheels is a framework for ColdFusion", truncateString=" (more)")##
		-> Wheels is a framework f (more)
	'
	categories="view-helper,text" functions="autoLink,excerpt,highlight,simpleFormat,titleize">
	<cfargument name="text" type="string" required="true" hint="The text to truncate.">
	<cfargument name="length" type="numeric" required="false" hint="Length to truncate the text to.">
	<cfargument name="truncateString" type="string" required="false" hint="String to replace the last characters with.">
	<cfscript>
		var loc = {};
		$args(name="truncate", args=arguments);
		if (Len(arguments.text) gt arguments.length)
			loc.returnValue = Left(arguments.text, arguments.length-Len(arguments.truncateString)) & arguments.truncateString;
		else
			loc.returnValue = arguments.text;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="wordTruncate" returntype="string" access="public" output="false" hint="Truncates text to the specified length of words and replaces the remaining characters with the specified truncate string. (Defaults to ""..."")."
	examples=
	'
		##wordTruncate(text="Wheels is a framework for ColdFusion", length=4)##
		-> Wheels is a frame...

		##truncate(text="Wheels is a framework for ColdFusion", truncateString=" (more)")##
		-> Wheels is a framework for (more)
	'
	categories="view-helper,text" functions="autoLink,excerpt,highlight,simpleFormat,titleize">
	<cfargument name="text" type="string" required="true" hint="The text to truncate.">
	<cfargument name="length" type="numeric" required="false" default="5" hint="Length to truncate the text to.">
	<cfargument name="truncateString" type="string" required="false" default="..." hint="String to replace the last characters with.">
	<cfscript>
		var loc = {};
		loc.returnValue = "";
		loc.wordArray = ListToArray(arguments.text, " ", false);
		loc.wordLen = ArrayLen(loc.wordArray);
		
		if (loc.wordLen gt arguments.length)
		{
			for (loc.i = 1; loc.i lte arguments.length; loc.i++)
				loc.returnValue = ListAppend(loc.returnValue, loc.wordArray[loc.i], " ");
			loc.returnValue = loc.returnValue & arguments.truncateString;
		}
		else
		{
			loc.returnValue = arguments.text;
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>