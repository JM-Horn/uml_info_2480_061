<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">
        <img src="images/rdb.png" alt="Read Dees Books Logo"/>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <cfoutput>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/JenniferHorn/MyFinalProject/">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#cgi.script_name#?p=content&id=C183786C-C371-46F6-AB65BBB030221AEA">Store Information</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#cgi.script_name#?p=content&id=ED41AA47-41D7-4081-A08D2ABE730EE476">Highlighted Favorites</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#cgi.script_name#?p=content&id=19596FEC-1007-4C2B-B9E20C5516B0778B">Events</a>
            </li>
        </ul>
            <form class="d-flex" action="#cgi.script_name#?p=details" method="post">
                <input class="form-control me-2" type="search" name="searchme" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Search</button>
            </form>
        </cfoutput>
        <cfoutput>
            <cfif session.user.isloggedin>
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a>Welcome #session.user.firstname#</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#cgi.script_name#?p=logoff ">Logout </a>
                    </li>
                </ul>
            <cfelse>
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#cgi.script_name#?p=login">Login</a>
                    </li>
                </ul>
            </cfif>
        </cfoutput>
    </div>
</nav>