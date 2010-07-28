<cffunction name="textField" returntype="string" access="public" output="false" hint="Builds and returns a string containing a text field form control based on the supplied `objectName` and `property`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- view code --->
		<cfoutput>
		    <p>##textField(label="First Name", objectName="user", property="firstName")##</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,submitTag,radioButton,checkBox,passwordField,hiddenField,textArea,fileField,select,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="The variable name of the object to build the form control for.">
	<cfargument name="property" type="string" required="true" hint="The name of the property to use in the form control.">
	<cfargument name="label" type="string" required="false" hint="The label text to use in the form control.">
	<cfargument name="labelPlacement" type="string" required="false" hint="Whether to place the label before, after, or wrapped around the form control.">
	<cfargument name="prepend" type="string" required="false" hint="String to prepend to the form control. Useful to wrap the form control around HTML tags.">
	<cfargument name="append" type="string" required="false" hint="String to append to the form control. Useful to wrap the form control around HTML tags.">
	<cfargument name="prependToLabel" type="string" required="false" hint="String to prepend to the form control's label. Useful to wrap the form control around HTML tags.">
	<cfargument name="appendToLabel" type="string" required="false" hint="String to append to the form control's label. Useful to wrap the form control around HTML tags.">
	<cfargument name="errorElement" type="string" required="false" hint="HTML tag to wrap the form control with when the object contains errors.">
	<cfscript>
		var loc = {};
		$args(name="textField", reserved="type,name,value", args=arguments);
		if (!StructKeyExists(arguments, "id"))
			arguments.id = $tagId(arguments.objectName, arguments.property);
		loc.before = $formBeforeElement(argumentCollection=arguments);
		loc.after = $formAfterElement(argumentCollection=arguments);
		arguments.type = "text";
		arguments.name = $tagName(arguments.objectName, arguments.property);
		loc.maxlength = $maxLength(argumentCollection=arguments);
		if (StructKeyExists(loc, "maxlength"))
			arguments.maxlength = loc.maxlength;
		arguments.value = $formValue(argumentCollection=arguments);
		loc.returnValue = loc.before & $tag(name="input", close=true, skip="objectName,property,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement", skipStartingWith="label", attributes=arguments) & loc.after;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="passwordField" returntype="string" access="public" output="false" hint="Builds and returns a string containing a password field form control based on the supplied `objectName` and `property`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- view code --->
		<cfoutput>
		    <p>##passwordField(objectName="user", property="pass")##</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapter="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,submitTag,textField,radioButton,checkBox,hiddenField,textArea,fileField,select,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="See documentation for @textField.">
	<cfargument name="property" type="string" required="true" hint="See documentation for @textField.">
	<cfargument name="label" type="string" required="false" hint="See documentation for @textField">
	<cfargument name="labelPlacement" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prepend" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="append" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prependToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="appendToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="errorElement" type="string" required="false" hint="See documentation for @textField.">
	<cfscript>
		var loc = {};
		$args(name="passwordField", reserved="type,name,value", args=arguments);
		if (!StructKeyExists(arguments, "id"))
			arguments.id = $tagId(arguments.objectName, arguments.property);
		loc.before = $formBeforeElement(argumentCollection=arguments);
		loc.after = $formAfterElement(argumentCollection=arguments);
		arguments.type = "password";
		arguments.name = $tagName(arguments.objectName, arguments.property);
		loc.maxlength = $maxLength(argumentCollection=arguments);
		if (StructKeyExists(loc, "maxlength"))
			arguments.maxlength = loc.maxlength;
		arguments.value = $formValue(argumentCollection=arguments);
		loc.returnValue = loc.before & $tag(name="input", close=true, skip="objectName,property,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement", skipStartingWith="label", attributes=arguments) & loc.after;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="hiddenField" returntype="string" access="public" output="false" hint="Builds and returns a string containing a hidden field form control based on the supplied `objectName` and `property`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- view code --->
		<cfoutput>
		    <p>##hiddenField(objectName="user", property="id")##</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,submitTag,textField,radioButton,checkBox,passwordField,textArea,fileField,select,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="See documentation for @textField.">
	<cfargument name="property" type="string" required="true" hint="See documentation for @textField.">
	<cfscript>
		var loc = {};
		$args(name="hiddenField", reserved="type,name,value", args=arguments);
		arguments.type = "hidden";
		arguments.name = $tagName(arguments.objectName, arguments.property);
		if (!StructKeyExists(arguments, "id"))
			arguments.id = $tagId(arguments.objectName, arguments.property);
		arguments.value = $formValue(argumentCollection=arguments);
		if (application.wheels.obfuscateUrls && StructKeyExists(request.wheels, "currentFormMethod") && request.wheels.currentFormMethod == "get")
			arguments.value = obfuscateParam(arguments.value);
		loc.returnValue = $tag(name="input", close=true, skip="objectName,property", attributes=arguments);
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="fileField" returntype="string" access="public" output="false" hint="Builds and returns a string containing a file field form control based on the supplied `objectName` and `property`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- view code --->
		<cfoutput>
		    <p>##fileField(objectName="photo", property="imageFile")##</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,submitTag,textField,radioButton,checkBox,passwordField,hiddenField,textArea,select,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="See documentation for @textField.">
	<cfargument name="property" type="string" required="true" hint="See documentation for @textField.">
	<cfargument name="label" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="labelPlacement" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prepend" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="append" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prependToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="appendToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="errorElement" type="string" required="false" hint="See documentation for @textField.">
	<cfscript>
		var loc = {};
		$args(name="fileField", reserved="type,name", args=arguments);
		if (!StructKeyExists(arguments, "id"))
			arguments.id = $tagId(arguments.objectName, arguments.property);
		loc.before = $formBeforeElement(argumentCollection=arguments);
		loc.after = $formAfterElement(argumentCollection=arguments);
		arguments.type = "file";
		arguments.name = $tagName(arguments.objectName, arguments.property);
		loc.returnValue = loc.before & $tag(name="input", close=true, skip="objectName,property,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement", skipStartingWith="label", attributes=arguments) & loc.after;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="textArea" returntype="string" access="public" output="false" hint="Builds and returns a string containing a password field form control based on the supplied `objectName` and `property`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- view code --->
		<cfoutput>
		  <p>##textArea(objectName="article", property="overview")##</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,submitTag,textField,radioButton,checkBox,passwordField,hiddenField,fileField,select,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="See documentation for @textField.">
	<cfargument name="property" type="string" required="true" hint="See documentation for @textField.">
	<cfargument name="label" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="labelPlacement" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prepend" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="append" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prependToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="appendToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="errorElement" type="string" required="false" hint="See documentation for @textField.">
	<cfscript>
		var loc = {};
		$args(name="textArea", reserved="name", args=arguments);
		if (!StructKeyExists(arguments, "id"))
			arguments.id = $tagId(arguments.objectName, arguments.property);
		loc.before = $formBeforeElement(argumentCollection=arguments);
		loc.after = $formAfterElement(argumentCollection=arguments);
		arguments.name = $tagName(arguments.objectName, arguments.property);
		loc.content = $formValue(argumentCollection=arguments);
		loc.returnValue = loc.before & $element(name="textarea", skip="objectName,property,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement", skipStartingWith="label", content=loc.content, attributes=arguments) & loc.after;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="radioButton" returntype="string" access="public" output="false" hint="Builds and returns a string containing a radio button form control based on the supplied `objectName` and `property`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- view code --->
		<cfoutput>
		    <p>
			    ##radioButton(objectName="user", property="gender", tagValue="m", label="Male")##<br />
		        ##radioButton(objectName="user", property="gender", tagValue="f", label="Female")##
			</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,textField,submitTag,checkBox,passwordField,hiddenField,textArea,fileField,select,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="See documentation for @textField.">
	<cfargument name="property" type="string" required="true" hint="See documentation for @textField.">
	<cfargument name="tagValue" type="string" required="true" hint="The value of the radio button when `selected`.">
	<cfargument name="label" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="labelPlacement" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prepend" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="append" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prependToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="appendToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="errorElement" type="string" required="false" hint="See documentation for @textField.">
	<cfscript>
		var loc = {};
		$args(name="radioButton", reserved="type,name,value,checked", args=arguments);
		loc.valueToAppend = LCase(Replace(ReReplaceNoCase(arguments.tagValue, "[^a-z0-9- ]", "", "all"), " ", "-", "all"));
		if (!StructKeyExists(arguments, "id"))
		{
			arguments.id = $tagId(arguments.objectName, arguments.property);
			if (len(loc.valueToAppend))
				arguments.id = arguments.id & "-" & loc.valueToAppend;
		}
		loc.before = $formBeforeElement(argumentCollection=arguments);
		loc.after = $formAfterElement(argumentCollection=arguments);
		arguments.type = "radio";
		arguments.name = $tagName(arguments.objectName, arguments.property);
		arguments.value = arguments.tagValue;
		if (arguments.tagValue == $formValue(argumentCollection=arguments))
			arguments.checked = "checked";
		loc.returnValue = loc.before & $tag(name="input", close=true, skip="objectName,property,tagValue,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement", skipStartingWith="label", attributes=arguments) & loc.after;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="checkBox" returntype="string" access="public" output="false" hint="Builds and returns a string containing a check box form control based on the supplied `objectName` and `property`. In most cases, this function generates a form field that should represent a `boolean` style field in your data. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- view code --->
		<cfoutput>
		    <p>##checkBox(objectName="photo", property="isPublic", label="Display this photo publicly.")##</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,submitTag,textField,radioButton,passwordField,hiddenField,textArea,fileField,select,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="See documentation for @textField.">
	<cfargument name="property" type="string" required="true" hint="See documentation for @textField.">
	<cfargument name="checkedValue" type="string" required="false" hint="The value of the check box when it's on the `checked` state.">
	<cfargument name="uncheckedValue" type="string" required="false" hint="The value of the check box when it's on the `unchecked` state.">
	<cfargument name="label" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="labelPlacement" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prepend" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="append" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prependToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="appendToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="errorElement" type="string" required="false" hint="See documentation for @textField.">
	<cfscript>
		var loc = {};
		$args(name="checkBox", reserved="type,name,value,checked", args=arguments);
		if (!StructKeyExists(arguments, "id"))
			arguments.id = $tagId(arguments.objectName, arguments.property);
		loc.before = $formBeforeElement(argumentCollection=arguments);
		loc.after = $formAfterElement(argumentCollection=arguments);
		arguments.type = "checkbox";
		arguments.name = $tagName(arguments.objectName, arguments.property);
		arguments.value = arguments.checkedValue;
		loc.value = $formValue(argumentCollection=arguments);
		if (loc.value == arguments.value || IsNumeric(loc.value) && loc.value == 1 || !IsNumeric(loc.value) && IsBoolean(loc.value) && loc.value)
			arguments.checked = "checked";
		loc.returnValue = loc.before & $tag(name="input", close=true, skip="objectName,property,checkedValue,uncheckedValue,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement", skipStartingWith="label", attributes=arguments);
		if (Len(arguments.uncheckedValue))
		{
			loc.hiddenAttributes = {};
			loc.hiddenAttributes.type = "hidden";
			loc.hiddenAttributes.id = arguments.id & "-checkbox";
			loc.hiddenAttributes.name = arguments.name & "($checkbox)";
			loc.hiddenAttributes.value = arguments.uncheckedValue;
			loc.returnValue = loc.returnValue & $tag(name="input", close=true, attributes=loc.hiddenAttributes);
		}
		loc.returnValue = loc.returnValue & loc.after;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="select" returntype="string" access="public" output="false" hint="Builds and returns a string containing a select form control based on the supplied `objectName` and `property`. Note: Pass any additional arguments like `class`, `rel`, and `id`, and the generated tag will also include those values as HTML attributes."
	examples=
	'
		<!--- controller code --->
		<cfset authors = model("author").findAll()>

		<!--- view code --->
		<cfoutput>
		    <p>##select(objectName="book", property="authorId", options=authors)##</p>
		</cfoutput>
	'
	categories="view-helper,forms-object" chapters="form-helpers-and-showing-errors" functions="URLFor,startFormTag,endFormTag,submitTag,textField,radioButton,checkBox,passwordField,hiddenField,textArea,fileField,dateTimeSelect,dateSelect,timeSelect">
	<cfargument name="objectName" type="any" required="true" hint="See documentation for @textField.">
	<cfargument name="property" type="string" required="true" hint="See documentation for @textField.">
	<cfargument name="options" type="any" required="true" hint="A collection to populate the select form control with. Can be a query recordset or an array of objects.">
	<cfargument name="includeBlank" type="any" required="false" hint="Whether to include a blank option in the select form control. Pass `true` to include a blank line or a string that should represent what display text should appear for the empty value (for example, ""- Select One -"").">
	<cfargument name="valueField" type="string" required="false" hint="The column or property to use for the value of each list element. Used only when a query or array of objects has been supplied in the `options` argument.">
	<cfargument name="textField" type="string" required="false" hint="The column or property to use for the value of each list element that the end user will see. Used only when a query or array of objects has been supplied in the `options` argument.">
	<cfargument name="label" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="labelPlacement" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prepend" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="append" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="prependToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="appendToLabel" type="string" required="false" hint="See documentation for @textField.">
	<cfargument name="errorElement" type="string" required="false" hint="See documentation for @textField.">
	<cfscript>
		var loc = {};
		$args(name="select", reserved="name", args=arguments);
		if (!StructKeyExists(arguments, "id"))
			arguments.id = $tagId(arguments.objectName, arguments.property);
		loc.before = $formBeforeElement(argumentCollection=arguments);
		loc.after = $formAfterElement(argumentCollection=arguments);
		arguments.name = $tagName(arguments.objectName, arguments.property);
		if (StructKeyExists(arguments, "multiple"))
		{
			if (arguments.multiple)
				arguments.multiple = "multiple";
			else
				StructDelete(arguments, "multiple");
		}
		loc.content = $optionsForSelect(argumentCollection=arguments);
		if (!IsBoolean(arguments.includeBlank) || arguments.includeBlank)
		{
			if (!IsBoolean(arguments.includeBlank))
				loc.blankOptionText = arguments.includeBlank;
			else
				loc.blankOptionText = "";
			loc.blankOptionAttributes = {value=""};
			loc.content = $element(name="option", content=loc.blankOptionText, attributes=loc.blankOptionAttributes) & loc.content;
		}
		loc.returnValue = loc.before & $element(name="select", skip="objectName,property,options,includeBlank,valueField,textField,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement", skipStartingWith="label", content=loc.content, attributes=arguments) & loc.after;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="$optionsForSelect" returntype="string" access="public" output="false">
	<cfargument name="options" type="any" required="true">
	<cfargument name="valueField" type="string" required="true">
	<cfargument name="textField" type="string" required="true">
	<cfscript>
		var loc = {};
		loc.value = $formValue(argumentCollection=arguments);
		loc.returnValue = "";
		if (IsQuery(arguments.options))
		{
			if (!Len(arguments.valueField) || !Len(arguments.textField))
			{
				// order the columns according to their ordinal position in the database table
				loc.info = GetMetaData(arguments.options);
				loc.iEnd = ArrayLen(loc.info);
				loc.columns = "";
				for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
					loc.columns = ListAppend(loc.columns, loc.info[loc.i].name);
				if (!Len(loc.columns))
				{
					arguments.valueField = "";
					arguments.textField = "";
				}
				else if (ListLen(loc.columns) == 1)
				{
					arguments.valueField = ListGetAt(loc.columns, 1);
					arguments.textField = ListGetAt(loc.columns, 1);
				}
				else
				{
					// take the first numeric field in the query as the value field and the first non numeric as the text field
					loc.iEnd = arguments.options.RecordCount;
					for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
					{
						loc.jEnd = ListLen(loc.columns);
						for (loc.j=1; loc.j <= loc.jEnd; loc.j++)
						{
							if (!Len(arguments.valueField) && IsNumeric(arguments.options[ListGetAt(loc.columns, loc.j)][loc.i]))
								arguments.valueField = ListGetAt(loc.columns, loc.j);
							if (!Len(arguments.textField) && !IsNumeric(arguments.options[ListGetAt(loc.columns, loc.j)][loc.i]))
								arguments.textField = ListGetAt(loc.columns, loc.j);
						}
					}
					if (!Len(arguments.valueField) || !Len(arguments.textField))
					{
						// the query does not contain both a numeric and a text column so we'll just use the first and second column instead
						arguments.valueField = ListGetAt(loc.columns, 1);
						arguments.textField = ListGetAt(loc.columns, 2);
					}
				}
			}
			loc.iEnd = arguments.options.RecordCount;
			for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
			{
				loc.returnValue = loc.returnValue & $option(objectValue=loc.value, optionValue=arguments.options[arguments.valueField][loc.i], optionText=arguments.options[arguments.textField][loc.i]);
			}
		}
		else if (IsStruct(arguments.options))
		{
			loc.sortedKeys = ListSort(StructKeyList(arguments.options), "textnocase"); // sort struct keys alphabetically
			loc.iEnd = ListLen(loc.sortedKeys);
			for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
			{
				loc.key = ListGetAt(loc.sortedKeys, loc.i);
				loc.returnValue = loc.returnValue & $option(objectValue=loc.value, optionValue=LCase(loc.key), optionText=arguments.options[loc.key]);
			}
		}
		else
		{
			// convert the options to an array so we don't duplicate logic
			if (IsSimpleValue(arguments.options))
				arguments.options = ListToArray(arguments.options);

			// loop through the array
			loc.iEnd = ArrayLen(arguments.options);
			for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
			{
				loc.optionValue = "";
				loc.optionText = "";
				// see if the value in the array cell is an array, which means the programmer is using multidimensional arrays. if it is, use the first dimension for the key and the second for the value if it exists.
				if (IsSimpleValue(arguments.options[loc.i]))
				{
					loc.optionValue = arguments.options[loc.i];
					loc.optionText = humanize(arguments.options[loc.i]);
				}
				else if (IsArray(arguments.options[loc.i]) && ArrayLen(arguments.options[loc.i]) >= 2)
				{
					loc.optionValue = arguments.options[loc.i][1];
					loc.optionText = arguments.options[loc.i][2];
				}
				else if (IsObject(arguments.options[loc.i]))
				{
					if (StructKeyExists(arguments.options[loc.i], arguments.valueField))
						loc.optionValue = arguments.options[loc.i][arguments.valueField];
					if (StructKeyExists(arguments.options[loc.i], arguments.textField))
						loc.optionText = arguments.options[loc.i][arguments.textField];
				}
				loc.returnValue = loc.returnValue & $option(objectValue=loc.value, optionValue=loc.optionValue, optionText=loc.optionText);
			}
		}
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>

<cffunction name="$option" returntype="string" access="public" output="false">
	<cfargument name="objectValue" type="string" required="true">
	<cfargument name="optionValue" type="string" required="true">
	<cfargument name="optionText" type="string" required="true">
	<cfscript>
		var loc = {};
		loc.optionAttributes = {value=arguments.optionValue};
		if (arguments.optionValue == arguments.objectValue || ListFindNoCase(arguments.objectValue, arguments.optionValue))
			loc.optionAttributes.selected = "selected";
		if (application.wheels.obfuscateUrls && StructKeyExists(request.wheels, "currentFormMethod") && request.wheels.currentFormMethod == "get")
			loc.optionAttributes.value = obfuscateParam(loc.optionAttributes.value);
		loc.returnValue = $element(name="option", content=arguments.optionText, attributes=loc.optionAttributes);
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>