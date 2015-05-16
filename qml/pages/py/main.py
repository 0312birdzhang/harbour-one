import os,sys,shutil
import pyotherside

cachePath="/home/nemo/.cache/harbour-one/harbour-one/one/"
savePath="/home/nemo/Pictures/save/One/"

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
