.pragma library
Qt.include("getBeforeDate.js");
var objects = new Object();
var signalcenter;
var app;
function sendWebRequest(url, callback, method, postdata) {
    console.log("url:"+url)
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
                switch(xmlhttp.readyState) {
                case xmlhttp.OPENED:signalcenter.loadStarted();break;
                case xmlhttp.HEADERS_RECEIVED:if (xmlhttp.status != 200)signalcenter.loadFailed(qsTr("error connection:")+xmlhttp.status+"  "+xmlhttp.statusText);break;
                case xmlhttp.DONE:if (xmlhttp.status == 200) {
                        try {
                            callback(xmlhttp.responseText);
                            signalcenter.loadFinished();
                        } catch(e) {
                            console.log(e)
                            signalcenter.loadFailed(qsTr("loading erro..."));
                        }
                    } else {
                        signalcenter.loadFailed("");
                    }
                    break;
                }
            }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}


function getHpinfo(strDate){
    sendWebRequest(getHp(strDate),loadHpInfo,"GET","");
}
function loadHpInfo(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.result === "SUCCESS"){
        objects.titulo = obj.hpEntity.strHpTitle;
        objects.imagen = obj.hpEntity.strOriginalImgUrl;
        objects.imagen_leyenda = obj.hpEntity.strAuthor;
        var strContent = obj.hpEntity.strContent;
        if(strContent.indexOf("by") != -1){
            objects.cita_content = strContent.split("by")[0];
            objects.cita_author = "by "+strContent.split("by")[1];
        }else{
            objects.cita_content = strContent.split("from")[0];
            objects.cita_author = "from "+strContent.split("from")[1];
        }
        var date = new Date(obj.hpEntity.strLastUpdateDate);
        objects.dom = date.toLocaleDateString(Qt.locale("zh_CN"),"dd");
        objects.may = date.toLocaleDateString(Qt.locale("zh_CN"),"MM yyyy");
        app.objects = objects;
    }else{
        signalcenter.showMessage(obj.message);
    }
}

function getContentInfo(strDate){
    sendWebRequest(getContent(strDate),loadContentInfo,"GET","");
}

function loadContentInfo(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.result === "SUCCESS"){
        objects.comilla_cerrar = obj.contentEntity.sGW;
        objects.articulo_titulo = obj.contentEntity.strContTitle;
        objects.articulo_autor = obj.contentEntity.sAuth;
        objects.articulo_contenido = obj.contentEntity.strContent;
        objects.articulo_editor = obj.contentEntity.strContAuthorIntroduce;
        app.objects = objects;
    }else{
        signalcenter.showMessage(obj.message);
    }
}

function getQuestionInfo(strDate){
    sendWebRequest(getQuestion(strDate),loadQuestion,"GET","");
}

function loadQuestion(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.result === "SUCCESS"){
        objects.cuestion_title = obj.questionAdEntity.strQuestionTitle;
        objects.cuestion_question = obj.questionAdEntity.strQuestionContent;
        objects.cuestion_answerer = obj.questionAdEntity.strAnswerTitle;
        objects.cuestion_contenians = obj.questionAdEntity.strAnswerContent;
        app.objects = objects;
    }else{
       signalcenter.showMessage(obj.message);
    }
}

function getThingInfo(strDate){
   sendWebRequest(getThing(strDate),loadTingInfo,"GET","");
}

function loadTingInfo(oritxt){
    var obj=JSON.parse(oritxt);
    if(obj.result === "SUCCESS"){
        objects.cosas_imagen = obj.entTg.strBu;
        objects.cosas_titulo = obj.entTg.strTt;
        objects.cosas_contenido = obj.entTg.strTc;
        app.objects = objects;
    }else{
       signalcenter.showMessage(obj.message);
    }
}

function getHp(strDate){
    console.log(strDate)
    return "http://bea.wufazhuce.com/OneForWeb/one/getHp_N?strDate="+parseDate(new Date())+"&strRow="+(getDiffDay(strDate+ " 00:00:00")+1);
}

function getContent(strDate){
    return "http://bea.wufazhuce.com/OneForWeb/one/getC_N?strDate="+parseDate(new Date())+"&strRow="+(getDiffDay(strDate+ " 00:00:00")+1);
}

function getQuestion(strDate){
    return "http://bea.wufazhuce.com/OneForWeb/one/getQ_N?strDate="+parseDate(new Date())+"&strRow="+(getDiffDay(strDate+ " 00:00:00")+1);
}

//已过期
function getThing(strDate){
    return "http://bea.wufazhuce.com/OneForWeb/one/o_f?strDate="+parseDate(new Date())+"&strRow="+(getDiffDay(strDate+ " 00:00:00")+1);
}

