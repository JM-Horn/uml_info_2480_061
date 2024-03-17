<cfparam name="newAccountMessage" default="" />

<script type="text/javascript">
    function validateNewAccount(){
        let originalPassword = document.getElementById('password').value;
        let confirmPassword = document.getElementById('confirmPassword').value;

        if(originalPassword !== '' && originalPassword === confirmPassword){
            document.getElementById('submitNewAccountForm').click();
            document.getElementById('newAccountMessage').innerHTML="";
        } else {
            document.getElementById('newAccountMessage').innerHTML="Please check that you entered your password and the confirm password entry."
        }
    }
</script>

<cfoutput>
<div id="newAccountMessage">#newAccountMessage#</div>
</cfoutput>

<form action="#cgi.script_name#?p=login" method="post">
    <div class="form-floating mb-3">
        <input type="text" id="title" name="title" class="form-control" placeholder="Please enter Mr./Ms./Miss/Mrs., etc." />
        <label for="title">Title:</label>
    </div>
    <div class="form-floating mb-3">
        <input type="text" id="firstname" name="firstname" class="form-control" placeholder="Please enter your first name." required />    
        <label for="firstname">*First Name:</label>
    </div>
    <div class="form-floating mb-3">
        <input type="text" id="lastname" name="lastname" class="form-control" placeholder="Please enter your last name." required />    
        <label for="lastname">*Last Name:</label>
    </div>
    <div class="form-floating mb-3">
        <input type="email" id="email" name="email" class="form-control" placeholder="Please provide your email address." required />    
        <label for="weight">*Email:</label>
    </div>
    <div class="form-floating mb-3">
        <input type="password" id="password" name="password" class="form-control" placeholder="Please enter a new password." required />    
        <label for="password">*Password:</label>
    </div>
    <div class="form-floating mb-3">
        <input type="password" id="confirmPassword" class="form-control" placeholder="Please re-enter your new password." required />    
        <label for="pages">*Confirm Password:</label>
    </div>
    <div>
        <button id="newAccountButton" class="btn btn-warning" type="button" onclick="validateNewAccount()">Make Account </button>
        <input type="submit" id="submitNewAccountForm" style="display:none" />
    </div>
</form>