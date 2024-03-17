<cfparam name="loginmessage" default="" />

<script type="text/javascript">
    function validateAccount(){
        if(originalPassword === confirmPassword){
            document.getElementById('submitLogin').click();
            document.getElementById('loginmessage').innerHTML="";
        } else {
            document.getElementById('loginmessage').innerHTML="Please verify your email address and password and try again."
        }
    }
</script>

<cfoutput>
    <div id="loginmessage">#loginmessage#</div>
</cfoutput>

<form action="#cgi.script_name#?p=login" method="post">
    <div class="form-floating mb-3">
        <input type="email" id="loginemail" name="loginemail" class="form-control" placeholder="Please enter your email address to log in." required />    
        <label for="weight">*Email:</label>
    </div>
    <div class="form-floating mb-3">
        <input type="password" id="loginpass" name="loginpass" class="form-control" placeholder="Please enter your password to log in." required />    
        <label for="password">*Password:</label>
    </div>
    <div>
        <button id="loginButton" class="btn btn-warning" type="button" onclick="validateAccount()">Log In </button>
        <input type="submit" id="submitLogin" style="display:none" />
    </div>
</form>