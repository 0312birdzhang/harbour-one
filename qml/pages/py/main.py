# -*- coding: utf-8 -*-
import os,sys,shutil
import pyotherside
import subprocess
import urllib
import urllib.request
import imghdr
import hashlib
from basedir import *
from htmlparse import *
import json
import logging
import sqlite3
import hashlib


__appname__ = "harbour-one"
cachePath=os.path.join(XDG_CACHE_HOME, __appname__, __appname__,"one","")
dbPath=os.path.join(XDG_DATA_HOME, __appname__,__appname__, "QML","OfflineStorage","Databases")
savePath=os.path.join(HOME, "Pictures", "save","One","")
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

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

#CREATE TABLE IF NOT EXISTS datas(day text UNIQUE, json TEXT)
def getDbname():
    h = hashlib.md5()
    h.update("one".encode(encoding='utf_8', errors='strict'))
    dbname=h.hexdigest()
    logging.debug(dbPath+"/"+dbname+".sqlite")
    return dbPath+"/"+dbname+".sqlite"

def getTodayContent(day):
    try:
        conn = sqlite3.connect(getDbname())
        cur = conn.cursor()
        cur.execute('''CREATE TABLE IF NOT EXISTS datas
                 (day text, json text) ''')
        cur.execute('SELECT json FROM datas WHERE day= %s ' % day)
        result= cur.fetchone()
        #logging.debug(result)
        if result:
            return json.loads(result[0])
        else:
            data=queryContent(day)
            #插入
            if data and data != "Timeout":
                insertDatas(day,data)
                return data
            else:
                return 'Error'
    except Exception as e:
        logging.debug(e)
        return 'Error'
    conn.close()

#插入数据
def insertDatas(day,data):
    try:
        conn = sqlite3.connect(getDbname())
        cur = conn.cursor()
        cur.execute("INSERT INTO datas VALUES ('%s','%s')" % (day,json.dumps(data) ) )
        conn.commit()
    except Exception as e:
        #pass
        logging.debug(e)
    conn.close()

#def getTodayContent(day):
#    return queryContent(day)
