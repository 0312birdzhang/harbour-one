# -*- coding: utf-8 -*-
import os,sys,shutil
try:
    import pyotherside
except:
    pass
import subprocess
import urllib.request,urllib.error,urllib.parse
import imghdr
import hashlib
from basedir import *
import json
import logging
import sqlite3
import traceback
from socket import timeout
import time
import datetime

__appname__ = "harbour-one"
cachePath=os.path.join(XDG_CACHE_HOME, __appname__, __appname__,"one","")
dbPath=os.path.join(XDG_DATA_HOME, __appname__,__appname__, "QML","OfflineStorage","Databases")
savePath=os.path.join(HOME, "Pictures", "save","One","")
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

url = 'http://v3.wufazhuce.com:8000/api/'


def saveImg(md5name,savename):
    try:
        realpath=cachePath+md5name
        tmppath = savePath+savename+"."+findImgType(realpath)
        isExis()
        #logging.debug(tmppath)
        shutil.copy(realpath,tmppath.encode("utf-8"))
        logging.debug(tmppath)
        pyotherside.send("1")
    except Exception as e:
        #logging.debug(e)
        pyotherside.send("-1")

def isExis():
    if os.path.exists(savePath):
        pass
    else:
        os.makedirs(savePath)

"""
    缓存图片
"""
def cacheImg(url,md5name):
    cachedFile = cachePath+md5name
    if os.path.exists(cachedFile):
        pass
    else:
        if os.path.exists(cachePath):
            pass
        else:
            os.makedirs(cachePath)
        downloadImg(cachedFile,url)
    #判断图片格式
    return cachedFile

"""
    下载文件
"""
def downloadImg(downname,downurl):
    try:
        urllib.request.urlretrieve(downurl,downname)
    except urllib.error.ContentTooShortError:
        pass

def clearImg():
    shutil.rmtree(cachePath)
    pyotherside.send("2")

#判断图片格式
def findImgType(cachedFile):
    imgType = imghdr.what(cachedFile)
    return imgType

#CREATE TABLE IF NOT EXISTS datas(vol text UNIQUE, json TEXT)
def getDbname():
    h = hashlib.md5()
    h.update("one".encode(encoding='utf_8', errors='strict'))
    dbname=h.hexdigest()
    return dbPath+"/"+dbname+".sqlite"


#def getTodayContent(vindex):
#    today = time.strftime("%Y-%m-%d", time.localtime())
#    conn = sqlite3.connect(getDbname())
#    try:
#        cur = conn.cursor()
#        cur.execute('''CREATE TABLE IF NOT EXISTS datas
#                 (vol int, json text) ''')
#        conn.commit()
#        cur.execute('SELECT json FROM datas WHERE vol= %s ' % vol)
#        result= cur.fetchone()
#        if result:
#            return json.loads(result[0])
#        else:
#            data=getHtml(day)
#            #插入
#            if data and data != "Timeout":
#                if day <= today:
#                    insertDatas(vol,data)
#                return data
#            else:
#                return 'Error'
#    except Exception as e:
#        logging.debug("error")
#        logging.debug(traceback.format_exc())
#        return 'Error'
#    finally:
#        conn.close()

#插入数据
def insertDatas(vol,data):
    conn = sqlite3.connect(getDbname())
    try:
        cur = conn.cursor()
        cur.execute("INSERT INTO datas VALUES (%s,'%s')" % (str(vol),json.dumps(data) ) )
        conn.commit()
    except Exception as e:
        logging.debug("Insert error")
        #logging.debug(traceback.format_exc())
    finally:
        conn.close()

def getHtml(api):
    #logging.debug(date)

    #logging.DEBUG(url)
    i_headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36",\
                 "Referer": 'http://www.wufazhuce.com/'}
    req = urllib.request.Request(url+api,headers=i_headers)
    try:
        response = urllib.request.urlopen(req,timeout=30)
        allhtml = response.read()
        return json.loads(allhtml.decode("utf-8"))
    except Exception as e:
        logging.debug("error")
        #logging.debug(traceback.format_exc())
        return ''


def getTodayContent(vindex):
    vindex = int(vindex)
    #home page
    h_api = "hp/idlist/0"
    h_datas = getHtml(h_api)
    h_index = h_datas["data"][vindex]
    h_detail_api = "hp/detail/"+h_index
    h_detail_datas = getHtml(h_detail_api)
    h_data = h_detail_datas.get("data")
    titulo = h_data.get("hp_title")
    imagen = h_data.get("hp_img_url")
    imagen_leyenda =h_data.get("hp_author")
    cita = h_data.get("hp_content")
    cita_content=""
    cita_author=""
    if "by" in cita:
        cita_content = cita.split("by")[0]
        cita_author = "by "+cita.split("by")[1]
    else:
        cita_content = cita.split("from")[0]
        cita_author = "from "+cita.split("from")[1]
    makettime = h_data.get("hp_makettime")
    dom = datetime.datetime.strptime(makettime, '%Y-%m-%d %H:%M:%S').date().strftime("%d")
    may =  datetime.datetime.strptime(makettime, '%Y-%m-%d %H:%M:%S').date().strftime("%B %Y")

    #######other
    o_api = "reading/index/"
    o_datas = getHtml(o_api)
    essay_index = o_datas.get("data").get("essay")[vindex].get("content_id")
    question_index = o_datas.get("data").get("question")[vindex].get("question_id")
    essay_api = "essay/" + essay_index
    essay_datas = getHtml(essay_api).get("data")
    comilla_cerrar = essay_datas.get("guide_word")
    articulo_titulo = essay_datas.get("hp_title")
    articulo_autor = essay_datas.get("hp_author")
    articulo_contenido = essay_datas.get("hp_content")
    articulo_editor = essay_datas.get("hp_author_introduce")
    question_api = "question/"+question_index
    question_datas = getHtml(question_api).get("data")
    cuestion_title = question_datas.get("question_title")
    cuestion_question = question_datas.get("question_content")
    cuestion_answerer = question_datas.get("answer_title")
    cuestion_contenians = question_datas.get("answer_content")
    cosas_imagen = ""
    cosas_titulo = ""
    cosas_contenido = ""
    one_map= {
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
    #print(one_map)
    return one_map

if __name__ == "__main__":
    getTodayContent(0)
