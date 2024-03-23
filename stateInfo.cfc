component {
    function obtainUser(
        isLoggedIn =false,
        firstname="",
        lastname="",
        email="",
        acctNumber="",
        isAdmin=0
    ){
       return {
            isLoggedIn=arguments.isLoggedIn,
            firstname:arguments.firstname,
            lastname:arguments.lastname,
            email:arguments.email,
            acctNumber:arguments.acctNumber,
            isAdmin:arguments.isAdmin
        }
    }

    function emailisUnique(required string email){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from people where email=:email");
        qs.addParam(name="email",value=arguments.email);
        return qs.execute().getResult().recordcount == 0;
    }

    function processNewAccount(formData){
        if(emailisUnique(formData.email)){
            var newID = createuuid();
            if(addPassword(newid, formData.password)){
                addAccount(newid, formData.firstname, formData.lastname, formData.email)
            }
            return {success:true, message:"Account made. Go login!"};
        } else {
            return {
                success:false,
                message:"That email is already in our system. Please login"
            };
        }
    }

    function addPassword(id, password){
        try{
            var qs = new query(datasource = application.dsource);
            qs.setSql("insert into passwords (personid, password)
            values (:personid, :password) ");
            qs.addParam(name = "personid", value= arguments.id);
            qs.addParam(name = "password", value = hash(arguments.password, "SHA-512"));
            qs.execute();
            return true;
        }
        catch(ary err){
            return false;
        }
    }

    function addAccount(
        required string id,
        required string firstName,
        required string lastName,
        required string email,
        numeric isAdmin = 0
    ) {
        var qs = new query(datasource=application.dsource);
        qs.setSql("insert into people (id, firstname, lastname, email, isAdmin) values (:personid, :firstname, :lastname, :email, :isAdmin) ");
        qs.addParam(name="personid", value=arguments.id);
        qs.addParam(name="firstname", value=arguments.firstName);
        qs.addParam(name="lastname", value=arguments.lastName);
        qs.addParam(name="email", value=arguments.email);
        qs.addParam(name="isAdmin", value=arguments.isAdmin);
        qs.execute();
    }

    function logMeIn(username, password){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from people inner join passwords on people.id=passwords.personid where people.email=:email and passwords.password=:password");
        qs.addParam(name="email", value=arguments.username);
        qs.addParam(name="password", value=hash(arguments.password, "SHA-512"));
        return qs.execute().getResult();
    }
}