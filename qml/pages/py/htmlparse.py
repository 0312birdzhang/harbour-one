import traceback
from bs4 import BeautifulSoup
import urllib.request,urllib.error,urllib.parse

def queryContent(url):
    url = str(url).split(".")[0]
    i_headers = {"User-Agent": "Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1) Gecko/20090624 Firefox/3.5",\
                 "Referer": 'http://www.baidu.com'}
    req = urllib.request.Request('http://wufazhuce.com/one/vol.'+url, headers=i_headers)
    try:
        response = urllib.request.urlopen(req)
        allhtml = response.read()
        soup = BeautifulSoup(allhtml,"html.parser")
        #title = soup.title.string
        #print allhtml
        titulo = soup.find_all("div", "one-titulo")[0].contents[0].strip() #VOL号
        imagen = soup.find_all("div", "one-imagen")[0].find("img")['src'].strip() #首页图片链接
        imagen_leyenda = soup.find_all("div", "one-imagen-leyenda")[0].contents[0].strip() #图片标题
        cita = soup.find_all("div", "one-cita")[0].contents[0].strip() #文章内容
        cita_content = cita.split("by")[0]
        cita_author = "by "+cita.split("by")[1]
        dom = soup.find_all("p", "dom")[0].contents[0].strip() #day
        may = soup.find_all("p", "may")[0].contents[0].strip() #month

        comilla_cerrar = soup.find_all("div","comilla-cerrar")[0].stripped_strings #文章最上面的文字
        comilla_cerrar = u''.join(str(item) for item in comilla_cerrar)
        articulo_titulo = soup.find_all("h2","articulo-titulo")[0].contents[0].strip() #文章标题
        articulo_autor = soup.find_all("p","articulo-autor")[0].contents[0].strip() #文章作者
        articulo_contenido = soup.find_all("div","articulo-contenido")[0].contents #文章内容
        articulo_contenido = u''.join(str(item) for item in articulo_contenido)
        articulo_editor = soup.find_all("p","articulo-editor")[0].contents[0].strip()#责任编辑

        cuestion_title = soup.find_all("h4")[0].stripped_strings #问题-标题
        cuestion_title = u''.join(str(item) for item in cuestion_title)
        cuestion_contenido = soup.find_all("div","cuestion-contenido") #问题-问
        cuestion_question = cuestion_contenido[0].contents[0].strip() #问题-问
        cuestion_answerer = soup.find_all("h4")[1].contents[0].strip() #问题-回答者
        cuestion_contenians = cuestion_contenido[1].contents #问题-答
        cuestion_contenians = u''.join(str(item) for item in cuestion_contenians)

        #print cuestion_contenians

        cosas_imagen = soup.find_all("div", "cosas-imagen")[0].find("img")['src'].strip() #东西里面的图片链接
        cosas_titulo = u''.join(str(item) for item in soup.find_all("h2","cosas-titulo")[0].stripped_strings) #东西名
        cosas_contenido = soup.find_all("div","cosas-contenido")[0].stripped_strings #东西说明
        cosas_contenido = u''.join(str(item) for item in cosas_contenido)

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
    except Exception as e:
        return traceback.format_exc()

def parseCont():
    u''.join(str(item) for item in cuestion_contenians)
