component {
   function processForms( required struct formData ){
    if(formData.keyExists("isbn13") && formData.isbn13.len()==13 && formData.keyExists('title') && formData.title.len() > 0){
        if(formdata.keyExists("uploadImage") && formData.uploadImage.len() > 0){
            formData.image = uploadBookCover();
        }
        var qs = new query (datasource = application.dsource);
        qs.setSql("
        if not exists( select * from books where isbn13=:isbn13)
        insert into books (isbn13,title) values (:isbn13, :title);
            update books set
                title=:title,
                weight=:weight,
                year=:year,
                pages=:pages,
                isbn=:isbn,
                publisherID=:publisher,
                image=:image,
                description=:description
                where isbn13=:isbn13");

        qs.addParam(
            name = "isbn13",
            cfsqltype = "CF_SQL_NVARCHAR",
            value = trim(formData.isbn13),
            null=formData.isbn13.len()!=13
        );
        qs.addParam(
            name = "title",
            cfsqltype = "CF_SQL_NVARCHAR",
            value = trim(formData.title),
            null=formData.title.len()==0
        );
        qs.addParam(
            name = "year",
            cfsqltype = "CF_SQL_NUMERIC",
            value = trim(formData.year)
        );
        qs.addParam(
            name = "weight",
            cfsqltype = "CF_SQL_NUMERIC",
            value = trim(formData.weight)
        );
        qs.addParam(
            name = "isbn",
            cfsqltype = "CF_SQL_NVARCHAR",
            value = trim(formData.isbn)
        );
        qs.addParam(
            name = "pages",
            cfsqltype = "CF_SQL_NUMERIC",
            value = trim(formData.pages)
        );
        qs.addParam(
            name = 'publisher',
            cfsqltype = "CF_SQL_NVARCHAR",
            value = trim(formData.publisher),
            null = trim(formData.publisher).len() != 35
        );
        qs.addParam(
            name="image",
            cfsqltype = "CF_SQL_NVARCHAR",
            value=formData.image
        );
        qs.addParam(
            name = "description",
            cfsqltype = "CF_SQL_NVARCHAR",
            value = trim(formData.description),
            null = trim(formData.description).len() == 0
        );
        qs.execute();
    }
   }

   function sideNavBooks(qterm){
    if(qterm.len() ==0){
        return queryNew("title");
    } else {
        var qs = new query (datasource=application.dsource);
        qs.setSql("select * from books where title like :qterm order by title");
        qs.addParam(
            name="qterm",
            value="%#qterm#%"
        );
        return qs.execute().getResult();
    }
}

    function bookDetails(isbn13){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from books where isbn13=:isbn13");
        qs.addParam(
            name="isbn13",
            CFSQLTYPE="CF_SQL_NVARCHAR",
            value=arguments.isbn13
        );
        return qs.execute().getResult();
    }

    function allPublishers(){
        var qs = new query (datasource=application.dsource);
        qs.setSql("select * from publishers order by name");
        return qs.execute().getResult();
    }

    function uploadBookCover(){
        var imageData = fileUpload(expandPath("../images/"),"uploadImage","*","makeUnique");
        return imageData.serverFile;
    }
   }

