component {
   function processForms(formData){
        try{
            var newid = formdata.id.len() ? formData.id : createuuid();
            var qs = new query (datasource=application.dsource);
            qs.setSql("if not exists( select * from content where contentid=:id)
            insert into content (contentid, title, description)
            values (:newid, :title, :description);
            update content set
            title=:title,
            description=:description
            where contentid=:id
            ");

            qs.addParam(
                name = "newid",
                value = newid
            );
            
            qs.addParam(
                name = "id",
                value = formData.id
            );

            qs.addParam(
                name = "title",
                value = formData.title
            );

            qs.addParam(
                name = "description",
                value = formData.description
            );
            qs.execute();
        } catch(any err){
        writeDump(err);
        }
    }

    function allArticles(){
        var qs = new query (datasource=application.dsource);
        qs.setSql("select * from content order by title");
        return qs.execute().getResult();
    }

    function obtainArticle(id){
        var qs = new query (datasource=application.dsource);
        qs.setSql("select * from content where contentID=:id");
        
        qs.addParam(
            name="id", 
            value=arguments.id
        );
        return qs.execute().getResult();
    }
}