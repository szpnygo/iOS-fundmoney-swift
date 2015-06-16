import UIKit

class FundAction {
    
    /** 基金数据 */
    var dataArray=[MoneyCls]()
    /** 单基金10日数据 */
    var listDataArray=[MoneyCls]()
    
    init(){
        
    }
    
    func loadApiData()->Bool{
        //make api url
        var apiUrl:NSURL!=NSURL(string: "http://api.smemo.info/fund.php");
        
        
        var netError:NSErrorPointer=NSErrorPointer()
        var err:NSError?
        //get data
        var apiData:NSData!=NSData(contentsOfURL: apiUrl, options: NSDataReadingOptions.DataReadingUncached, error:&err);
        
        
        if err != nil{
            return false
        }
        
        if apiData == nil{
            return false
        }
        
        //make json object
        var apiResult=NSString(data: apiData, encoding: NSUTF8StringEncoding)
        
        
        var apiJson: AnyObject?=NSJSONSerialization.JSONObjectWithData(apiData, options: NSJSONReadingOptions.MutableContainers, error: netError)
        
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                
                
                var profit=data.objectForKey("fund_profit") as! String
                var fourteenday=data.objectForKey("fund_p_fourteen") as! String
                var sevenday=data.objectForKey("fund_p_seven") as! String
                var twentyeight=data.objectForKey("fund_p_twenty") as! String
                var foundid=data.objectForKey("fundid") as! String
                var gettime=data.objectForKey("fund_time") as! String
                var company=data.objectForKey("company") as! String
                var title=data.objectForKey("fund_title") as! String
                var id=data.objectForKey("id") as! String
                var name=data.objectForKey("name") as! String
                var bean = MoneyCls()
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
                bean.fund_p_month=data.objectForKey("fund_p_month") as! String
                bean.fund_p_year=data.objectForKey("fund_p_year") as! String
                bean.fund_type=data.objectForKey("fund_type") as! String
                bean.fund_maketime=data.objectForKey("fund_maketime") as! String
                bean.fund_director=data.objectForKey("fund_director") as! String
                bean.fund_money=data.objectForKey("fund_money") as! String
                bean.fund_time=data.objectForKey("fund_time") as! String
                bean.fund_manager=data.objectForKey("fund_manager") as! String
                dataArray.append(bean)
            }
        }
        return true
    }
    
    func getFundDataArray()->[MoneyCls]{
        return dataArray
    }
    
    func getTempDataArray()->[MoneyCls]{
        
        //获取本地资源文件路径
        var path:String=NSBundle.mainBundle().pathForResource("fund", ofType: "json")!
        //转为NSURL
        var nsUrl = NSURL(fileURLWithPath: path)
        
        var err:NSError?
        //获取NSDATA
        var apiData=NSData(contentsOfURL: nsUrl!)
        if err != nil{
            println("\(err?.description)")
        }
        
        var apiJson: AnyObject?=NSJSONSerialization.JSONObjectWithData(apiData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                
                
                var profit=data.objectForKey("fund_profit") as! String
                var fourteenday=data.objectForKey("fund_p_fourteen") as! String
                var sevenday=data.objectForKey("fund_p_seven") as! String
                var twentyeight=data.objectForKey("fund_p_twenty") as! String
                var foundid=data.objectForKey("fundid") as! String
                var gettime=data.objectForKey("fund_time") as! String
                var company=data.objectForKey("company") as! String
                var title=data.objectForKey("fund_title") as! String
                var id=data.objectForKey("id") as! String
                var name=data.objectForKey("name") as! String
                var bean = MoneyCls()
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
                bean.fund_p_month=data.objectForKey("fund_p_month") as! String
                bean.fund_p_year=data.objectForKey("fund_p_year") as! String
                bean.fund_type=data.objectForKey("fund_type") as! String
                bean.fund_maketime=data.objectForKey("fund_maketime") as! String
                bean.fund_director=data.objectForKey("fund_director") as! String
                bean.fund_money=data.objectForKey("fund_money") as! String
                bean.fund_time=data.objectForKey("fund_time") as! String
                bean.fund_manager=data.objectForKey("fund_manager") as! String
                dataArray.append(bean)
            }
        }
        
        return dataArray
    }
    

    
    func loadFundList(index:String)->Bool{
        
        //make api url
        var apiUrl:NSURL!=NSURL(string: "http://api.smemo.info/fund.php/Index/getList?id=\(index)");
        
        var err:NSError?
        
        //get data
        var apiData:NSData!=NSData(contentsOfURL: apiUrl, options: NSDataReadingOptions.DataReadingUncached, error: &err);
        
        if err != nil{
            println(err?.description)
            return false
        }
        if apiData == nil{
            return false
        }
        
        //make json object
        var apiResult=NSString(data: apiData, encoding: NSUTF8StringEncoding)
        
        var apiJson: AnyObject?=NSJSONSerialization.JSONObjectWithData(apiData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                var profit=data.objectForKey("fund_profit") as! String
                var fourteenday=data.objectForKey("fund_p_fourteen") as! String
                var sevenday=data.objectForKey("fund_p_seven") as! String
                var twentyeight=data.objectForKey("fund_p_twenty") as! String
                var foundid=data.objectForKey("fundid") as! String
                var gettime=data.objectForKey("fund_time") as! String
                var company=data.objectForKey("company") as! String
                var title=data.objectForKey("fund_title") as! String
                var id=data.objectForKey("id") as! String
                var name=data.objectForKey("name") as! String
                var bean = MoneyCls()
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
                listDataArray.append(bean)
            }
        }
        return true
    }
    
    func getFundListDataArray(index:String)->[MoneyCls]{
        
        //获取本地资源文件路径
        var path:String=NSBundle.mainBundle().pathForResource("list\(index)", ofType: "json")!
        //转为NSURL
        var nsUrl = NSURL(fileURLWithPath: path)
        
        var err:NSError?
        //获取NSDATA
        var apiData=NSData(contentsOfURL: nsUrl!)
        if err != nil{
            println("\(err?.description)")
        }
    
        //make json object
        var apiResult=NSString(data: apiData!, encoding: NSUTF8StringEncoding)
        
        var apiJson: AnyObject?=NSJSONSerialization.JSONObjectWithData(apiData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        if let jsonItem = apiJson as? NSArray{
            for data in jsonItem{
                var profit=data.objectForKey("fund_profit") as! String
                var fourteenday=data.objectForKey("fund_p_fourteen") as! String
                var sevenday=data.objectForKey("fund_p_seven") as! String
                var twentyeight=data.objectForKey("fund_p_twenty") as! String
                var foundid=data.objectForKey("fundid") as! String
                var gettime=data.objectForKey("fund_time") as! String
                var company=data.objectForKey("company") as! String
                var title=data.objectForKey("fund_title") as! String
                var id=data.objectForKey("id") as! String
                var name=data.objectForKey("name") as! String
                var bean = MoneyCls()
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
                listDataArray.append(bean)
            }
        }
        return listDataArray
    }
    
    func getFundListDataArray()->[MoneyCls]{
        return listDataArray
    }
    
    func testFundData(){
        loadApiData()
        println("action test")
        var testArray=getFundDataArray()
        for item in testArray{
            item.toStirng()
        }
    }
    
    func testFundListData(){
        loadFundList("000343")
        println("action test")
        var testArray=getFundListDataArray()
        for item in testArray{
            println(item.toStirng())
        }
    }
    
}
