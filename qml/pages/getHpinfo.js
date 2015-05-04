Qt.include("getBeforeDate.js")


function load(index) {
    var today = new Date();
    homeModel.clear();
    var xhr = new XMLHttpRequest();
    var date = Qt.formatDate(getBeforeDate(today, index), "yyyy-MM-dd");
    var url="http://211.152.49.184:7001/OneForWeb/one/getHpinfo?strDate="+date;
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
        homeModel.append({
                             "strHpId": jsonObject.hpEntity.strHpId,
                             "strHpTitle": jsonObject.hpEntity.strHpTitle,
                             "strThumbnailUrl": jsonObject.hpEntity.strThumbnailUrl,
                             "strAuthor": jsonObject.hpEntity.strAuthor,
                             "strContent": jsonObject.hpEntity.strContent,
                             "strMarketTime": jsonObject.hpEntity.strMarketTime
                    });
        //console.log("strAuthor"+jsonObject.hpEntity.strAuthor);
    }

}



