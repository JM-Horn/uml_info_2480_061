component {
    function obtainSearchResults ( searchMe, genre ) {
        if(searchme.len()){
        var qs = new query (datasource=application.dsource);
        qs.setSql("
        select * from books
        inner join publishers
        on books.publisherid=publishers.id
        where title like :searchme
        or isbn13 like :searchme
        ");

        qs.addParam(name = "searchme", value="%#trim(arguments.searchme)#%");

        return qs.execute().getResult();
        } else if(genre.len()){
            var qs = new query(datasource=application.dsource);
            qs.setSql("
            select * from books 
            inner join genrestobooks
            on books.isbn13 = genrestobooks.bookid
            inner join publishers
            on books.publisherid=publishers.id
            where genreid = :genre ");
            qs.addParam(name="genre", value=trim(arguments.genre));
            return qs.execute().getResult();
        }
    }

    function genresInStock(){
        var qs = new query (datasource=application.dsource);
        qs.setSql("
        select distinct name, genreid from genrestobooks
        inner join genres on genres.id = genrestobooks.genreid
        order by genres.name");
        return qs.execute().getResult();
    }

    function resultsHeader(searchme, genre){
        if(searchme.len() > 0){
            return 'Keyword: #searchme#';
        } elseif (genre.len() > 0) {
            return 'Genre: #obtainGenreNameById(arguments.genre)#';
        }
    }

    function obtainGenreNameById(genreid){
        var qs = new query(datasource=application.dsource);
        qs.setSql("
        select name from genres where id=:genreid");
        qs.addParam(name="genreid", value=arguments.genreid);
        return qs.execute().getResult().name;
    }
}