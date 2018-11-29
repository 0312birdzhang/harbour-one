# -*- coding: utf-8 -*-
import os
import sys
import shutil
try:
    import pyotherside
except:
    pass
import subprocess
import urllib.request
import urllib.error
import urllib.parse
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
import feedparser
import base64

__appname__ = "harbour-one"
cachePath = os.path.join(XDG_CACHE_HOME, __appname__, __appname__, "one", "")
dbPath = os.path.join(XDG_DATA_HOME, __appname__,
                      __appname__, "QML", "OfflineStorage", "Databases")
savePath = os.path.join(HOME, "Pictures", "save", "One", "")
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)

url = 'http://v3.wufazhuce.com:8000/api/'
one_api_url = "https://rsshub.app/one"


def sumMd5(str):
    h = hashlib.md5()
    h.update(str.encode("utf-8"))
    md5name = h.hexdigest()
    return md5name

def saveImg(imgurl, savename):
    md5name = sumMd5(imgurl)
    try:
        realpath = cachePath+md5name
        tmppath = savePath+savename+"."+findImgType(realpath)
        isExis()
        shutil.copy(realpath, tmppath.encode("utf-8"))
        logging.debug(tmppath)
        pyotherside.send("1")
    except Exception as e:
        logging.debug(str(e))
        pyotherside.send("-1")


def isExis():
    if os.path.exists(savePath):
        pass
    else:
        os.makedirs(savePath)


"""
    缓存图片
"""


def cacheImg(url):
    md5name = sumMd5(url)
    cachedFile = cachePath+md5name
    if os.path.exists(cachedFile):
        pass
    else:
        if os.path.exists(cachePath):
            pass
        else:
            os.makedirs(cachePath)
        downloadImg(cachedFile, url)
    # 判断图片格式
    return cachedFile


"""
    下载文件
"""


def downloadImg(downname, downurl):
    try:
        urllib.request.urlretrieve(downurl, downname)
    except urllib.error.ContentTooShortError:
        pass


def clearImg():
    shutil.rmtree(cachePath)
    pyotherside.send("2")

# 判断图片格式


def findImgType(cachedFile):
    imgType = imghdr.what(cachedFile)
    return imgType

# CREATE TABLE IF NOT EXISTS datas(vol text UNIQUE, json TEXT)


def getDbname():
    dbname = sumMd5("one")
    return dbPath+"/"+dbname+".sqlite"


def getTodayContent(daystr):
    today = time.strftime("%Y%m%d", time.localtime())
    conn = sqlite3.connect(getDbname())
    try:
        cur = conn.cursor()
        cur.execute('''CREATE TABLE IF NOT EXISTS datas
                (vol int, json text) ''')
        conn.commit()
        cur.execute('SELECT json FROM datas WHERE vol= %s ' % daystr)
        result = cur.fetchone()
        if result:
            return json.dumps(base64.b64decode(result[0]))
        else:
            if today == daystr:
                data = getHtml()
                if data:
                    insertDatas(daystr, data)
                    return json.loads(data)
            else:
                return 'Error'
    except Exception as e:
        logging.debug("error")
        logging.debug(traceback.format_exc())
        return 'Error'
    finally:
        conn.close()

# 插入数据


def insertDatas(daystr, data):
    data = base64.b64encode(data.encode("utf-8"))
    conn = sqlite3.connect(getDbname())
    try:
        cur = conn.cursor()
        cur.execute("INSERT INTO datas VALUES ({0}, {1})".format(int(daystr),data.replace('"', '""')))
        conn.commit()
    except Exception as e:
        logging.debug("Insert error")
        logging.debug(str(e))
    finally:
        conn.close()


def getHtml():
    try:
        d = feedparser.parse(one_api_url)
        return json.dumps(d)
    except Exception as e:
        logging.debug("error")
        return {}


if __name__ == "__main__":
    getTodayContent(0)
