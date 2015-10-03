//
//  BaseAction.swift
//  test
//
//  Created by suzhenpeng on 15/9/30.
//  Copyright © 2015年 suzhenpeng. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class BaseAction{
    
    /**
    post网络请求
    
    - parameter url:     网络请求地址
    - parameter object:  传递参数
    - parameter success: 请求成功返回内容
    - parameter failure: 请求失败code
    - parameter message: 请求失败内容
    */
    static func post(url:String,object:[String: AnyObject]?,success:((response:NSData)->Void),failure:((code:Int,message:String)->Void)){
        post(url, object: object, headers: nil, success: { (response) -> Void in
            success(response: response)
            }) { (code, message) -> Void in
                failure(code: code, message: message)
        }
    }
    
    
    /**
    post网络请求
    
    - parameter url:     网络请求地址
    - parameter object:  传递参数
    - parameter headers: header内容
    - parameter success: 请求成功返回内容
    - parameter failure: 请求失败code
    - parameter message: 请求失败内容
    */
    static func post(url:String,object:[String: AnyObject]?,headers:[String: String]?,success:((response:NSData)->Void),failure:((code:Int,message:String)->Void)){
        print("request:\(url)", terminator: "")
        if url.isEmpty{
            failure(code: API_REQUEST_ERROR, message: "请求地址为空")
            return
        }
        
        let request = NSURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadRevalidatingCacheData, timeoutInterval: 5000)
        
        Alamofire.request(.POST,request, headers:headers,parameters: object).responseString { response in
            //print("Response String: \(response.result.value)")
            }.response { (req:NSURLRequest?, res:NSHTTPURLResponse?, ns:NSData?, error:NSError?) -> Void in
                let statusCode:Int=(res?.statusCode)!
                //网络请求失败
                if statusCode != 200{
                    failure(code:API_REQUEST_ERROR, message:"http code:\(statusCode)")
                    return
                }
                
                //网络请求成功
                let jsonData=JSON(data: ns!)
                let msg=jsonData["message"]
                print("message:\(msg)")
                if let apicode=jsonData["code"].int{
                    if(apicode == 0){
                        //数据返回成功
                        success(response: ns!)
                    }else{
                        //如果返回错误值
                        let message=jsonData["message"].string
                        failure(code: apicode, message: message!)
                    }
                }else{
                    let error=jsonData["data"].error
                    print("数据解析失败\(error)")
                    failure(code: API_DATA_ERROR, message: error!.description)
                }
        }
    }
    
    /**
    get网络请求
    
    - parameter url:     网络请求地址
    - parameter object:  传递参数
    - parameter success: 请求成功返回内容
    - parameter failure: 请求失败code
    - parameter message: 请求失败内容
    */
    static func get(url:String,object:[String: AnyObject]?,success:((response:NSData)->Void),failure:((code:Int,message:String)->Void)){
        get(url, object: object, headers: nil, success: { (response) -> Void in
            success(response: response)
            }) { (code, message) -> Void in
                failure(code: code, message: message)
        }
    }
    
    
    /**
    get网络请求
    
    - parameter url:     网络请求地址
    - parameter object:  传递参数
    - parameter headers: header内容
    - parameter success: 请求成功返回内容
    - parameter failure: 请求失败code
    - parameter message: 请求失败内容
    */
    static func get(url:String,object:[String: AnyObject]?,headers:[String: String]?,success:((response:NSData)->Void),failure:((code:Int,message:String)->Void)){
        print("request:\(url)", terminator: "")
        if url.isEmpty{
            failure(code: API_REQUEST_ERROR, message: "请求地址为空")
            return
        }
        
        let request = NSURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadRevalidatingCacheData, timeoutInterval: 5000)
        
        Alamofire.request(.GET,request, headers:headers,parameters: object).responseString { response in
            //print("Response String: \(response.result.value)")
            }.response { (req:NSURLRequest?, res:NSHTTPURLResponse?, ns:NSData?, error:NSError?) -> Void in
                let statusCode:Int=(res?.statusCode)!
                //网络请求失败
                if statusCode != 200{
                    failure(code:API_REQUEST_ERROR, message:"http code:\(statusCode)")
                    return
                }
                
                //网络请求成功
                let jsonData=JSON(data: ns!)
                let msg=jsonData["message"]
                print("message:\(msg)")
                if let apicode=jsonData["code"].int{
                    if(apicode == 0){
                        //数据返回成功
                        success(response: ns!)
                    }else{
                        //如果返回错误值
                        let message=jsonData["message"].string
                        failure(code: apicode, message: message!)
                    }
                }else{
                    let error=jsonData["data"].error
                    print("数据解析失败\(error)")
                    failure(code: API_DATA_ERROR, message: error!.description)
                }
        }
    }
    
    
}