#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Created on 2015年6月17日

@author: zhangdebo
'''
from bs4 import BeautifulSoup
import urllib2

def queryStatus(url):
    response = urllib2.urlopen(url)
    allhtml = response.read()
    soup = BeautifulSoup(allhtml)
    title = soup.title.string
    #print allhtml
    titulo = soup.find_all("div", "one-titulo")[0].contents[0].strip() #VOL号
    imagen = soup.find_all("div", "one-imagen")[0].find("img")['src'].strip()#首页图片链接
    imagen_leyenda = soup.find_all("div", "one-imagen-leyenda")[0].contents[0].strip()#图片标题
    cita = soup.find_all("div", "one-cita")[0].contents[0].strip()#文章内容
    dom = soup.find_all("p", "dom")[0].contents[0].strip()#day
    may = soup.find_all("p", "may")[0].contents[0].strip()#month

    comilla_cerrar = soup.find_all("div","comilla-cerrar")[0].contents[0].strip() #文章最上面的文字
    articulo_titulo = soup.find_all("h2","articulo-titulo")[0].contents[0].strip() #文章标题
    articulo_autor = soup.find_all("p","articulo-autor")[0].contents[0].strip() #文章作者
    articulo_contenido = soup.find_all("div","articulo-contenido")[0].contents[0] #文章内容

    #cuestion_q_icono = soup.find_all("div","cuestion-q-icono")[0].contents[0].strip() #问题-标题
    cuestion_contenido = soup.find_all("div","cuestion-contenido")[0].contents[0].strip() #问题-问
    cuestion_contenians = soup.find_all("div","cuestion-contenido")[0].contents[0] #问题-答
    print cuestion_contenido,"----",cuestion_contenians

if __name__ == "__main__":
    queryStatus('http://wufazhuce.com/one/vol.1118')