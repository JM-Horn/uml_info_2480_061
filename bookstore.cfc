component {
    function obtainSearchResults ( searchMe ) {
        var qs = new query (datasource=application.dsource);
        qs.setSql("
        select * from books inner join publishers on books.publisherid=publishers.id where title like '%#trim(form.searchme)#%' or isbn13 like '%#trim(searchme)#%'
        ");

        qs.addParam(
           name = "searchme", value="%#searchme#%"
        );
        return qs.execute().getResult();
    }
}