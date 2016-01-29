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
    var b= today.getTime();
    var c = 60*60*24*1000;
    var d = new Date().getTime();
    if(b > d){
        b = d;
    }
    if(b < a){
        return 1;
    }
    var res = (b - a)/c;
    return parseInt(res);
}

function getDiffDay3(today){
    var a = new Date("2012-10-07 00:00:00").getTime();
    var b= new Date(today).getTime();
    var c = 60*60*24*1000;
    var d = new Date().getTime();
    if(b > d){
        b = d;
    }
    if(b < a){
        return 1;
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


function translateNumber(numberText) {
    var CHINESE_NEGATIVE = "负";
    var CHINESE_ZERO = "零";
    var CHINESE_DIGITS = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九"];
    var CHINESE_UNITS = ["", "十", "百", "千"];
    var CHINESE_GROUP_UNITS = ["", "万", "亿", "兆", "京", "垓", "杼", "穰", "溝", "澗", "正", "載", "極"];
    if (numberText === "") {
        return "";
    }
    numberText = numberText.replace(/^0+/g, "");
    numberText = numberText.replace(/^-0+/g, "-");
    if (numberText === "" || numberText === "-") {
        return CHINESE_ZERO;
    }
    var result = "";
    if (numberText[0] === "-") {
        result += CHINESE_NEGATIVE;
        numberText = numberText.substring(1);
    }

    var groupIsZero = true;
    var needZero = false;
    for (var i = 0; i < numberText.length; ++i) {
        var position = numberText.length - 1 - i;
        var digit = parseInt(numberText[i]);
        var unit = position % CHINESE_UNITS.length;
        var group = (position - unit) / CHINESE_UNITS.length;

        if (digit !== 0) {
            if (needZero) {
                result += CHINESE_ZERO;
            }

            if (digit !== 1 || unit !== 1 || !groupIsZero || (group === 0 && needZero)) {
                result += CHINESE_DIGITS[digit];
            }

            result += CHINESE_UNITS[unit];
        }

        groupIsZero = groupIsZero && (digit === 0);

        if (unit === 0 && !groupIsZero) {
            result += CHINESE_GROUP_UNITS[group];
        }

        needZero = (digit === 0 && (unit !== 0 || groupIsZero));

        if (unit === 0) {
            groupIsZero = true;
        }
    }
    return result;
}
function doNumberTranslation() {
    numberText = document.getElementById('number-input').value;
    chinese = translateNumber(numberText);
    document.getElementById('chinese-output').value = chinese;
}
