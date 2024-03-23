<cfset stateFunctions = createObject("stateInfo") />

<cfif !session.keyExists("user")>
    <cfset session.user = stateFunctions.obtainUser() />
</cfif>

<cfif form.keyExists("firstname")>
    <cfset newAccountResult = stateFunctions.processNewAccount(form) />
    <cfset newAccountMessage = newAccountResult.message />
</cfif>

<cfif form.keyExists("loginPass")>
    <cfset userData = stateFunctions.logMeIn(form.loginemail, form.loginpass) />
    <cfif userData.recordCount == 1>
        <cfset session.user=stateFunctions.obtainUser(
            isLoggedIn=1,
            firstname=userData.firstname[1],
            lastname=userData.lastname[1],
            email=userData.email[1],
            isAdmin=userData.isAdmin[1]
        ) />
        <cfset p="carousel">
    <cfelse>
        <cfset loginMessage="That login did not work." />
    </cfif>
</cfif>

<cfif url.keyExists("p") && url.p =='logoff'>
    <cfset session.user = stateFunctions.obtainUser() />
    <cfset p="carousel" />
</cfif>