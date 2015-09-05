Qt.include("getBeforeDate.js")

var tmp_index;
var retry_count=0;
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
        try{
            var tmpArr = new Date(jsonObject.contentEntity.strContMarketTime).toString().split(" ");
            var time_day = tmpArr[2];
            time_day = (time_day.length==1) ? "0"+time_day : time_day;
            var timeStr=tmpArr[1]+" "+time_day+","+tmpArr[4];

            contentModel.append({
                                    "sGW": jsonObject.contentEntity.sGW,
                                    "strContTitle": jsonObject.contentEntity.strContTitle,
                                    "strContAuthor": jsonObject.contentEntity.strContAuthor,
                                    "strContAuthorIntroduce": jsonObject.contentEntity.strContAuthorIntroduce,
                                    "sAuth": jsonObject.contentEntity.sAuth,
                                    "strMarketTime": timeStr,
                                    "sWbN": jsonObject.contentEntity.sWbN,
                                    "strContent": jsonObject.contentEntity.strContent
                                });
        }catch(e){
            if(retry_count < 2){
                load(parseInt(tmp_index) + 1);
            }
            retry_count+=1;
        }
    }

}



