#coding=utf-8
import time
class MyKeywords():
    def __init__(self):
        pass


    #获取当前时间
    def get_current_time(self):
        current_time = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        return current_time