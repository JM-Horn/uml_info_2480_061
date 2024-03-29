<cfparam name="id" default="4" />

<cfset contentFunctions = createObject("JenniferHorn.MyFinalProject.management.content") />
<cfset myContent = contentFunctions.obtainArticle(id) />

<cfoutput>
    <h1>#myContent.title#</h1>
    <p>#myContent.description#</p>
</cfoutput>