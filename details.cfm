<cfparam name="searchme" default="" />
<cfparam name="genre" default="" />

<cfoutput>
    <cfset bookInfo=bookstoreFunctions.obtainSearchResults( searchme, genre ) />

    <cfif bookinfo.recordcount == 0>
        #noResults()#
    <cfelseif bookinfo.recordcount == 1>
        #oneResult()#
    <cfelse>
        #manyResults()#
    </cfif>

</cfoutput>

<cffunction name="noResults">
    There are no results that match your query. Please try again.
</cffunction>
<cffunction name="oneResult">
    <cfoutput>
        <div class="row">
            <div class="col-6">
                <img src="images/#bookinfo.IMAGE[1]#" style="float:left; width:250px; height:250px" />
            </div>
            <div class="col-6">
                <span>Title: #bookinfo.title[1]#</span><br/>
                <span>Publisher: #bookinfo.name[1]#</span><br/>
                <span>Year: #bookinfo.year[1]#</span><br/>
                <span>Pages: #bookinfo.pages[1]#</span><br/>
                <span>Description: #bookinfo.description[1]#</span>
            </div>
    </cfoutput>
</cffunction>
<cffunction name="manyResults">
    <div>
        <h3>
            <cfoutput>
                #bookstoreFunctions.resultsHeader(searchme, genre)#
            </cfoutput>
        </h3>
    </div>
    <div>
        <div>
            <ol class="nav flex-column">
                <cfoutput query="bookinfo">
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.script_name#?=details&searchme=#trim(isbn13)#">
                            #trim(title)#
                        </a>
                    </li>
                </cfoutput>
            </ol>
        </div>
    </div>
</cffunction>