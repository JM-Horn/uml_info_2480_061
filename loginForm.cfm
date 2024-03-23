<cfparam name="loginmessage" default="" />

<cfoutput>
    <div id="loginmessage">#loginmessage#</div>
    <form action="#cgi.script_name#?p=login" method="post">
        <div class="form-floating mb-3">
            <input type="text" id="loginemail" name="loginemail" class="form-control" placeholder="Please enter your email." required />    
            <label for="loginemail">*Email:</label>
        </div>
        <div class="form-floating mb-3">
            <input type="password" id="loginpass" name="loginpass" class="form-control" placeholder="Please enter your password." required />    
            <label for="loginpass">*Password:</label>
        </div>
        <div class="form-floating mb-3">
            <input type="submit" class="btn btn-primary" value="Login" />
        </div>
    </form>
</cfoutput>