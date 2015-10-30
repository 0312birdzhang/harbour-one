import os,sys,shutil
import pyotherside
import subprocess
import urllib
import urllib.request
import imghdr
from basedir import *
import htmlparse

cachePath=os.path.join(XDG_CACHE_HOME, "harbour-one", "harbour-one","one","")
savePath=os.path.join(HOME, "Pictures", "save","One","")

def saveImg(md5name,savename):
    try:
        realpath=cachePath+md5name
        isExis()
        shutil.copy(realpath,savePath+savename+"."+findImgType(realpath))
        pyotherside.send("1")
    except:
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

def getTodayContent():
    return queryContent(str(vol))
