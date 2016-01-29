#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Created on 2016年1月29日

@author: 0312birdzhang
'''
import traceback
import urllib.request,urllib.error,urllib.parse
from socket import timeout
import logging
import json
import chardet

def getHp(strDate):
    return "http://bea.wufazhuce.com/OneForWeb/one/getHp_N?strDate={0}&strRow=1".format(strDate)

def getContent(strDate):
    return "http://bea.wufazhuce.com/OneForWeb/one/getC_N?strDate={0}&strRow=1".format(strDate)

def getQuestion(strDate):
    return "http://bea.wufazhuce.com/OneForWeb/one/getQ_N?strDate={0}&strRow=1".format(strDate)

def getThing(strDate):
    return "http://bea.wufazhuce.com/OneForWeb/one/o_f?strDate={0}&strRow=1".format(strDate)


def queryFactory(url):
    print(url)
    i_headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36",\
                 "Referer": 'http://www.baidu.com'}
    req = urllib.request.Request(url, headers=i_headers)
    try:
        response = urllib.request.urlopen(req,timeout=30)
        jsondata = response.read()
        code_f = chardet.detect(jsondata)["encoding"]
        if code_f:
            jsondata = json.loads(jsondata.decode(code_f))
        else:
            jsondata = json.loads(jsondata.decode("gbk"))
        return jsondata
    except timeout:
        logging.error('socket timed out - URL %s', url)
        return "Timeout"
    except Exception as e:
        print(traceback.format_exc())
        return None

def main(strDate):
    #查询首页
    jsondata = queryFactory(getHp(strDate))["hpEntity"]
    titulo = jsondata["strHpTitle"]
    imagen = jsondata["strOriginalImgUrl"]
    imagen_leyenda = jsondata["strAuthor"].replace("&","<br/>")
    cita_content=""
    cita_author=""
    if "by" in jsondata["strContent"]:
        cita_content = jsondata["strContent"].split("by")[0]
        cita_author = "by "+jsondata["strContent"].split("by")[1]
    else:
        cita_content = jsondata["strContent"].split("from")[0]
        cita_author = "from "+jsondata["strContent"].split("from")[1]

    dom = strDate.split("-")[-1]
    may = strDate.split("-")[1]
    #查询文章
    jsondata = queryFactory(getContent(strDate))["contentEntity"]
    comilla_cerrar = jsondata["sGW"]
    articulo_titulo = jsondata["strContTitle"]
    articulo_autor = jsondata["sAuth"]
    articulo_contenido = jsondata["strContent"]
    articulo_editor = jsondata["strContAuthorIntroduce"]

    #查询问题
    jsondata = queryFactory(getQuestion(strDate))["questionAdEntity"]
    cuestion_title = jsondata["strQuestionTitle"]
    cuestion_question = jsondata["strQuestionContent"]
    cuestion_answerer = jsondata["strAnswerTitle"]
    cuestion_contenians = jsondata["strAnswerContent"]

    #查询东西
    jsondata = queryFactory(getThing(strDate))["entTg"]
    cosas_imagen = jsondata["strBu"]
    cosas_titulo = jsondata["strTt"]
    cosas_contenido = jsondata["strTc"]

    one_map = {
            "titulo":titulo,
            "imagen":imagen,
            "imagen_leyenda":imagen_leyenda,
            "cita_content":cita_content,
            "cita_author":cita_author,
            "dom":dom,
            "may":may,
            "comilla_cerrar":comilla_cerrar,
            "articulo_titulo":articulo_titulo,
            "articulo_autor":articulo_autor,
            "articulo_contenido":articulo_contenido,
            "articulo_editor":articulo_editor,

            "cuestion_title":cuestion_title,
            "cuestion_question":cuestion_question,
            "cuestion_answerer":cuestion_answerer,
            "cuestion_contenians":cuestion_contenians,

            "cosas_imagen":cosas_imagen,
            "cosas_titulo":cosas_titulo,
            "cosas_contenido":cosas_contenido
        }
    print(one_map)
    return one_map

if __name__ == "__main__":
    main("2016-01-29")
