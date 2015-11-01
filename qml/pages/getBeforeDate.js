function getBeforeDate(d,n){
    var year = d.getFullYear();
    var mon = d.getMonth()+1;
    var day=d.getDate();
    var hour = d.getHours();
    if(day <= n){
        if(mon>1) {
            mon=mon-1;
        }
        else {
            year = year-1;
            mon = 12;
        }
    }
    d.setDate(d.getDate()-n);
    year = d.getFullYear();
    mon=d.getMonth()+1;
    day=d.getDate();
    var s = year+"-"+(mon<10?('0'+mon):mon)+"-"+(day<10?('0'+day):day);
    return s;
}

//获取两个日期时间差多少天
function getDiffDay(startday){
    var a = new Date(startday).getTime();
    var b= new Date().getTime();
    var c = 60*60*24*1000;
    var res = (b - a)/c;
    return parseInt(res);
}

function getDiffDay2(today){
    var a = new Date("2012-10-07 00:00:00").getTime();
    var b= new Date(today).getTime();
    var c = 60*60*24*1000;
    var d = new Date().getTime();
    if(b > d){
        b = d;
    }
    var res = (b - a)/c;
    return parseInt(res);
}

function parseDate(date){
    //console.log(date)
    var d = new Date(date);
    var year = d.getFullYear();
    var mon = d.getMonth()+1;
    var day=d.getDate();
    return year+"-"+mon+"-"+day
}
