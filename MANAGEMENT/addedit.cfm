<cfparam name="qterm" default="">
<cfparam name="book" default="">
<cftry>
    <cfset addEditFunctions = createObject("addedit") />
    <cfset addEditFunctions.processForms(form)>
    
    <div class="row">
        <div id="main" class="col-9">
            <cfif book neq "">
                <cfoutput>#mainForm()#</cfoutput>
            </cfif>
        </div>

        <div id="leftgutter" class="col-lg-3 order-first">
            <cfoutput>#sideNav()#</cfoutput>
        </div>
    </div>
    <cfcatch type="any">
        <cfoutput>
            #cfcatch#
        </cfoutput>
    </cfcatch>
</cftry>

<cffunction name="mainForm">
    <cfif book.len() == 0>
        Please choose a book from the left hand side.
    <cfelse>

        <cfset var allPublishers = addEditFunctions.allPublishers()>
        <cfset var thisBookDetails = addEditFunctions.bookDetails(book)>
        <cfset var allGenres = addEditFunctions.allGenres()>
        <cfset var bookGenres = addEditFunctions.bookGenres(book)>

        <cfoutput>
            <form action="#cgi.script_name#?tool=addedit&qterm=#qterm#" method="post" enctype="multipart/form-data">
                <div class="form-floating mb-3">
                    <input type="text" id="isbn13" name="isbn13" class="form-control" value="#thisBookDetails.isbn13[1]#" placeholder="ISBN13" />
                    <label for="isbn13">ISBN13:</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" id="title" name="title" class="form-control" value="#thisBookDetails.title[1]#" placeholder="Book title" />    
                    <label for="title">Book Title:</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="number" id="year" name="year" min="1900" class="form-control" value="#thisBookDetails.year[1]#" placeholder="Year published" />    
                    <label for="year">Year Published:</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="number" id="weight" name="weight" step=".01" class="form-control" value="#thisBookDetails.weight[1]#" placeholder="Book weight" />    
                    <label for="weight">Weight:</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="text" id="isbn" name="isbn" class="form-control" value="#thisBookDetails.isbn[1]#" placeholder="ISBN" />    
                    <label for="isbn">ISBN:</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="number" id="pages" name="pages" class="form-control" value="#thisBookDetails.pages[1]#" placeholder="Number of pages" />    
                    <label for="pages">Number of Pages:</label>
                </div>
                <div class="form-floating mb-3">
                    <select class="form-select" id="publisher" name="publisher" aria-label="Publisher Select Control">
                        <option></option>
                        <cfloop query="allPublishers">
                            <option value="#id#" #id eq thisBookDetails.publisherid ? "selected" : ""#> #name# </option>
                        </cfloop>
                    </select>
                    <label for="publisher">Publisher:</label>
                </div>
                <div class="row">
                    <div class="col">
                        <label for="uploadImage">Upload Cover</label>
                        <div class="input-group mb-3">
                            <input type="file" id="uploadImage" name="uploadimage" class="form-control" />
                            <input type="hidden" name="image" value="#trim(thisBookDetails.image[1])#" />
                        </div>
                    </div>
                    <div class="col">
                        <cfif thisBookDetails.image[1].len() gt 0 >
                            <img src="../images/#trim(thisBookDetails.image[1])#" style="width:200px" />
                        </cfif>
                    </div>
                </div>
                <div class="form-floating mb-3">
                    <div>
                        <label for="description">Description</label>
                    </div>
                    <textarea id="description" name="description" class="form-control">
                        <cfoutput>#trim(thisBookDetails.description[1])#</cfoutput>
                    </textarea>
                    <script>
                        ClassEditor
                            .create(document.querySelector('##description'))
                            .catch(error => {console.dir(error)});
                    </script>
                </div>
                <div>
                    <h4>Genres</h4>
                     <cfloop query="allGenres">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="#id#" id="genre#id#" name="genre">
                            <label class="form-check-label" for="genre#id#">
                                #name#
                            </label>
                        </div>
                    </cfloop>
                    <cfloop query="bookGenres">
                        <script>
                            document.getElementById("genre#genreid#").checked=true;
                        </script>
                    </cfloop>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%">Add Book</button>
            </form>
        </cfoutput>
    </cfif>
</cffunction>

<cffunction name="sideNav">
    <cfset allbooks = addEditFunctions.sideNavBooks(qterm)>
    <div>
        Book List
    </div>
    <cfoutput>
        #findBookForm()#
    </cfoutput>
    <cfoutput>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="#cgi.script_name#?tool=addedit&book=new" class="nav-link">
                    Add A New Book
                </a>
            </li>
            <cfif qterm.len() ==0>
                No Search Term Entered
            <cfelseif allBooks.recordcount==0>
                No Results Found
            <cfelse>
                <cfloop query="allbooks">
                    <li class="nav-item">
                        <a href="#cgi.script_name#?tool=addedit&book=#isbn13#&qterm=#qterm#" class="nav-link">#trim(title)#</a>
                    </li>
                </cfloop>
            </cfif>
        </ul>
    </cfoutput>
</cffunction>

<cffunction name="findBookForm">
    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit" />
                <label for="qterm">Search Inventory</label>
            </div>
        </form>
    </cfoutput>
</cffunction>