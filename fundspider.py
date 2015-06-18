from bs4 import BeautifulSoup
import urllib.request
import sys
import getopt
import os
import json
import pymysql

#初始化
fund_id ='000343'
#是否带你信息 0 不打印 1打印
showprint=0
#是否保存数据库 0 不保存 1保存
savemysqlstate=0

#基金数据类
class FundBean:
    company=''
    name=''
    fundid=''
    img=''

    fund_title=''
    fund_type=''
    fund_manager=''
    fund_money=''
    fund_maketime=''
    fund_director=''
    fund_director_info=''
    fund_time=''
    fund_profit=''
    fund_p_seven=''
    fund_p_fourteen=''
    fund_p_twenty=''
    fund_p_month=''
    fund_p_year=''

#基金采集参数
class FundAnalyseBean:
    company=''
    name=''
    fundid=''
    img=''

def SaveMysql(fb):
    if(fb==None):
        return
    if(savemysqlstate==0):
        return
    conn=pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='password', db='funddata',charset="utf8")
    cur=conn.cursor()
    sta=cur.execute("INSERT INTO `funddata` (`company`, `name`, `fundid`, `img`, `fund_title`, `fund_type`, `fund_manager`, `fund_money`, `fund_maketime`, `fund_director`, `fund_director_info`, `fund_time`, `fund_profit`, `fund_p_seven`, `fund_p_fourteen`, `fund_p_twenty`, `fund_p_month`, `fund_p_year`, `data_time`, `date`)VALUES( \'"+fb.company+"\', \'"+fb.name+"\', \'"+fb.fundid+"\', \'"+fb.img+"\', \'"+fb.fund_title+"\', \'"+fb.fund_type+"\', \'"+fb.fund_manager+"\', \'"+fb.fund_money+"\', \'"+fb.fund_maketime+"\', \'"+fb.fund_director+"\', \'"+fb.fund_director_info+"\', \'"+fb.fund_time+"\', \'"+fb.fund_profit+"\', \'"+fb.fund_p_seven+"\', \'"+fb.fund_p_fourteen+"\', \'"+fb.fund_p_twenty+"\', \'"+fb.fund_p_month+"\', \'"+fb.fund_p_year+"\', now(),curdate());")
    if(sta==1):
        print("数据库插入成功")
    else:
        print(sta)

#打印数据
def printFundData(fb):
    if(fb==None):
        return
    #是否打印数据
    if(showprint==1):
        print('')
        if(fb.company!=None):
            print("服务商名称   "+fb.company)
            print("产品名称     "+fb.name)
            print("基金ID       "+fb.fundid)
        print("基金名称     "+fb.fund_title)
        print("日期         "+fb.fund_time)
        print("收益         "+fb.fund_profit)
        print("七日内收益   "+fb.fund_p_seven)
        print("十四日收益   "+fb.fund_p_fourteen)
        print("二十日收益   "+fb.fund_p_twenty)
        print("三个月收益   "+fb.fund_p_month)
        print('')
    SaveMysql(fb)


#分析网页获取基金数据
def analyseData( fdid,*fdbean):
    fb=FundBean()
    #是否是通过JSON格式进入的数据
    if(fdbean != ()):
        fdid=fdbean[0].fundid
        fb.fundid=fdbean[0].fundid
        fb.company=fdbean[0].company
        fb.name=fdbean[0].name
        fb.img=fdbean[0].img
    #获取网页源码
    try:
        respone=urllib.request.urlopen('http://fund.eastmoney.com/'+fdid+'.html')
    except Exception as e:
        print(e)
        # sys.exit()
        return

    html=respone.read() 
    #转为UTF-8编码
    data=html.decode('gbk') 
    #生成BeautifulSoup对象
    soup=BeautifulSoup(data)

    #获取页面基金名称
    fund_title=soup.html.find('div',class_='bktit_new').a.string
    #获取基金类型
    fund_type=soup.html.find('tr',class_='rowselp').findAll('a')[0].string
    #h获取基金管理人
    fund_manager=soup.html.find('tr',class_='rowselp').findAll('a')[1].string
    #获取基金规模
    fund_money=soup.html.find('tr',class_='rowselp').findAll('td')[5].string
    #获取基金成立时间
    fund_maketime=soup.html.find('table',class_='sytable').findAll('tr')[4].findAll('td')[1].string
    #获取基金经理
    fund_director=soup.html.find('table',class_='sytable').findAll('tr')[4].findAll('td')[3].a.string
    #获取基金经理信息
    fund_director_info=soup.html.find('table',class_='sytable').findAll('tr')[4].findAll('td')[3].a['href']
    #获取数据时间
    fund_time=soup.html.findAll('td',rowspan='3')[1].string
    #获取万份收益
    fund_profit=soup.html.findAll('span',class_='red bold')[0].string
    #获取七日收益
    fund_p_seven=soup.html.findAll('span',class_='red bold')[1].string
    #获取十四日收益
    fund_p_fourteen=soup.html.findAll('span',class_='red bold')[2].string
    #获取二十日收益
    fund_p_twenty=soup.html.findAll('span',class_='red bold')[3].string
    #获取三月收益
    fund_p_month=soup.html.findAll('span',class_='red bold')[4].string
    #获取一年收益
    fund_p_year=soup.html.findAll('span',class_='red bold')[5].string

    #创建对象存数据
    fb.fund_title=fund_title
    fb.fund_type=fund_type
    fb.fund_manager=fund_manager
    fb.fund_money=fund_money
    fb.fund_maketime=fund_maketime
    fb.fund_director=fund_director
    fb.fund_director_info=fund_director_info
    fb.fund_time=fund_time
    fb.fund_profit=fund_profit
    fb.fund_p_seven=fund_p_seven
    fb.fund_p_fourteen=fund_p_fourteen
    fb.fund_p_twenty=fund_p_twenty
    fb.fund_p_month=fund_p_month
    fb.fund_p_year=fund_p_year

    return fb
    #函数结束

def analyseWithJson(jsondata):
    #加载JSON
    jd=json.loads(jsondata)
    #该JSON为数据，循环取出其中的数据，并且进行抓取
    for item in jd:
        fab=FundAnalyseBean()
        fab.name=item['name']
        fab.company=item['company']
        fab.fundid=item['fundid']
        fab.img=item['img']
        fb=analyseData('',fab)
        printFundData(fb)

#接受参数
opts,args=getopt.getopt(sys.argv[1:],'hf:i:sm',['help','file=','id=','show','mysql'])
for option,value in opts:
    if option in ["-h","-help"]:
        print("Fund Analyse Data 1 ")
        print(" -h  --help                 display this help")
        print(" -f  --file                 read json file with foundation to get data ")
        print(" -i  --id                   input one foundation id to get date ")
        print(" -s  --show                 print data info")
        sys.exit()
    elif option in ['--show','-s']:
        showprint=1
    elif option in ['--mysql','-m']:
        savemysqlstate=1
    elif option in ['--file','-f']:
        if(os.path.exists(value)):
            file_data=open(value)
            try:
                text=file_data.read()
            except Exception as e:
                print(e)
            finally:
                file_data.close()
            analyseWithJson(text)
        else:
            print('\nError!The file does not exist\n')
        sys.exit()
    elif option in ['--id','-i']:
        if(len(value) != 6):
            print('\nError!Please input right foundation id like 000343.(default id 000343)\n')
            sys.exit()
        else:
            fund_id=value
            fb=analyseData(fund_id)
            #判断是否请求成功
            if(fb==None):
                print('Request Failure')
                sys.exit()
            printFundData(fb)
            sys.exit()