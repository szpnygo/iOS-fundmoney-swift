import UIKit
import Foundation

class MoneyCls {

    //收益
    var profit:String!
    //十四日收益
    var fourteenday:String!
    //日期收益
    var sevenday:String!
    //二十日收益
    var twentyeight:String!
    //基金ID
    var foundid:String!
    //收益日期
    var gettime:String!
    //基金公司
    var company:String!
    //基金名称
    var title:String!
    //ID
    var id:String!
    //俗称
    var name:String!
    
    var fund_p_month:String!
    var fund_p_year:String!
    var fund_type:String!
    var fund_manager:String!
    var fund_maketime:String!
    var fund_director:String!
    var fund_money:String!
    var fund_time:String!
    
    init(){
        
    }
   
    //升序
    class func sortFuncAsc(b1:MoneyCls,b2:MoneyCls)->Bool {
        var d1:Double=(b1.profit as NSString).doubleValue
        var d2:Double=(b2.profit as NSString).doubleValue
        if(d1 < d2){
            return true
        }else{
            return false
        }
    }
    
    //降序
    class func sortFuncDesc(b1:MoneyCls,b2:MoneyCls)->Bool {
        var d1:Double=(b1.profit as NSString).doubleValue
        var d2:Double=(b2.profit as NSString).doubleValue
        if(d1 > d2){
            return true
        }else{
            return false
        }
    }
    
    func toStirng()->(String){
        var data="company:\(company) title:\(title) id:\(id) gettime:\(gettime) profit:\(profit) fourteenday+\(fourteenday) foundid:\(foundid) gettime:\(gettime) sevenday:\(sevenday)" as String
        return (data)
    }
}