component {
    function obtainUser(
        isLoggedIn = false,
        firstname="",
        lastname="",
        email="",
        acctNumber=""
    ) {
        return {
            isLoggedIn=arguments.isLoggedIn,
            firstname:arguments.firstname,
            lastname:arguments.lastname,
            email:arguments.email,
            acctNumber:arguments.acctNumber
        };
    }
}