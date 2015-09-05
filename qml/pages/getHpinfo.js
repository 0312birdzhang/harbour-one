Qt.include("getBeforeDate.js")
Qt.include("md5.js")

var tmp_index;
var retry_count=0;
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
        try{
            var tmpArr = jsonObject.hpEntity.strAuthor.split("&");
            var imgName=tmpArr[0];
            var authorName=tmpArr[1];
            if(jsonObject.hpEntity.strContent.indexOf("from")>0){
                tmpArr = jsonObject.hpEntity.strContent.split("from");
                var contentStr=tmpArr[0];
                var contentFrom="<i>from</i> "+tmpArr[1];
            }else if(jsonObject.hpEntity.strContent.indexOf("by")>0){
                tmpArr = jsonObject.hpEntity.strContent.split("by");
                var contentStr=tmpArr[0];
                var contentFrom="<i>by</i> "+tmpArr[1];
            }else{
                var contentStr=tmpArr[0];
                var contentFrom="";
            }
            tmpArr = new Date(jsonObject.hpEntity.strMarketTime).toString().split(" ");
            var time_day=tmpArr[2];
            time_day = (time_day.length==1) ? "0"+time_day : time_day;
            var time_month_year=tmpArr[1]+" "+tmpArr[4]
            homeModel.append({
                                 "strHpId": jsonObject.hpEntity.strHpId,
                                 "strHpTitle": jsonObject.hpEntity.strHpTitle,
                                 "strThumbnailUrl": jsonObject.hpEntity.strThumbnailUrl,
                                 //                             "strAuthor": jsonObject.hpEntity.strAuthor,
                                 //                             "strContent": jsonObject.hpEntity.strContent,
                                 "imgName":imgName,
                                 "authorName":authorName,
                                 "contentStr":contentStr,
                                 "contentFrom":contentFrom,
                                 "time_day":time_day,
                                 "time_month_year":time_month_year,
                                 "day":jsonObject.hpEntity.strMarketTime
                             });
           }
        catch(e){
            if(retry_count < 2){
                load(parseInt(tmp_index) + 1);
            }
            retry_count+=1;
        }
    }

}



