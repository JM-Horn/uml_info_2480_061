<cfset stateFunctions = createObject("stateInfo") />

<cfif !session.keyExists("user")>
    <cfset session.user = stateFunctions.obtainUser() />
</cfif>