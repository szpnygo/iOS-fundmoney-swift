//
//  UserAction.swift
//  fundapp
//
//  Created by suzhenpeng on 15/6/5.
//  Copyright (c) 2015年 suzhenpeng. All rights reserved.
//

import UIKit


class UserAction{

    init(){
        
    }
    
    func log(){
        
        //获取设备名称
        let name = UIDevice.currentDevice().name
        //获取设备系统名称
        let systemName = UIDevice.currentDevice().systemName
        //获取系统版本
        let systemVersion = UIDevice.currentDevice().systemVersion
        //获取设备模型
        let model = UIDevice.currentDevice().model
        
        
        var req=NSMutableURLRequest(URL: NSURL(string: "http://api.smemo.info/fund.php/Index/loginLog")!)
        req.timeoutInterval=6
        req.HTTPMethod="POST"
        req.HTTPBody=NSString(string: "name=\(name)&&systemName=\(systemName)&&systemVersion=\(systemVersion)&&model=\(model)").dataUsingEncoding(NSUTF8StringEncoding)
        //POST异步请求
        
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
        }
    }

}