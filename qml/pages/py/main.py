import os,sys,shutil
import pyotherside
import subprocess
from basedir import *

cachePath=os.path.join(XDG_CACHE_HOME, "harbour-one", "harbour-one","one","")
savePath=os.path.join(HOME, "Pictures", "save","One","")

def saveImg(basename,volname):
    try:
        realpath=cachePath+basename+".jpg"
        isExis()
        shutil.copy(realpath,savePath+volname)
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
    cachedFile = cachePath+md5name+".jpg"
    if os.path.exists(cachedFile):
        pass
    else:
        if os.path.exists(cachePath):
            pass
        else:
            os.makedirs(cachePath)
        downloadImg(cachedFile,url)
    return cachedFile

"""
    下载文件

"""
def downloadImg(downname,downurl):
    p = subprocess.Popen("curl -o "+downname+" "+downurl,shell=True)
    #0则安装成功
    retval = p.wait()
"""
   清理缓存
"""
def clearImg():
    shutil.rmtree(cachePath)
    pyotherside.send("2")
