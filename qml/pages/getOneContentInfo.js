Qt.include("getBeforeDate.js")


function load(index) {
    var today = new Date();
    contentModel.clear();
    var xhr = new XMLHttpRequest();
    var date = Qt.formatDate(getBeforeDate(today, index), "yyyy-MM-dd");
    var url="http://211.152.49.184:7001/OneForWeb/one/getOneContentInfo?strDate="+date;
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                //var jsonObject = xhr.responseText;
                loaded(jsonObject)
            }
        }
    }

    xhr.send();
}



function loaded(jsonObject)
{
    if(jsonObject.result != "SUCCESS" ){

    }
    else{
        contentModel.append({
                                "sGW": jsonObject.contentEntity.sGW,
                                "strContTitle": jsonObject.contentEntity.strContTitle,
                                "strContAuthor": jsonObject.contentEntity.strContAuthor,
                                "strContAuthorIntroduce": jsonObject.contentEntity.strContAuthorIntroduce,
                                "sAuth": jsonObject.contentEntity.sAuth,
                                "strMarketTime": jsonObject.contentEntity.strMarketTime,
                                "sWbN": jsonObject.contentEntity.sWbN,
                                "strContent": jsonObject.contentEntity.strContent
                            });

    }

}



