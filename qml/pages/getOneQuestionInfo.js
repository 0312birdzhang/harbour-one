Qt.include("getBeforeDate.js")


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
        strQuestionTitle = jsonObject.questionAdEntity.strQuestionTitle;
        strQuestionContent = jsonObject.questionAdEntity.strQuestionContent;
        strAnswerTitle = jsonObject.questionAdEntity.strAnswerTitle;
        strAnswerContent = jsonObject.questionAdEntity.strAnswerContent;
    }

}

