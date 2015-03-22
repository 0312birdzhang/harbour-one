.pragma library

var today = new Date();
var homeModel;
var contentModel;
var questionModel;
var signalCenter;
var utility;

function sendWebRequest(url, callback, param){
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function(){
                switch(xhr.readyState){
                case xhr.OPENED:
                    signalCenter.loadStarted()
                    break;
                case xhr.HEADERS_RECEIVED:
                    if (xhr.status != 200)
                        signalCenter.loadFailed(qsTr("Error!Code:")+xhr.status+"  "+xhr.statusText)
                    break;
                case xhr.DONE:
                    if (xhr.status == 200){
                        try {
                            callback(xhr.responseText, param)
                            signalCenter.loadFinished()
                        } catch (e){
                            console.log(JSON.stringify(e))
                            signalCenter.loadFailed("")
                        }
                    } else {
                        signalCenter.loadFailed("")
                    }
                    break;
                }
            }
    xhr.open("GET", url)
    xhr.send()
}

function preloadHomeModel(index){
    if (homeModel.count > index)
        return;
    var date = Qt.formatDate(utility.dateBeforeDays(today, index), "yyyy-MM-dd");
    homeModel.append({"date": date, "hpEntity": undefined})
    sendWebRequest("http://211.152.49.184:7001/OneForWeb/one/getHpinfo?strDate="+date, loadHomeModelResult, date);
}
function loadHomeModelResult(oritxt, date){
    var obj = JSON.parse(oritxt);
    if (obj.result != "SUCCESS"){
        homeModel.hasPrev = false;
        homeModel.remove(getIndexByDate(homeModel, date));
    } else {
        homeModel.setProperty(getIndexByDate(homeModel, date), "hpEntity", obj.hpEntity)
    }
}



function preloadContentModel(index){
    if (contentModel.count > index)
        return;
    var date = Qt.formatDate(utility.dateBeforeDays(today, index), "yyyy-MM-dd");
    contentModel.append({"date":date, "contentEntity": undefined});
    sendWebRequest("http://211.152.49.184:7001/OneForWeb/one/getOneContentInfo?strDate="+date, loadContentModelResult, date);
}
function loadContentModelResult(oritxt, date){
    var obj = JSON.parse(oritxt);
    if (obj.result != "SUCCESS"){
        contentModel.hasPrev = false;
        contentModel.remove(getIndexByDate(contentModel, date));
    } else {
        contentModel.setProperty(getIndexByDate(contentModel, date), "contentEntity", obj.contentEntity)
    }
}


function preloadQuestionModel(index){
    if (questionModel.count > index)
        return;
    var date = Qt.formatDate(utility.dateBeforeDays(today, index), "yyyy-MM-dd");
    questionModel.append({"date":date, "questionAdEntity": undefined});
    sendWebRequest("http://211.152.49.184:7001/OneForWeb/one/getOneQuestionInfo?strDate="+date, loadQuestionModelResult, date);
}

function loadQuestionModelResult(oritxt, date){
    var obj = JSON.parse(oritxt);
    if (obj.result != "SUCCESS"){
        questionModel.hasPrev = false;
        questionModel.remove(getIndexByDate(questionModel, date));
    } else {
        questionModel.setProperty(getIndexByDate(questionModel, date), "questionAdEntity", obj.questionAdEntity)
    }
}


function getIndexByDate(model, date){
    for (var i=0; i<model.count; i++){
        if (model.get(i).date == date){
            return i;
        }
    }
    return -1;
}


function getContentData(date){
    sendWebRequest("http://211.152.49.184:7001/OneForWeb/one/getOneContentInfo?strDate="+date, loadContentData, date)
}

function loadContentData(oritxt, date){
    var obj = JSON.parse(oritxt)
    if (obj.result != "SUCCESS"){
        signalCenter.showMessage(obj.message)
    } else {
        signalCenter.getContentDataFinished(obj.contentEntity)
    }
}
