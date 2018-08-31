*** Settings ***
Library    RequestsLibrary    
Library    SeleniumLibrary   

*** Variables ***
${url}    http://workorder2016-admin.lunztech.cn
${username}    gdadmin
${password}    Gdadmin


*** Keywords ***
谷歌浏览器访问工单中心
     SeleniumLibrary.Open Browser    ${url}    chrome
登录
    BuiltIn.Sleep    3    
    SeleniumLibrary.Input Text    name=username    ${username}
    SeleniumLibrary.Input Password    name=password    ${password}
    SeleniumLibrary.Click Button    css=[type=submit]
         

*** Test Cases ***
调用瓜子新增工单接口（post）
    #post x-www-form-urlencoded 调用接口示例
    RequestsLibrary.Create Session    AddOrUpdateOrderForGZ    http://workorder2016.lunztech.cn
    ${dic_headers}    BuiltIn.Create Dictionary    Content-Type=application/x-www-form-urlencoded    appkey=CB4A40DE-2E86-47BE-89BE-FEE881A53447
    ${dic_postData}    BuiltIn.Create Dictionary        borrower_name=车主010	install_cont_pho=123123123123	install_cont_per=联系人555	install_area=青岛	    install_date=2018-8-22	install_address=解放东路	city_code=110000	car_type=3	car_brand=宝马	car_model=宝马车系	car_color=红色	car_vin=78454554587554555	product_id=4F500000-4C4F-0200-5AAD-08D46AAB3257	service_life=2	product_type[0].count=10	product_type[1].type=22	special_tag=QJZ
    
    ${dic_resp}    RequestsLibrary.Post Request    AddOrUpdateOrderForGZ    api/OutwardInterface/AddOrUpdateOrderForGZ    data=${dic_postData}	headers=${dic_headers}
    BuiltIn.Log    ${dic_resp}    
    BuiltIn.Log    ${dic_resp.text}    

调用查询hbase接口（post）
    #post application/json 调用接口示例
    RequestsLibrary.Create Session    查询hbase    http://47.97.237.88:80
    ${dic_headers1}    BuiltIn.Create Dictionary    Content-Type=application/json
    
    ${dic_resp1}    RequestsLibrary.Post    查询hbase    /api/arch    data={"imei": "180310030743489","startTime": "2018-04-10T00:00:00+08:00","endTime": "2018-04-10T23:59:59+08:00","limit":1000}	headers=${dic_headers1}
    BuiltIn.Log    ${dic_resp1.text}    #${dic_resp1.content}    

调用瓜子查询工单接口（get）
    #get方法调用接口示例
    RequestsLibrary.Create Session    瓜子工单查询	http://workorder2016.lunztech.cn    
    ${dic_headers2}    BuiltIn.Create Dictionary    appkey=CB4A40DE-2E86-47BE-89BE-FEE881A53447
    ${dic_param2}    BuiltIn.Create Dictionary    worksheet_id=18082118480220121
    
    ${dic_resp2}    RequestsLibrary.Get Request    瓜子工单查询    /api/OutwardInterface/GetAllOrderInfoByAppCode    params=${dic_param2}    headers=${dic_headers2}    timeout=5
    BuiltIn.Log    ${dic_resp2.content}    

imei查询iccid(get)
    #get方法调用接口示例
    RequestsLibrary.Create Session    imei_api    http://lbs-device-api.iccidkudu.lunz.cn    
    ${dic_headers2}    BuiltIn.Create Dictionary    appkey=4DB480CA-5ACA-497B-BAE8-8F1F187D27A8
    ${dic_param2}    BuiltIn.Create Dictionary    IMEI=863014530083711    Ip=118.178.228.145
    
    ${dic_resp2}    RequestsLibrary.Get Request    imei_api    /geticcidbyimei    params=${dic_param2}    headers=${dic_headers2}    
    BuiltIn.Log    ${dic_resp2.content}    

    
登录工单中心
    #selenium的使用
    谷歌浏览器访问工单中心
    登录

    

    