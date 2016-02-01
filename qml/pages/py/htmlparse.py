import traceback
from bs4 import BeautifulSoup
import urllib.request,urllib.error,urllib.parse
from socket import timeout
import sys
import logging

def getHtml(date,type):
    i_headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36",\
                 "Referer": 'http://www.baidu.com'}
    req = urllib.request.Request('http://m.wufazhuce.com/'+type+'/'+date, headers=i_headers)
    try:
        response = urllib.request.urlopen(req,timeout=30)
        allhtml = response.read()
        return allhtml
    except Exception as e:
        print(e)

def queryContent(date):
    allhtml = getHtml(date,"one")
    soup = BeautifulSoup(allhtml,"html.parser")
    titulo = soup.find_all("span", "picture-detail-issue-no")[0].contents[0].strip() #VOL号
    imagen = soup.find_all("img", "item-picture-img")[0]["src"].strip() #首页图片链接
    imagen_leyenda =soup.find_all("p", "text-author")[0].contents[1].strip() #图片标题

    cita = soup.find_all("p", "text-content")[0].contents[0].strip() #首页内容

    cita_content=""
    cita_author=""
    if "by" in cita:
        cita_content = cita.split("by")[0]
        cita_author = "by "+cita.split("by")[1]
    else:
        cita_content = cita.split("from")[0]
        cita_author = "from "+cita.split("from")[1]
    dom = soup.find_all("p", "day")[0].contents[0].strip() #day
    may = soup.find_all("p", "month")[0].contents[0].strip() #month

    #获取文章
    allhtml = getHtml(date,"article")
    soup = BeautifulSoup(allhtml,"html.parser")
    comilla_cerrar = soup.find_all("p","text-lead")[0].contents[0].strip() #文章最上面的文字
    articulo_titulo = soup.find_all("p","text-title")[0].contents[0].strip() #文章标题
    articulo_autor = soup.find_all("p","text-author")[0].contents[0].strip() #文章作者
    articulo_contenido = soup.find_all("div","text-content")[0].stripped_strings #文章内容
    articulo_contenido =u''.join(str(item) for item in  articulo_contenido)
    articulo_tmp = soup.find_all("p","text-editor")
    articulo_editor = articulo_tmp[0].contents[0].strip() if len(articulo_tmp) > 0 else "" #责任编辑

    #获取问题
    allhtml = getHtml(date,"question")
    soup = BeautifulSoup(allhtml,"html.parser")
    cuestion_title = soup.find_all("p","text-title")[0].contents[0].strip() #问题-标题
    cuestion_question = soup.find_all("div","text-content")[0].stripped_strings#问题-问
    cuestion_question = u''.join(str(item) for item in  cuestion_question)
    cuestion_answerer = soup.find_all("p","text-title")[1].stripped_strings #问题-回答者
    cuestion_answerer = u''.join(str(item) for item in  cuestion_answerer)
    cuestion_contenians = soup.find_all("div","text-content")[1].stripped_strings #问题-答
    cuestion_contenians = u''.join(str(item) for item in  cuestion_contenians)

    #东西已经过期
#     cosas_imagen_tmp = soup.find_all("div", "cosas-imagen")[0].find("img")
#     cosas_imagen = cosas_imagen_tmp['src'].strip() if cosas_imagen_tmp.get("src") else 'http://www.example.com' #东西里面的图片链接
#     cosas_titulo = u''.join(str(item) for item in  soup.find_all("h2","cosas-titulo")[0].stripped_strings) #东西名
#     cosas_contenido = soup.find_all("div","cosas-contenido")[0].stripped_strings #东西说明
#     cosas_contenido = u''.join(str(item) for item in  cosas_contenido)
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
    return one_map

if __name__ == "__main__":
    queryContent(sys.argv[1])
