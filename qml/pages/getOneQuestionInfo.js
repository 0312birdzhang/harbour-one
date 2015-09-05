Qt.include("getBeforeDate.js")

var tmp_index;
var retry_count=0;
function load(index) {
    var today = new Date();
    var xhr = new XMLHttpRequest();
    var date = Qt.formatDate(getBeforeDate(today, index), "yyyy-MM-dd");
    var url="http://211.152.49.184:7001/OneForWeb/one/getOneQuestionInfo?strDate="+date;
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
            var tmpArr = new Date(jsonObject.questionAdEntity.strQuestionMarketTime).toString().split(" ");
            var time_day = tmpArr[2];
            time_day = (time_day.length==1) ? "0"+time_day : time_day;
            var timeStr=tmpArr[1]+" "+time_day+","+tmpArr[4];
            strQuestionTitle = jsonObject.questionAdEntity.strQuestionTitle;
            strQuestionContent = jsonObject.questionAdEntity.strQuestionContent;
            strAnswerTitle = jsonObject.questionAdEntity.strAnswerTitle;
            strAnswerContent = jsonObject.questionAdEntity.strAnswerContent;
            strQuestionMarketTime = timeStr;
        }catch(e){
            if(retry_count < 2){
                load(parseInt(tmp_index) + 1);
            }
            retry_count+=1;
        }
    }

}

