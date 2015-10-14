//
//  FundListAction.swift
//  fundapp
//
//  Created by suzhenpeng on 15/10/3.
//  Copyright © 2015年 suzhenpeng. All rights reserved.
//

import Foundation


class FundListAction : BaseAction{
    
    static func getFundList(success:([MoneyCls])->Void){
    
        /** 基金数据 */
        var dataArray=[MoneyCls]()
        
        get(API_FUND_LIST, object: nil, success: { (response) -> Void in
            
            let jsonData=JSON(data:response)
            if let jsonArray=jsonData["data"].array{
                for item in jsonArray{
                    let profit=item["fund_profit"].string
                    let fourteenday=item["fund_p_fourteen"].string
                    let sevenday=item["fund_p_seven"].string
                    let twentyeight=item["fund_p_twenty"].string
                    let foundid=item["fundid"].string
                    let gettime=item["fund_time"].string
                    let company=item["company"].string
                    let title=item["fund_title"].string
                    let id=item["id"].string
                    let name=item["name"].string
                    let bean = MoneyCls()
                    bean.title=title
                    bean.profit=profit
                    bean.fourteenday=fourteenday
                    bean.twentyeight=twentyeight
                    bean.foundid=foundid
                    bean.gettime=gettime
                    bean.company=company
                    bean.sevenday=sevenday
                    bean.name=name
                    bean.id=id
                    bean.fund_p_month=item["fund_p_month"].string
                    bean.fund_p_year=item["fund_p_year"].string
                    bean.fund_type=item["fund_type"].string
                    bean.fund_maketime=item["fund_maketime"].string
                    bean.fund_director=item["fund_director"].string
                    bean.fund_money=item["fund_money"].string
                    bean.fund_time=item["fund_time"].string
                    bean.fund_manager=item["fund_manager"].string
                    dataArray.append(bean)

                }
            }
            success(dataArray)
            }) { (code, message) -> Void in
                //请求失败
                print("getFundHistory error code=\(code) message=\(message)", terminator: "")
                let fundAction=FundAction()
                let fundDataArray=fundAction.getTempDataArray()
                success(fundDataArray)

        }
        
    }
    
}